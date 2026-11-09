[![EN](https://user-images.githubusercontent.com/9499881/33184537-7be87e86-d096-11e7-89bb-f3286f752bc6.png)](https://github.com/GTA-Vice-City-Multiplayer/GTA-Vice-City-Multiplayer/) 
[![RU](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)](https://github.com/GTA-Vice-City-Multiplayer/GTA-Vice-City-Multiplayer/blob/master/README.RU.md)

# GTA Vice City Multiplayer
Готовая сборка сервера для игры по сети с дополнительными улучшениями и доработками серверных скриптов.

<img width="444" height="280" alt="logo" src="https://github.com/user-attachments/assets/3e3093af-9aa8-4c5a-bb8b-74810ca6af6e" />

## Игровой процесс
[![Полёты на вертолётах](https://github.com/user-attachments/assets/86d8c752-feda-4fc5-a00d-a6615ca5cf42)](https://www.youtube.com/feed/subscriptions?flow=2) 
[![Поездка на лодках](https://github.com/user-attachments/assets/ad8fc2b3-eb06-4a48-90fe-cc352b708c31)](https://www.youtube.com/feed/subscriptions?flow=2)
[![Сражения между участниками](https://github.com/user-attachments/assets/21517faa-fd51-42a4-b57a-aafc5ebe4db0)](https://www.youtube.com/feed/subscriptions?flow=2)
[![Оружейный магазин](https://github.com/user-attachments/assets/1211c641-f2f1-454c-a6c6-4eba3118b3eb)](https://www.youtube.com/feed/subscriptions?flow=2)
[![Подчинка авто](https://github.com/user-attachments/assets/a4e673c6-203b-4e36-b7c7-a64d57d0b3ea)](https://www.youtube.com/feed/subscriptions?flow=2)
[![Телепорт](https://github.com/user-attachments/assets/5242a473-ba10-41df-acf5-9d63d21c6325)](https://www.youtube.com/feed/subscriptions?flow=2)


## Особенности
- Добавлены персонажи для выбора.
- На карту добавлено всё оружие из оригинальной игры, а также дополнительное.
- Расставлены все автомобили (в том числе секретные) и дополнительный транспорт, включая вертолёты и лодки.
- Расставлены аптечки и бронежилеты.
- Добавлены точки сбора денег.
- Добавлены и размещены телепорты для быстрого перемещения по городу.
- Реализован ремонт автомобилей в мастерских через взаимодействие с предметом.

## Установка и настройка
1. Установите **GTA Vice City (2003), английскую версию 1.0** (рекомендуется) или версии **Modern Mod**, **Deluxe**, без дополнительных патчей (NoCD можно). Версия от "1C" и "7Волк" не работает. Для перевода игры на русский приложен русификатор.
2. Запустите игру и выберите нужное разрешение экрана (например, 1920x1080).
3. (Опционально) Для поддержки широкоформатных разрешений распакуйте содержимое архива `Widescreen Fix` в папку с игрой. Если широкоформатный режим не заработал, используйте патч Xdelta.
4. Распакуйте архив `Server.zip` на компьютере, который будет использоваться в качестве сервера (например, в `C:\Games\GTA VC Multiplayer\Server`). Создайте ярлык для `server64.exe` на рабочий стол.
5. Запустите `server64.exe` и разрешите ему доступ к сети в брандмауэре Windows.
6. Распакуйте архив `Client.zip` на компьютерах, с которых планируется подключение к серверу (например, в `C:\Games\GTA VC Multiplayer\Client`). Создайте ярлык для `VCMPBrowser.exe` на рабочий стол.
7. Запустите `VCMPBrowser.exe` и откройте **Tools → Settings**. Укажите свой никнейм (`Username`) и путь к папке с игрой (`GTA:VC Directory`).
8. Выберите **Server → Add Server** и добавьте адрес сервера в формате `IP:Порт`.
   - Для игры по локальной сети укажите локальный IP-адрес компьютера, на котором запущен сервер (например, `192.168.0.100:8192`).
   - Для проверки на одном компьютере используйте `127.0.0.1:8192`.
   - Для игры через интернет потребуется настроить перенаправление порта (Port Forwarding) на маршрутизаторе, чтобы другие игроки могли подключаться к серверу. Также убедитесь, что брандмауэр Windows разрешает входящие подключения.

## Команды
По умолчанию команды выключены, включить их можно в файле `scripts\main.nut` изменив `DEBUG_MODE` на `true`.

Команда | Действие
------------ | -------------
`/health` | Восстановить здоровье.
`/armour` | Получить броню.
`/guns` | Получить дробовик, автомат и пулемёт.
`/bring` | Телепортация другого игрока к себе.
`/kill` | Умереть.
`/where` | Координаты игрока на карте.
`/tp`, `/tpto` | Координаты игрока на карте для удобного копирования в скрипт телепортов.
`/up`, `/down`, `/left`, `/right` | Команды для перемещения игрока вперёд, назад, влево, вправо для перемещения сквозь стены (работа с телепортами).

## Загрузка
>Сервер, клиент и другие файлы.

**[Загрузить](https://github.com/GTA-Vice-City-Multiplayer/GTA-Vice-City-Multiplayer/releases)**

## Полезные ссылки
[Форум разработчиков мультиплеера](https://forum.vc-mp.org/index.php) | 
[Модели персонажей](https://wiki.gtaconnected.com/Resources/GTAVC/PedSkins) | 
[Модели оружия](https://wiki.gtaconnected.com/Resources/GTAVC/Weapons) | 
[Модели транспорта](https://wiki.vc-mp.org/wiki/Vehicles)

## Благодарности
- [MEGAMIND](https://forum.vc-mp.org/index.php?action=profile;u=483) - за предоставленные ссылки и помощь.
- [ChatGPT](https://chatgpt.com) - за картинку клиента, помощь с координатами оружия и прочую справку.
- [Claude AI](https://claude.ai) — за помощь в создании широкоэкранного хака для мультиплеерной версии.

## Обратная связь
`r57zone@gmail.com`