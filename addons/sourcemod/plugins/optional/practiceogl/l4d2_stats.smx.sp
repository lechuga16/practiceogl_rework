/*
** ATTENTION
** THE PRODUCED CODE, IS NOT ABLE TO COMPILE!
** THE DECOMPILER JUST TRIES TO GIVE YOU A POSSIBILITY
** TO LOOK HOW A PLUGIN DOES IT'S JOB AND LOOK FOR
** POSSIBLE MALICIOUS CODE.
**
** ALL CONVERSIONS ARE WRONG! AT EXAMPLE:
** SetEntityRenderFx(client, RenderFx 0);  →  SetEntityRenderFx(client, view_as<RenderFx>0);  →  SetEntityRenderFx(client, RENDERFX_NONE);
*/

 PlVers __version = 5;
 float NULL_VECTOR[3];
 char NULL_STRING[1];
 Extension __ext_core = 72;
 int MaxClients;
 char CTag[6][0];
 char CTagCode[6][4] =
{
	"\x01",
	"\x04",
	"\x03",
	"\x03",
	"\x03",
	"\x05"
}
 bool CTagReqSayText2[6] =
{
	0, 0, 1, 1, 1, 0
}
 bool CEventIsHooked;
 bool CSkipList[66];
 bool CProfile_Colors[6] =
{
	1, 1, 0, 0, 0, 0
}
 int CProfile_TeamIndex[6] =
{
	-1, ...
}
 bool CProfile_SayText2;
 int g_iAlarmCarClient;
public Plugin myinfo =
{
	name = "L4D2 Realtime Stats",
	description = "Display Skeets/Etc to Chat to clients",
	author = "Griffin, Philogl, Sir",
	version = "1.0",
	url = "<- URL ->"
};
 int g_iSurvivorLimit = 4;
 Handle g_hCvarSurvivorLimit;
 bool g_bHasRoundEnded;
 int g_iBoomerClient;
 int g_iBoomerKiller;
 int g_iBoomerShover;
 int g_iLastHealth[66];
 bool g_bHasBoomLanded;
 bool g_bIsPouncing[66];
 Handle g_hBoomerShoveTimer;
 Handle g_hBoomerKillTimer;
 float BoomerKillTime;
 char Boomer[8];
 int g_iDamageDealt[66][66];
 int g_iShotsDealt[66][66];
 bool g_bShotCounted[66][66];
public int __ext_core_SetNTVOptional()
{
	MarkNativeAsOptional("GetFeatureStatus");
	MarkNativeAsOptional("RequireFeature");
	MarkNativeAsOptional("AddCommandListener");
	MarkNativeAsOptional("RemoveCommandListener");
	MarkNativeAsOptional("BfWriteBool");
	MarkNativeAsOptional("BfWriteByte");
	MarkNativeAsOptional("BfWriteChar");
	MarkNativeAsOptional("BfWriteShort");
	MarkNativeAsOptional("BfWriteWord");
	MarkNativeAsOptional("BfWriteNum");
	MarkNativeAsOptional("BfWriteFloat");
	MarkNativeAsOptional("BfWriteString");
	MarkNativeAsOptional("BfWriteEnt");
	MarkNativeAsOptional("BfWriteAngle");
	MarkNativeAsOptional("BfWriteCoord");
	MarkNativeAsOptional("BfWriteVecCoord");
	MarkNativeAsOptional("BfWriteVecNormal");
	MarkNativeAsOptional("BfWriteAngles");
	MarkNativeAsOptional("BfReadBool");
	MarkNativeAsOptional("BfReadByte");
	MarkNativeAsOptional("BfReadChar");
	MarkNativeAsOptional("BfReadShort");
	MarkNativeAsOptional("BfReadWord");
	MarkNativeAsOptional("BfReadNum");
	MarkNativeAsOptional("BfReadFloat");
	MarkNativeAsOptional("BfReadString");
	MarkNativeAsOptional("BfReadEntity");
	MarkNativeAsOptional("BfReadAngle");
	MarkNativeAsOptional("BfReadCoord");
	MarkNativeAsOptional("BfReadVecCoord");
	MarkNativeAsOptional("BfReadVecNormal");
	MarkNativeAsOptional("BfReadAngles");
	MarkNativeAsOptional("BfGetNumBytesLeft");
	MarkNativeAsOptional("PbReadInt");
	MarkNativeAsOptional("PbReadFloat");
	MarkNativeAsOptional("PbReadBool");
	MarkNativeAsOptional("PbReadString");
	MarkNativeAsOptional("PbReadColor");
	MarkNativeAsOptional("PbReadAngle");
	MarkNativeAsOptional("PbReadVector");
	MarkNativeAsOptional("PbReadVector2D");
	MarkNativeAsOptional("PbGetRepeatedFieldCount");
	MarkNativeAsOptional("PbSetInt");
	MarkNativeAsOptional("PbSetFloat");
	MarkNativeAsOptional("PbSetBool");
	MarkNativeAsOptional("PbSetString");
	MarkNativeAsOptional("PbSetColor");
	MarkNativeAsOptional("PbSetAngle");
	MarkNativeAsOptional("PbSetVector");
	MarkNativeAsOptional("PbSetVector2D");
	MarkNativeAsOptional("PbAddInt");
	MarkNativeAsOptional("PbAddFloat");
	MarkNativeAsOptional("PbAddBool");
	MarkNativeAsOptional("PbAddString");
	MarkNativeAsOptional("PbAddColor");
	MarkNativeAsOptional("PbAddAngle");
	MarkNativeAsOptional("PbAddVector");
	MarkNativeAsOptional("PbAddVector2D");
	MarkNativeAsOptional("PbRemoveRepeatedFieldValue");
	MarkNativeAsOptional("PbReadMessage");
	MarkNativeAsOptional("PbReadRepeatedMessage");
	MarkNativeAsOptional("PbAddMessage");
	VerifyCoreVersion();
	return 0;
}

bool StrEqual(char str1[], char str2[], bool caseSensitive)
{
	return strcmp(str1, str2, caseSensitive) == 0;
}

int StrCat(char buffer[], int maxlength, char source[])
{
	int len = strlen(buffer);
	if (len >= maxlength)
	{
		return 0;
	}
	return Format(buffer[len], maxlength - len, "%s", source);
}

Handle StartMessageOne(char msgname[], int client, int flags)
{
	int players[1];
	players[0] = client;
	return StartMessage(msgname, players, 1, flags);
}

int CPrintToChat(int client, char szMessage[])
{
	int var1;
	if (client <= 0)
	{
		ThrowError("Invalid client index %d", client);
	}
	if (!IsClientInGame(client))
	{
		ThrowError("Client %d is not in game", client);
	}
	char szBuffer[252];
	char szCMessage[252];
	SetGlobalTransTarget(client);
	Format(szBuffer, 250, "\x01%s", szMessage);
	VFormat(szCMessage, 250, szBuffer, 3);
	int index = CFormat(szCMessage, 250, -1);
	if (index == -1)
	{
		PrintToChat(client, szCMessage);
	}
	else
	{
		CSayText2(client, index, szCMessage);
	}
	return 0;
}

int CPrintToChatAll(char szMessage[])
{
	char szBuffer[252];
	int i = 1;
	while (i <= MaxClients)
	{
		int var1;
		if (IsClientInGame(i))
		{
			SetGlobalTransTarget(i);
			VFormat(szBuffer, 250, szMessage, 2);
			CPrintToChat(i, szBuffer);
		}
		CSkipList[i] = 0;
		i++;
	}
	return 0;
}

int CFormat(char szMessage[], int maxlength, int author)
{
	if (!CEventIsHooked)
	{
		CSetupProfile();
		HookEvent("server_spawn", EventHook 1, EventHookMode 2);
		CEventIsHooked = 1;
	}
	int iRandomPlayer = -1;
	if (author != -1)
	{
		if (CProfile_SayText2)
		{
			ReplaceString(szMessage, maxlength, "{teamcolor}", "\x03", true);
			iRandomPlayer = author;
		}
		else
		{
			ReplaceString(szMessage, maxlength, "{teamcolor}", CTagCode[4][0], true);
		}
	}
	else
	{
		ReplaceString(szMessage, maxlength, "{teamcolor}", "", true);
	}
	int i = 0;
	while (i < 6)
	{
		if (!(StrContains(szMessage, CTag[i][0][0], true) == -1))
		{
			if (!CProfile_Colors[i][0][0])
			{
				ReplaceString(szMessage, maxlength, CTag[i][0][0], CTagCode[4][0], true);
			}
			else
			{
				if (!CTagReqSayText2[i][0][0])
				{
					ReplaceString(szMessage, maxlength, CTag[i][0][0], CTagCode[i][0][0], true);
				}
				if (!CProfile_SayText2)
				{
					ReplaceString(szMessage, maxlength, CTag[i][0][0], CTagCode[4][0], true);
				}
				if (iRandomPlayer == -1)
				{
					iRandomPlayer = CFindRandomPlayerByTeam(CProfile_TeamIndex[i][0][0]);
					if (iRandomPlayer == -2)
					{
						ReplaceString(szMessage, maxlength, CTag[i][0][0], CTagCode[4][0], true);
					}
					else
					{
						ReplaceString(szMessage, maxlength, CTag[i][0][0], CTagCode[i][0][0], true);
					}
				}
				ThrowError("Using two team colors in one message is not allowed");
			}
		}
		i++;
	}
	return iRandomPlayer;
}

int CFindRandomPlayerByTeam(int color_team)
{
	if (color_team)
	{
		int i = 1;
		while (i <= MaxClients)
		{
			int var1;
			if (IsClientInGame(i))
			{
				return i;
			}
			i++;
		}
		return -2;
	}
	return 0;
}

int CSayText2(int client, int author, char szMessage[])
{
	Handle hBuffer = StartMessageOne("SayText2", client, 0);
	if (GetUserMessageType() == 1)
	{
		PbSetInt(hBuffer, "ent_idx", author, -1);
		PbSetBool(hBuffer, "chat", true, -1);
		PbSetString(hBuffer, "msg_name", szMessage, -1);
		PbAddString(hBuffer, "params", "");
		PbAddString(hBuffer, "params", "");
		PbAddString(hBuffer, "params", "");
		PbAddString(hBuffer, "params", "");
	}
	else
	{
		BfWriteByte(hBuffer, author);
		BfWriteByte(hBuffer, 1);
		BfWriteString(hBuffer, szMessage);
	}
	EndMessage();
	return 0;
}

int CSetupProfile()
{
	char szGameName[32];
	GetGameFolderName(szGameName, 30);
	if (StrEqual(szGameName, "cstrike", false))
	{
		CProfile_Colors[8] = 1;
		CProfile_Colors[12] = 1;
		CProfile_Colors[16] = 1;
		CProfile_Colors[20] = 1;
		CProfile_TeamIndex[8] = 0;
		CProfile_TeamIndex[12] = 2;
		CProfile_TeamIndex[16] = 3;
		CProfile_SayText2 = 1;
	}
	else
	{
		if (StrEqual(szGameName, "tf", false))
		{
			CProfile_Colors[8] = 1;
			CProfile_Colors[12] = 1;
			CProfile_Colors[16] = 1;
			CProfile_Colors[20] = 1;
			CProfile_TeamIndex[8] = 0;
			CProfile_TeamIndex[12] = 2;
			CProfile_TeamIndex[16] = 3;
			CProfile_SayText2 = 1;
		}
		int var1;
		if (StrEqual(szGameName, "left4dead", false))
		{
			CProfile_Colors[8] = 1;
			CProfile_Colors[12] = 1;
			CProfile_Colors[16] = 1;
			CProfile_Colors[20] = 1;
			CProfile_TeamIndex[8] = 0;
			CProfile_TeamIndex[12] = 3;
			CProfile_TeamIndex[16] = 2;
			CProfile_SayText2 = 1;
		}
		if (StrEqual(szGameName, "hl2mp", false))
		{
			if (GetConVarBool(FindConVar("mp_teamplay")))
			{
				CProfile_Colors[12] = 1;
				CProfile_Colors[16] = 1;
				CProfile_Colors[20] = 1;
				CProfile_TeamIndex[12] = 3;
				CProfile_TeamIndex[16] = 2;
				CProfile_SayText2 = 1;
			}
			else
			{
				CProfile_SayText2 = 0;
				CProfile_Colors[20] = 1;
			}
		}
		if (StrEqual(szGameName, "dod", false))
		{
			CProfile_Colors[20] = 1;
			CProfile_SayText2 = 0;
		}
		if (GetUserMessageId("SayText2") == -1)
		{
			CProfile_SayText2 = 0;
		}
		CProfile_Colors[12] = 1;
		CProfile_Colors[16] = 1;
		CProfile_TeamIndex[12] = 2;
		CProfile_TeamIndex[16] = 3;
		CProfile_SayText2 = 1;
	}
	return 0;
}

public Action CEvent_MapStart(Handle event, char name[], bool dontBroadcast)
{
	CSetupProfile();
	int i = 1;
	while (i <= MaxClients)
	{
		CSkipList[i] = 0;
		i++;
	}
	return Action 0;
}

public int OnPluginStart()
{
	HookEvent("round_start", EventHook 29, EventHookMode 1);
	HookEvent("round_end", EventHook 27, EventHookMode 1);
	HookEvent("player_hurt", EventHook 21, EventHookMode 1);
	HookEvent("player_death", EventHook 19, EventHookMode 1);
	HookEvent("player_spawn", EventHook 25, EventHookMode 1);
	HookEvent("ability_use", EventHook 9, EventHookMode 1);
	HookEvent("lunge_pounce", EventHook 13, EventHookMode 1);
	HookEvent("weapon_fire", EventHook 31, EventHookMode 1);
	HookEvent("player_shoved", EventHook 23, EventHookMode 1);
	HookEvent("player_now_it", EventHook 17, EventHookMode 1);
	HookEvent("create_panic_event", EventHook 15, EventHookMode 1);
	HookEvent("triggered_car_alarm", EventHook 11, EventHookMode 1);
	g_hCvarSurvivorLimit = FindConVar("survivor_limit");
	HookConVarChange(g_hCvarSurvivorLimit, ConVarChanged 7);
	g_iSurvivorLimit = GetConVarInt(g_hCvarSurvivorLimit);
	return 0;
}

public int Event_PlayerSpawn(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	int var1;
	if (client)
	{
		return 0;
	}
	if (GetClientTeam(client) == 3)
	{
		int zombieclass = GetEntProp(client, PropType 0, "m_zombieClass", 4, 0);
		if (zombieclass == 8)
		{
			return 0;
		}
		if (zombieclass == 2)
		{
			int var2;
			if (!IsFakeClient(client))
			{
				g_bHasBoomLanded = 0;
				g_iBoomerClient = client;
				g_iBoomerShover = 0;
				g_iBoomerKiller = 0;
			}
			if (g_hBoomerShoveTimer)
			{
				KillTimer(g_hBoomerShoveTimer, false);
				g_hBoomerShoveTimer = 0;
			}
			BoomerKillTime = 0;
			g_hBoomerKillTimer = CreateTimer(0,1, Timer_KillBoomer, any 0, 1);
		}
		g_iLastHealth[client] = GetClientHealth(client);
	}
	return 0;
}

public int Event_WeaponFire(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	int i = 1;
	while (i <= MaxClients)
	{
		g_bShotCounted[i][0][0][client] = 0;
		i++;
	}
	return 0;
}

public int OnMapStart()
{
	g_bHasRoundEnded = 0;
	ClearMapStats();
	return 0;
}

public int Event_RoundStart(Handle event, char name[], bool dontBroadcast)
{
	g_bHasRoundEnded = 0;
	if (g_hBoomerKillTimer)
	{
		KillTimer(g_hBoomerKillTimer, false);
		g_hBoomerKillTimer = 0;
		BoomerKillTime = 0;
	}
	g_iAlarmCarClient = 0;
	return 0;
}

public int Event_RoundEnd(Handle event, char name[], bool dontBroadcast)
{
	if (g_bHasRoundEnded)
	{
		return 0;
	}
	g_bHasRoundEnded = 1;
	int i = 1;
	while (i <= MaxClients)
	{
		ClearDamage(i);
		i++;
	}
	return 0;
}

public int Event_AbilityUse(Handle event, char name[], bool dontBroadcast)
{
	if (g_bHasRoundEnded)
	{
		return 0;
	}
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	int var1;
	if (!IsClientInGame(client))
	{
		return 0;
	}
	int zombieclass = GetEntProp(client, PropType 0, "m_zombieClass", 4, 0);
	if (zombieclass == 3)
	{
		g_bIsPouncing[client] = 1;
		CreateTimer(0,5, Timer_GroundedCheck, client, 1);
	}
	return 0;
}

public int Event_LungePounce(Handle event, char name[], bool dontBroadcast)
{
	int attacker = GetClientOfUserId(GetEventInt(event, "userid"));
	int zombieclass = GetEntProp(attacker, PropType 0, "m_zombieClass", 4, 0);
	if (zombieclass == 3)
	{
		g_bIsPouncing[attacker] = 0;
	}
	return 0;
}

public Action Timer_GroundedCheck(Handle timer, any client)
{
	int var1;
	if (!IsClientInGame(client))
	{
		g_bIsPouncing[client] = 0;
		KillTimer(timer, false);
	}
	return Action 0;
}


/* ERROR! Unrecognized opcode sysreq_c */
 function "Timer_KillBoomer" (number 20)
bool IsGrounded(int client)
{
	return GetEntProp(client, PropType 1, "m_fFlags", 4, 0) & 1 > 0;
}

public int Event_PlayerHurt(Handle event, char name[], bool dontBroadcast)
{
	if (g_bHasRoundEnded)
	{
		return 0;
	}
	int victim = GetClientOfUserId(GetEventInt(event, "userid"));
	int attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	int var1;
	if (victim)
	{
		return 0;
	}
	int var2;
	if (!attacker)
	{
		return 0;
	}
	int damage = GetEventInt(event, "dmg_health");
	int var3;
	if (GetClientTeam(attacker) == 2)
	{
		int zombieclass = GetEntProp(victim, PropType 0, "m_zombieClass", 4, 0);
		if (zombieclass == 8)
		{
			return 0;
		}
		if (!g_bShotCounted[victim][0][0][attacker])
		{
			g_iShotsDealt[victim][0][0][attacker]++;
			g_bShotCounted[victim][0][0][attacker] = 1;
		}
		int remaining_health = GetEventInt(event, "health");
		if (0 >= remaining_health)
		{
			return 0;
		}
		g_iLastHealth[victim] = remaining_health;
		g_iDamageDealt[victim][0][0][attacker] += damage;
		if (zombieclass == 2)
		{
		}
		else
		{
			if (zombieclass == 3)
			{
			}
			else
			{
				if (zombieclass == 1)
				{
				}
				else
				{
					if (zombieclass == 5)
					{
					}
					else
					{
						if (zombieclass == 6)
						{
						}
					}
				}
			}
		}
	}
	return 0;
}


/* ERROR! Unrecognized opcode genarray */
 function "Event_PlayerDeath" (number 23)
public Action Timer_BoomerKilledCheck(Handle timer)
{
	BoomerKillTime = FloatSub(BoomerKillTime, 0,2);
	int var1;
	if (g_bHasBoomLanded)
	{
		g_iBoomerClient = 0;
		BoomerKillTime = 0;
		return Action 0;
	}
	if (__FLOAT_LT__(BoomerKillTime, 0,1))
	{
		BoomerKillTime = 1036831949;
	}
	if (IsValidClient(g_iBoomerKiller))
	{
		if (IsValidClient(g_iBoomerClient))
		{
			if (__FLOAT_LT__(BoomerKillTime, 0,5))
			{
				CPrintToChatAll("{green}★ {olive}%N {default}has shutdown {olive}%s{default}'s Boomer in {blue}%0.1fs", 1968, 2520, 2516);
			}
			if (__FLOAT_LT__(BoomerKillTime, 1,4))
			{
				CPrintToChatAll("{green}★ {olive}%N {default}has shutdown {olive}%s{default}'s Boomer in {blue}%0.1fs", 1968, 2520, 2516);
			}
			CPrintToChatAll("{green}★ {olive}%N {default}has shutdown {olive}%s{default}'s Boomer in {blue}%0.1fs", 1968, 2520, 2516);
		}
	}
	g_iBoomerClient = 0;
	BoomerKillTime = 0;
	return Action 0;
}

public int Event_PlayerShoved(Handle event, char name[], bool dontBroadcast)
{
	if (g_bHasRoundEnded)
	{
		return 0;
	}
	int victim = GetClientOfUserId(GetEventInt(event, "userid"));
	int var1;
	if (victim)
	{
		return 0;
	}
	int attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	int var2;
	if (attacker)
	{
		return 0;
	}
	int zombieclass = GetEntProp(victim, PropType 0, "m_zombieClass", 4, 0);
	if (zombieclass == 2)
	{
		if (g_hBoomerShoveTimer)
		{
			KillTimer(g_hBoomerShoveTimer, false);
			int var3;
			if (!g_iBoomerShover)
			{
				g_iBoomerShover = attacker;
			}
		}
		else
		{
			g_iBoomerShover = attacker;
		}
		g_hBoomerShoveTimer = CreateTimer(4, Timer_BoomerShove, any 0, 0);
	}
	return 0;
}

public Action Timer_BoomerShove(Handle timer)
{
	g_hBoomerShoveTimer = 0;
	g_iBoomerShover = 0;
	return Action 0;
}

public int Event_PlayerBoomed(Handle event, char name[], bool dontBroadcast)
{
	if (g_bHasBoomLanded)
	{
		return 0;
	}
	g_bHasBoomLanded = 1;
	if (!(GetEventBool(event, "exploded")))
	{
	}
	return 0;
}

public int Event_Panic(Handle event, char name[], bool dontBroadcast)
{
	g_iAlarmCarClient = GetClientOfUserId(GetEventInt(event, "userid"));
	CreateTimer(0,5, Clear, g_iAlarmCarClient, 0);
	return 0;
}

public Action Clear(Handle timer)
{
	g_iAlarmCarClient = 0;
	return Action 0;
}

public Action Event_AlarmCar(Handle event, char name[], bool dontBroadcast)
{
	int var1;
	if (g_iAlarmCarClient)
	{
		CPrintToChatAll("{green}★ {olive}%N {default}triggered an {red}Alarmed {default}Car", 1828);
		g_iAlarmCarClient = 0;
	}
	return Action 0;
}

public int Cvar_SurvivorLimit(Handle convar, char oldValue[], char newValue[])
{
	g_iSurvivorLimit = StringToInt(newValue, 10);
	return 0;
}

int ClearMapStats()
{
	int i = 1;
	while (i <= MaxClients)
	{
		ClearDamage(i);
		i++;
	}
	g_iAlarmCarClient = 0;
	return 0;
}

int ClearDamage(int client)
{
	g_iLastHealth[client] = 0;
	int i = 1;
	while (i <= MaxClients)
	{
		g_iDamageDealt[client][0][0][i] = 0;
		g_iShotsDealt[client][0][0][i] = 0;
		i++;
	}
	return 0;
}

public int ClientValue2DSortDesc(int x[], int y[], int array[][], Handle data)
{
	if (y[4] < x[4])
	{
		return -1;
	}
	if (y[4] > x[4])
	{
		return 1;
	}
	return 0;
}

bool IsValidClient(int client)
{
	int var1;
	if (client <= 0)
	{
		return false;
	}
	return IsClientInGame(client);
}

