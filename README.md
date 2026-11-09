[![EN](https://user-images.githubusercontent.com/9499881/33184537-7be87e86-d096-11e7-89bb-f3286f752bc6.png)](https://github.com/r57zone/GTA-Vice-City-Multiplayer/) 
[![RU](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)](https://github.com/r57zone/GTA-Vice-City-Multiplayer/blob/master/README.RU.md)
← Choose language | Выберите язык

# GTA Vice City Multiplayer
A ready-to-use multiplayer server build with additional improvements and enhancements to server scripts.

[![logo](https://github.com/user-attachments/assets/3e3093af-9aa8-4c5a-bb8b-74810ca6af6e)](https://youtu.be/wEtutl2oogc) 

## Gameplay
[![Helicopter flights](https://github.com/user-attachments/assets/86d8c752-feda-4fc5-a00d-a6615ca5cf42)](https://youtu.be/wEtutl2oogc) 
[![Boat rides](https://github.com/user-attachments/assets/ad8fc2b3-eb06-4a48-90fe-cc352b708c31)](https://youtu.be/wEtutl2oogc)
[![Player battles](https://github.com/user-attachments/assets/21517faa-fd51-42a4-b57a-aafc5ebe4db0)](https://youtu.be/wEtutl2oogc)
[![Weapon shop](https://github.com/user-attachments/assets/1211c641-f2f1-454c-a6c6-4eba3118b3eb)](https://youtu.be/wEtutl2oogc)
[![Vehicle repair](https://github.com/user-attachments/assets/a4e673c6-203b-4e36-b7c7-a64d57d0b3ea)](https://youtu.be/wEtutl2oogc)
[![Teleport](https://github.com/user-attachments/assets/5242a473-ba10-41df-acf5-9d63d21c6325)](https://youtu.be/wEtutl2oogc)

## Features
- Added selectable player characters.
- All weapons from the original game are available on the map, along with additional weapons.
- All vehicles from the original game (including hidden vehicles) have been placed around the map, along with additional vehicles, including helicopters and boats.
- Added health pickups and body armor.
- Added money pickups.
- Added and placed teleport points at certain locations.
- Implemented vehicle repair at Pay 'n' Spray shops through object interaction.

## Installation and Setup
1. Install **GTA Vice City (2003), original English version 1.0**  (recommended), without any patches (No-CD is allowed).
2. Launch the game and select your desired screen resolution (e.g. 1920x1080).
3. (Optional) To enable widescreen support, extract the contents of the `Widescreen Fix` archive into the game folder. If widescreen mode doesn't work, use the Xdelta patch.
4. Extract `Server.zip` on the computer that will host the server (e.g. to `C:\Games\GTA VC Multiplayer\Server`). Create a desktop shortcut for `server64.exe`.
5. Run `server64.exe` and allow it through Windows Firewall.
6. Extract `Client.zip` on each computer that will connect to the server (e.g. to `C:\Games\GTA VC Multiplayer\Client`). Create a desktop shortcut for `VCMPBrowser.exe`.
7. Run `VCMPBrowser.exe` and open **Tools → Settings**. Enter your nickname (`Username`) and the path to your game folder (`GTA:VC Directory`).
8. Select **Server → Add Server** and enter the server address in `IP:Port` format.
   - For LAN play, enter the local IP address of the computer hosting the server (e.g. `192.168.0.100:8192`).
   - To test the server on the same computer, use `127.0.0.1:8192`.
   - For internet play, you need to configure port forwarding on your router so other players can connect to the server. Also make sure Windows Firewall allows incoming connections.

## Commands
Commands are disabled by default. To enable them, open `scripts\main.nut` and set `DEBUG_MODE` to `true`.

Command | Description
------------ | -------------
`/health` | Restore health.
`/armour` | Get body armor.
`/guns` | Get a shotgun, assault rifle and submachine gun.
`/bring` | Teleport another player to your location.
`/kill` | Kill yourself.
`/where` | Display your current map coordinates.
`/tp`, `/tpto` | Display your coordinates in a format convenient for copying into the teleport script.
`/up`, `/down`, `/left`, `/right` | Move your character forward, backward, left or right through walls (useful when working with teleport points).

## Downloads
> Server, client and other files.

**[Download](https://github.com/GTA-Vice-City-Multiplayer/GTA-Vice-City-Multiplayer/releases)**

## Useful Links
[Multiplayer Developer Forum](https://forum.vc-mp.org/index.php) | 
[Ped Models](https://wiki.gtaconnected.com/Resources/GTAVC/PedSkins) | 
[Weapon Models](https://wiki.gtaconnected.com/Resources/GTAVC/Weapons) | 
[Vehicle Models](https://wiki.vc-mp.org/wiki/Vehicles)

## Credits
- [VC:MP Development Team](https://www.vc-mp.org/) — for creating the Vice City multiplayer modification.
- [MEGAMIND](https://forum.vc-mp.org/index.php?action=profile;u=483) - for providing useful links and assistance.
- [ChatGPT](https://chatgpt.com) - for the client image, help with weapon coordinates and other information.
- [Claude AI](https://claude.ai) - for help creating the widescreen hack for the multiplayer version.

## Feedback
`r57zone@gmail.com`