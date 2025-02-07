#pragma semicolon 1
#pragma newdecls required;

#include <sourcemod>
#include <colors>
#include <left4dhooks>

#undef REQUIRE_PLUGIN
#include <readyup>
#define REQUIRE_PLUGIN

#define CONSOLE 0

ConVar
	g_cvarLife;

// for some reason it won't let you compile from left4dhooks
static const char L4D2WeaponNameFix[L4D2WeaponId][] =
{
	"weapon_none",					// 0
	"weapon_pistol",				// 1
	"weapon_smg",					// 2
	"weapon_pumpshotgun",			// 3
	"weapon_autoshotgun",			// 4
	"weapon_rifle",					// 5
	"weapon_hunting_rifle",			// 6
	"weapon_smg_silenced",			// 7
	"weapon_shotgun_chrome",		// 8
	"weapon_rifle_desert",			// 9
	"weapon_sniper_military",		// 10
	"weapon_shotgun_spas",			// 11
	"weapon_first_aid_kit",			// 12
	"weapon_molotov",				// 13
	"weapon_pipe_bomb",				// 14
	"weapon_pain_pills",			// 15
	"weapon_gascan",				// 16
	"weapon_propanetank",			// 17
	"weapon_oxygentank",			// 18
	"",					// 19
	"weapon_chainsaw",				// 20
	"weapon_grenade_launcher",		// 21
	"",				// 22
	"weapon_adrenaline",			// 23
	"weapon_defibrillator",			// 24
	"weapon_vomitjar",				// 25
	"weapon_rifle_ak47",			// 26
	"weapon_gnome",					// 27
	"weapon_cola_bottles",			// 28
	"weapon_fireworkcrate",			// 29
	"weapon_upgradepack_incendiary",	// 30
	"weapon_upgradepack_explosive",		// 31
	"weapon_pistol_magnum",			// 32
	"weapon_smg_mp5",				// 33
	"weapon_rifle_sg552",			// 34
	"weapon_sniper_awp",			// 35
	"weapon_sniper_scout",			// 36
	"weapon_rifle_m60",				// 37
	"",				// 38
	"",			// 39
	"",			// 40
	"",			// 41
	"",			// 42
	"",			// 43
	"",			// 44
	"",			// 45
	"",						// 46
	"",						// 47
	"",						// 48
	"",						// 49
	"",							// 50
	"",						// 51
	"",							// 52
	"",						// 53
	"",					// 54
	"",					// 55
	""
};

public Plugin myinfo =
{
	name		= "Practice Commands",
	author		= "lechuga",
	description = "commands for practice support",
	version		= "2",
	url			= "https://github.com/lechuga16/practiceogl_rework"
}

public void OnPluginStart()
{
	LoadTranslation("practiceogl.phrases");
	LoadTranslation("common.phrases");
	g_cvarLife = CreateConVar("sm_pr_life", "10000", "Changes the maximum survivor life", FCVAR_NONE, true, 1.0);

	RegConsoleCmd("sm_give", CMD_Give, "Gives items to players.");
	RegConsoleCmd("sm_spawn", CMD_ZSpawn, "Spawns a special sInfected.");
}

public void OnRoundIsLive()
{
	for (int iClient = 1; iClient <= MaxClients; iClient++)
	{
		if (IsClientInGame(iClient) && L4D_GetClientTeam(iClient) == L4DTeam_Survivor && IsPlayerAlive(iClient))
		{
			CPrintToChat(iClient, "%t %t", "Tag", "AddLife", g_cvarLife.IntValue);
			SetEntityHealth(iClient, g_cvarLife.IntValue);
		}
	}
}

public void OnMapStart()
{
	// Precache Bill
	if (!IsModelPrecached("models/survivors/survivor_namvet.mdl"))
		PrecacheModel("models/survivors/survivor_namvet.mdl");

	// Precache L4D1 Survivors
	if (!IsModelPrecached("models/survivors/survivor_teenangst.mdl"))
		PrecacheModel("models/survivors/survivor_teenangst.mdl");
	if (!IsModelPrecached("models/survivors/survivor_biker.mdl"))
		PrecacheModel("models/survivors/survivor_biker.mdl");
	if (!IsModelPrecached("models/survivors/survivor_manager.mdl"))
		PrecacheModel("models/survivors/survivor_manager.mdl");

	// Precache M60
	if (!IsModelPrecached("models/v_models/v_m60.mdl"))
		PrecacheModel("models/v_models/v_m60.mdl");
	if (!IsModelPrecached("models/w_models/weapons/w_m60.mdl"))
		PrecacheModel("models/w_models/weapons/w_m60.mdl");

	// Precache CSS Weapons
	if (!IsModelPrecached("models/v_models/v_rif_sg552.mdl"))
		PrecacheModel("models/v_models/v_rif_sg552.mdl");
	if (!IsModelPrecached("models/w_models/weapons/w_rifle_sg552.mdl"))
		PrecacheModel("models/w_models/weapons/w_rifle_sg552.mdl");
	if (!IsModelPrecached("models/v_models/v_snip_awp.mdl"))
		PrecacheModel("models/v_models/v_snip_awp.mdl");
	if (!IsModelPrecached("models/w_models/weapons/w_sniper_awp.mdl"))
		PrecacheModel("models/w_models/weapons/w_sniper_awp.mdl");
	if (!IsModelPrecached("models/v_models/v_snip_scout.mdl"))
		PrecacheModel("models/v_models/v_snip_scout .mdl");
	if (!IsModelPrecached("models/w_models/weapons/w_sniper_scout.mdl"))
		PrecacheModel("models/w_models/weapons/w_sniper_scout.mdl");
	if (!IsModelPrecached("models/v_models/v_smg_mp5.mdl"))
		PrecacheModel("models/v_models/v_smg_mp5.mdl");
	if (!IsModelPrecached("models/w_models/weapons/w_smg_mp5.mdl"))
		PrecacheModel("models/w_models/weapons/w_smg_mp5.mdl");
	if (!IsModelPrecached("models/v_models/v_knife_t.mdl"))
		PrecacheModel("models/v_models/v_knife_t.mdl");
	if (!IsModelPrecached("models/w_models/weapons/w_knife_t.mdl"))
		PrecacheModel("models/w_models/weapons/w_knife_t.mdl");

	// Precache Melee Weapons
	if (!IsModelPrecached("models/weapons/melee/v_golfculb.mdl"))
		PrecacheModel("models/weapons/melee/v_golfculb.mdl");
	if (!IsModelPrecached("models/weapons/melee/w_golfculb.mdl"))
		PrecacheModel("models/weapons/melee/w_golfculb.mdl");
	if (!IsModelPrecached("models/weapons/melee/v_bat.mdl"))
		PrecacheModel("models/weapons/melee/v_bat.mdl");
	if (!IsModelPrecached("models/weapons/melee/w_bat.mdl"))
		PrecacheModel("models/weapons/melee/w_bat.mdl");
	if (!IsModelPrecached("models/weapons/melee/v_riotshield.mdl"))
		PrecacheModel("models/weapons/melee/v_riotshield.mdl");
	if (!IsModelPrecached("models/weapons/melee/w_riotshield.mdl"))
		PrecacheModel("models/weapons/melee/w_riotshield.mdl");
	if (!IsModelPrecached("models/weapons/melee/v_tonfa.mdl"))
		PrecacheModel("models/weapons/melee/v_tonfa.mdl");
	if (!IsModelPrecached("models/weapons/melee/w_tonfa.mdl"))
		PrecacheModel("models/weapons/melee/w_tonfa.mdl");

	// Precache Misc
	if (!IsModelPrecached("models/v_models/v_bile_flask.mdl"))
		PrecacheModel("models/v_models/v_bile_flask.mdl");
	if (!IsModelPrecached("models/w_models/weapons/w_eq_bile_flask.mdl"))
		PrecacheModel("models/w_models/weapons/w_eq_bile_flask.mdl");
	if (!IsModelPrecached("models/w_models/weapons/v_cola.mdl"))
		PrecacheModel("models/w_models/weapons/v_cola.mdl");
	if (!IsModelPrecached("models/w_models/weapons/W_cola.mdl"))
		PrecacheModel("models/w_models/weapons/W_cola.mdl");
	if (!IsModelPrecached("models/weapons/melee/v_gnome.mdl"))
		PrecacheModel("models/weapons/melee/v_gnome.mdl");
	if (!IsModelPrecached("models/weapons/melee/w_gnome.mdl"))
		PrecacheModel("models/weapons/melee/w_gnome.mdl");

	// Precache Tank
	if (!IsModelPrecached("models/infected/hulk.mdl"))
		PrecacheModel("models/infected/hulk.mdl");

	// Precache Witch
	if (!IsModelPrecached("models/infected/witch.mdl"))
		PrecacheModel("models/infected/witch.mdl");
	if (!IsModelPrecached("models/infected/witch_bride.mdl"))
		PrecacheModel("models/infected/witch_bride.mdl");

	// Precache Infected
	if (!IsModelPrecached("models/infected/boomette.mdl"))
		PrecacheModel("models/infected/boomette.mdl");
	if (!IsModelPrecached("models/infected/common_male_ceda.mdl"))
		PrecacheModel("models/infected/common_male_ceda.mdl");
	if (!IsModelPrecached("models/infected/common_male_clown.mdl"))
		PrecacheModel("models/infected/common_male_clown.mdl");
	if (!IsModelPrecached("models/infected/common_male_fallen_survivor.mdl"))
		PrecacheModel("models/infected/common_male_fallen_survivor.mdl");
	if (!IsModelPrecached("models/infected/common_male_jimmy.mdl"))
		PrecacheModel("models/infected/common_male_jimmy.mdl");
	if (!IsModelPrecached("models/infected/common_male_mud.mdl"))
		PrecacheModel("models/infected/common_male_mud.mdl");
	if (!IsModelPrecached("models/infected/common_male_riot.mdl"))
		PrecacheModel("models/infected/common_male_riot.mdl");
	if (!IsModelPrecached("models/infected/common_male_roadcrew.mdl"))
		PrecacheModel("models/infected/common_male_roadcrew.mdl");
}

public Action CMD_Give(int iClient, int iArgs)
{
	if (iClient == CONSOLE)
	{
		ConsoleGive(iArgs);
		return Plugin_Handled;
	}

	if (!IsClientInGame(iClient))
	{
		CReplyToCommand(iClient, "%t %t", "Tag", "ClientNotInGame");
		return Plugin_Handled;
	}
	if (L4D_GetClientTeam(iClient) != L4DTeam_Survivor)
	{
		CReplyToCommand(iClient, "%t %t", "Tag", "ClientNotInTeam");
		return Plugin_Handled;
	}

	char sItem[32];
	GetCmdArg(1, sItem, sizeof(sItem));

	if (StrEqual(sItem, "", false))
	{
		CPrintToChat(iClient, "%t %t: sm_give <Item>", "Tag", "Use");
		CPrintToChat(iClient, "%t %t", "Tag", "ShowItems");
		PrintToConsole(iClient, "%t", "ItemsInfo");
		for(L4D2WeaponId i = L4D2WeaponId_Pistol; i <= L4D2WeaponId_MAX; i++)
		{
			if (StrEqual(L4D2WeaponNameFix[i], "", false))
			 	continue;
			
			PrintToConsole(iClient, "> %s", L4D2WeaponNameFix[i]);
		}
		return Plugin_Handled;
	}

	int iCmdFlags = GetCommandFlags("give");
	SetCommandFlags("give", iCmdFlags & ~FCVAR_CHEAT);
	FakeClientCommand(iClient, "give %s", sItem);
	SetCommandFlags("give", iCmdFlags);

	CPrintToChat(iClient, "%t %t", "Tag", "AddedItem", sItem);
	return Plugin_Handled;
}

public void ConsoleGive(int iArgs)
{
	char sItem[32];
	GetCmdArg(2, sItem, sizeof(sItem));
	char target[32];
	char target_name[32];
	int	 target_list[MAXPLAYERS];
	int	 target_count;
	bool tn_is_ml;
	GetCmdArg(1, target, sizeof(target));
	if ((target_count = ProcessTargetString(target, CONSOLE, target_list, MAXPLAYERS, COMMAND_FILTER_ALIVE, target_name, sizeof(target_name), tn_is_ml)) <= 0)
	{
		ReplyToTargetError(CONSOLE, target_count);
	}
	for (int iPlayer = 0; iPlayer < target_count; iPlayer++)
	{
		if (target_list[iPlayer] == CONSOLE)
		{
			CReplyToCommand(CONSOLE, "%t %t", "Tag", "TargetConsole");
			continue;
		}
		if (!IsClientInGame(target_list[iPlayer]))
		{
			CReplyToCommand(CONSOLE, "%t %t", "Tag", "ConsoleNotInGame");
			continue;
		}
		if (L4D_GetClientTeam(target_list[iPlayer]) != L4DTeam_Survivor)
		{
			CReplyToCommand(CONSOLE, "%t %t", "Tag", "ConsoleNotInTeam");
			continue;
		}

		int iCmdFlags = GetCommandFlags("give");
		SetCommandFlags("give", iCmdFlags & ~FCVAR_CHEAT);
		FakeClientCommand(target_list[iPlayer], "give %s", sItem);
		SetCommandFlags("give", iCmdFlags);
		CPrintToChat(target_list[iPlayer], "%t %t", "Tag", "ConsoleAddedItem", sItem);
	}
}

public Action CMD_ZSpawn(int iClient, int iArgs)
{
	if (L4D_GetClientTeam(iClient) != L4DTeam_Survivor && L4D_GetClientTeam(iClient) != L4DTeam_Infected)
	{
		CReplyToCommand(iClient, "%t %t", "Tag", "ClientNotInAnyTeam");
		return Plugin_Handled;
	}

	char sInfected[32];
	GetCmdArg(1, sInfected, sizeof(sInfected));

	if (StrEqual(sInfected, "", false))
	{
		CPrintToChat(iClient, "%t %t: sm_spawn <Infected>", "Tag", "Use");
		CPrintToChat(iClient, "%t %t", "Tag", "ShowInfected");
		PrintToConsole(iClient, "%t", "InfectedInfo");
		for(int i = 0; i < sizeof(L4D2ZombieClassname); i++)
		{
			if (StrEqual(L4D2ZombieClassname[i], "error_bad_L4D2ZombieClassType", false))
			 	continue;
			
			PrintToConsole(iClient, "> %s", L4D2ZombieClassname[i]);
		}
		return Plugin_Handled;
	}

	L4D2ZombieClassType iZombieClass = L4D2ZombieClass_NotInfected;
	for (int i = 0; i < sizeof(L4D2ZombieClassname) + 1; i++)
	{
		if (StrEqual(L4D2ZombieClassname[i], sInfected, false))
		{
			iZombieClass = view_as<L4D2ZombieClassType>(i + 1);	   // +1 porque L4D2ZombieClassType empieza en 1
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
			L4D2_SpawnSpecial((view_as<int>(iZombieClass)), fVecPos, NULL_VECTOR);
	}
	CPrintToChat(iClient, "%t %t", "Tag", "Spawned", sInfected);
	return Plugin_Handled;
}

/**
 * Check if the translation file exists
 *
 * @param translation	Translation name.
 * @noreturn
 */
stock void LoadTranslation(const char[] translation)
{
	char
		sPath[PLATFORM_MAX_PATH],
		sName[64];

	Format(sName, sizeof(sName), "translations/%s.txt", translation);
	BuildPath(Path_SM, sPath, sizeof(sPath), sName);
	if (!FileExists(sPath))
		SetFailState("Missing translation file %s.txt", translation);

	LoadTranslations(translation);
}
