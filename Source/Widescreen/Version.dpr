library Version;

{ GTA: Vice City Multiplayer Widescreen Fix by r57zone.
En:
  Specifically designed for the multiplayer version of the game.
  For the regular version of GTA: Vice City, use
  https://github.com/ThirteenAG/WidescreenFixesPack/releases/tag/gtavc
Ru:
  Предназначен специально для мультиплеерной версии игры.
  Для обычной версии GTA: Vice City используйте
  https://github.com/ThirteenAG/WidescreenFixesPack/releases/tag/gtavc
}

uses
  SysUtils, Classes, Fake, Windows, IniFiles;

{$R *.res}

const
  ADDR_ASPECT_1 = $0054A292;
  ADDR_ASPECT_2 = $0054A2B3;
  ADDR_ASPECT_3 = $0054A2C6;

  ADDR_FOV_RESET_INSTR = $0054A2E4; // Снятие блока смены FOV, asm: fstp dword ptr [0x696658]
  ADDR_FOV_VALUE = $00696658;       // FOV (Single)

  // Отдельная копия константы 1/640, используемая именно при расчёте
  // ширины радара (найдена через дизассемблирование - без её правки
  // карта остаётся овальной при широкоформатном aspect ratio)
  ADDR_MAP_WIDTH_SCALE = $0068FD14;
  BASE_MAP_WIDTH_SCALE: Single = 1.0 / 640.0;

  ADDR_MAP_SIZE   = $0068FD24;
  ADDR_MAP_POS_X  = $0068FD2C;
  ADDR_MAP_HEIGHT = $0068FD30;
  ADDR_MAP_POS_Y  = $0068FD34;

  // Базовые значения для 4:3
  // (реальные штатные значения, снятые из exe через анализ бинарника,
  // а не подобранные на глаз как раньше)
  BASE_MAP_SIZE: Single = 94.0;
  BASE_MAP_POS_X: Single = 40.0;
  BASE_MAP_HEIGHT: Single = 76.0;
  BASE_MAP_POS_Y: Single = 116.0;

  ADDR_RING_WIDTH = $00697C1C;
  ADDR_RING_POS_Y = $00697C18;
  ADDR_RING_HEIGHT = $00697C20;
  ADDR_RING_POS_X_1 = $0055A956;
  ADDR_RING_POS_X_2 = $0055AA94;
  // Указатели (DWORD, не Single) — перенаправляем на ADDR_MAP_POS_X
  ADDR_RING_POS_X2_PTR_1 = $0055A9AE;
  ADDR_RING_POS_X2_PTR_2 = $0055AAE7;

  // Общий множитель ширины (crosshair и, похоже, завязанные на него спрайты).
  // База = 1.0/640.0 (классическая GTA-константа перевода virtual->screen).
  ADDR_GLOBAL_WIDTH_SCALE = $00697A70;
  BASE_GLOBAL_WIDTH_SCALE: Single = 1.0 / 640.0;

var
  // Delta - фактический базовый адрес загрузки минус "предпочтительный" базовый адрес из PE-заголовка.
  // Если модуль не был перемещён (обычный случай) — Delta = 0, и вся адресация
  // работает точно так же, как в исходной рабочей версии.
  RebaseDelta: Integer;

function GetPreferredImageBase(Module: HMODULE): DWORD;
var
  DosHeader: PImageDosHeader;
  NtHeaders: PImageNtHeaders;
begin
  DosHeader:=PImageDosHeader(Module);
  NtHeaders:=PImageNtHeaders(DWORD(Module) + DWORD(DosHeader^._lfanew));
  Result:=NtHeaders^.OptionalHeader.ImageBase;
end;

procedure InitRebaseDelta;
var
  Module: HMODULE;
  RealBase, PreferredBase: DWORD;
begin
  Module:=GetModuleHandle(nil);
  RealBase:=DWORD(Module);
  PreferredBase:=GetPreferredImageBase(Module);
  RebaseDelta:=Integer(RealBase) - Integer(PreferredBase);
end;

function Rebase(OldAddr: DWORD): Pointer;
begin
  Result:=Pointer(Integer(OldAddr) + RebaseDelta);
end;

procedure PatchOne(Addr: Pointer; Value: Single);
var
  OldProtect: DWORD;
begin
  if VirtualProtect(Addr, SizeOf(Single), PAGE_EXECUTE_READWRITE, OldProtect) then begin
    PSingle(Addr)^:=Value;
    VirtualProtect(Addr, SizeOf(Single), OldProtect, OldProtect);
  end;
end;

procedure PatchBytes(Addr: Pointer; const Bytes: array of Byte);
var
  OldProtect: DWORD;
begin
  if VirtualProtect(Addr, Length(Bytes), PAGE_EXECUTE_READWRITE, OldProtect) then begin
    Move(Bytes[0], Addr^, Length(Bytes));
    VirtualProtect(Addr, Length(Bytes), OldProtect, OldProtect);
  end;
end;

procedure PatchPointer(Addr: Pointer; NewTarget: DWORD);
var
  OldProtect: DWORD;
begin
  if VirtualProtect(Addr, SizeOf(DWORD), PAGE_EXECUTE_READWRITE, OldProtect) then begin
    PDWORD(Addr)^:=NewTarget;
    VirtualProtect(Addr, SizeOf(DWORD), OldProtect, OldProtect);
  end;
end;

function GetMonitorAspectRatio: Single;
var
  W, H: Integer;
begin
  W:=GetSystemMetrics(SM_CXSCREEN);
  H:=GetSystemMetrics(SM_CYSCREEN);
  if (W > 0) and (H > 0) then
    Result:=W / H
  else
    Result:=16.0 / 9.0;
end;

function ParseAspectRatio(const S: string): Single;
var
  P: Integer;
  W, H: Single;
begin
  if SameText(Trim(S), 'auto') then begin
    Result:=GetMonitorAspectRatio;
    Exit;
  end;

  P := Pos(':', S);
  if P > 0 then begin
    W:=StrToFloatDef(Copy(S, 1, P - 1), 16);
    H:=StrToFloatDef(Copy(S, P + 1, MaxInt), 9);
    if H <> 0 then
      Result:=W / H
    else
      Result:=16.0 / 9.0;
  end else
    Result:=StrToFloatDef(S, 16.0 / 9.0);
end;

function PatchThread(Param: Pointer): Integer; stdcall;
var
  Ini: TIniFile;
  AspectRatioStr: string;
  NewAspect: Single;
  NewFov: Single;
  K: Single; // общий коэффициент коррекции ширины: (4/3) / NewAspect
begin
  Sleep(2000); // Ждём инициализации игры, тут Sleep уже безопасен - мы не в loader lock

  InitRebaseDelta;

  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'GTAVCMP.Widescreen.ini');
  try
    AspectRatioStr:=Ini.ReadString('Main', 'AspectRatio', 'auto');
    NewFov:=Ini.ReadFloat('Main', 'FOV', 82);
  finally
    Ini.Free;
  end;

  NewAspect:=ParseAspectRatio(AspectRatioStr);
  K:=(4.0 / 3.0) / NewAspect;

  // Aspect ratio
  PatchOne(Rebase(ADDR_ASPECT_1), NewAspect);
  PatchOne(Rebase(ADDR_ASPECT_2), NewAspect);
  PatchOne(Rebase(ADDR_ASPECT_3), NewAspect);

  // FOV: снятие сброса
  PatchBytes(Rebase(ADDR_FOV_RESET_INSTR), [$DD, $D8, $90, $90, $90, $90]);
  // FOV
  PatchOne(Rebase(ADDR_FOV_VALUE), NewFov);

  // Карта
  // Важно: именно эта локальная copy константы, а НЕ MAP_SIZE, отвечает за
  // горизонтальное растяжение карты (деление MAP_SIZE на K даёт овальную карту!)
  PatchOne(Rebase(ADDR_MAP_WIDTH_SCALE), BASE_MAP_WIDTH_SCALE * K);
  PatchOne(Rebase(ADDR_MAP_SIZE), BASE_MAP_SIZE);
  PatchOne(Rebase(ADDR_MAP_POS_X), BASE_MAP_POS_X);
  PatchOne(Rebase(ADDR_MAP_HEIGHT), BASE_MAP_HEIGHT);
  PatchOne(Rebase(ADDR_MAP_POS_Y), BASE_MAP_POS_Y);

  // Розовое кольцо поверх карты
  PatchOne(Rebase(ADDR_RING_WIDTH), BASE_MAP_SIZE);
  PatchOne(Rebase(ADDR_RING_POS_Y), BASE_MAP_POS_Y);
  PatchOne(Rebase(ADDR_RING_HEIGHT), BASE_MAP_HEIGHT);
  PatchOne(Rebase(ADDR_RING_POS_X_1), BASE_MAP_POS_X);
  PatchOne(Rebase(ADDR_RING_POS_X_2), BASE_MAP_POS_X);
  PatchPointer(Rebase(ADDR_RING_POS_X2_PTR_1), DWORD(Rebase(ADDR_MAP_POS_X)));
  PatchPointer(Rebase(ADDR_RING_POS_X2_PTR_2), DWORD(Rebase(ADDR_MAP_POS_X)));

  // Общий множитель ширины (всё кроме розового кольца)
  PatchOne(Rebase(ADDR_GLOBAL_WIDTH_SCALE), BASE_GLOBAL_WIDTH_SCALE * K);

  Result:=0;
end;

begin
  DecimalSeparator:='.';
  CreateThread(nil, 0, @PatchThread, nil, 0, PDWORD(nil)^);
end.
