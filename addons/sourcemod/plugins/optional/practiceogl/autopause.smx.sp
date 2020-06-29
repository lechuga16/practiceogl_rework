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
 Extension __ext_sdktools = 1020;
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
 SharedPlugin __pl_readyup = 1912;
public Plugin myinfo =
{
	name = "L4D2 Auto-pause",
	description = "When a player disconnects due to crash, automatically pause the game. When they rejoin, give them a correct spawn timer.",
	author = "Darkid, Griffin",
	version = "1.9",
	url = "https://github.com/jbzdarkid/AutoPause"
};
 Handle enabled;
 Handle force;
 Handle apdebug;
 Handle crashedPlayers;
 Handle infectedPlayers;
 bool readyUpIsAvailable;
 bool RoundEnd;
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

float operator-(_:,Float:)(int oper1, float oper2)
{
	return FloatSub(float(oper1), oper2);
}

bool StrEqual(char str1[], char str2[], bool caseSensitive)
{
	return strcmp(str1, str2, caseSensitive) == 0;
}

Handle StartMessageOne(char msgname[], int client, int flags)
{
	int players[1];
	players[0] = client;
	return StartMessage(msgname, players, 1, flags);
}

Handle L4D2Direct_GetGameConf()
{
	static Handle g_hGameConf_l4d2dir;
	if (!g_hGameConf_l4d2dir)
	{
		g_hGameConf_l4d2dir = LoadGameConfigFile("l4d2_direct");
	}
	return g_hGameConf_l4d2dir;
}

int CTimer_Start(CountdownTimer timer, float duration)
{
	CTimer_SetTimestamp(timer, FloatAdd(GetGameTime(), duration));
	CTimer_SetDuration(timer, duration);
	return 0;
}

float CTimer_GetRemainingTime(CountdownTimer timer)
{
	return FloatSub(CTimer_GetTimestamp(timer), GetGameTime());
}

int CTimer_SetDuration(CountdownTimer timer, float duration)
{
	StoreToAddress(timer + 4, duration, NumberType 2);
	return 0;
}

float CTimer_GetTimestamp(CountdownTimer timer)
{
	return LoadFromAddress(timer + 8, NumberType 2);
}

int CTimer_SetTimestamp(CountdownTimer timer, float timestamp)
{
	StoreToAddress(timer + 8, timestamp, NumberType 2);
	return 0;
}

CountdownTimer L4D2Direct_GetSpawnTimer(int client)
{
	int var1;
	if (client < 1)
	{
		return CountdownTimer 0;
	}
	Address pEntity = GetEntityAddress(client);
	if (pEntity)
	{
		int offs = GameConfGetOffset(L4D2Direct_GetGameConf(), "CTerrorPlayer::SpawnTimer");
		if (offs == -1)
		{
			return CountdownTimer 0;
		}
		return offs + pEntity;
	}
	return CountdownTimer 0;
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

public int __pl_readyup_SetNTVOptional()
{
	MarkNativeAsOptional("AddStringToReadyFooter");
	MarkNativeAsOptional("IsInReady");
	MarkNativeAsOptional("IsClientCaster");
	MarkNativeAsOptional("IsIDCaster");
	return 0;
}

public int OnPluginStart()
{
	enabled = CreateConVar("autopause_enable", "1", "Whether or not to automatically pause when a player crashes.", 0, false, 0, false, 0);
	force = CreateConVar("autopause_force", "0", "Whether or not to force pause when a player crashes.", 0, false, 0, false, 0);
	apdebug = CreateConVar("autopause_apdebug", "0", "Whether or not to debug information.", 0, false, 0, false, 0);
	crashedPlayers = CreateTrie();
	infectedPlayers = CreateArray(64, 0);
	HookEvent("round_start", EventHook 21, EventHookMode 1);
	HookEvent("round_end", EventHook 19, EventHookMode 1);
	HookEvent("player_team", EventHook 17, EventHookMode 1);
	HookEvent("player_disconnect", EventHook 15, EventHookMode 0);
	return 0;
}

public int OnAllPluginsLoaded()
{
	readyUpIsAvailable = LibraryExists("readyup");
	return 0;
}

public int OnLibraryRemoved(char name[])
{
	if (StrEqual(name, "readyup", true))
	{
		readyUpIsAvailable = 0;
	}
	return 0;
}

public int OnLibraryAdded(char name[])
{
	if (StrEqual(name, "readyup", true))
	{
		readyUpIsAvailable = 1;
	}
	return 0;
}

public int round_start(Handle event, char name[], bool dontBroadcast)
{
	ClearTrie(crashedPlayers);
	ClearArray(infectedPlayers);
	RoundEnd = 0;
	return 0;
}

public int round_end(Handle event, char name[], bool dontBroadcast)
{
	RoundEnd = 1;
	return 0;
}

public int playerTeam(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	int var1;
	if (client <= 0)
	{
		return 0;
	}
	char steamId[64];
	GetClientAuthString(client, steamId, 64, true);
	if (strcmp(steamId, "BOT", true))
	{
		int oldTeam = GetEventInt(event, "oldteam");
		int newTeam = GetEventInt(event, "team");
		int index = FindStringInArray(infectedPlayers, steamId);
		if (oldTeam == 3)
		{
			if (index != -1)
			{
				RemoveFromArray(infectedPlayers, index);
			}
			if (GetConVarBool(apdebug))
			{
				LogMessage("[AutoPause] Removed player %s from infected team.", steamId);
			}
		}
		if (newTeam == 3)
		{
			float spawnTime;
			if (GetTrieValue(crashedPlayers, steamId, spawnTime))
			{
				CountdownTimer spawnTimer = L4D2Direct_GetSpawnTimer(client);
				CTimer_Start(spawnTimer, spawnTime);
				RemoveFromTrie(crashedPlayers, steamId);
				LogMessage("[AutoPause] Player %s rejoined, set spawn timer to %f.", steamId, spawnTime);
			}
			else
			{
				if (index == -1)
				{
					PushArrayString(infectedPlayers, steamId);
					if (GetConVarBool(apdebug))
					{
						LogMessage("[AutoPause] Added player %s to infected team.", steamId);
					}
				}
			}
		}
		return 0;
	}
	return 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "playerDisconnect" (number 26)
