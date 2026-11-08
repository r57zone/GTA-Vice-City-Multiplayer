/*
Vice City Multiplayer 0.4 Blank Server (by Sebastian) for 64bit Windows.
You can use it to script your own server. Here you can find all events developed.

VC:MP Official: www.vc-mp.org
Forum: forum.vc-mp.org
Wiki: wiki.vc-mp.org
*/

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
	player.Armour = 100; 
}

function onPlayerDeath( player, reason )
{
}

function onPlayerKill( player, killer, reason, bodypart )
{
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
	if(cmd == "heal")
	{
		local hp = player.Health;
		if(hp == 100) Message("[#FF3636]Error - [#8181FF]Use this command when you have less than 100% hp !");
		else {
			player.Health = 100.0;
			MessagePlayer( "[#FFFF81]---> You have been healed !", player );
		}
	}
	
	else if(cmd == "goto") {
		if(!text) MessagePlayer( "Error - Correct syntax - /goto <Name/ID>' !",player );
		else {
			local plr = FindPlayer(text);
			if(!plr) MessagePlayer( "Error - Unknown player !",player);
			else {
				player.Pos = plr.Pos;
				MessagePlayer( "[ /" + cmd + " ] " + player.Name + " was sent to " + plr.Name, player );
			}
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
		local msg = "You are at: X=" + pos.x + " Y=" + pos.y + " Z=" + pos.z + " | Angle=" + angle + "°";

		if(player.Vehicle) {
			local vehAngle = player.Vehicle.Angle;
			msg += " | Vehicle Angle=" + vehAngle + "°";
		}

		MessagePlayer(msg, player);
	}
	
	else if(cmd == "goto2")
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
	
	else if(cmd == "fix")
	{
		if(player.Vehicle) {
			player.Vehicle.Health = 1000;
			MessagePlayer("Vehicle repaired!", player);
		} else MessagePlayer("You are not in a vehicle!", player);
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
    [283] = { wep = 24, ammo = 90, msg = "Ingram picked up" },
    [290] = { wep = 33, ammo = 500, msg = "Minigun picked up" },
    [287] = { wep = 30, ammo = 30, msg = "RPG picked up" },
    [288] = { wep = 31, ammo = 400, msg = "Flame Thrower picked up" },
    [278] = { wep = 20, ammo = 90, msg = "Spaz Shotgun picked up" }
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