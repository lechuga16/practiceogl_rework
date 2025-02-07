#pragma semicolon 1
#pragma newdecls required;

#include <sourcemod>
#include <colors>
#include <left4dhooks>

#undef REQUIRE_PLUGIN
#include <readyup>
#define REQUIRE_PLUGIN

ConVar
	g_cvarLife;

public Plugin myinfo =
{
	name = "Practice Commands",
	author = "lechuga",
	description = "commands for practice support",
	version = "2",
	url = "https://github.com/lechuga16/practiceogl_rework"
}

public void OnPluginStart()
{
	g_cvarLife = CreateConVar("sm_pr_life", "10000", "Changes the maximum survivor life", FCVAR_NONE, true, 1.0);
	
	RegConsoleCmd("sm_give", CMD_Give, "Gives items to players.");
	RegConsoleCmd("sm_spawn", CMD_ZSpawn, "Spawns a special sInfected.");
}

public void OnRoundIsLive()
{
	for (int iClient = 1; iClient <= MaxClients; iClient++){
		if (IsClientInGame(iClient) && L4D_GetClientTeam(iClient) == L4DTeam_Survivor && IsPlayerAlive(iClient)){
			SetEntityHealth(iClient, g_cvarLife.IntValue);
		}
	}
}

public Action CMD_Give(int iClient, int iArgs)
{
	if (iClient == 0)
	{
		ConsoleUseGive(iClient, iArgs);
		return Plugin_Handled;
	}

	if (!IsClientInGame(iClient))
	{
		ReplyToCommand(iClient, "Debes estar dentro del juego.");
		return Plugin_Handled;
	}
	if (L4D_GetClientTeam(iClient) != L4DTeam_Survivor)
	{
		ReplyToCommand(iClient, "Debes estar en el equipo de sobrevivientes.");
		return Plugin_Handled;
	}

	char item[32];
	GetCmdArg(1, item, sizeof(item));

	int iCmdFlags = GetCommandFlags("give");
	SetCommandFlags("give", iCmdFlags & ~FCVAR_CHEAT);
	FakeClientCommand(iClient, "give %s", item);
	SetCommandFlags("give", iCmdFlags);

	CPrintToChat(iClient, "Recibiste un(a) %s.", item);
	return Plugin_Handled;
}

public void ConsoleUseGive(int iClient, int iArgs)
{
	char item[32];
	GetCmdArg(2, item, sizeof(item));
	char target[32];
	char target_name[32];
	int target_list[MAXPLAYERS];
	int target_count;
	bool tn_is_ml;
	GetCmdArg(1, target, sizeof(target));
	if ((target_count = ProcessTargetString(target, iClient, target_list, MAXPLAYERS, COMMAND_FILTER_ALIVE, target_name, sizeof(target_name), tn_is_ml)) <= 0)
	{
		ReplyToTargetError(iClient, target_count);
	}
	for (int iPlayer = 0; iPlayer < target_count; iPlayer++)
	{
		if (target_list[iPlayer] == 0)
		{
			ReplyToCommand(iClient, "No puedes apuntar a la consola.");
			continue;
		}
		if (!IsClientInGame(target_list[iPlayer]))
		{
			ReplyToCommand(iClient, "El jugador debe estar dentro del juego.");
			continue;
		}
		if (L4D_GetClientTeam(target_list[iPlayer]) != L4DTeam_Survivor)
		{
			ReplyToCommand(iClient, "El jugador debe estar en el equipo de sobrevivientes.");
			continue;
		}

		int iCmdFlags = GetCommandFlags("give");
		SetCommandFlags("give", iCmdFlags & ~FCVAR_CHEAT);
		FakeClientCommand(target_list[iPlayer], "give %s", item);
		SetCommandFlags("give", iCmdFlags);
		CPrintToChat(target_list[iPlayer], "Recibiste un(a) %s desde la consola %s.", item);
	}
}

public Action CMD_ZSpawn(int iClient, int iArgs)
{
	if (L4D_GetClientTeam(iClient) != L4DTeam_Survivor && L4D_GetClientTeam(iClient) != L4DTeam_Infected)
	{
		ReplyToCommand(iClient, "Debes estar dentro de algun equipo juego.");
		return Plugin_Handled;
	}

	char sInfected[32];
	GetCmdArg(1, sInfected, sizeof(sInfected));

	/*
	int iCmdFlags = GetCommandFlags("z_spawn");
	SetCommandFlags("z_spawn", iCmdFlags & ~FCVAR_CHEAT);
	FakeClientCommand(iClient, "z_spawn %s", sInfected);
	SetCommandFlags("z_spawn", iCmdFlags);
	*/
	L4D2ZombieClassType iZombieClass = L4D2ZombieClass_NotInfected;
	for (int i = 0; i < sizeof(L4D2ZombieClassname) + 1; i++)
	{
		if (StrEqual(L4D2ZombieClassname[i], sInfected, false))
		{
			iZombieClass = view_as<L4D2ZombieClassType>(i + 1); // +1 because L4D2ZombieClassType starts at 1
			break;
		}
	}

	float fVecPos[3];
	L4D_GetRandomPZSpawnPosition(iClient, view_as<int>(iZombieClass), 20, fVecPos);

	switch (iZombieClass)
	{
		case L4D2ZombieClass_Witch:
			L4D2_SpawnWitch(fVecPos, NULL_VECTOR);
		case L4D2ZombieClass_Tank:
			L4D2_SpawnTank(fVecPos, NULL_VECTOR);
		default:
			L4D2_SpawnSpecial((view_as<int>(iZombieClass) ), fVecPos, NULL_VECTOR);
	}
	CPrintToChat(iClient, "Has invocado un(a) %s.", sInfected);
	return Plugin_Handled;
}