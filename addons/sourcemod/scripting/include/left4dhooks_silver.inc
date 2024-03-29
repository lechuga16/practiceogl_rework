/*
*	Left 4 DHooks Direct - Stock Functions
*	Copyright (C) 2022 Silvers
*
*	This program is free software: you can redistribute it and/or modify
*	it under the terms of the GNU General Public License as published by
*	the Free Software Foundation, either version 3 of the License, or
*	(at your option) any later version.
*
*	This program is distributed in the hope that it will be useful,
*	but WITHOUT ANY WARRANTY; without even the implied warranty of
*	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*	GNU General Public License for more details.
*
*	You should have received a copy of the GNU General Public License
*	along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#if defined _l4d_silver_included
 #endinput
#endif
#define _l4d_silver_included

#include <sdktools>
#include <sdkhooks>

#tryinclude <left4dhooks_anim>
#tryinclude <left4dhooks_stocks>
#tryinclude <left4dhooks_lux_library>





// ====================================================================================================
// ENUMS
// ====================================================================================================
enum
{
	L4D_TEAM_UNASSIGNED			= 0,
	L4D_TEAM_SPECTATOR			= 1,
	L4D_TEAM_SURVIVOR			= 2,
	L4D_TEAM_INFECTED			= 3,
	L4D_TEAM_FOUR				= 4
}

enum
{
	L4D_WEAPON_SLOT_PRIMARY		= 0,
	L4D_WEAPON_SLOT_SECONDARY	= 1,
	L4D_WEAPON_SLOT_GRENADE		= 2,
	L4D_WEAPON_SLOT_MEDKIT		= 3,	// L4D2: Also upgrade ammo packs and defibrillator
	L4D_WEAPON_SLOT_PILLS		= 4,	// L4D2: Also Adrenaline
	L4D_WEAPON_SLOT_CARRIED		= 5		// Physics props such as GasCan etc.
}

enum
{
	L4D1_ZOMBIE_CLASS_SMOKER	= 1,
	L4D1_ZOMBIE_CLASS_BOOMER	= 2,
	L4D1_ZOMBIE_CLASS_HUNTER	= 3,
	L4D1_ZOMBIE_CLASS_WITCH		= 4,
	L4D1_ZOMBIE_CLASS_TANK		= 5
}

enum
{
	L4D2_ZOMBIE_CLASS_SMOKER	= 1,
	L4D2_ZOMBIE_CLASS_BOOMER	= 2,
	L4D2_ZOMBIE_CLASS_HUNTER	= 3,
	L4D2_ZOMBIE_CLASS_SPITTER	= 4,
	L4D2_ZOMBIE_CLASS_JOCKEY	= 5,
	L4D2_ZOMBIE_CLASS_CHARGER	= 6,
	L4D2_ZOMBIE_CLASS_WITCH		= 7,
	L4D2_ZOMBIE_CLASS_TANK		= 8
}

enum
{
	SERVER_OS_WINDOWS			= 0,
	SERVER_OS_LINUX				= 1,
}

// Thanks to "Dragokas":
enum // m_eDoorState
{
	DOOR_STATE_CLOSED,
	DOOR_STATE_OPENING_IN_PROGRESS,
	DOOR_STATE_OPENED,
	DOOR_STATE_CLOSING_IN_PROGRESS
}

// Thanks to "Dragokas":
enum // m_spawnflags
{
	DOOR_FLAG_STARTS_OPEN		= 1,
	DOOR_FLAG_STARTS_LOCKED		= 2048,
	DOOR_FLAG_SILENT			= 4096,
	DOOR_FLAG_USE_CLOSES		= 8192,
	DOOR_FLAG_SILENT_NPC		= 16384,
	DOOR_FLAG_IGNORE_USE		= 32768,
	DOOR_FLAG_UNBREAKABLE		= 524288
}





// ====================================================================================================
// STOCKS
// ====================================================================================================

// ==================================================
// ENGINE STOCKS
// ==================================================
static EngineVersion g_iEngine;

/**
 * @brief Returns if the server is running on the Left 4 Dead series engine
 *
 * @return					True if the server is running on the Left 4 Dead series
 */
stock bool L4D_IsEngineLeft4Dead()
{
	if( g_iEngine == Engine_Unknown )
	{
		g_iEngine = GetEngineVersion();
	}

	return (g_iEngine == Engine_Left4Dead || g_iEngine == Engine_Left4Dead2);
}

/**
 * @brief Returns if the server is running on Left 4 Dead 1
 *
 * @return					True if server is running on Left 4 Dead 1
 */
stock bool L4D_IsEngineLeft4Dead1()
{
	if( g_iEngine == Engine_Unknown )
	{
		g_iEngine = GetEngineVersion();
	}

	return g_iEngine == Engine_Left4Dead;
}

/**
 * @brief Returns if the server is running on Left 4 Dead 2
 *
 * @return					True if server is running on Left 4 Dead 2
 */
stock bool L4D_IsEngineLeft4Dead2()
{
	if( g_iEngine == Engine_Unknown )
	{
		g_iEngine = GetEngineVersion();
	}

	return g_iEngine == Engine_Left4Dead2;
}



// ==================================================
// DOOR STOCKS
// ==================================================

/**
 * @brief Returns the specified door state. Uses the "DOOR_STATE_*" enum
 *
 * @param entity			The "prop_door*" entity to check
 *
 * @return the "DOOR_STATE_*" value
 */
stock int L4D_GetDoorState(int entity)
{
	return GetEntProp(entity, Prop_Data, "m_eDoorState");
}

/**
 * @brief Returns the specified door flags. Uses the "DOOR_FLAG_*" enum
 *
 * @param entity			The "prop_door*" entity to check
 *
 * @return the "DOOR_FLAG_*" value
 */
stock int L4D_GetDoorFlag(int entity)
{
	return GetEntProp(entity, Prop_Data, "m_spawnflags");
}



// ==================================================
// ENTITY STOCKS
// ==================================================

/**
 * @brief Returns a players current weapon, or -1 if none.
 *
 * @param client			Client ID of the player to check
 *
 * @return weapon entity index or -1 if none
 */
stock int L4D_GetPlayerCurrentWeapon(int client)
{
	return GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
}

/**
 * @brief Returns the Custom Ability entity of a Special Infected
 * @remarks Returns the entity of "ability_vomit" (Boomer), "ability_lunge" (Hunter), "ability_tongue" (Smoker), "ability_charge" (Charger), "ability_ride" (Jockey), "ability_spit" (Spitter), "ability_throw" (Tank)
 *
 * @param client			Client ID of the player to check
 *
 * @return entity index or -1 if none
 */
stock int L4D_GetPlayerCustomAbility(int client)
{
	return GetEntPropEnt(client, Prop_Send, "m_customAbility");
}

/**
 * @brief Returns the players Use Action Target
 *
 * @param client			Client ID of the player to check
 *
 * @return entity index or -1 if none
 */
stock int L4D_GetPlayerUseTarget(int client)
{
	return GetEntPropEnt(client, Prop_Send, "m_useActionTarget");
}

/**
 * @brief Returns the parent of an entity
 *
 * @param client			Entity index to check
 *
 * @return entity index or -1 if none
 */
stock int L4D_EntityParent(int entity)
{
	return GetEntPropEnt(entity, Prop_Data, "m_pParent");
}



// ==================================================
// COMMON INFECTED STOCKS
// ==================================================

/**
 * @brief Creates a panic event mob horde
 * @remarks Subject to horde cooldown timer
 * @remarks Can probably reset the timer with either "L4D_ResetMobTimer();" native or using "L4D2CT_MobSpawnTimer" with the timer natives.
 *
 * @noreturn
 */
stock void L4D_ForcePanicEvent()
{
	static EngineVersion engine;
	static int director = INVALID_ENT_REFERENCE;

	if( engine == Engine_Unknown )
	{
		engine = GetEngineVersion();
	}

	if( engine == Engine_Left4Dead2 )
	{
		if( director == INVALID_ENT_REFERENCE || EntRefToEntIndex(director) == INVALID_ENT_REFERENCE )
		{
			director = FindEntityByClassname(-1, "info_director");
			if( director != INVALID_ENT_REFERENCE )
			{
				director = EntIndexToEntRef(director);
			}
		}

		if( director != INVALID_ENT_REFERENCE )
		{
			AcceptEntityInput(director, "ForcePanicEvent");
		}
	}
	else
	{
		int flags = GetCommandFlags("director_force_panic_event");
		SetCommandFlags("director_force_panic_event", flags & ~FCVAR_CHEAT);
		ServerCommand("director_force_panic_event");
		SetCommandFlags("director_force_panic_event", flags);
	}
}

/**
 * @brief Returns the current number of common infected
 *
 * @return entity index or -1 if none
 */
stock int L4D_GetCommonsCount()
{
	int entity = -1;
	int count;
	while( (entity = FindEntityByClassname(entity, "infected")) != INVALID_ENT_REFERENCE )
	{
		count++;
	}

	return count;
}

/**
 * @brief Spawns a Common Infected at the given position
 *
 * @param vPos			Origin vector to spawn at
 * @param vAng			Angles vector to spawn at (optional)
 *
 * @return entity index or -1 on failure
 */
stock int L4D_SpawnCommonInfected(float vPos[3], float vAng[3] = { 0.0, 0.0, 0.0 })
{
	int entity = CreateEntityByName("infected");
	if( entity != -1 )
	{
		DispatchSpawn(entity);
		TeleportEntity(entity, vPos, vAng, NULL_VECTOR);
	}

	return entity;
}



// ==================================================
// INFECTED: GET VICTIM
// ==================================================

/**
 * @brief Returns the Survivor victim when pinned by a Hunter
 *
 * @param client			Client ID of the Special Infected player to check
 *
 * @return Victim client index, or 0 if none
 */
stock int L4D_GetVictimHunter(int client)
{
    int attacker;

    if( (attacker = GetEntPropEnt(client, Prop_Send, "m_pounceVictim")) > 0 )
        return attacker;

    return 0;
}

/**
 * @brief Returns the Survivor victim when pinned by a Smoker
 *
 * @param client			Client ID of the Special Infected player to check
 *
 * @return Victim client index, or 0 if none
 */
stock int L4D_GetVictimSmoker(int client)
{
    int attacker;

    if( (attacker = GetEntPropEnt(client, Prop_Send, "m_tongueVictim")) > 0 )
        return attacker;

    return 0;
}

/**
 * @brief Returns the Survivor victim when pinned by a Charger
 *
 * @param client			Client ID of the Special Infected player to check
 *
 * @return Victim client index, or 0 if none
 */
// L4D2 only.
stock int L4D_GetVictimCharger(int client)
{
    int attacker;

    if( L4D_IsEngineLeft4Dead2() )
    {
		if( (attacker = GetEntPropEnt(client, Prop_Send, "m_pummelVictim")) > 0 )
			return attacker;
	}

    return 0;
}

/**
 * @brief Returns the Survivor victim when carried by a Charger
 *
 * @param client			Client ID of the Special Infected player to check
 *
 * @return Victim client index, or 0 if none
 */
// L4D2 only.
stock int L4D_GetVictimCarry(int client)
{
    int attacker;

    if( L4D_IsEngineLeft4Dead2() )
    {
		if( (attacker = GetEntPropEnt(client, Prop_Send, "m_carryVictim")) > 0 )
			return attacker;
	}

    return 0;
}

/**
 * @brief Returns the Survivor victim when pinned by a Jockey
 *
 * @param client			Client ID of the Special Infected player to check
 *
 * @return Victim client index, or 0 if none
 */
// L4D2 only.
stock int L4D_GetVictimJockey(int client)
{
    int attacker;

    if( L4D_IsEngineLeft4Dead2() )
    {
		if( (attacker = GetEntPropEnt(client, Prop_Send, "m_jockeyVictim")) > 0 )
			return attacker;
	}

    return 0;
}



// ==================================================
// SURVIVOR: GET ATTACKER
// ==================================================

/**
 * @brief Returns a Survivors attacker when pinned by a Hunter
 *
 * @param client			Client ID of the Survivor player to check
 *
 * @return Attacker client index, or 0 if none
 */
stock int L4D_GetAttackerHunter(int client)
{
    int attacker;

    if( (attacker = GetEntPropEnt(client, Prop_Send, "m_pounceAttacker")) > 0 )
        return attacker;

    return 0;
}

/**
 * @brief Returns a Survivors attacker when pinned by a Smoker
 *
 * @param client			Client ID of the Survivor player to check
 *
 * @return Attacker client index, or 0 if none
 */
stock int L4D_GetAttackerSmoker(int client)
{
    int attacker;

    if( (attacker = GetEntPropEnt(client, Prop_Send, "m_tongueOwner")) > 0 )
        return attacker;

    return 0;
}

/**
 * @brief Returns a Survivors attacker when pummelled by a Charger
 *
 * @param client			Client ID of the Survivor player to check
 *
 * @return Attacker client index, or 0 if none
 */
// L4D2 only.
stock int L4D_GetAttackerCharger(int client)
{
    int attacker;

    if( L4D_IsEngineLeft4Dead2() )
    {
        if( (attacker = GetEntPropEnt(client, Prop_Send, "m_pummelAttacker")) > 0 )
            return attacker;
    }

    return 0;
}

/**
 * @brief Returns a Survivors attacker when carried by a Charger
 *
 * @param client			Client ID of the Survivor player to check
 *
 * @return Attacker client index, or 0 if none
 */
// L4D2 only.
stock int L4D_GetAttackerCarry(int client)
{
    int attacker;

    if( L4D_IsEngineLeft4Dead2() )
    {
        if( (attacker = GetEntPropEnt(client, Prop_Send, "m_carryAttacker")) > 0 )
            return attacker;
    }

    return 0;
}

/**
 * @brief Returns a Survivors attacker when pinned by a Jockey
 *
 * @param client			Client ID of the Survivor player to check
 *
 * @return Attacker client index, or 0 if none
 */
// L4D2 only.
stock int L4D_GetAttackerJockey(int client)
{
    int attacker;

    if( L4D_IsEngineLeft4Dead2() )
    {
        if( (attacker = GetEntPropEnt(client, Prop_Send, "m_jockeyAttacker")) > 0 )
            return attacker;
    }

    return 0;
}



// ==================================================
// PINNED CHECKS
// ==================================================

/**
 * @brief Returns the attacker when a Survivor is pinned by a Special Infected
 *
 * @param client			Client ID of the player to check
 *
 * @return Attacker client index, or 0 if none
 */
stock int L4D_GetPinnedInfected(int client)
{
    int attacker;

    if( (attacker = GetEntPropEnt(client, Prop_Send, "m_pounceAttacker")) > 0 )
        return attacker;

    if( (attacker = GetEntPropEnt(client, Prop_Send, "m_tongueOwner")) > 0 )
        return attacker;

    if( L4D_IsEngineLeft4Dead2() )
    {
        if( (attacker = GetEntPropEnt(client, Prop_Send, "m_jockeyAttacker")) > 0 )
            return attacker;

        if( (attacker = GetEntPropEnt(client, Prop_Send, "m_pummelAttacker")) > 0 )
            return attacker;

        if( (attacker = GetEntPropEnt(client, Prop_Send, "m_carryAttacker")) > 0 )
            return attacker;
    }

    return 0;
}

/**
 * @brief Returns if a Survivor is pinned by a Special Infected
 *
 * @param client			Client ID of the player to check
 *
 * @return True if pinned, false otherwise
 */
stock bool L4D_IsPlayerPinned(int client)
{
    return L4D_GetPinnedInfected(client) != 0;
}



// ==================================================
// LEDGE HANG STOCKS
// ==================================================

/**
 * @brief Returns if a Survivor is hanging from a ledge
 *
 * @param client			Client ID of the player to check
 *
 * @return True if hanging, false otherwise
 */
stock bool L4D_IsPlayerHangingFromLedge(int client)
{
	return GetEntProp(client, Prop_Send, "m_isHangingFromLedge", 1) == 1;
}

/**
 * @brief Returns if a Survivor can ledge hang
 *
 * @param client			Client ID of the player to check
 *
 * @return True if can hang, false otherwise
 */
stock bool L4D_CanPlayerLedgeHang(int client)
{
	// Get address
	static int addy = -1;
	if( addy == -1 )
	{
		/*
			See the function "CTerrorPlayer::InputDisableLedgeHang"
			On Windows: this[16417] = 0;
			m_bWasPresentAtSurvivalStart offset == 16388
			16388 + 29 = 16417
			Offset unlikely to change unless netprops are added/removed/changed - which is very unlikely
		*/
		addy = FindSendPropInfo("CTerrorPlayer", "m_bWasPresentAtSurvivalStart") + 29;
	}

	return GetEntData(client, addy, 1) == 1;
}

/**
 * @brief Allow a Survivor to ledge hang
 *
 * @param client			Client ID of the player to affect
 *
 * @noreturn
 */
stock void L4D_LedgeHangEnable(int client)
{
	AcceptEntityInput(client, "EnableLedgeHang");
}

/**
 * @brief Disallow a Survivor to ledge hang
 *
 * @param client			Client ID of the player to affect
 *
 * @noreturn
 */
stock void L4D_LedgeHangDisable(int client)
{
	AcceptEntityInput(client, "DisableLedgeHang");
}

/**
 * @brief Checks if a Survivor is currently staggering
 *
 * @param client			Client ID of the player to affect
 *
 * @noreturn
 */
stock bool L4D_IsPlayerStaggering(int client)
{
	static int m_iQueuedStaggerType = -1;
	if( m_iQueuedStaggerType == -1 )
		m_iQueuedStaggerType = FindSendPropInfo("CTerrorPlayer", "m_staggerDist") + 4;

	if( GetEntData(client, m_iQueuedStaggerType, 4) == -1 )
	{
		return GetEntPropFloat(client, Prop_Send, "m_staggerTimer", 1) >= GetGameTime();
	}

	return true;
}



// ==================================================
// INCAP and REVIVE STOCKS
// ==================================================
/**
 * @brief Set a Survivors incapacitated netprop
 * @remarks When setting to false can make a Survivor have 300 health (the incapped health value)
 *
 * @param client			Client ID of the player to affect
 * @param incap				True to incap, false to remove incap (not the proper way of reviving from incap, probably bypasses revive event)
 *
 * @noreturn
 */
stock void L4D_SetPlayerIncapped(int client, bool incap)
{
    SetEntProp(client, Prop_Send, "m_isIncapacitated", incap ? 1 : 0);
}

/**
 * @brief Incap a Survivor by giving them 100.0 damage
 *
 * @param client			Client ID of the player to affect
 * @param attacker			Optionally set the attacker to credit them for the incap
 *
 * @noreturn
 */
stock void L4D_SetPlayerIncappedDamage(int client, int attacker = 0)
{
	SDKHooks_TakeDamage(client, attacker, attacker, 100.0);
}

/**
 * @brief Returns a Survivors revive target
 *
 * @param client			Client ID of the player to check
 *
 * @return Target client index, or 0 if none
 */
stock int L4D_GetPlayerReviveTarget(int client)
{
	int target = GetEntPropEnt(client, Prop_Send, "m_reviveTarget");
	if( target > 0 )
		return target;

	return 0;
}

/**
 * @brief Returns an incapacitated Survivor's reviver
 *
 * @param client			Client ID of the player to check
 *
 * @return Reviver client index, or 0 if none
 */
stock int L4D_GetPlayerReviveOwner(int client)
{
	int target = GetEntPropEnt(client, Prop_Send, "m_reviveOwner");
	if( target > 0 )
		return target;

	return 0;
}

/**
 * @brief Stops a Survivor reviving someone
 * @remarks Prevents accidental freezing of player who tried to revive you
 * @remarks Thanks to "Dragokas" for the stock
 *
 * @param client			Client ID of the player to affect
 *
 * @noreturn
 */
stock void L4D_StopReviveAction(int client)
{
	int owner_save = -1;
	int target_save = -1;
	int owner = GetEntPropEnt(client, Prop_Send, "m_reviveOwner"); // when you reviving somebody, this is -1. When somebody revive you, this is somebody's id
	int target = GetEntPropEnt(client, Prop_Send, "m_reviveTarget"); // when you reviving somebody, this is somebody's id. When somebody revive you, this is -1

	SetEntPropEnt(client, Prop_Send, "m_reviveOwner", -1);
	SetEntPropEnt(client, Prop_Send, "m_reviveTarget", -1);

	if( owner != -1 ) // we must reset flag for both - for you, and who you revive
	{
		SetEntPropEnt(owner, Prop_Send, "m_reviveOwner", -1);
		SetEntPropEnt(owner, Prop_Send, "m_reviveTarget", -1);
		owner_save = owner;
	}

	if( target != -1 )
	{
		SetEntPropEnt(target, Prop_Send, "m_reviveOwner", -1);
		SetEntPropEnt(target, Prop_Send, "m_reviveTarget", -1);
		target_save = target;
	}

	if( L4D_IsEngineLeft4Dead2() )
	{
		owner = GetEntPropEnt(client, Prop_Send, "m_useActionOwner");		// used when healing e.t.c.
		target = GetEntPropEnt(client, Prop_Send, "m_useActionTarget");
		SetEntPropEnt(client, Prop_Send, "m_useActionOwner", -1);
		SetEntPropEnt(client, Prop_Send, "m_useActionTarget", -1);

		if( owner != -1 )
		{
			SetEntPropEnt(owner, Prop_Send, "m_useActionOwner", -1);
			SetEntPropEnt(owner, Prop_Send, "m_useActionTarget", -1);
			owner_save = owner;
		}

		if( target != -1 )
		{
			SetEntPropEnt(target, Prop_Send, "m_useActionOwner", -1);
			SetEntPropEnt(target, Prop_Send, "m_useActionTarget", -1);
			target_save = target;
		}

		SetEntProp(client, Prop_Send, "m_iCurrentUseAction", 0);
		SetEntPropFloat(client, Prop_Send, "m_flProgressBarDuration", 0.0);

		if( owner_save != -1 )
		{
			SetEntProp(owner_save, Prop_Send, "m_iCurrentUseAction", 0);
			SetEntPropFloat(owner_save, Prop_Send, "m_flProgressBarDuration", 0.0);
		}

		if( target_save != -1 )
		{
			SetEntProp(target_save, Prop_Send, "m_iCurrentUseAction", 0);
			SetEntPropFloat(target_save, Prop_Send, "m_flProgressBarDuration", 0.0);
		}
	}
	else
	{
		owner = GetEntPropEnt(client, Prop_Send, "m_healOwner");		// used when healing
		target = GetEntPropEnt(client, Prop_Send, "m_healTarget");
		SetEntPropEnt(client, Prop_Send, "m_healOwner", -1);
		SetEntPropEnt(client, Prop_Send, "m_healTarget", -1);

		if( owner != -1 )
		{
			SetEntPropEnt(owner, Prop_Send, "m_healOwner", -1);
			SetEntPropEnt(owner, Prop_Send, "m_healTarget", -1);
			owner_save = owner;
		}

		if( target != -1 )
		{
			SetEntPropEnt(target, Prop_Send, "m_healOwner", -1);
			SetEntPropEnt(target, Prop_Send, "m_healTarget", -1);
			target_save = target;
		}

		SetEntProp(client, Prop_Send, "m_iProgressBarDuration", 0);

		if( owner_save != -1 )
		{
			SetEntProp(owner_save, Prop_Send, "m_iProgressBarDuration", 0);
		}

		if( target_save != -1 )
		{
			SetEntProp(target_save, Prop_Send, "m_iProgressBarDuration", 0);
		}
	}
}

/**
 * @brief Returns if a Survivor is incapacitated
 *
 * @param client			Client ID of the player to check
 *
 * @return True if incapacitated, false otherwise
 */
#pragma deprecated Use L4D_IsPlayerIncapacitated instead
stock bool L4D_IsPlayerIncapped(int client)
{
    return GetEntProp(client, Prop_Send, "m_isIncapacitated", 1) != 0;
}





// ==================================================
// GET CLIENT STOCKS
// ==================================================

/**
 * @brief Returns a random client in-game
 *
 * @return Client index or 0 if none
 */
stock int GetAnyRandomClient()
{
	int client;
	ArrayList aClients = new ArrayList();

	for( int i = 1; i <= MaxClients; i++ )
	{
		if( IsClientInGame(i) )
		{
			aClients.Push(i);
		}
	}

	if( aClients.Length > 0 )
	{
		SetRandomSeed(GetGameTickCount());
		client = aClients.Get(GetRandomInt(0, aClients.Length - 1));
	}

	delete aClients;

	return client;
}

/**
 * @brief Returns a random Survivor
 *
 * @param alive			-1 = Any. 0 = Only dead players. 1 = Only alive players
 * @param bots			-1 = Any. 0 - Only real players. 1 = Only fake players
 *
 * @return Client index or 0 if none
 */
stock int GetRandomSurvivor(int alive = -1, int bots = -1)
{
	return Local_GetRandomClient(2, alive, bots);
}

/**
 * @brief Returns a random Special Infected
 *
 * @param alive			-1 = Any. 0 = Only dead players. 1 = Only alive players
 * @param bots			-1 = Any. 0 - Only real players. 1 = Only fake players
 *
 * @return Client index or 0 if none
 */
stock int GetRandomInfected(int alive = -1, int bots = -1)
{
	return Local_GetRandomClient(3, alive, bots);
}

stock int Local_GetRandomClient(int team, int alive = -1, int bots = -1)
{
	ArrayList aClients = new ArrayList();

	for( int i = 1; i <= MaxClients; i++ )
	{
		if( IsClientInGame(i) && GetClientTeam(i) == team && (alive == -1 || IsPlayerAlive(i) == view_as<bool>(alive)) && (bots == -1 || IsFakeClient(i) == view_as<bool>(bots)) )
		{
			aClients.Push(i);
		}
	}

	int client;

	if( aClients.Length > 0 )
	{
		SetRandomSeed(GetGameTickCount());
		client = aClients.Get(GetRandomInt(0, aClients.Length - 1));
	}

	delete aClients;

	return client;
}