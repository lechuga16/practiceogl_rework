#pragma semicolon 1
 
#include <sourcemod>
#include <sdktools>
#include <l4d2util_infected>
#include <colors>

new bool:g_bGT_TankIsInPlay;
 
public Plugin:myinfo =
{
		name = "Practice Commands",
		author = "epilimic, lechuga",
		description = "commands for practice support",
		version = "1.0",
		url = "-"
}

public OnPluginStart()
{
	RegConsoleCmd("sm_tank", Spawntank_Cmd, "", 0);
	RegConsoleCmd("sm_witch", Spawnwitch_Cmd, "", 0);
	RegConsoleCmd("sm_ammo", Giveammo_Cmd, "", 0);
}

 public OnRoundIsLive()
{
	new i = 1;
	while (i <= MaxClients)
	{
		if (IsClientInGame(i) && GetClientTeam(i) == 2 && IsPlayerAlive(i))
		{
			SetEntityHealth(i, 20000);
		}
		i++;
	}
	return 0;
}

public IsTankInPlay()
{
    return g_bGT_TankIsInPlay;
}

public Action:Spawntank_Cmd(client, args)
{
	if (client > 0 && !IsTankInPlay())
	{
		new flags = GetCommandFlags("z_spawn");
		SetCommandFlags("z_spawn", flags ^ 16384);
		FakeClientCommand(client, "z_spawn tank");
		SetCommandFlags("z_spawn", flags);
	}
	return Action:3;
}

public Action:Spawnwitch_Cmd(client, args)
{
	if (client > 0)
	{
		new flags = GetCommandFlags("z_spawn");
		SetCommandFlags("z_spawn", flags ^ 16384);
		FakeClientCommand(client, "z_spawn witch");
		SetCommandFlags("z_spawn", flags);
	}
	return Action:3;
}

public Action:Giveammo_Cmd(client, args)
{
	if (0 < client)
	{
		new flags = GetCommandFlags("give");
		SetCommandFlags("give", flags ^ 16384);
		FakeClientCommand(client, "give ammo");
		SetCommandFlags("give", flags);
	}
	return Action:3;
}
