# GTA Vice City Multiplayer
A configured server for GTA Vice City (2003). Development in progress.

[![](https://github.com/user-attachments/assets/3c82817f-85e4-4ff7-a7da-fddba2dcc30f)](https://github.com/user-attachments/assets/f3282cd0-3599-4e6c-99d0-f13dee5a99a9)
[![](https://github.com/user-attachments/assets/7d21240b-5362-47c8-94ea-d5210f647626)](https://github.com/user-attachments/assets/2c4b8d06-72ed-477e-99fb-af1aa1799024)
[![](https://github.com/user-attachments/assets/db752eae-028f-4743-ae59-c369f23d5934)](https://github.com/user-attachments/assets/c539d500-e2d7-47fa-91be-92b348053408)

## Server Setup
1. Extract the server archive — `Server.zip`
2. Run `server64.exe` and allow network access.
3. Install GTA Vice City (2003) version 1.0, without the Widescreen patch (not supported).
4. Install `VCMP04_Installer.msi`.
5. Extract the `Client_0.4.7.1.zip` archive into `%AppData%\..\Local\Vice City Multiplayer`.
6. Launch `Vice City Multiplayer`, go to Tools → Settings and set your nickname (`Username`) and the path to the game (`GTA:VC Directory`).

## Goals
Goal | Status | Done
------------ | ------------- | -------------
Create different characters | +- | Police officer, SWAT officer, FBI agent, soldier, medic, firefighter, taxi driver, chainsaw worker
Place helicopters on the map | +- | Helicopter near the police station, second military helicopter at the base
Place vehicles on the map | - | 
Place medkits and weapons on the map | +- | Vercetti mansion yard, police

## Commands
Command | Action
------------ | -------------
`/heal` | Restore health.
`/armour` | Armor.
`/guns` | Weapons.
`/where` | Player coordinates.
`/kill` | Kill the player.

Commands for test debugging; they can be removed or modified in the `main.nut` file.

## Download
> Server, client and other files.

**[Download](https://github.com/r57zone/DSAdvance/releases)**

## Useful Links
[Multiplayer Developers Forum](https://forum.vc-mp.org/index.php).
[Character Models](https://wiki.gtaconnected.com/Resources/GTAVC/PedSkins).
[Weapon Models](https://wiki.gtaconnected.com/Resources/GTAVC/Weapons).
[Vehicle Models](https://wiki.vc-mp.org/wiki/Vehicles).

## Credits
MEGAMIND — for providing links and assistance.