unit fake;

interface

uses Windows, SysUtils;

var aDWORD: array [0..16] of DWORD;

implementation

procedure SetProcedure;
type
    TDWordArray = array [0..$FFFFF] of DWORD;
var lib: THandle;
    NameRealDll, NameDll, Name: String;
    i, mylib: DWORD;
    pExportDirectory: PImageExportDirectory;
    pNameRVAs: ^TDWordArray;

   function GetModuleName: string;
   var S: array[0..MAX_PATH] of Char;
   begin
     GetModuleFileName(hInstance, S, SizeOf(S));
     Result:=LowerCase(S);
   end;

   function GetSysDir: string;
   var S: array[0..MAX_PATH] of Char;
   begin
     GetSystemDirectory(S,SizeOf(S));
     Result:=S;
   end;

begin
   NameDll:=GetModuleName; mylib := dword(GetModuleHandle(PChar(NameDll))); // Íàøà dll
   NameRealDll:=GetSysDir+'\'+ExtractFileName(NameDll);
   //NameRealDll:='_'+ExtractFileName(NameDll); //Åñëè íå ñèñòåìíàÿ

   lib := LoadLibrary(PChar(NameRealDll)); // Íåíàøà dll
   
   pExportDirectory := pointer(pdword(mylib+$178)^ + mylib);
   pNameRVAs := pointer(dword(pExportDirectory^.AddressOfNames) + mylib);
   for i := 0 to pExportDirectory^.NumberOfNames - 1 do begin
      Name := PChar(pNameRVAs^[i]+mylib);
      aDWORD[i] := dword(GetProcAddress(lib, PAnsiChar(Name))); // Proxy
   end;

end;

(* Ôåéê-ôóíêöèè *)

procedure GetFileVersionInfoA;
asm
   jmp dword [aDWORD+0];
end;

procedure GetFileVersionInfoByHandle;
asm
   jmp dword [aDWORD+4];
end;

procedure GetFileVersionInfoExA;
asm
   jmp dword [aDWORD+8];
end;

procedure GetFileVersionInfoExW;
asm
   jmp dword [aDWORD+12];
end;

procedure GetFileVersionInfoSizeA;
asm
   jmp dword [aDWORD+16];
end;

procedure GetFileVersionInfoSizeExA;
asm
   jmp dword [aDWORD+20];
end;

procedure GetFileVersionInfoSizeExW;
asm
   jmp dword [aDWORD+24];
end;

procedure GetFileVersionInfoSizeW;
asm
   jmp dword [aDWORD+28];
end;

procedure GetFileVersionInfoW;
asm
   jmp dword [aDWORD+32];
end;

procedure VerFindFileA;
asm
   jmp dword [aDWORD+36];
end;

procedure VerFindFileW;
asm
   jmp dword [aDWORD+40];
end;

procedure VerInstallFileA;
asm
   jmp dword [aDWORD+44];
end;

procedure VerInstallFileW;
asm
   jmp dword [aDWORD+48];
end;

procedure VerLanguageNameA;
asm
   jmp dword [aDWORD+52];
end;

procedure VerLanguageNameW;
asm
   jmp dword [aDWORD+56];
end;

procedure VerQueryValueA;
asm
   jmp dword [aDWORD+60];
end;

procedure VerQueryValueW;
asm
   jmp dword [aDWORD+64];
end;
(* ------------ *)

exports
   GetFileVersionInfoA index 1 name 'GetFileVersionInfoA',
   GetFileVersionInfoByHandle index 2 name 'GetFileVersionInfoByHandle',
   GetFileVersionInfoExA index 3 name 'GetFileVersionInfoExA',
   GetFileVersionInfoExW index 4 name 'GetFileVersionInfoExW',
   GetFileVersionInfoSizeA index 5 name 'GetFileVersionInfoSizeA',
   GetFileVersionInfoSizeExA index 6 name 'GetFileVersionInfoSizeExA',
   GetFileVersionInfoSizeExW index 7 name 'GetFileVersionInfoSizeExW',
   GetFileVersionInfoSizeW index 8 name 'GetFileVersionInfoSizeW',
   GetFileVersionInfoW index 9 name 'GetFileVersionInfoW',
   VerFindFileA index 10 name 'VerFindFileA',
   VerFindFileW index 11 name 'VerFindFileW',
   VerInstallFileA index 12 name 'VerInstallFileA',
   VerInstallFileW index 13 name 'VerInstallFileW',
   VerLanguageNameA index 14 name 'VerLanguageNameA',
   VerLanguageNameW index 15 name 'VerLanguageNameW',
   VerQueryValueA index 16 name 'VerQueryValueA',
   VerQueryValueW index 17 name 'VerQueryValueW';

initialization SetProcedure;

end.
