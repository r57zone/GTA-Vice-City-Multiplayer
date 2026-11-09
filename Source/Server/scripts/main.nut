/*
Vice City Multiplayer 0.4 Blank Server (by Sebastian) for 64bit Windows.
You can use it to script your own server. Here you can find all events developed.

VC:MP Official: www.vc-mp.org
Forum: forum.vc-mp.org
Wiki: wiki.vc-mp.org

Improved by r57zone
https://github.com/r57zone/GTA-Vice-City-Multiplayer
*/

local DEBUG_MODE = false;

// safety first
getroottable().rawset("system", null);
// ---

local   SRV_NAME = GetServerName(),
        SRV_PASS = GetPassword();

        
// Creating a connection between client and server scripts
// I'm using bytes for identification, because they are the most waste-less for the designated task
// This must be the same in both, client-side and server-side.
enum StreamType
{
    ServerName = 0x01
}

local Teleports =
[
    {
        name = "Juan García Cortés Port",
        x = -251.359,
        y = -1360.64,
        z = 8.11296,
		
        to = Vector(-256.89, -1360.64, 8.11296),
		toAngle = 1.58913
    },
    {
        name = "Vice City Downtown",
        x = -255.856,
        y = -1360.61,
        z = 8.11296,

        to = Vector(-247.784, -1360.75, 8.11296),
		toAngle = -1.56056
    },
	
	{
        name = "WK Chariot Hotel",
        x = 476.257,
        y = 30.4392,
        z = 12.0714,

        to = Vector(462.512, 30.2534, 30.9712),
		toAngle = -1.55232
    },
    {
        name = "Vice City",
        x = 459.985,
        y = 30.2768,
        z = 30.9712,

        to = Vector(479.041, 30.3537, 11.0712),
		toAngle = -1.53583
    },
	
	// Police station near Diaz
	{
        name = "Police Helipad",
        x = 364.418,
        y = -505.478,
        z = 12.3246,

        to = Vector(388.447, -483.779, 21.5735),
		toAngle = 2.49841
    },
	{
        name = "Vice City",
        x = 389.202,
        y = -482.76,
        z = 21.5734,

        to = Vector(363.426, -506.712, 12.3246),
		toAngle = 2.46466
    },
	
	// Около Love Rock здание с вертолётной площадкой, которое можно купить
	{
        name = "Helipad",
        x = -830.679,
        y = 1312.54,
        z = 11.5491,

        to = Vector(-814.801, 1354.34, 66.4591),
		toAngle = 1.58108
    },
	{
        name = "Vice City",
        x = -811.682,
        y = 1354.23,
        z = 66.4665,

        to = Vector(-829.198, 1308.37, 11.558),
		toAngle = -1.33487
    },

    {
        name = "Downtown Office Building",
        x = -557.433,
        y = 782.295,
        z = 22.8768,

        to = Vector(-554.671, 788.093, 97.5104),
		toAngle = 1.6317
    },
    {
        name = "Vice City",
        x = -551.552,
        y = 787.996,
        z = 97.5104,

        to = Vector(-560.379, 782.23, 22.8768),
		toAngle = 0.854728
    },
    {
        name = "Escobar International Airport Gates",
        x = -1359.49,
        y = -931.751,
        z = 20.8931,

        to = Vector(-1491.15, -1017.77, 14.868),
		toAngle = -2.00255
    },
    {
        name = "Escobar International Airport Terminal",
        x = -1495,
        y = -1016,
        z = 14.868,

        to = Vector(-1362.04, -927.851, 20.8931),
		toAngle = 0.571321
    },
    {
        name = "Escobar International Airport Gates",
        x = -1512.47,
        y = -932.087,
        z = 20.8823,

        to = Vector(-1493.91, -1102.93, 14.868),
		toAngle = -2.18854
    },
    {
        name = "Escobar International Airport Terminal",
        x = -1497.28,
        y = -1100.46,
        z = 14.868,

        to = Vector(-1511.19, -930.077, 20.8823),
		toAngle = -0.560583
    },
    { // Военная база
        name = "Military Base Courtyard",
        x = -1697.34,
        y = -283.841,
        z = 14.8683,

        to = Vector(-1692.43, -281.325, 14.8683),
		toAngle = -0.585702
    },
    {
        name = "Military Base Main Entrance",
        x = -1694.85,
        y = -283.841,
        z = 14.8683,

        to = Vector(-1700.29, -281.851, 14.8683),
		toAngle = 1.59086
    },
    { // Отель рядом с Ocean view
        name = "Hotel roof",
        x = 246.07,
        y = -1170.65,
        z = 12.0664,

        to = Vector(240.864, -1169.75, 52.7791),
		toAngle = -1.69747
    },
    {
        name = "Ocean Beach",
        x = 236.954,
        y = -1169.28,
        z = 52.7791,

        to = Vector(248.678, -1171.03, 12.0664),
		toAngle = -1.6572
    },
    { // Главный вход около стриптиза
        name = "Hotel roof",
        x = 78.6669,
        y = -1533.2,
        z = 11.5943,

        to = Vector(76.4579, -1532.74, 79.2818),
		toAngle = -1.7851
    },
    {
        name = "Ocean Beach",
        x = 72.9471,
        y = -1532.18,
        z = 79.2818,

        to = Vector(81.2187, -1533.56, 11.5943),
		toAngle = -1.68462
    },
    { // Дальняя вышка к воде
        name = "Hotel Roof Towers",
        x = 69.2285,
        y = -1548.46,
        z = 79.2818,

        to = Vector(67.4239, -1560.51, 98.8184),
		toAngle = 1.21292
    },
    {
        name = "Hotel Roof",
        x = 67.6791,
        y = -1555.14,
        z = 98.8184,

        to = Vector(69.774, -1545.83, 79.2818),
		toAngle = -0.204118
    },
    { // Передняя вышка к городу
        name = "Hotel Roof Towers",
        x = 75.037,
        y = -1515.24,
        z = 79.2818,

        to = Vector(76.5598, -1503.78, 98.8184),
		toAngle = 0.271615
    },
    {
        name = "Hotel Roof",
        x = 76.2163,
        y = -1509.66,
        z = 98.8184,

        to = Vector(74.6572, -1517.62, 79.2818),
		toAngle = 3.00598
    },
    { // Крыша больницы, около начала игры
        name = "Hospital Rooftop",
        x = -120.261,
        y = -1060.59,
        z = 14.0762,

        to = Vector(-134.695, -1043.69, 84.1526),
		toAngle = 0.790108
    },
    {
        name = "Washington Beach",
        x = -127.306,
        y = -1045.71,
        z = 84.1526,

        to = Vector(-119.08, -1065.93, 14.0661),
		toAngle = -2.91068
    },
    { // Крыша рядом с банком
        name = "Building Roof",
        x = -938.033,
        y = -351.49,
        z = 17.8038,

        to = Vector(-900.367, -396.378, 56.0882),
		toAngle = -1.57207
    },
    {
        name = "El Banco Corrupto Grande",
        x = -915.398,
        y = -396.931,
        z = 56.0882,

        to = Vector(-934.899, -351.465, 17.8038),
		toAngle = -1.46852
    },
	// Здание VCN, около Love Rock вертолётная площадкая, с пасхалкой
	{
        name = "VCN Building Helipad",
        x = -410.515,
        y = 1121.87,
        z = 11.1456,

        to = Vector(-447.196, 1128.12, 56.6909),
		toAngle = -1.59316
    },
	{
        name = "VCN Building Entrance",
        x = -451.74,
        y = 1128.15,
        z = 56.6909,

        to = Vector(-410.808, 1116.65, 11.0709),
		toAngle = 3.09974
    },
	// Концертный зал Love Rock
	{
        name = "Love Fist Concert Hall Rooftop",
        x = -892.773,
        y = 1054.53,
        z = 15.6737,

        to = Vector(-893.528, 1057.45, 75.8666),
		toAngle = 1.10189
    },
	{
        name = "Love Fist Concert Hall",
        x = -890.453,
        y = 1055.32,
        z = 75.8666,

        to = Vector(-888.088, 1054.58, 14.6236),
		toAngle = -1.58817
    },
	// Вертолетная площадка в конце городе, около раллийной трассы
	{
        name = "Downtown Rooftop",
        x = -436.765,
        y = 1318.57,
         z = 11.767,

        to = Vector(-449.954, 1252.63, 77.4228),
		toAngle = 0.399704
    },
	{
        name = "Downtown",
        x = -448.447,
        y = 1250.34,
        z = 77.4062,

        to = Vector(-438.568, 1318.87, 11.767),
		toAngle = 1.24264
    }

];

// =========================================== S E R V E R   E V E N T S ==============================================

/*
function onServerStart()
{
}

function onServerStop()
{
}
*/

function onScriptLoad()
{
    // server info is printed in the console
    print( "------------------------------------" );
    print( "Server name: " + SRV_NAME );
    if( SRV_PASS != "" ) print( "Password: " + SRV_PASS );
    print( "------------------------------------" );
}

function onScriptUnload()
{
}

// =========================================== P L A Y E R   E V E N T S ==============================================

function onPlayerJoin( player )
{
}

function onPlayerPart( player, reason )
{
}

function onPlayerRequestClass( player, classID, team, skin )
{
    return 1;
}

function onPlayerRequestSpawn( player )
{
	return 1;
}

function onPlayerSpawn( player )
{
	//player.SetWeapon(33, 9999);
	//player.Armour = 100; 
	player.Cash = 1500;
}

function onPlayerDeath( player, reason )
{
}

//function onPlayerKill( player, killer, reason, bodypart )
function onPlayerKill( killer, player, reason, bodypart )
{
    //if(killer && killer != player)
    //{
    //    killer.Cash += 1000;

    //    MessagePlayer("[#81FF81]+$1000 for a kill!", killer);
    //}
}

function onPlayerTeamKill( player, killer, reason, bodypart )
{
}

function onPlayerChat( player, text )
{
	print( player.Name + ": " + text );
	return 1;
}

function onPlayerCommand( player, cmd, text )
{
	if(!DEBUG_MODE)
	{
		MessagePlayer("Debug commands are disabled.", player);
		return 1;
	}

	if(cmd == "health")
	{
		local hp = player.Health;
		if(hp == 100) Message("[#FF3636]Error - [#8181FF]Use this command when you have less than 100% hp !");
		else {
			player.Health = 100.0;
			MessagePlayer( "[#FFFF81]---> You have been healed !", player );
		}
	}
	
	else if(cmd == "bring") {
		if(!text) MessagePlayer( "Error - Correct syntax - /bring <Name/ID>' !",player );
		else {
			local plr = FindPlayer(text);
			if(!plr) MessagePlayer( "Error - Unknown player !",player);
			else {
				plr.Pos = player.Pos;
				MessagePlayer( "[ /" + cmd + " ] " + plr.Name + " was sent to " + player.Name, player );
			}
		}
	}
    
	else if(cmd == "exec") 
	{
		if( !text ) MessagePlayer( "Error - Syntax: /exec <Squirrel code>", player);
		else
		{
			try
			{
				local script = compilestring( text );
				script();
			}
			catch(e) MessagePlayer( "Error: " + e, player);
		}
	}
	
	else if(cmd == "where")
	{


		if(!player.Spawned) {
			MessagePlayer("You are not spawned yet!", player);
			return 1;
		}

		local pos = player.Pos;
		local angle = player.Angle;
		local msg = "You are at: X=" + pos.x + " Y=" + pos.y + " Z=" + pos.z + " | Angle=" + angle;
		
		print("WHERE MESSAGE: x=\"" + pos.x + "\" y=\"" + pos.y + "\" z=\"" + pos.z + "\" angle=\"" + angle + "\"");

		if(player.Vehicle) {
			local vehAngle = player.Vehicle.Angle;
			msg += " | Vehicle Angle=" + vehAngle;
		}

		MessagePlayer(msg, player);
	}
	
	else if(cmd == "tp" || cmd == "totp")
	{

		if(!player.Spawned) {
			MessagePlayer("You are not spawned yet!", player);
			return 1;
		}

		local pos = player.Pos;
		local angle = player.Angle;

		if(cmd == "tp")
		{
			print("");
			print("======== Teleport start ========");
			print("WHERE MESSAGE: x=\"" + pos.x + "\" y=\"" + pos.y + "\" z=\"" + pos.z + "\" angle=\"" + angle + "\"");
			print("    x = " + pos.x + ",");
			print("    y = " + pos.y + ",");
			print("    z = " + pos.z + ",");
			print("================================");
			print("");
		}
		else if(cmd == "totp")
		{
			print("");
			print("======== Teleport end ========");
			print("to = Vector(" + pos.x + ", " + pos.y + ", " + pos.z + "),");
			print("toAngle = " + angle);
			print("================================");
			print("");
		}
		MessagePlayer("Printed!", player);
	}
	
	else if(cmd == "up" || cmd == "down" || cmd == "left" || cmd == "right")
	{
		if(!player.Spawned) {
			MessagePlayer("You are not spawned yet!", player);
			return 1;
		}

		local pos = player.Pos;
		local angle = player.Angle;
		local distance = 10.0;

		// Направление вперёд
		local dx = sin(angle);
		local dy = cos(angle);

		if(cmd == "up")
		{
			pos.x += dx * distance;
			pos.y += dy * distance;
		}
		else if(cmd == "down")
		{
			pos.x -= dx * distance;
			pos.y -= dy * distance;
		}
		else if(cmd == "left")
		{
			pos.x += dy * distance;
			pos.y -= dx * distance;
		}
		else if(cmd == "right")
		{
			pos.x -= dy * distance;
			pos.y += dx * distance;
		}

		player.Pos = pos;
	}
	
	else if(cmd == "goto")
	{
		local args = split(text, " ");
		if(args.len() < 3) MessagePlayer("Usage: /goto <x> <y> <z>", player);
		else {
			local x = args[0].tofloat();
			local y = args[1].tofloat();
			local z = args[2].tofloat();
			player.Pos = Vector(x, y, z);
			MessagePlayer("Teleported to X=" + x + " Y=" + y + " Z=" + z, player);
		}
	}

	else if(cmd == "who")
	{
		local list = "";
		foreach(p in GetPlayers()) list += p.Name + " ";
		MessagePlayer("Players online: " + list, player);
	}
	
	else if(cmd == "armour")
	{
		player.Armour = 100;
		MessagePlayer("[#81FF81]You received full armour!", player);
	}

	else if(cmd == "guns")
	{
		player.SetWeapon(17, 500); // Pump Shotgun
		player.SetWeapon(24, 500); // M4
		player.SetWeapon(33, 2000); // Minigun
		MessagePlayer("[#FFAA00]Guns loaded!", player);
	}
	
	else if(cmd == "car")
	{
		if(!text) MessagePlayer("Usage: /car <id>", player);
		else {
			local id = text.tointeger();
			local veh = CreateVehicle(id, player.Pos.x, player.Pos.y, player.Pos.z, player.Angle);
			MessagePlayer("Vehicle " + id + " spawned!", player);
		}
	}


	else if(cmd == "kill")
	{
		player.Health = 0;
	}

    
	return 1;
}

function onPlayerPM( player, playerTo, message )
{
	return 1;
}

function onPlayerBeginTyping( player )
{
}

function onPlayerEndTyping( player )
{
}

/*
function onLoginAttempt( player )
{
	return 1;
}
*/

function onNameChangeable( player )
{
}

function onPlayerSpectate( player, target )
{
}

function onPlayerCrashDump( player, crash )
{
}

function onPlayerMove( player, lastX, lastY, lastZ, newX, newY, newZ )
{
    foreach(tp in Teleports)
    {
        local dx = newX - tp.x;
        local dy = newY - tp.y;
        local dz = newZ - tp.z;

        local dist = dx*dx + dy*dy + dz*dz;

        if(dist <= 0.4)
        {
			// Проверяем наличие денег
            if(player.Cash < 50)
            {
                MessagePlayer("[#FF3636]You need $100 to use this teleport!", player);
                return 1;
            }
			
            // Списываем $100
            player.Cash -= 50;

            //if(player.Vehicle)
            //{
			//	local veh = player.Vehicle;

			//	veh.Pos = Vector(tp.to.x, tp.to.y, tp.to.z + 0.5);
			//	veh.Angle = tp.toAngle;
            //}
            //else
            //{
                player.Pos = tp.to;
                player.Angle = tp.toAngle;
            //}

            MessagePlayer("[#81FF81]Entered to " + tp.name + " for $100.", player);
            return 1;
        }
    }

    return 1;
}

function onPlayerHealthChange( player, lastHP, newHP )
{
}

function onPlayerArmourChange( player, lastArmour, newArmour )
{
}

function onPlayerWeaponChange( player, oldWep, newWep )
{
}

function onPlayerAwayChange( player, status )
{
}

function onPlayerNameChange( player, oldName, newName )
{
}

function onPlayerActionChange( player, oldAction, newAction )
{
}

function onPlayerStateChange( player, oldState, newState )
{
}

function onPlayerOnFireChange( player, IsOnFireNow )
{
}

function onPlayerCrouchChange( player, IsCrouchingNow )
{
}

function onPlayerGameKeysChange( player, oldKeys, newKeys )
{
}

function onPlayerUpdate( player, update )
{
}

function onClientScriptData( player )
{
    // receiving client data
    local stream = Stream.ReadByte();
    switch ( stream )
    {
        case StreamType.ServerName:
        {
            Message( "Server received client's request, so it's sending back the server name." );
            // server received the request of client-side, so it sends back the server name
            SendDataToClient( player, StreamType.ServerName, SRV_NAME );
        }
        break;
    }
}

// ========================================== V E H I C L E   E V E N T S =============================================

function onPlayerEnteringVehicle( player, vehicle, door )
{
	return 1;
}

function onPlayerEnterVehicle( player, vehicle, door )
{
    if (vehicle.Model == 157)
    {
        player.Armour = 100;
        MessagePlayer("[#81FF81]You received 100% armour!", player);
    }
}

function onPlayerExitVehicle( player, vehicle )
{
}

function onVehicleExplode( vehicle )
{
}

function onVehicleRespawn( vehicle )
{
}

function onVehicleHealthChange( vehicle, oldHP, newHP )
{
}

function onVehicleMove( vehicle, lastX, lastY, lastZ, newX, newY, newZ )
{
}

// =========================================== P I C K U P   E V E N T S ==============================================

function onPickupClaimPicked( player, pickup )
{
	return 1;
}

// mapping: pickup.Model -> { wep = <weaponID>, ammo = <amount>, msg = "<text>" }
local PickupWeaponMap = {
    [259] = { wep = 1,  ammo = 1,   msg = "Brass Knuckles picked up" },
    [260] = { wep = 2,  ammo = 1,   msg = "Screwdriver picked up" },
    [261] = { wep = 3,  ammo = 1,   msg = "Golf Club picked up" },
    [262] = { wep = 4,  ammo = 1,   msg = "Nightstick picked up" },
    [263] = { wep = 5,  ammo = 1,   msg = "Knife picked up" },
    [264] = { wep = 6,  ammo = 1,   msg = "Baseball Bat picked up" },
    [265] = { wep = 7,  ammo = 1,   msg = "Hammer picked up" },
    [266] = { wep = 8,  ammo = 1,   msg = "Meat Cleaver picked up" },
    [267] = { wep = 9,  ammo = 1,   msg = "Machete picked up" },
    [268] = { wep = 10, ammo = 1,   msg = "Katana picked up" },
    [269] = { wep = 11, ammo = 1,   msg = "Chainsaw picked up" },

    [270] = { wep = 12, ammo = 10,  msg = "Grenade picked up" },
    [271] = { wep = 14, ammo = 10,  msg = "Teargas picked up" },
    [272] = { wep = 15, ammo = 10,  msg = "Molotov Cocktail picked up" },

    [274] = { wep = 17, ammo = 100, msg = "Colt .45 picked up" },
    [275] = { wep = 18, ammo = 100, msg = "Python picked up" },

    [277] = { wep = 19, ammo = 50,  msg = "Shotgun picked up" },
    [278] = { wep = 20, ammo = 90,  msg = "Spaz Shotgun picked up" },
    [279] = { wep = 21, ammo = 50,  msg = "Stubby Shotgun picked up" },

    [280] = { wep = 26, ammo = 200, msg = "M4 picked up" },
    [281] = { wep = 22, ammo = 100, msg = "Tec-9 picked up" },
    [282] = { wep = 23, ammo = 100, msg = "Uzi picked up" },
    [283] = { wep = 24, ammo = 90,  msg = "Ingram picked up" },
    [284] = { wep = 25, ammo = 100, msg = "MP5 picked up" },
    [285] = { wep = 28, ammo = 50,  msg = "Sniper Rifle picked up" },
    [286] = { wep = 29, ammo = 50,  msg = "Laser Sniper picked up" },

    [287] = { wep = 30, ammo = 20,  msg = "RPG picked up" },
    [288] = { wep = 31, ammo = 400, msg = "Flame Thrower picked up" },
    [289] = { wep = 32, ammo = 200, msg = "M60 picked up" },
    [290] = { wep = 33, ammo = 500, msg = "Minigun picked up" },
    [291] = { wep = 13, ammo = 10,  msg = "Remote Grenade picked up" },

    [292] = { wep = 34, ammo = 1,   msg = "Camera picked up" },

    // Дополнительные модели Minigun
    [294] = { wep = 33, ammo = 500, msg = "Minigun picked up" }
};

function onPickupPickedUp(player, pickup)
{
    // защита
    if(!player || !pickup) return 1;

    local info = PickupWeaponMap.rawin(pickup.Model) ? PickupWeaponMap[pickup.Model] : null;
    if(info != null)
    {
        // выдать оружие (через SetWeapon)
        player.SetWeapon(info.wep, info.ammo);

        // опционально: уведомление игроку
        MessagePlayer("[#81FF81]" + info.msg, player);

        // опционально: удалить/пересоздать пикап вручную (если хочешь контролировать респаун)
        // RemovePickup(pickup); CreatePickup(pickup.Model, pickup.Type, pickup.Pos.x, pickup.Pos.y, pickup.Pos.z);

        // Возвращаем 1 — обработка завершена
        return 1;
    }
	
	// 💉 Пикап здоровья (model 366)
    if (pickup.Model == 366)
    {
        player.Health = 100;
        MessagePlayer("[#81FF81]Health restored to 100!", player);
        return 1;
    }

    // 🛡️ Пикап брони (model 368)
    if (pickup.Model == 368)
    {
        player.Armour = 100;
        MessagePlayer("[#81FF81]Armour restored to 100!", player);
        return 1;
    }
	
	// 💉 Пикап денег (model 337)
    if (pickup.Model == 337)
    {
		local money = rand() % 81 + 20;
		player.Cash += money;

		MessagePlayer("[#81FF81]You found $" + money + "!", player);
        return 1;
    }
	
    // Car fix
    if (pickup.Model == 370)
    {
		if(player.Vehicle)
		{
			if(player.Cash < 500)
			{
				MessagePlayer("[#FF3636]You need $500 to repair your vehicle!", player);
				return 1;
			}

			player.Cash -= 500;
			player.Vehicle.Health = 1000;

			MessagePlayer("[#81FF81]Vehicle repaired for $500!", player);
		}
		else
		{
			MessagePlayer("[#FF3636]You are not in a vehicle!", player);
		}

		return 1;
    }

    // для остальных пикапов оставить поведение по-умолчанию
    return 1;
}

function onPickupRespawn( pickup )
{
}

// ========================================== O B J E C T   E V E N T S ==============================================

function onObjectShot( object, player, weapon )
{
}

function onObjectBump( object, player )
{
}

// ====================================== C H E C K P O I N T   E V E N T S ==========================================

function onCheckpointEntered( player, checkpoint )
{
}

function onCheckpointExited( player, checkpoint )
{
}

// =========================================== B I N D   E V E N T S =================================================

function onKeyDown( player, key )
{
}

function onKeyUp( player, key )
{
}

// ================================== E N D   OF   O F F I C I A L   E V E N T S ======================================


function SendDataToClient( player, ... )
{
    if( vargv[0] )
    {
        local     byte = vargv[0],
                len = vargv.len();
                
        if( 1 > len ) devprint( "ToClent <" + byte + "> No params specified." );
        else
        {
            Stream.StartWrite();
            Stream.WriteByte( byte );

            for( local i = 1; i < len; i++ )
            {
                switch( typeof( vargv[i] ) )
                {
                    case "integer": Stream.WriteInt( vargv[i] ); break;
                    case "string": Stream.WriteString( vargv[i] ); break;
                    case "float": Stream.WriteFloat( vargv[i] ); break;
                }
            }
            
            if( player == null ) Stream.SendStream( null );
            else if( typeof( player ) == "instance" ) Stream.SendStream( player );
            else devprint( "ToClient <" + byte + "> Player is not online." );
        }
    }
    else devprint( "ToClient: Even the byte wasn't specified..." );
}