[![EN](https://user-images.githubusercontent.com/9499881/33184537-7be87e86-d096-11e7-89bb-f3286f752bc6.png)](https://github.com/GTA-Vice-City-Multiplayer/GTA-Vice-City-Multiplayer/) 
[![RU](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)](https://github.com/GTA-Vice-City-Multiplayer/GTA-Vice-City-Multiplayer/blob/master/README.RU.md)

# GTA Vice City Multiplayer
Настроенный сервер для GTA Vice City (2003). Разработка в процессе.

[![](https://github.com/user-attachments/assets/3c82817f-85e4-4ff7-a7da-fddba2dcc30f)](https://github.com/user-attachments/assets/825b7288-9b89-4f8a-b764-25d4552e3705)
[![](https://github.com/user-attachments/assets/7d21240b-5362-47c8-94ea-d5210f647626)](https://github.com/user-attachments/assets/2c4b8d06-72ed-477e-99fb-af1aa1799024)
[![](https://github.com/user-attachments/assets/db752eae-028f-4743-ae59-c369f23d5934)](https://github.com/user-attachments/assets/c539d500-e2d7-47fa-91be-92b348053408)

## Настройка сервера
1. Распаковать архив сервера - `Server.zip`
2. Запустить `server64.exe` и разрешить доступ к сети.
3. Установить GTA Vice City (2003) версии 1.0, без Widescreen патча (не работает).
4. Установить `VCMP04_Installer.msi`.
5. Распаковать архив `Client_0.4.7.1.zip` в папку `%AppData%\..\Local\Vice City Multiplayer`.
6. Запустить `Vice City Multiplayer`, в Tools → Settings указать ваш ник (`Username`) и путь до игры (`GTA:VC Directory`).
7. Добавьте локальный или внешний IP адрес сервера, для проверки можно ввести `127.0.0.1`, после чего по двойному клику запустится мультиплеерная игра.

## Цели
Цель | Статус | Сделано
------------ | ------------- | -------------
Сделать различных персонажей | +- | Полицейский, спецназовец, агент ФБР, военный, медик, пожарный, таксист, бензопильщик.
Разместить по карте вертолёты | +- | Вертолёт около полиции, второй военный вертолёт на базе.
Разместить по карте транспорт | - | 
Разместить по карте аптечки и оружие | +- | Двор особняка Версетти, полиция.

## Команды
Команда | Действие
------------ | -------------
`/heal` | Жизни.
`/armour` | Броня.
`/guns` | Оружие.
`/where` | Координаты на карте.
`/kill` | Смерть.

Команды для тестовой отладки, удалить или изменить их можно в файле `main.nut`.

## Загрузка
>Сервер, клиент и другие файлы.

**[Загрузить](https://github.com/GTA-Vice-City-Multiplayer/GTA-Vice-City-Multiplayer/releases)**

## Полезные ссылки
[Форум разработчиков мультиплеера](https://forum.vc-mp.org/index.php) | 
[Модели персонажей](https://wiki.gtaconnected.com/Resources/GTAVC/PedSkins) | 
[Модели оружия](https://wiki.gtaconnected.com/Resources/GTAVC/Weapons) | 
[Модели транспорта](https://wiki.vc-mp.org/wiki/Vehicles)

## Благодарности
MEGAMIND - за предоставленные ссылки и помощь.