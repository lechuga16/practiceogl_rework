#pragma semicolon 1
#pragma newdecls required;

#include <sourcemod>
#include <readyup>

#define TEAM_SPECTATORS         1
#define TEAM_SURVIVORS          2
#define TEAM_INFECTED           3

// ========================
//  Plugin Variables
// ========================
// Game Cvars
ConVar
InfiniteAmmo;

bool 
g_bGT_TankIsInPlay;

public Plugin myinfo =
{
	name = "Practice Commands",
	author = "epilimic, lechuga",
	description = "commands for practice support",
	version = "1.1",
	url = "https://github.com/lechuga16/practiceogl_rework"
}

public void OnPluginStart()
{
	// Commands
	RegConsoleCmd("sm_tank", Spawntank_Cmd, "respawn a tank");
	RegConsoleCmd("sm_witch", Spawnwitch_Cmd, "respawn a witch");
	
	InfiniteAmmo = FindConVar("sv_infinite_ammo");
}

public void OnRoundIsLive()
{
	for (int client = 1; client <= MaxClients; client++){
		if (IsClientInGame(client) && GetClientTeam(client) == TEAM_SURVIVORS && IsPlayerAlive(client)){
			SetEntityHealth(client, 20000);
		}
	}
	
	InfiniteAmmo.Flags &= ~FCVAR_NOTIFY;
	InfiniteAmmo.SetBool(true);
	InfiniteAmmo.Flags |= FCVAR_NOTIFY;
}

public bool IsTankInPlay()
{
	return g_bGT_TankIsInPlay;
}

public Action Spawntank_Cmd(int client, int args)
{
	if (GetClientTeam(client) == TEAM_SURVIVORS || GetClientTeam(client) == TEAM_INFECTED)
	{
		if (client > 0 && !IsTankInPlay())
		{
			int flags = GetCommandFlags("z_spawn");
			SetCommandFlags("z_spawn", flags ^ 16384);
			FakeClientCommand(client, "z_spawn tank");
			SetCommandFlags("z_spawn", flags);
		}
	}
	return Plugin_Continue;
}

public Action Spawnwitch_Cmd(int client, int args)
{
	if (GetClientTeam(client) == TEAM_SURVIVORS || GetClientTeam(client) == TEAM_INFECTED)
	{
		if (client > 0)
		{
			int flags = GetCommandFlags("z_spawn");
			SetCommandFlags("z_spawn", flags ^ 16384);
			FakeClientCommand(client, "z_spawn witch");
			SetCommandFlags("z_spawn", flags);
		}
	}
	return Plugin_Continue;
}