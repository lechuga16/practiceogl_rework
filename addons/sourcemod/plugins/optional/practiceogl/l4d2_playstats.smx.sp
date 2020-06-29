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
 Extension __ext_sdktools = 1028;
 Extension __ext_sdkhooks = 1072;
 Extension __ext_left4downtown = 1116;
 Extension __ext_cprefs = 1284;
 SharedPlugin __pl_readyup = 1336;
 bool g_bLateLoad;
 bool g_bFirstLoadDone;
 bool g_bLoadSkipDone;
 bool g_bLGOAvailable;
 bool g_bReadyUpAvailable;
 bool g_bPauseAvailable;
 bool g_bSkillDetectLoaded;
 bool g_bCMTActive;
 bool g_bCMTSwapped;
 bool g_bModeCampaign;
 bool g_bModeScavenge;
 Handle g_hCookiePrint;
 int g_iCookieValue[66];
 Handle g_hCvarDebug;
 Handle g_hCvarMVPBrevityFlags;
 Handle g_hCvarAutoPrintVs;
 Handle g_hCvarAutoPrintCoop;
 Handle g_hCvarShowBots;
 Handle g_hCvarDetailPercent;
 Handle g_hCvarWriteStats;
 Handle g_hCvarSkipMap;
 bool g_bGameStarted;
 bool g_bInRound;
 bool g_bTeamChanged;
 bool g_bTankInGame;
 bool g_bPlayersLeftStart;
 bool g_bSecondHalf;
 bool g_bFailedPrevious;
 int g_iRound;
 int g_iCurTeam;
 int g_iTeamSize = 4;
 int g_iLastRoundEndPrint;
 int g_iSurvived[2];
 bool g_bPaused;
 int g_iPauseStart;
 int g_iScores[2];
 int g_iFirstScoresSet[3];
 int g_iBoomedBy[66];
 int g_iPlayerIndexSorted[4][64];
 int g_iPlayerSortedUseTeam[4][64];
 int g_iPlayerRoundTeam[3][64];
 int g_iPlayerGameTeam[2][64];
 int g_strGameData[2];
 int g_strAllRoundData[2][19];
 int g_strRoundData[48][2][19];
 int g_strPlayerData[64][77];
 int g_strRoundPlayerData[64][2][77];
 int g_strPlayerInfData[64][77];
 int g_strRoundPlayerInfData[64][2][77];
 Handle g_hTriePlayers;
 Handle g_hTrieWeapons;
 Handle g_hTrieMaps;
 Handle g_hTrieEntityCreated;
 float g_fHighestFlow[4];
 char g_sPlayerName[64][16];
 char g_sPlayerNameSafe[64][16];
 char g_sPlayerId[64][8];
 char g_sMapName[48][8];
 char g_sConfigName[8];
 int g_iPlayers;
 char g_sConsoleBuf[10][1024];
 int g_iConsoleBufChunks;
 char g_sStatsFile[16];
 Handle g_hStatsFile;
public Plugin myinfo =
{
	name = "Player Statistics",
	description = "Tracks statistics, even when clients disconnect. MVP, Skills, Accuracy, etc.",
	author = "Tabun",
	version = "0.9.30",
	url = "https://github.com/Tabbernaut/L4D2-Plugins"
};
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

int RoundFloat(float value)
{
	return RoundToNearest(value);
}

float operator*(Float:,_:)(float oper1, int oper2)
{
	return FloatMul(oper1, float(oper2));
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

int ExplodeString(char text[], char split[], char buffers[][], int maxStrings, int maxStringLength, bool copyRemainder)
{
	int reloc_idx = 0;
	int idx = 0;
	int total = 0;
	int var1;
	if (maxStrings < 1)
	{
		return 0;
	}
	int var2 = SplitString(text[reloc_idx], split, buffers[total], maxStringLength);
	idx = var2;
	while (var2 != -1)
	{
		reloc_idx = idx + reloc_idx;
		total++;
		if (maxStrings == total)
		{
			if (copyRemainder)
			{
				strcopy(buffers[total + -1], maxStringLength, text[reloc_idx - idx]);
			}
			return total;
		}
	}
	total++;
	strcopy(buffers[total], maxStringLength, text[reloc_idx]);
	return total;
}

int PrintToChatAll(char format[])
{
	char buffer[192];
	int i = 1;
	while (i <= MaxClients)
	{
		if (IsClientInGame(i))
		{
			SetGlobalTransTarget(i);
			VFormat(buffer, 192, format, 2);
			PrintToChat(i, "%s", buffer);
			i++;
		}
		i++;
	}
	return 0;
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

Address L4D2Direct_GetTerrorNavMesh()
{
	static Address TheNavMesh;
	if (!TheNavMesh)
	{
		TheNavMesh = GameConfGetAddress(L4D2Direct_GetGameConf(), "TerrorNavMesh");
	}
	return TheNavMesh;
}

Address L4D2Direct_GetMapMaxFlowDistanceAddr()
{
	static Address pMapMaxFlowDistance;
	if (!pMapMaxFlowDistance)
	{
		int offs = GameConfGetOffset(L4D2Direct_GetGameConf(), "TerrorNavMesh::m_fMapMaxFlowDistance");
		if (offs == -1)
		{
			return Address 0;
		}
		pMapMaxFlowDistance = L4D2Direct_GetTerrorNavMesh() + offs;
	}
	return pMapMaxFlowDistance;
}

float L4D2Direct_GetMapMaxFlowDistance()
{
	return LoadFromAddress(L4D2Direct_GetMapMaxFlowDistanceAddr(), NumberType 2);
}

float L4D2Direct_GetFlowDistance(int client)
{
	static Handle GetFlowDistanceSDKCall;
	if (!GetFlowDistanceSDKCall)
	{
		StartPrepSDKCall(SDKCallType 2);
		if (!PrepSDKCall_SetFromConf(L4D2Direct_GetGameConf(), SDKFuncConfSource 1, "CTerrorPlayer::GetFlowDistance"))
		{
			return 0;
		}
		PrepSDKCall_AddParameter(SDKType 4, SDKPassMethod 1, 0, 0);
		PrepSDKCall_SetReturnInfo(SDKType 5, SDKPassMethod 1, 0, 0);
		GetFlowDistanceSDKCall = EndPrepSDKCall();
		if (GetFlowDistanceSDKCall)
		{
		}
		else
		{
			return 0;
		}
	}
	return SDKCall(GetFlowDistanceSDKCall, client, 0);
}

public int __pl_readyup_SetNTVOptional()
{
	MarkNativeAsOptional("AddStringToReadyFooter");
	MarkNativeAsOptional("IsInReady");
	MarkNativeAsOptional("IsClientCaster");
	MarkNativeAsOptional("IsIDCaster");
	return 0;
}

public int __pl_lgofnoc_SetNTVOptional()
{
	MarkNativeAsOptional("LGO_BuildConfigPath");
	MarkNativeAsOptional("LGO_ExecuteConfigCfg");
	MarkNativeAsOptional("LGO_IsMapDataAvailable");
	MarkNativeAsOptional("LGO_GetMapValueInt");
	MarkNativeAsOptional("LGO_GetMapValueFloat");
	MarkNativeAsOptional("LGO_GetMapValueVector");
	MarkNativeAsOptional("LGO_GetMapValueString");
	MarkNativeAsOptional("LGO_CopyMapSubsection");
	return 0;
}

public APLRes AskPluginLoad2(Handle myself, bool late, char error[], int err_max)
{
	g_bLateLoad = late;
	return APLRes 0;
}

public int OnAllPluginsLoaded()
{
	g_bLGOAvailable = LibraryExists("lgofnoc");
	g_bReadyUpAvailable = LibraryExists("readyup");
	g_bPauseAvailable = LibraryExists("pause");
	g_bSkillDetectLoaded = LibraryExists("skill_detect");
	return 0;
}

public int OnLibraryRemoved(char name[])
{
	if (StrEqual(name, "lgofnoc", true))
	{
		g_bLGOAvailable = 0;
	}
	else
	{
		if (StrEqual(name, "readyup", true))
		{
			g_bReadyUpAvailable = 0;
		}
		if (StrEqual(name, "pause", true))
		{
			g_bPauseAvailable = 0;
		}
		if (StrEqual(name, "skill_detect", true))
		{
			g_bSkillDetectLoaded = 0;
		}
	}
	return 0;
}

public int OnLibraryAdded(char name[])
{
	if (StrEqual(name, "lgofnoc", true))
	{
		g_bLGOAvailable = 1;
	}
	else
	{
		if (StrEqual(name, "readyup", true))
		{
			g_bReadyUpAvailable = 1;
		}
		if (StrEqual(name, "pause", true))
		{
			g_bPauseAvailable = 1;
		}
		if (StrEqual(name, "skill_detect", true))
		{
			g_bSkillDetectLoaded = 1;
		}
	}
	return 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "OnPluginStart" (number 18)
public int LGO_OnMatchModeStart(char sConfig[])
{
	g_bLoadSkipDone = 0;
	return 0;
}

public int OnConfigsExecuted()
{
	g_iTeamSize = GetConVarInt(FindConVar("survivor_limit"));
	Handle tmpHandle = FindConVar("l4d_ready_cfg_name");
	if (tmpHandle)
	{
		GetConVarString(tmpHandle, g_sConfigName, 32);
	}
	return 0;
}

public int OnClientPostAdminCheck(int client)
{
	GetPlayerIndexForClient(client);
	return 0;
}

public int OnClientDisconnect(int client)
{
	g_iCookieValue[client] = 0;
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(client);
	if (index == -1)
	{
		return 0;
	}
	int time = GetTime({0,0});
	if (g_bPaused)
	{
		time = g_iPauseStart;
	}
	if (g_iCurTeam == g_iPlayerRoundTeam[8][0][index])
	{
		g_strRoundPlayerData[index][0][0][g_iCurTeam][288] = time;
		if (!g_strRoundPlayerData[index][0][0][g_iCurTeam][296])
		{
			g_strRoundPlayerData[index][0][0][g_iCurTeam][296] = time;
		}
		if (!g_strRoundPlayerData[index][0][0][g_iCurTeam][304])
		{
			g_strRoundPlayerData[index][0][0][g_iCurTeam][304] = time;
		}
	}
	else
	{
		int var1;
		if (g_iCurTeam == g_iPlayerRoundTeam[8][0][index])
		{
			var1 = 0;
		}
		else
		{
			var1 = 1;
		}
		if (var1)
		{
			g_strRoundPlayerInfData[index][0][0][g_iCurTeam][96] = time;
		}
	}
	return 0;
}

public int OnMapStart()
{
	g_bSecondHalf = 0;
	CheckGameMode();
	int var2;
	if (!g_bLoadSkipDone)
	{
		PrintDebug(2, "OnMapStart: Resetting all stats (resetnextmap setting)... ");
		ResetStats(false, -1, false);
		SetConVarInt(g_hCvarSkipMap, 0, false, false);
		g_bLoadSkipDone = 1;
		g_iFirstScoresSet[0] = 0;
		g_iFirstScoresSet[4] = 0;
		g_iFirstScoresSet[8] = 1;
	}
	else
	{
		if (g_bFirstLoadDone)
		{
			PrintDebug(2, "OnMapStart: Reset stats for round (Timer_ResetStats)");
			CreateTimer(5, Timer_ResetStats, any 1, 2);
		}
	}
	g_bFirstLoadDone = 1;
	CreateTimer(1, Timer_SaveFlows, any 0, 3);
	GetCurrentMap(g_sMapName[g_iRound][0][0], 32);
	return 0;
}

public int OnMapEnd()
{
	g_bInRound = 0;
	g_iRound += 1;
	int var1;
	if (!g_bCMTActive)
	{
		HandleGameEnd();
	}
	return 0;
}

public int Event_MissionLostCampaign(Handle hEvent, char name[], bool dontBroadcast)
{

/* ERROR! unknown load */
 function "Event_MissionLostCampaign" (number 25)
public int Event_RoundStart(Handle hEvent, char name[], bool dontBroadcast)
{
	HandleRoundStart(false);
	CreateTimer(5,5, Timer_RoundStart, any 0, 2);
	return 0;
}

int HandleRoundStart(bool bLeftStart)
{
	if (g_bInRound)
	{
		return 0;
	}
	g_bInRound = 1;
	g_bPlayersLeftStart = bLeftStart;
	g_bTankInGame = 0;
	g_bPaused = 0;
	if (bLeftStart)
	{
		int var1;
		if (g_bModeCampaign)
		{
			var1 = 0;
		}
		else
		{
			var1 = GetCurrentTeamSurvivor();
		}
		g_iCurTeam = var1;
		ClearPlayerTeam(g_iCurTeam);
	}
	return 0;
}

public Action Timer_RoundStart(Handle timer)
{
	int var1;
	if (g_bModeCampaign)
	{
		var1 = 0;
	}
	else
	{
		var1 = GetCurrentTeamSurvivor();
	}
	g_iCurTeam = var1;
	ClearPlayerTeam(g_iCurTeam);
	return Action 0;
}

public int Event_RoundEnd(Handle hEvent, char name[], bool dontBroadcast)
{
	HandleRoundEnd(false);
	return 0;
}

int HandleRoundEnd(bool bFailed)
{
	PrintDebug(1, "HandleRoundEnd (failed: %i): inround: %i, current round: %i", bFailed, 1964, 1988);
	if (!g_bInRound)
	{
		return 0;
	}
	g_iSurvived[g_iCurTeam] = GetUprightSurvivors();
	if (g_bTankInGame)
	{
		HandleTankTimeEnd();
	}
	SetRoundEndTimes();
	g_bInRound = 0;
	int var1;
	if (!g_bModeCampaign)
	{
		if (GetConVarBool(g_hCvarWriteStats))
		{
			if (g_bSecondHalf)
			{
				CreateTimer(1, Timer_WriteStats, g_iCurTeam, 0);
			}
			WriteStatsToFile(g_iCurTeam, false);
		}
		HandleRoundAddition();
		int var2;
		if (g_iLastRoundEndPrint)
		{
			AutomaticRoundEndPrint(false);
		}
	}
	int var3;
	if (g_bModeCampaign)
	{
		PrintDebug(2, "HandleRoundEnd: Reset stats for entire game (no players on server)...");
		ResetStats(false, -1, false);
	}
	if (!g_bModeCampaign)
	{
		if (g_bSecondHalf)
		{
			g_iFirstScoresSet[8] = 0;
		}
		g_bSecondHalf = 1;
	}
	else
	{
		g_bFailedPrevious = bFailed;
	}
	g_bPlayersLeftStart = 0;
	return 0;
}

int SetRoundEndTimes()
{
	int i = 0;
	int j = 0;
	int time = GetTime({0,0});
	i = 13;
	while (i < 18)
	{
		int var1;
		if (g_strRoundData[g_iRound][0][0][g_iCurTeam][i])
		{
			g_strRoundData[g_iRound][0][0][g_iCurTeam][i + 1] = time;
			i += 2;
		}
		i += 2;
	}
	j = 0;
	while (j < g_iPlayers)
	{
		i = 71;
		while (i < 76)
		{
			int var2;
			if (g_strRoundPlayerData[j][0][0][g_iCurTeam][i])
			{
				g_strRoundPlayerData[j][0][0][g_iCurTeam][i + 1] = time;
				i += 2;
			}
			i += 2;
		}
		i = 23;
		while (i < 24)
		{
			int var3;
			if (g_strRoundPlayerInfData[j][0][0][g_iCurTeam][i])
			{
				g_strRoundPlayerInfData[j][0][0][g_iCurTeam][i + 1] = time;
				i += 2;
			}
			i += 2;
		}
		j++;
	}
	return 0;
}

int HandleRoundAddition()
{
	int i = 0;
	int j = 0;
	int var1;
	if (g_iCurTeam)
	{
		var1 = 190424;
	}
	else
	{
		var1 = 190420;
	}
	PrintDebug(1, "Handling round addition for round %i, roundhalf %i (team %s).", 1988, 1980, var1);
	i = 0;
	while (i < 13)
	{
		int var5 = g_strAllRoundData[g_iCurTeam][0][0][i];
		var5 = g_strRoundData[g_iRound][0][0][g_iCurTeam][i] + var5;
		i++;
	}
	i = 13;
	while (i < 18)
	{
		int var2;
		if (!g_strRoundData[g_iRound][0][0][g_iCurTeam][i])
		{
		}
		else
		{
			if (!g_strAllRoundData[g_iCurTeam][0][0][i])
			{
				g_strAllRoundData[g_iCurTeam][0][0][i] = g_strRoundData[g_iRound][0][0][g_iCurTeam][i];
				g_strAllRoundData[g_iCurTeam][0][0][i + 1] = g_strRoundData[g_iRound][0][0][g_iCurTeam][i + 1];
			}
			else
			{
				int var6 = g_strAllRoundData[g_iCurTeam][0][0][i + 1];
				var6 = g_strRoundData[g_iRound][0][0][g_iCurTeam][i + 1] - g_strRoundData[g_iRound][0][0][g_iCurTeam][i] + var6;
			}
		}
		i += 2;
	}
	j = 0;
	while (j < g_iPlayers)
	{
		i = 0;
		while (i < 71)
		{
			int var7 = g_strPlayerData[j][0][0][i];
			var7 = g_strRoundPlayerData[j][0][0][g_iCurTeam][i] + var7;
			i++;
		}
		i = 71;
		while (i < 76)
		{
			int var3;
			if (!g_strRoundPlayerData[j][0][0][g_iCurTeam][i])
			{
			}
			else
			{
				if (!g_strPlayerData[j][0][0][i])
				{
					g_strPlayerData[j][0][0][i] = g_strRoundPlayerData[j][0][0][g_iCurTeam][i];
					g_strPlayerData[j][0][0][i + 1] = g_strRoundPlayerData[j][0][0][g_iCurTeam][i + 1];
				}
				else
				{
					int var8 = g_strPlayerData[j][0][0][i + 1];
					var8 = g_strRoundPlayerData[j][0][0][g_iCurTeam][i + 1] - g_strRoundPlayerData[j][0][0][g_iCurTeam][i] + var8;
				}
			}
			i += 2;
		}
		i = 0;
		while (i < 23)
		{
			int var9 = g_strPlayerInfData[j][0][0][i];
			var9 = g_strRoundPlayerInfData[j][0][0][g_iCurTeam][i] + var9;
			i++;
		}
		i = 23;
		while (i < 24)
		{
			int var4;
			if (!g_strRoundPlayerInfData[j][0][0][g_iCurTeam][i])
			{
			}
			else
			{
				if (!g_strPlayerInfData[j][0][0][i])
				{
					g_strPlayerInfData[j][0][0][i] = g_strRoundPlayerInfData[j][0][0][g_iCurTeam][i];
					g_strPlayerInfData[j][0][0][i + 1] = g_strRoundPlayerInfData[j][0][0][g_iCurTeam][i + 1];
				}
				else
				{
					int var10 = g_strPlayerInfData[j][0][0][i + 1];
					var10 = g_strRoundPlayerInfData[j][0][0][g_iCurTeam][i + 1] - g_strRoundPlayerInfData[j][0][0][g_iCurTeam][i] + var10;
				}
			}
			i += 2;
		}
		j++;
	}
	return 0;
}

public int Event_MapTransition(Handle hEvent, char name[], bool dontBroadcast)
{
	if (g_bModeCampaign)
	{
		HandleRoundEnd(false);
	}
	return 0;
}

public int Event_FinaleWin(Handle hEvent, char name[], bool dontBroadcast)
{
	if (g_bModeCampaign)
	{
		HandleRoundEnd(false);
		if (!g_bCMTActive)
		{
			HandleGameEnd();
		}
	}
	return 0;
}

int HandleGameEnd()
{
	PrintDebug(2, "HandleGameEnd...");
	ResetStats(false, -1, false);
	g_bLoadSkipDone = 0;
	return 0;
}

public int OnRoundIsLive()
{
	RoundReallyStarting();
	return 0;
}

public Action L4D_OnFirstSurvivorLeftSafeArea(int client)
{
	HandleRoundStart(true);
	if (!g_bReadyUpAvailable)
	{
		RoundReallyStarting();
	}
	return Action 0;
}

int RoundReallyStarting()
{
	g_bPlayersLeftStart = 1;
	int time = GetTime({0,0});
	int i = 1;
	while (i <= MaxClients)
	{
		g_iBoomedBy[i] = 0;
		i++;
	}
	i = 0;
	while (i < 4)
	{
		g_fHighestFlow[i] = 0;
		i++;
	}
	if (!g_bGameStarted)
	{
		g_bGameStarted = 1;
		g_strGameData[4] = time;
		SetStartSurvivorTime(true, g_bFailedPrevious);
	}
	int var1;
	if (g_bFailedPrevious)
	{
		g_strRoundData[g_iRound][0][0][g_iCurTeam][52] = time - g_strRoundData[g_iRound][0][0][g_iCurTeam][56] - g_strRoundData[g_iRound][0][0][g_iCurTeam][52];
		g_strRoundData[g_iRound][0][0][g_iCurTeam][56] = 0;
		g_bFailedPrevious = 0;
	}
	else
	{
		g_strRoundData[g_iRound][0][0][g_iCurTeam][52] = time;
	}
	UpdatePlayerCurrentTeam();
	SetStartSurvivorTime(false, false);
	return 0;
}

public int OnPause()
{
	if (g_bPaused)
	{
		return 0;
	}
	g_bPaused = 1;
	int time = GetTime({0,0});
	g_iPauseStart = time;
	PrintDebug(1, "Pause (start time: %i -- stored time: %i -- round start time: %i).", 2016, g_strRoundData[g_iRound][0][0][g_iCurTeam][60], g_strRoundData[g_iRound][0][0][g_iCurTeam][52]);
	return 0;
}

public int OnUnpause()
{
	g_bPaused = 0;
	int time = GetTime({0,0});
	int pauseTime = time - g_iPauseStart;
	int client = 0;
	int index = 0;
	int var1;
	if (!g_strRoundData[g_iRound][0][0][g_iCurTeam][60])
	{
		g_strRoundData[g_iRound][0][0][g_iCurTeam][60] = g_iPauseStart;
	}
	else
	{
		g_strRoundData[g_iRound][0][0][g_iCurTeam][60] = g_iPauseStart - g_strRoundData[g_iRound][0][0][g_iCurTeam][64] - g_strRoundData[g_iRound][0][0][g_iCurTeam][60];
	}
	g_strRoundData[g_iRound][0][0][g_iCurTeam][64] = time;
	g_strRoundData[g_iRound][0][0][g_iCurTeam][52] += pauseTime;
	if (g_bTankInGame)
	{
		g_strRoundData[g_iRound][0][0][g_iCurTeam][68] += pauseTime;
	}
	client = 1;
	while (client <= MaxClients)
	{
		int var2;
		if (client > 0)
		{
		}
		else
		{
			index = GetPlayerIndexForClient(client);
			if (index == -1)
			{
			}
			else
			{
				int var4;
				if (client > 0)
				{
					g_strRoundPlayerData[index][0][0][g_iCurTeam][300] += pauseTime;
				}
			}
		}
		client++;
	}
	PrintDebug(1, "Pause End (end time: %i -- pause duration: %i -- round start time: %i).", GetTime({0,0}), pauseTime, g_strRoundData[g_iRound][0][0][g_iCurTeam][52]);
	g_iPauseStart = 0;
	return 0;
}

public Action L4D_OnSetCampaignScores(&int scoreA, &int scoreB)
{
	if (g_bCMTSwapped)
	{
		g_iScores[4] = scoreA;
		g_iScores[0] = scoreB;
	}
	else
	{
		g_iScores[0] = scoreA;
		g_iScores[4] = scoreB;
	}
	if (!g_iFirstScoresSet[8][0])
	{
		g_iFirstScoresSet[0] = scoreA;
		g_iFirstScoresSet[4] = scoreB;
		g_iFirstScoresSet[8] = 1;
	}
	return Action 0;
}

public Action Cmd_Say(int client, int args)
{
	if (!client)
	{
		return Action 0;
	}
	char sMessage[64];
	GetCmdArg(1, sMessage, 64);
	int var1;
	if (StrEqual(sMessage, "!mvp", true))
	{
		return Action 3;
	}
	return Action 0;
}

public Action Cmd_StatsDisplayGeneral(int client, int args)
{
	int iType = 0;
	char sArg[24];
	GetCmdArg(0, sArg, 24);
	if (StrEqual(sArg, "sm_mvp", false))
	{
		iType = 1;
	}
	else
	{
		if (StrEqual(sArg, "sm_ff", false))
		{
			iType = 2;
		}
		if (StrEqual(sArg, "sm_skill", false))
		{
			iType = 3;
		}
		if (StrEqual(sArg, "sm_acc", false))
		{
			iType = 4;
		}
		if (StrEqual(sArg, "sm_inf", false))
		{
			iType = 5;
		}
	}
	bool bSetRound = 0;
	bool bRound = 1;
	bool bSetGame = 0;
	bool bGame = 0;
	bool bSetAll = 0;
	bool bAll = 0;
	bool bOther = 0;
	bool bTank = 0;
	bool bMore = 0;
	bool bMy = 0;
	int iStart = 1;
	int otherTeam;
	int var1;
	if (g_iCurTeam)
	{
		var1 = 0;
	}
	else
	{
		var1 = 1;
	}
	otherTeam = var1;
	if (args)
	{
		GetCmdArg(1, sArg, 24);
		int var2;
		if (StrEqual(sArg, "help", false))
		{
			int var3;
			if (client > 0)
			{
				PrintToChat(client, "\x01Use: /stats [<type>] [\x05round\x01/\x05game\x01/\x05team\x01/\x05all\x01/\x05other\x01]");
				PrintToChat(client, "\x01 or: /stats [<type>] [\x05r\x01/\x05g\x01/\x05t\x01/\x05a\x01/\x05o\x01]");
				PrintToChat(client, "\x01 where <type> is '\x04mvp\x01', '\x04skill\x01', '\x04ff\x01', '\x04acc\x01' or '\x04inf\x01'. (for more, see console)");
			}
			char bufBasic[4096];
			Format(bufBasic, 4096, "|------------------------------------------------------------------------------|\n");
			Format(bufBasic, 4096, "%s| /stats command help      in chat:    '/stats <type> [argument [argument]]'   |\n", bufBasic);
			Format(bufBasic, 4096, "%s|                          in console: 'sm_stats <type> [arguments...]'        |\n", bufBasic);
			Format(bufBasic, 4096, "%s|------------------------------------------------------------------------------|\n", bufBasic);
			Format(bufBasic, 4096, "%s| stat type:   'general':  general statistics about the game, as in campaign   |\n", bufBasic);
			Format(bufBasic, 4096, "%s|              'mvp'    :  SI damage, common kills    (extra argument: 'tank') |\n", bufBasic);
			Format(bufBasic, 4096, "%s|              'skill'  :  skeets, levels, crowns, tongue cuts, etc            |\n", bufBasic);
			Format(bufBasic, 4096, "%s|              'ff'     :  friendly fire damage (per type of weapon)           |\n", bufBasic);
			Format(bufBasic, 4096, "%s|              'acc'    :  accuracy details           (extra argument: 'more') |\n", bufBasic);
			Format(bufBasic, 4096, "%s|              'inf'    :  special infected stats (dp's, damage done etc)      |", bufBasic);
			int var5;
			if (client > 0)
			{
				PrintToConsole(client, bufBasic);
			}
			else
			{
				PrintToServer(bufBasic);
			}
			Format(bufBasic, 4096, "|------------------------------------------------------------------------------|\n");
			Format(bufBasic, 4096, "%s| arguments:                                                                   |\n", bufBasic);
			Format(bufBasic, 4096, "%s|------------------------------------------------------------------------------|\n", bufBasic);
			Format(bufBasic, 4096, "%s|   'round' ('r') / 'game' ('g') : for this round; or for entire game so far   |\n", bufBasic);
			Format(bufBasic, 4096, "%s|   'team' ('t') / 'all' ('a')   : current survivor team only; or all players  |\n", bufBasic);
			Format(bufBasic, 4096, "%s|   'other' ('o') / 'my'         : team that is now infected; or your team NMW |\n", bufBasic);
			Format(bufBasic, 4096, "%s|   'tank'          [ MVP only ] : show stats for tank fight                   |\n", bufBasic);
			Format(bufBasic, 4096, "%s|   'more'    [ ACC & MVP only ] : show more stats ( MVP time / SI/tank hits ) |", bufBasic);
			int var7;
			if (client > 0)
			{
				PrintToConsole(client, bufBasic);
			}
			else
			{
				PrintToServer(bufBasic);
			}
			Format(bufBasic, 4096, "|------------------------------------------------------------------------------|\n");
			Format(bufBasic, 4096, "%s| examples:                                                                    |\n", bufBasic);
			Format(bufBasic, 4096, "%s|------------------------------------------------------------------------------|\n", bufBasic);
			Format(bufBasic, 4096, "%s|   '/stats skill round all' => shows skeets etc for all players, this round   |\n", bufBasic);
			Format(bufBasic, 4096, "%s|   '/stats ff team game'    => shows active team's friendly fire, this round  |\n", bufBasic);
			Format(bufBasic, 4096, "%s|   '/stats acc my'          => shows accuracy stats (your team, this round)   |\n", bufBasic);
			Format(bufBasic, 4096, "%s|   '/stats mvp tank'        => shows survivor action while tank is/was up     |\n", bufBasic);
			Format(bufBasic, 4096, "%s|------------------------------------------------------------------------------|", bufBasic);
			int var9;
			if (client > 0)
			{
				PrintToConsole(client, bufBasic);
			}
			else
			{
				PrintToServer(bufBasic);
			}
			return Action 3;
		}
		if (StrEqual(sArg, "mvp", false))
		{
			iType = 1;
			iStart++;
		}
		else
		{
			if (StrEqual(sArg, "ff", false))
			{
				iType = 2;
				iStart++;
			}
			int var11;
			if (StrEqual(sArg, "skill", false))
			{
				iType = 3;
				iStart++;
			}
			int var12;
			if (StrEqual(sArg, "acc", false))
			{
				iType = 4;
				iStart++;
			}
			int var13;
			if (StrEqual(sArg, "inf", false))
			{
				iType = 5;
				iStart++;
			}
			int var14;
			if (StrEqual(sArg, "fact", false))
			{
				iType = 6;
				iStart++;
			}
			int var15;
			if (StrEqual(sArg, "general", false))
			{
				iType = 0;
				iStart++;
			}
		}
		int i = iStart;
		while (i <= args)
		{
			GetCmdArg(i, sArg, 24);
			int var16;
			if (StrEqual(sArg, "round", false))
			{
				bSetRound = 1;
				bRound = 1;
				i++;
			}
			else
			{
				int var17;
				if (StrEqual(sArg, "game", false))
				{
					bSetGame = 1;
					bGame = 1;
					i++;
				}
				int var18;
				if (StrEqual(sArg, "all", false))
				{
					bSetAll = 1;
					bAll = 1;
					i++;
				}
				int var19;
				if (StrEqual(sArg, "team", false))
				{
					if (bSetAll)
					{
						bSetAll = 1;
						bAll = 0;
						i++;
					}
					i++;
				}
				int var20;
				if (StrEqual(sArg, "other", false))
				{
					bOther = 1;
					i++;
				}
				int var21;
				if (StrEqual(sArg, "more", false))
				{
					bMore = 1;
					i++;
				}
				if (StrEqual(sArg, "tank", false))
				{
					bTank = 1;
					i++;
				}
				if (StrEqual(sArg, "my", false))
				{
					bMy = 1;
					i++;
				}
				int var22;
				if (client > 0)
				{
					PrintToChat(client, "Stats command: unknown argument: '%s'. Type '/stats help' for possible arguments.", sArg);
					i++;
				}
				PrintToServer("Stats command: unknown argument: '%s'. Type '/stats help' for possible arguments.", sArg);
				i++;
			}
			i++;
		}
	}
	int iTeam;
	int var24;
	if (bOther)
	{
		var24 = otherTeam;
	}
	else
	{
		var24 = -1;
	}
	iTeam = var24;
	if (bMy)
	{
		int index = GetPlayerIndexForClient(client);
		int curteam = -1;
		if (index != -1)
		{
			curteam = g_iPlayerRoundTeam[8][0][index];
			if (curteam != -1)
			{
				bSetAll = 1;
				bAll = 0;
				iTeam = curteam;
			}
			iTeam = -1;
		}
	}
	switch (iType)
	{
		case 0: {
			int var54;
			if (bSetAll)
			{
				var55 = 0;
			}
			else
			{
				var55 = 1;
			}
			int var56;
			if (bSetRound)
			{
				var57 = 1;
			}
			else
			{
				var57 = 0;
			}
			DisplayStats(client, var57, -1, var55, iTeam);
		}
		case 1: {
			int var45;
			if (bSetAll)
			{
				var46 = 0;
			}
			else
			{
				var46 = 1;
			}
			int var47;
			if (bSetGame)
			{
				var48 = 0;
			}
			else
			{
				var48 = 1;
			}
			DisplayStatsMVP(client, bTank, bMore, var48, var46, iTeam);
			int var49;
			if (!bTank)
			{
				int var50;
				if (bSetAll)
				{
					var51 = 0;
				}
				else
				{
					var51 = 1;
				}
				int var52;
				if (bSetGame)
				{
					var53 = 0;
				}
				else
				{
					var53 = 1;
				}
				DisplayStatsMVPChat(client, var53, var51, iTeam);
			}
		}
		case 2: {
			int var41;
			if (bSetAll)
			{
				var42 = 0;
			}
			else
			{
				var42 = 1;
			}
			int var43;
			if (bSetGame)
			{
				var44 = 0;
			}
			else
			{
				var44 = 1;
			}
			DisplayStatsFriendlyFire(client, var44, var42, false, iTeam);
		}
		case 3: {
			int var37;
			if (bSetAll)
			{
				var38 = 0;
			}
			else
			{
				var38 = 1;
			}
			int var39;
			if (bSetGame)
			{
				var40 = 0;
			}
			else
			{
				var40 = 1;
			}
			DisplayStatsSpecial(client, var40, var38, false, iTeam);
		}
		case 4: {
			int var33;
			if (bSetAll)
			{
				var34 = 0;
			}
			else
			{
				var34 = 1;
			}
			int var35;
			if (bSetGame)
			{
				var36 = 0;
			}
			else
			{
				var36 = 1;
			}
			DisplayStatsAccuracy(client, bMore, var36, var34, false, iTeam);
		}
		case 5: {
			int var29;
			if (bSetAll)
			{
				var30 = 0;
			}
			else
			{
				var30 = 1;
			}
			int var31;
			if (bSetGame)
			{
				var32 = 0;
			}
			else
			{
				var32 = 1;
			}
			DisplayStatsInfected(client, var32, var30, false, iTeam);
		}
		case 6: {
			int var25;
			if (bSetAll)
			{
				var26 = 0;
			}
			else
			{
				var26 = 1;
			}
			int var27;
			if (bSetGame)
			{
				var28 = 0;
			}
			else
			{
				var28 = 1;
			}
			DisplayStatsFunFactChat(client, var28, var26, iTeam);
		}
		default: {
		}
	}
	return Action 3;
}

public Action Cmd_StatsReset(int client, int args)
{
	ResetStats(false, -1, false);
	PrintToChatAll("Player statistics reset.");
	return Action 3;
}

public Action Cmd_Cookie_SetPrintFlags(int client, int args)
{
	int var1;
	if (client > 0)
	{
		PrintToServer("This command can only be used by clients. Use the sm_stats_autoprint_* cvars to set server preferences.");
		return Action 3;
	}
	if (args)
	{
		char sArg[24];
		GetCmdArg(1, sArg, 24);
		int iFlags = StringToInt(sArg, 10);
		int var3;
		if (StrEqual(sArg, "?", false))
		{
			PrintToChat(client, "\x01Use: \x04/stats_auto <flags>\x01. Flags is an integer that is the sum of all printouts to be displayed at round-end.");
			PrintToChat(client, "\x01Set flags to 0 to use server autoprint default; set to -1 to not display anything at all.");
			PrintToChat(client, "\x01See: \x05https://github.com/Tabbernaut/L4D2-Plugins/blob/master/stats/README.md\x01 for a list of flags.");
			return Action 3;
		}
		int var4;
		if (StrEqual(sArg, "test", false))
		{
			if (g_iCookieValue[client][0][0] < 1)
			{
				PrintToChat(client, "\x01Stats Preview: No flags set. First set flags with \x04/stats_auto <flags>\x01. Type \x04/stats_auto help\x01 for more info.");
				return Action 3;
			}
			AutomaticPrintPerClient(g_iCookieValue[client][0][0], client, -1, false, false, false, false);
		}
		else
		{
			if (iFlags >= -1)
			{
				if (iFlags == -1)
				{
					PrintToChat(client, "\x01Stats Pref.: \x04no round end prints at all\x01.");
				}
				else
				{
					if (iFlags)
					{
						int var8;
						char tmpPrint[256];
						int part = 0;
						if (iFlags & 1)
						{
							Format(var8[part], 24, "mvp/chat(round)");
							part++;
						}
						if (iFlags & 2)
						{
							Format(var8[part], 24, "mvp/chat(game)");
							part++;
						}
						if (iFlags & 4)
						{
							Format(var8[part], 24, "mvp(round)");
							part++;
						}
						if (iFlags & 8)
						{
							Format(var8[part], 24, "mvp(game)");
							part++;
						}
						if (iFlags & 32768)
						{
							Format(var8[part], 24, "mvp/more(round)");
							part++;
						}
						if (iFlags & 65536)
						{
							Format(var8[part], 24, "mvp/more(game)");
							part++;
						}
						if (iFlags & 16)
						{
							Format(var8[part], 24, "mvp/tankfight");
							part++;
						}
						if (iFlags & 128)
						{
							Format(var8[part], 24, "skill/special(round)");
							part++;
						}
						if (iFlags & 256)
						{
							Format(var8[part], 24, "skill/special(game)");
							part++;
						}
						if (iFlags & 32)
						{
							Format(var8[part], 24, "ff(round)");
							part++;
						}
						if (iFlags & 64)
						{
							Format(var8[part], 24, "ff(game)");
							part++;
						}
						if (iFlags & 512)
						{
							Format(var8[part], 24, "accuracy(round)");
							part++;
						}
						if (iFlags & 1024)
						{
							Format(var8[part], 24, "accuracy(game)");
							part++;
						}
						if (iFlags & 2048)
						{
							Format(var8[part], 24, "acc/more(round)");
							part++;
						}
						if (iFlags & 4096)
						{
							Format(var8[part], 24, "acc/more(game)");
							part++;
						}
						PrintToChat(client, "\x01Stats Pref.: Flags set for:", var8);
						int tmpCnt = 0;
						int i = 0;
						while (i < part)
						{
							int var5;
							if (tmpCnt)
							{
								var5 = 194372;
							}
							else
							{
								var5 = 194376;
							}
							Format(tmpPrint, 256, "%s%s%s", tmpPrint, var5, var8[i]);
							tmpCnt++;
							int var6;
							if (tmpCnt >= 6)
							{
								int var7;
								if (i < part + -1)
								{
									var7 = 194388;
								}
								else
								{
									var7 = 194392;
								}
								PrintToChat(client, "\x04%s%s\x01", tmpPrint, var7);
								tmpCnt = 0;
								i++;
							}
							i++;
						}
						PrintToChat(client, "\x01Use \x04/stats_auto test\x01 to get a report preview.");
					}
					PrintToChat(client, "\x01Stats Pref.: \x04server default\x01.");
				}
				g_iCookieValue[client] = iFlags;
				if (AreClientCookiesCached(client))
				{
					char sCookieValue[16];
					IntToString(iFlags, sCookieValue, 16);
					SetClientCookie(client, g_hCookiePrint, sCookieValue);
				}
				else
				{
					PrintToChat(client, "Stats Pref.: Error: cookie not cached yet (try again in a bit).");
				}
			}
			PrintToChat(client, "Stats Pref.: invalid value: '%s'. Type '/stats_auto help' for more info.", sArg);
		}
	}
	else
	{
		PrintToChat(client, "\x01Use: \x04/stats_auto <flags>\x01. Type \x04/stats_auto help\x01 for more info.");
	}
	return Action 3;
}

public int OnClientCookiesCached(int client)
{
	char sCookieValue[16];
	GetClientCookie(client, g_hCookiePrint, sCookieValue, 16);
	g_iCookieValue[client] = StringToInt(sCookieValue, 10);
	return 0;
}

public int OnCMTStart(int rounds, char mapname[])
{
	g_bCMTActive = 1;
	PrintDebug(2, "CMT start. Rounds: %i. First map: %s", rounds, mapname);
	ResetStats(false, -1, false);
	return 0;
}

public int OnCMTEnd()
{
	g_bCMTActive = 0;
	PrintDebug(2, "CMT end.");
	HandleGameEnd();
	return 0;
}

public int OnCMTTeamSwap()
{
	PrintDebug(2, "CMT TeamSwap.");
	g_bCMTSwapped = !g_bCMTSwapped;
	int iTmp = g_iScores[0][0];
	g_iScores[0] = g_iScores[4][0];
	g_iScores[4] = iTmp;
	iTmp = g_iFirstScoresSet[0][0];
	g_iFirstScoresSet[0] = g_iFirstScoresSet[4][0];
	g_iFirstScoresSet[4] = iTmp;
	return 0;
}

public Action Event_PlayerTeam(Handle event, char name[], bool dontBroadcast)
{
	if (!g_bTeamChanged)
	{
		int newTeam = GetEventInt(event, "team");
		int oldTeam = GetEventInt(event, "oldteam");
		int var1;
		if (newTeam != 2)
		{
			return Action 0;
		}
		g_bTeamChanged = 1;
		CreateTimer(0,5, Timer_TeamChanged, any 0, 2);
	}
	return Action 0;
}

public Action Timer_TeamChanged(Handle timer)
{
	g_bTeamChanged = 0;
	UpdatePlayerCurrentTeam();
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerHurt" (number 52)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_InfectedHurt" (number 53)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerFallDamage" (number 54)
public Action Event_WitchKilled(Handle event, char name[], bool dontBroadcast)
{
	g_strRoundData[g_iRound][0][0][g_iCurTeam][32]++;
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerDeath" (number 56)
public Action Timer_CheckTankDeath(Handle hTimer, any client_oldTank)
{
	if (!IsTankInGame())
	{
		g_strRoundData[g_iRound][0][0][g_iCurTeam][36]++;
		g_bTankInGame = 0;
		if (g_bInRound)
		{
			HandleTankTimeEnd();
		}
	}
	return Action 0;
}

int HandleTankTimeEnd()
{
	g_strRoundData[g_iRound][0][0][g_iCurTeam][72] = GetTime({0,0});
	return 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_TankSpawned" (number 59)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerIncapped" (number 60)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerRevived" (number 61)
public Action Event_SurvivorRescue(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "victim"));
	int index = GetPlayerIndexForClient(client);
	if (index == -1)
	{
		return Action 0;
	}
	int time = GetTime({0,0});
	int var1;
	if (g_strRoundPlayerData[index][0][0][g_iCurTeam][296])
	{
		int var3 = g_strRoundPlayerData[index][0][0][g_iCurTeam][292];
		var3 = time - g_strRoundPlayerData[index][0][0][g_iCurTeam][296] + var3;
		g_strRoundPlayerData[index][0][0][g_iCurTeam][296] = 0;
	}
	int var2;
	if (g_strRoundPlayerData[index][0][0][g_iCurTeam][304])
	{
		int var4 = g_strRoundPlayerData[index][0][0][g_iCurTeam][300];
		var4 = time - g_strRoundPlayerData[index][0][0][g_iCurTeam][304] + var4;
		g_strRoundPlayerData[index][0][0][g_iCurTeam][304] = 0;
	}
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerLedged" (number 63)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerLedgeRelease" (number 64)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_DefibUsed" (number 65)
public Action Event_HealSuccess(Handle event, char name[], bool dontBroadcast)
{
	g_strRoundData[g_iRound][0][0][g_iCurTeam][8]++;
	return Action 0;
}

public Action Event_PillsUsed(Handle event, char name[], bool dontBroadcast)
{
	g_strRoundData[g_iRound][0][0][g_iCurTeam][4]++;
	return Action 0;
}

public Action Event_AdrenUsed(Handle event, char name[], bool dontBroadcast)
{
	g_strRoundData[g_iRound][0][0][g_iCurTeam][4]++;
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_WeaponFire" (number 69)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerSpawn" (number 70)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerBoomed" (number 71)
public Action Event_PlayerUnboomed(Handle event, char name[], bool dontBroadcast)
{
	int victim = GetClientOfUserId(GetEventInt(event, "userid"));
	g_iBoomedBy[victim] = 0;
	return Action 0;
}

public int OnSpecialShoved(int attacker, int victim, int zombieClass)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][152]++;
	return 0;
}

public int OnHunterDeadstop(int attacker, int victim)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][156]++;
	return 0;
}

public int OnSkeet(int attacker, int victim)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][120]++;
	return 0;
}

public int OnSkeetGL(int attacker, int victim)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][120]++;
	return 0;
}

public int OnSkeetHurt(int attacker, int victim, int damage)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][124]++;
	return 0;
}

public int OnSkeetMelee(int attacker, int victim)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][128]++;
	return 0;
}

public int OnSkeetMeleeHurt(int attacker, int victim, int damage)
{
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][124]++;
	return 0;
}

public int OnSkeetSniper(int attacker, int victim)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][120]++;
	return 0;
}

public int OnSkeetSniperHurt(int attacker, int victim, int damage)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][124]++;
	return 0;
}

public int OnBoomerPop(int attacker, int victim, int shoveCount, float timeAlive)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][140]++;
	return 0;
}

public int OnChargerLevel(int attacker, int victim)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][132]++;
	return 0;
}

public int OnChargerLevelHurt(int attacker, int victim, int damage)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][136]++;
	return 0;
}

public int OnTongueCut(int attacker, int victim)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][160]++;
	return 0;
}

public int OnSmokerSelfClear(int attacker, int victim, int withShove)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][164]++;
	return 0;
}

public int OnWitchCrown(int attacker, int damage)
{
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][144]++;
	return 0;
}

public int OnWitchDrawCrown(int attacker, int damage, int chipdamage)
{
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][148]++;
	return 0;
}

public int OnTankRockEaten(int attacker, int victim)
{
	if (!g_bPlayersLeftStart)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(victim);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][204]++;
	return 0;
}

public int OnTankRockSkeeted(int attacker, int victim)
{
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][200]++;
	return 0;
}

public int OnHunterHighPounce(int attacker, int victim, int actualDamage, float damage, float height, bool bReportedHigh)
{
	if (!bReportedHigh)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerInfData[index][0][0][g_iCurTeam][32]++;
	int var1 = g_strRoundPlayerInfData[index][0][0][g_iCurTeam][36];
	var1 = RoundToFloor(damage) + var1;
	return 0;
}

public int OnJockeyHighPounce(int attacker, int victim, float height, bool bReportedHigh)
{
	if (!bReportedHigh)
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerInfData[index][0][0][g_iCurTeam][40]++;
	return 0;
}

public int OnDeathCharge(int attacker, int victim, float height, float distance, bool bCarried)
{
	int index = GetPlayerIndexForClient(attacker);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerInfData[index][0][0][g_iCurTeam][44]++;
	return 0;
}

public int OnSpecialClear(int clearer, int pinner, int pinvictim, int zombieClass, float timeA, float timeB, bool withShove)
{
	float fClearTime = timeA;
	int var1;
	if (zombieClass == 6)
	{
		fClearTime = timeB;
	}
	int var2;
	if (__FLOAT_LT__(fClearTime, 0))
	{
		return 0;
	}
	int index = GetPlayerIndexForClient(clearer);
	if (index == -1)
	{
		return 0;
	}
	g_strRoundPlayerData[index][0][0][g_iCurTeam][280] = RoundFloat(FloatDiv(FloatAdd(float(g_strRoundPlayerData[index][0][0][g_iCurTeam][276] * g_strRoundPlayerData[index][0][0][g_iCurTeam][280]), FloatMul(1000, fClearTime)), float(g_strRoundPlayerData[index][0][0][g_iCurTeam][276] + 1)));
	g_strRoundPlayerData[index][0][0][g_iCurTeam][276]++;
	return 0;
}

public Action Timer_ResetStats(Handle timer, any roundOnly)
{
	ResetStats(roundOnly, -1, false);
	return Action 0;
}

int ResetStats(bool bCurrentRoundOnly, int iTeam, bool bFailedRound)
{
	int i = 0;
	int j = 0;
	int k = 0;
	int var1;
	if (bCurrentRoundOnly)
	{
		var1 = 195264;
	}
	else
	{
		var1 = 195276;
	}
	PrintDebug(1, "Resetting stats [round %i]. (for: %s; for team: %i)", 1988, var1, iTeam);
	if (!bCurrentRoundOnly)
	{
		DisplayStats(-1, false, -1, true, -1);
		g_iRound = 0;
		g_bGameStarted = 0;
		g_strGameData[0] = 0;
		i = 0;
		while (i < 48)
		{
			j = 0;
			while (j < 2)
			{
				k = 0;
				while (k <= 18)
				{
					g_strRoundData[i][0][0][j][k] = 0;
					k++;
				}
				j++;
			}
			i++;
		}
		j = 0;
		while (j < 2)
		{
			k = 0;
			while (k <= 18)
			{
				g_strAllRoundData[j][0][0][k] = 0;
				k++;
			}
			j++;
		}
		i = 0;
		while (i < 64)
		{
			j = 0;
			while (j <= 76)
			{
				g_strPlayerData[i][0][0][j] = 0;
				j++;
			}
			j = 0;
			while (j <= 24)
			{
				g_strPlayerInfData[i][0][0][j] = 0;
				j++;
			}
			j = 0;
			while (j < 2)
			{
				g_iPlayerGameTeam[j][0][0][i] = -1;
				j++;
			}
			i++;
		}
		j = 0;
		while (j < 2)
		{
			g_iScores[j] = 0;
			j++;
		}
	}
	else
	{
		if (iTeam == -1)
		{
			k = 0;
			while (k <= 18)
			{
				int var2;
				if (bFailedRound)
				{
				}
				else
				{
					int var4 = g_strRoundData[g_iRound][0][0];
					var4[0][var4][k] = 0;
					g_strRoundData[g_iRound][0][0][4][k] = 0;
				}
				k++;
			}
		}
		k = 0;
		while (k <= 18)
		{
			int var3;
			if (bFailedRound)
			{
			}
			else
			{
				g_strRoundData[g_iRound][0][0][iTeam][k] = 0;
			}
			k++;
		}
	}
	if (iTeam == -1)
	{
		i = 0;
		while (i < 64)
		{
			j = 0;
			while (j < 2)
			{
				k = 0;
				while (k <= 76)
				{
					g_strRoundPlayerData[i][0][0][j][k] = 0;
					k++;
				}
				k = 0;
				while (k <= 76)
				{
					g_strRoundPlayerInfData[i][0][0][j][k] = 0;
					k++;
				}
				j++;
			}
			i++;
		}
	}
	else
	{
		i = 0;
		while (i < 64)
		{
			k = 0;
			while (k <= 76)
			{
				g_strRoundPlayerData[i][0][0][iTeam][k] = 0;
				k++;
			}
			k = 0;
			while (k <= 24)
			{
				g_strRoundPlayerInfData[i][0][0][iTeam][k] = 0;
				k++;
			}
			i++;
		}
	}
	return 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "UpdatePlayerCurrentTeam" (number 97)
int ClearPlayerTeam(int iTeam)
{
	int i = 0;
	int j = 0;
	if (iTeam == -1)
	{
		j = 0;
		while (j < 3)
		{
			i = 0;
			while (i < 64)
			{
				g_iPlayerRoundTeam[j][0][0][i] = -1;
				i++;
			}
			j++;
		}
	}
	else
	{
		i = 0;
		while (i < 64)
		{
			g_iPlayerRoundTeam[iTeam][0][0][i] = -1;
			i++;
		}
	}
	return 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "SetStartSurvivorTime" (number 99)

/* ERROR! Unrecognized opcode dec */
 function "DisplayStats" (number 100)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "DisplayStatsMVPChat" (number 101)
char GetMVPChatString(bool bRound, bool bTeam, int iTeam)
{
	char printBuffer[1024];
	char tmpBuffer[512];
	SortPlayersMVP(bRound, 0, bTeam, iTeam);
	SortPlayersMVP(bRound, 1, bTeam, iTeam);
	SortPlayersMVP(bRound, 2, bTeam, iTeam);
	int team;
	int var3;
	if (iTeam != -1)
	{
		var3 = iTeam;
	}
	else
	{
		int var1;
		if (g_bSecondHalf)
		{
			int var2;
			if (g_iCurTeam)
			{
				var2 = 0;
			}
			else
			{
				var2 = 1;
			}
			var3 = var2;
		}
		var3 = g_iCurTeam;
	}
	team = var3;
	int mvp_SI;
	int var43 = g_iPlayerIndexSorted;
	mvp_SI = var43[0][0][var43];
	int mvp_Common = g_iPlayerIndexSorted[4][0];
	int mvp_FF = g_iPlayerIndexSorted[8][0];
	int var4;
	if (bTeam)
	{
		int i = 0;
		while (i < g_iPlayers)
		{
			if (team == g_iPlayerRoundTeam[team][0][0][i])
			{
				int var44 = i;
				mvp_FF = var44;
				mvp_Common = var44;
				mvp_SI = var44;
			}
			i++;
		}
	}
	int iBrevityFlags = GetConVarInt(g_hCvarMVPBrevityFlags);
	int var7;
	if (g_iPlayers < 1)
	{
		mvp_SI = -1;
	}
	int var10;
	if (g_iPlayers < 1)
	{
		mvp_Common = -1;
	}
	int var13;
	if (g_iPlayers < 1)
	{
		mvp_FF = -1;
	}
	int var15;
	if (mvp_SI == -1)
	{
		int var16;
		if (bRound)
		{
			var16 = 197180;
		}
		else
		{
			var16 = 197184;
		}
		Format(tmpBuffer, 512, "[MVP%s]: (not enough action yet)\n", var16);
		StrCat(printBuffer, 1024, tmpBuffer);
	}
	else
	{
		if (!iBrevityFlags & 1)
		{
			if (mvp_SI > -1)
			{
				if (iBrevityFlags & 32)
				{
					int var17;
					if (bRound)
					{
						var17 = g_strRoundPlayerData[mvp_SI][0][0][team][96];
					}
					else
					{
						var17 = g_strPlayerData[mvp_SI][0][0][96];
					}
					int var18;
					if (bRound)
					{
						var18 = g_strRoundPlayerData[mvp_SI][0][0][team][104];
					}
					else
					{
						var18 = g_strPlayerData[mvp_SI][0][0][104];
					}
					int var19;
					if (bRound)
					{
						var19 = 197236;
					}
					else
					{
						var19 = 197240;
					}
					Format(tmpBuffer, 512, "[MVP%s] SI:\x03 %s \x01(\x05%d \x01dmg,\x05 %d \x01kills)\n", var19, g_sPlayerName[mvp_SI][0][0], var18, var17);
				}
				else
				{
					if (iBrevityFlags & 64)
					{
						int var20;
						if (bRound)
						{
							var20 = FloatDiv(float(g_strRoundPlayerData[mvp_SI][0][0][team][96]), float(g_strRoundData[g_iRound][0][0][team][20])) * 100;
						}
						else
						{
							var20 = FloatDiv(float(g_strPlayerData[mvp_SI][0][0][96]), float(g_strAllRoundData[team][0][0][20])) * 100;
						}
						int var21;
						if (bRound)
						{
							var21 = FloatDiv(float(g_strRoundPlayerData[mvp_SI][0][0][team][104]), float(g_strRoundData[g_iRound][0][0][team][24])) * 100;
						}
						else
						{
							var21 = FloatDiv(float(g_strPlayerData[mvp_SI][0][0][104]), float(g_strAllRoundData[team][0][0][24])) * 100;
						}
						int var22;
						if (bRound)
						{
							var22 = 197296;
						}
						else
						{
							var22 = 197300;
						}
						Format(tmpBuffer, 512, "[MVP%s] SI:\x03 %s \x01(dmg \x04%i%%\x01, kills \x04%i%%\x01)\n", var22, g_sPlayerName[mvp_SI][0][0], RoundFloat(var21), RoundFloat(var20));
					}
					int var23;
					if (bRound)
					{
						var23 = FloatDiv(float(g_strRoundPlayerData[mvp_SI][0][0][team][96]), float(g_strRoundData[g_iRound][0][0][team][20])) * 100;
					}
					else
					{
						var23 = FloatDiv(float(g_strPlayerData[mvp_SI][0][0][96]), float(g_strAllRoundData[team][0][0][20])) * 100;
					}
					int var24;
					if (bRound)
					{
						var24 = g_strRoundPlayerData[mvp_SI][0][0][team][96];
					}
					else
					{
						var24 = g_strPlayerData[mvp_SI][0][0][96];
					}
					int var25;
					if (bRound)
					{
						var25 = FloatDiv(float(g_strRoundPlayerData[mvp_SI][0][0][team][104]), float(g_strRoundData[g_iRound][0][0][team][24])) * 100;
					}
					else
					{
						var25 = FloatDiv(float(g_strPlayerData[mvp_SI][0][0][104]), float(g_strAllRoundData[team][0][0][24])) * 100;
					}
					int var26;
					if (bRound)
					{
						var26 = g_strRoundPlayerData[mvp_SI][0][0][team][104];
					}
					else
					{
						var26 = g_strPlayerData[mvp_SI][0][0][104];
					}
					int var27;
					if (bRound)
					{
						var27 = 197368;
					}
					else
					{
						var27 = 197372;
					}
					Format(tmpBuffer, 512, "[MVP%s] SI:\x03 %s \x01(\x05%d \x01dmg[\x04%i%%\x01],\x05 %d \x01kills [\x04%i%%\x01])\n", var27, g_sPlayerName[mvp_SI][0][0], var26, RoundFloat(var25), var24, RoundFloat(var23));
				}
				StrCat(printBuffer, 1024, tmpBuffer);
			}
			int var28;
			if (bRound)
			{
				var28 = 197404;
			}
			else
			{
				var28 = 197408;
			}
			Format(tmpBuffer, 512, "[MVP%s] SI: \x03(nobody)\x01\n", var28);
			StrCat(printBuffer, 1024, tmpBuffer);
		}
		if (!iBrevityFlags & 2)
		{
			int var32;
			if (mvp_Common > -1)
			{
				if (iBrevityFlags & 32)
				{
					int var33;
					if (bRound)
					{
						var33 = g_strRoundPlayerData[mvp_Common][0][0][team][88];
					}
					else
					{
						var33 = g_strPlayerData[mvp_Common][0][0][88];
					}
					int var34;
					if (bRound)
					{
						var34 = 197448;
					}
					else
					{
						var34 = 197452;
					}
					Format(tmpBuffer, 512, "[MVP%s] CI:\x03 %s \x01(\x05%d \x01common)\n", var34, g_sPlayerName[mvp_Common][0][0], var33);
				}
				else
				{
					if (iBrevityFlags & 64)
					{
						int var35;
						if (bRound)
						{
							var35 = FloatDiv(float(g_strRoundPlayerData[mvp_Common][0][0][team][88]), float(g_strRoundData[g_iRound][0][0][team][16])) * 100;
						}
						else
						{
							var35 = FloatDiv(float(g_strPlayerData[mvp_Common][0][0][88]), float(g_strAllRoundData[team][0][0][16])) * 100;
						}
						int var36;
						if (bRound)
						{
							var36 = 197488;
						}
						else
						{
							var36 = 197492;
						}
						Format(tmpBuffer, 512, "[MVP%s] CI:\x03 %s \x01(\x04%i%%\x01)\n", var36, g_sPlayerName[mvp_Common][0][0], RoundFloat(var35));
					}
					int var37;
					if (bRound)
					{
						var37 = FloatDiv(float(g_strRoundPlayerData[mvp_Common][0][0][team][88]), float(g_strRoundData[g_iRound][0][0][team][16])) * 100;
					}
					else
					{
						var37 = FloatDiv(float(g_strPlayerData[mvp_Common][0][0][88]), float(g_strAllRoundData[team][0][0][16])) * 100;
					}
					int var38;
					if (bRound)
					{
						var38 = g_strRoundPlayerData[mvp_Common][0][0][team][88];
					}
					else
					{
						var38 = g_strPlayerData[mvp_Common][0][0][88];
					}
					int var39;
					if (bRound)
					{
						var39 = 197544;
					}
					else
					{
						var39 = 197548;
					}
					Format(tmpBuffer, 512, "[MVP%s] CI:\x03 %s \x01(\x05%d \x01common [\x04%i%%\x01])\n", var39, g_sPlayerName[mvp_Common][0][0], var38, RoundFloat(var37));
				}
				StrCat(printBuffer, 1024, tmpBuffer);
			}
		}
	}
	if (!iBrevityFlags & 4)
	{
		if (mvp_FF == -1)
		{
			int var40;
			if (bRound)
			{
				var40 = 197596;
			}
			else
			{
				var40 = 197600;
			}
			Format(tmpBuffer, 512, "[LVP%s] FF: no friendly fire at all!\n", var40);
			StrCat(printBuffer, 1024, tmpBuffer);
		}
		int var41;
		if (bRound)
		{
			var41 = g_strRoundPlayerData[mvp_FF][0][0][team][176];
		}
		else
		{
			var41 = g_strPlayerData[mvp_FF][0][0][176];
		}
		int var42;
		if (bRound)
		{
			var42 = 197640;
		}
		else
		{
			var42 = 197644;
		}
		Format(tmpBuffer, 512, "[LVP%s] FF:\x03 %s \x01(\x05%d \x01dmg)\n", var42, g_sPlayerName[mvp_FF][0][0], var41);
		StrCat(printBuffer, 1024, tmpBuffer);
	}
	return printBuffer;
}


/* ERROR! Unrecognized opcode dec */
 function "DisplayStatsMVP" (number 103)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "DisplayStatsFunFactChat" (number 104)
char GetFunFactChatString(bool bRound, bool bTeam, int iTeam)
{
	int var24;
	char printBuffer[1024];
	int team;
	int var3;
	if (iTeam != -1)
	{
		var3 = iTeam;
	}
	else
	{
		int var1;
		if (g_bSecondHalf)
		{
			int var2;
			if (g_iCurTeam)
			{
				var2 = 0;
			}
			else
			{
				var2 = 1;
			}
			var3 = var2;
		}
		var3 = g_iCurTeam;
	}
	team = var3;
	int i = 0;
	int j = 0;
	int wTotal = 0;
	int wPicks[256];
	int wTypeHighPly[17];
	int wTypeHighVal[17];
	int wTypeHighTeam[17];
	int wTmp = 0;
	int highest = 0;
	int value = 0;
	int property = 0;
	int minval = 0;
	int maxval = 0;
	bool bInf = 0;
	i = 0;
	while (i <= 16)
	{
		wTmp = 0;
		wTypeHighPly[i] = -1;
		wTypeHighTeam[i] = team;
		bInf = 0;
		switch (i)
		{
			case 1: {
				property = 36;
				minval = 1;
				maxval = 10;
			}
			case 2: {
				property = 37;
				minval = 1;
				maxval = 10;
			}
			case 3: {
				property = 30;
				minval = 2;
				maxval = 20;
			}
			case 4: {
				property = 32;
				minval = 1;
				maxval = 10;
			}
			case 5: {
				bInf = 1;
				property = 8;
				minval = 2;
				maxval = 10;
			}
			case 6: {
				bInf = 1;
				property = 10;
				minval = 2;
				maxval = 10;
			}
			case 7: {
				property = 38;
				minval = 15;
				maxval = 50;
			}
			case 8: {
				property = 49;
				minval = 4;
				maxval = 10;
			}
			case 9: {
				property = 40;
				minval = 4;
				maxval = 10;
			}
			case 10: {
				property = 35;
				minval = 4;
				maxval = 10;
			}
			case 11: {
				property = 39;
				minval = 7;
				maxval = 20;
			}
			case 12: {
				property = 33;
				minval = 3;
				maxval = 10;
			}
			case 13: {
				bInf = 1;
				property = 4;
				minval = 50;
				maxval = 200;
			}
			case 14: {
				bInf = 1;
				property = 11;
				minval = 1;
				maxval = 4;
			}
			case 15: {
				bInf = 1;
				property = 6;
				minval = 40;
				maxval = 200;
			}
			case 16: {
				bInf = 1;
				property = 5;
				minval = 60;
				maxval = 200;
			}
			default: {
			}
		}
		highest = GetPlayerWithHighestValue(property, bRound, bTeam, team, bInf);
		if (!(highest == -1))
		{
			if (bInf)
			{
				int var4;
				if (bRound)
				{
					value = g_strRoundPlayerInfData[highest][0][0][team][property];
				}
				else
				{
					int var25 = g_strRoundPlayerInfData[highest][0][0];
					if (g_strRoundPlayerInfData[highest][0][0][4][property] < var25[0][var25][property])
					{
						int var26 = g_strRoundPlayerInfData[highest][0][0];
						value = var26[0][var26][property];
						wTypeHighTeam[i] = 0;
					}
					value = g_strRoundPlayerInfData[highest][0][0][4][property];
					wTypeHighTeam[i] = 1;
				}
			}
			else
			{
				int var5;
				if (bRound)
				{
					value = g_strRoundPlayerData[highest][0][0][team][property];
				}
				int var27 = g_strRoundPlayerData[highest][0][0];
				if (g_strRoundPlayerData[highest][0][0][4][property] < var27[0][var27][property])
				{
					int var28 = g_strRoundPlayerData[highest][0][0];
					value = var28[0][var28][property];
					wTypeHighTeam[i] = 0;
				}
				value = g_strRoundPlayerData[highest][0][0][4][property];
				wTypeHighTeam[i] = 1;
			}
			if (value > minval)
			{
				wTypeHighPly[i] = highest;
				wTypeHighVal[i] = value;
				if (value >= maxval)
				{
					wTmp = 10;
				}
				wTmp = RoundFloat(FloatMul(FloatDiv(float(value - minval), float(maxval - minval)), float(10))) + 1;
			}
			if (wTmp)
			{
				j = 0;
				while (j < wTmp)
				{
					wPicks[j + wTotal] = i;
					j++;
				}
				wTotal = wTmp + wTotal;
			}
		}
		i++;
	}
	if (!wTotal)
	{
		return printBuffer;
	}
	int wPick = GetRandomInt(0, wTotal + -1);
	wPick = wPicks[wPick];
	switch (wPick)
	{
		case 1: {
			int var23;
			if (bRound)
			{
				var23 = 200436;
			}
			else
			{
				var23 = 200444;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01crowned \x05%d \x01witches.\n", var23, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 2: {
			int var22;
			if (bRound)
			{
				var22 = 200496;
			}
			else
			{
				var22 = 200504;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01draw-crowned \x05%d \x01witches.\n", var22, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 3: {
			int var21;
			if (bRound)
			{
				var21 = 200552;
			}
			else
			{
				var21 = 200560;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01skeeted \x05%d \x01hunters.\n", var21, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 4: {
			int var19;
			if (wTypeHighVal[wPick] == 1)
			{
				var19 = 200644;
			}
			else
			{
				var19 = 200648;
			}
			int var20;
			if (bRound)
			{
				var20 = 200628;
			}
			else
			{
				var20 = 200636;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01skeeted \x05%d \x01hunter%s with a melee weapon.\n", var20, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick], var19);
		}
		case 5: {
			int var18;
			if (bRound)
			{
				var18 = 201076;
			}
			else
			{
				var18 = 201084;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01landed \x05%d \x01highpounces with hunters.\n", var18, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 6: {
			int var17;
			if (bRound)
			{
				var17 = 201148;
			}
			else
			{
				var17 = 201156;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01landed \x05%d \x01highpounces with jockeys.\n", var17, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 7: {
			int var16;
			if (bRound)
			{
				var16 = 200700;
			}
			else
			{
				var16 = 200708;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01shoved \x05%d \x01special infected.\n", var16, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 8: {
			int var15;
			if (bRound)
			{
				var15 = 200768;
			}
			else
			{
				var15 = 200776;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01got \x05%d \x01melee swings on the tank.\n", var15, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 9: {
			int var14;
			if (bRound)
			{
				var14 = 200824;
			}
			else
			{
				var14 = 200832;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01cut \x05%d \x01tongue cuts.\n", var14, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 10: {
			int var13;
			if (bRound)
			{
				var13 = 200880;
			}
			else
			{
				var13 = 200888;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01popped \x05%d \x01boomers.\n", var13, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 11: {
			int var12;
			if (bRound)
			{
				var12 = 200940;
			}
			else
			{
				var12 = 200948;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01deadstopped \x05%d \x01hunters.\n", var12, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 12: {
			int var11;
			if (bRound)
			{
				var11 = 201004;
			}
			else
			{
				var11 = 201012;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01fully leveled \x05%d \x01chargers.\n", var11, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 13: {
			int var10;
			if (bRound)
			{
				var10 = 201316;
			}
			else
			{
				var10 = 201324;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01did a total of \x05%d \x01damage by scratching (standing) survivors.\n", var10, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 14: {
			int var8;
			if (wTypeHighVal[wPick] == 1)
			{
				var8 = 201228;
			}
			else
			{
				var8 = 201232;
			}
			int var9;
			if (bRound)
			{
				var9 = 201212;
			}
			else
			{
				var9 = 201220;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01death-charged \x05%d \x01 survivor%s.\n", var9, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick], var8);
		}
		case 15: {
			int var7;
			if (bRound)
			{
				var7 = 201424;
			}
			else
			{
				var7 = 201432;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01got a total of \x05%d \x01damage by common hits on boomed (standing) survivors.\n", var7, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		case 16: {
			int var6;
			if (bRound)
			{
				var6 = 201516;
			}
			else
			{
				var6 = 201524;
			}
			Format(printBuffer, 1024, "[%s fact] \x04%s \x01did a total of \x05%d \x01spit-damage on (standing) survivors.\n", var6, g_sPlayerName[wTypeHighPly[wPick]][0][0], wTypeHighVal[wPick]);
		}
		default: {
		}
	}
	return printBuffer;
}


/* ERROR! Unrecognized opcode dec */
 function "DisplayStatsAccuracy" (number 106)

/* ERROR! Unrecognized opcode dec */
 function "DisplayStatsSpecial" (number 107)

/* ERROR! Unrecognized opcode dec */
 function "DisplayStatsInfected" (number 108)

/* ERROR! Unrecognized opcode dec */
 function "DisplayStatsFriendlyFire" (number 109)

/* ERROR! Unrecognized opcode stradjust_pri */
 function "BuildConsoleBufferGeneral" (number 110)

/* ERROR! Unrecognized opcode stradjust_pri */
 function "BuildConsoleBufferSpecial" (number 111)

/* ERROR! Unrecognized opcode stradjust_pri */
 function "BuildConsoleBufferInfected" (number 112)

/* ERROR! Unrecognized opcode stradjust_pri */
 function "BuildConsoleBufferAccuracy" (number 113)

/* ERROR! Unrecognized opcode stradjust_pri */
 function "BuildConsoleBufferMVP" (number 114)

/* ERROR! Unrecognized opcode stradjust_pri */
 function "BuildConsoleBufferFriendlyFireGiven" (number 115)

/* ERROR! Unrecognized opcode stradjust_pri */
 function "BuildConsoleBufferFriendlyFireTaken" (number 116)
int SortPlayersMVP(bool bRound, int sortCol, bool bTeam, int iTeam)
{
	int iStored = 0;
	int i = 0;
	int j = 0;
	bool found = 0;
	int highest = 0;
	int highTeam = 0;
	int pickTeam = 0;
	int var1;
	if (sortCol < 0)
	{
		return 0;
	}
	int team;
	int var4;
	if (iTeam != -1)
	{
		var4 = iTeam;
	}
	else
	{
		int var2;
		if (g_bSecondHalf)
		{
			int var3;
			if (g_iCurTeam)
			{
				var3 = 0;
			}
			else
			{
				var3 = 1;
			}
			var4 = var3;
		}
		var4 = g_iCurTeam;
	}
	team = var4;
	while (iStored < g_iPlayers)
	{
		highest = -1;
		i = 0;
		while (i < g_iPlayers)
		{
			found = 0;
			j = 0;
			while (j < iStored)
			{
				if (i == g_iPlayerIndexSorted[sortCol][0][0][j])
				{
					found = 1;
					j++;
				}
				j++;
			}
			if (!found)
			{
				switch (sortCol)
				{
					case 0: {
						if (bRound)
						{
							if (bTeam)
							{
								int var29;
								if (highest == -1)
								{
									highest = i;
								}
							}
							else
							{
								int var42 = g_strRoundPlayerData[i][0][0];
								int var30;

/* ERROR! unknown load */
 function "SortPlayersMVP" (number 117)
int GetPlayerWithHighestValue(int property, bool bRound, bool bTeam, int team, bool bInfected)
{
	int i = 0;
	int highest = 0;
	int highTeam = 0;
	int pickTeam = 0;
	highest = -1;
	if (bInfected)
	{
		i = 4;
		while (i < g_iPlayers)
		{
			if (bRound)
			{
				if (bTeam)
				{
					int var1;
					if (highest == -1)
					{
						highest = i;
						i++;
					}
					i++;
				}
				else
				{
					int var9 = g_strRoundPlayerInfData[i][0][0];
					int var2;
					if (var9[0][var9][property] >= g_strRoundPlayerInfData[i][0][0][4][property])
					{
						var2 = 0;
					}
					else
					{
						var2 = 1;
					}
					pickTeam = var2;
					int var3;
					if (highest == -1)
					{
						highest = i;
						highTeam = pickTeam;
						i++;
					}
					i++;
				}
				i++;
			}
			else
			{
				int var4;
				if (highest == -1)
				{
					highest = i;
					i++;
				}
				i++;
			}
			i++;
		}
	}
	else
	{
		i = 4;
		while (i < g_iPlayers)
		{
			if (bRound)
			{
				if (bTeam)
				{
					int var5;
					if (highest == -1)
					{
						highest = i;
						i++;
					}
					i++;
				}
				else
				{
					int var10 = g_strRoundPlayerData[i][0][0];
					int var6;
					if (var10[0][var10][property] >= g_strRoundPlayerData[i][0][0][4][property])
					{
						var6 = 0;
					}
					else
					{
						var6 = 1;
					}
					pickTeam = var6;
					int var7;
					if (highest == -1)
					{
						highest = i;
						highTeam = pickTeam;
						i++;
					}
					i++;
				}
				i++;
			}
			else
			{
				int var8;
				if (highest == -1)
				{
					highest = i;
					i++;
				}
				i++;
			}
			i++;
		}
	}
	return highest;
}

int TableIncludePlayer(int index, int team, bool bRound, bool bReverseTeam, int statA, int statB)
{
	if (bReverseTeam)
	{
		int var1;
		if (team)
		{
			var1 = 0;
		}
		else
		{
			var1 = 1;
		}
		if (var1 != g_iPlayerRoundTeam[team][0][0][index])
		{
			return 0;
		}
	}
	else
	{
		if (team != g_iPlayerRoundTeam[team][0][0][index])
		{
			return 0;
		}
	}
	if (g_bPlayersLeftStart)
	{
		if (bReverseTeam)
		{
			int var3;
			if (g_strRoundPlayerInfData[index][0][0][team][92])
			{
				return 1;
			}
		}
		else
		{
			int var6;
			if (g_iCurTeam == team)
			{
				return 1;
			}
		}
	}
	else
	{
		if (!bRound)
		{
			if (bReverseTeam)
			{
				int var8;
				if (g_strPlayerInfData[index][0][0][92])
				{
					return 0;
				}
			}
			else
			{
				int var11;
				if (g_strPlayerData[index][0][0][284])
				{
					return 0;
				}
			}
		}
		if (index >= 4)
		{
			if (!IsIndexSurvivor(index, bReverseTeam))
			{
				if (g_iCurTeam == team)
				{
					return 0;
				}
			}
			if (g_iCurTeam != team)
			{
				return 0;
			}
		}
	}
	if (bReverseTeam)
	{
		if (bRound)
		{
			int var13;
			if (g_strRoundPlayerInfData[index][0][0][team][statA])
			{
				return 1;
			}
		}
		else
		{
			int var14;
			if (g_strPlayerInfData[index][0][0][statA])
			{
				return 1;
			}
		}
	}
	else
	{
		if (bRound)
		{
			int var15;
			if (g_strRoundPlayerData[index][0][0][team][statA])
			{
				return 1;
			}
		}
		int var16;
		if (g_strPlayerData[index][0][0][statA])
		{
			return 1;
		}
	}
	if (index < 4)
	{
		return 0;
	}
	int presTime = 0;
	int time = GetTime({0,0});
	if (!bReverseTeam)
	{
		if (bRound)
		{
			int var17;
			if (g_strRoundPlayerData[index][0][0][team][288])
			{
				var17 = g_strRoundPlayerData[index][0][0][team][288];
			}
			else
			{
				var17 = time;
			}
			presTime = var17 - g_strRoundPlayerData[index][0][0][team][284];
		}
		else
		{
			int var18;
			if (g_strPlayerData[index][0][0][288])
			{
				var18 = g_strPlayerData[index][0][0][288];
			}
			else
			{
				var18 = time;
			}
			presTime = var18 - g_strPlayerData[index][0][0][284];
		}
	}
	else
	{
		if (bRound)
		{
			int var19;
			if (g_strRoundPlayerInfData[index][0][0][team][96])
			{
				var19 = g_strRoundPlayerInfData[index][0][0][team][96];
			}
			else
			{
				var19 = time;
			}
			presTime = var19 - g_strRoundPlayerInfData[index][0][0][team][92];
		}
		int var20;
		if (g_strPlayerInfData[index][0][0][96])
		{
			var20 = g_strPlayerInfData[index][0][0][96];
		}
		else
		{
			var20 = time;
		}
		presTime = var20 - g_strPlayerInfData[index][0][0][92];
	}
	if (presTime >= 30)
	{
		return 1;
	}
	return 0;
}

int GetFullRoundTime(int bRound, int bTeam, int team, bool bTank)
{
	int start = 13;
	int stop = 14;
	if (bTank)
	{
		start = 17;
		stop = 18;
	}
	int fullTime = 0;
	int time = GetTime({0,0});
	if (bRound)
	{
		if (bTeam)
		{
			if (g_strRoundData[g_iRound][0][0][team][start])
			{
				int var1;
				if (g_strRoundData[g_iRound][0][0][team][stop])
				{
					var1 = g_strRoundData[g_iRound][0][0][team][stop];
				}
				else
				{
					var1 = time;
				}
				fullTime = var1 - g_strRoundData[g_iRound][0][0][team][start];
				int var2;
				if (g_bPaused)
				{
					int var3;
					if (!bTank)
					{
						fullTime -= time - g_iPauseStart;
					}
				}
			}
		}
		else
		{
			int var19 = g_strRoundData[g_iRound][0][0];
			if (var19[0][var19][start])
			{
				int var20 = g_strRoundData[g_iRound][0][0];
				int var4;
				if (var20[0][var20][stop])
				{
					int var21 = g_strRoundData[g_iRound][0][0];
					var4 = var21[0][var21][stop];
				}
				else
				{
					var4 = time;
				}
				int var22 = g_strRoundData[g_iRound][0][0];
				fullTime = var4 - var22[0][var22][start];
				int var5;
				if (g_bPaused)
				{
					int var6;
					if (!bTank)
					{
						fullTime -= time - g_iPauseStart;
					}
				}
			}
			if (g_strRoundData[g_iRound][0][0][4][start])
			{
				int var7;
				if (g_strRoundData[g_iRound][0][0][4][stop])
				{
					var7 = g_strRoundData[g_iRound][0][0][4][stop];
				}
				else
				{
					var7 = time;
				}
				fullTime = var7 - g_strRoundData[g_iRound][0][0][4][start] + fullTime;
				int var8;
				if (g_bPaused)
				{
					int var9;
					if (!bTank)
					{
						fullTime -= time - g_iPauseStart;
					}
				}
			}
		}
	}
	else
	{
		if (bTeam)
		{
			if (g_strAllRoundData[team][0][0][start])
			{
				int var10;
				if (g_strAllRoundData[team][0][0][stop])
				{
					var10 = g_strAllRoundData[team][0][0][stop];
				}
				else
				{
					var10 = time;
				}
				fullTime = var10 - g_strAllRoundData[team][0][0][start];
				int var11;
				if (g_bPaused)
				{
					int var12;
					if (!bTank)
					{
						fullTime -= time - g_iPauseStart;
					}
				}
			}
		}
		int var23 = g_strAllRoundData;
		if (var23[0][0][var23][start])
		{
			int var24 = g_strAllRoundData;
			int var13;
			if (var24[0][0][var24][stop])
			{
				int var25 = g_strAllRoundData;
				var13 = var25[0][0][var25][stop];
			}
			else
			{
				var13 = time;
			}
			int var26 = g_strAllRoundData;
			fullTime = var13 - var26[0][0][var26][start];
			int var14;
			if (g_bPaused)
			{
				int var15;
				if (!bTank)
				{
					fullTime -= time - g_iPauseStart;
				}
			}
		}
		if (g_strAllRoundData[4][0][start])
		{
			int var16;
			if (g_strAllRoundData[4][0][stop])
			{
				var16 = g_strAllRoundData[4][0][stop];
			}
			else
			{
				var16 = time;
			}
			fullTime = var16 - g_strAllRoundData[4][0][start] + fullTime;
			int var17;
			if (g_bPaused)
			{
				int var18;
				if (!bTank)
				{
					fullTime -= time - g_iPauseStart;
				}
			}
		}
	}
	return fullTime;
}

int GetPauseTime(int bRound, int bTeam, int team, bool bCurrentOnly)
{
	int start = 15;
	int stop = 16;
	int fullTime = 0;
	int time = GetTime({0,0});
	if (bCurrentOnly)
	{
		if (bRound)
		{
			int var2;
			if (g_bPaused)
			{
				fullTime = time - g_iPauseStart + fullTime;
			}
		}
		return fullTime;
	}
	if (bRound)
	{
		if (bTeam)
		{
			int var3;
			if (g_strRoundData[g_iRound][0][0][team][start])
			{
				fullTime = g_strRoundData[g_iRound][0][0][team][stop] - g_strRoundData[g_iRound][0][0][team][start];
			}
			int var4;
			if (g_bPaused)
			{
				fullTime = time - g_iPauseStart + fullTime;
			}
		}
		else
		{
			int var10 = g_strRoundData[g_iRound][0][0];
			int var5;
			if (var10[0][var10][start])
			{
				int var12 = g_strRoundData[g_iRound][0][0];
				int var13 = g_strRoundData[g_iRound][0][0];
				fullTime = var12[0][var12][stop] - var13[0][var13][start];
			}
			int var6;
			if (g_strRoundData[g_iRound][0][0][4][start])
			{
				fullTime = g_strRoundData[g_iRound][0][0][4][stop] - g_strRoundData[g_iRound][0][0][4][start] + fullTime;
			}
			if (g_bPaused)
			{
				fullTime = time - g_iPauseStart + fullTime;
			}
		}
	}
	else
	{
		if (bTeam)
		{
			int var7;
			if (g_strAllRoundData[team][0][0][start])
			{
				fullTime = g_strAllRoundData[team][0][0][stop] - g_strAllRoundData[team][0][0][start];
			}
		}
		int var14 = g_strAllRoundData;
		int var8;
		if (var14[0][0][var14][start])
		{
			int var16 = g_strAllRoundData;
			int var17 = g_strAllRoundData;
			fullTime = var16[0][0][var16][stop] - var17[0][0][var17][start];
		}
		int var9;
		if (g_strAllRoundData[4][0][start])
		{
			fullTime = g_strAllRoundData[4][0][stop] - g_strAllRoundData[4][0][start] + fullTime;
		}
	}
	return fullTime;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "SaveFurthestFlows" (number 122)
public Action Timer_SaveFlows(Handle timer)
{
	int var1;
	if (!g_bPlayersLeftStart)
	{
		return Action 0;
	}
	SaveFurthestFlows();
	return Action 0;
}

int AutomaticRoundEndPrint(bool doDelay)
{
	g_iLastRoundEndPrint = GetTime({0,0});
	float fDelay = 1077936128;
	if (g_bModeScavenge)
	{
		fDelay = 1073741824;
	}
	if (doDelay)
	{
		CreateTimer(fDelay, Timer_AutomaticRoundEndPrint, any 0, 2);
	}
	else
	{
		Timer_AutomaticRoundEndPrint(Handle 0);
	}
	return 0;
}

public Action Timer_AutomaticRoundEndPrint(Handle timer)
{
	int iFlags;
	int var1;
	if (g_bModeCampaign)
	{
		var1 = g_hCvarAutoPrintCoop;
	}
	else
	{
		var1 = g_hCvarAutoPrintVs;
	}
	iFlags = GetConVarInt(var1);
	AutomaticPrintPerClient(iFlags, -1, -1, false, false, false, false);
	int client = 1;
	while (client <= MaxClients)
	{
		if (0 < g_iCookieValue[client][0][0])
		{
			AutomaticPrintPerClient(g_iCookieValue[client][0][0], client, -1, false, false, false, false);
			client++;
		}
		client++;
	}
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "AutomaticPrintPerClient" (number 126)
public Action Timer_DelayedPrint(Handle timer, Handle pack)
{
	ResetPack(pack, false);
	int flags = ReadPackCell(pack);
	int client = ReadPackCell(pack);
	int team = ReadPackCell(pack);
	bool bSortedRound = ReadPackCell(pack);
	bool bSortedGame = ReadPackCell(pack);
	CloseHandle(pack);
	AutomaticPrintPerClient(flags, client, team, true, true, bSortedRound, bSortedGame);
	return Action 0;
}

int GetCurrentTeamSurvivor()
{
	if (g_bCMTSwapped)
	{
		return !GameRules_GetProp("m_bAreTeamsFlipped", 4, 0);
	}
	return GameRules_GetProp("m_bAreTeamsFlipped", 4, 0);
}

int GetWeaponTypeForClassname(char classname[])
{
	strWeaponType weaponType = 0;
	if (!GetTrieValue(g_hTrieWeapons, classname, weaponType))
	{
		return 0;
	}
	return weaponType;
}

int GetPlayerIndexForClient(int client)
{
	int var1;
	if (client > 0)
	{
		return -1;
	}
	char sSteamId[32];
	if (IsFakeClient(client))
	{
		Format(sSteamId, 32, "BOT_%i", GetPlayerCharacter(client));
	}
	else
	{
		GetClientAuthString(client, sSteamId, 32, true);
	}
	return GetPlayerIndexForSteamId(sSteamId, client);
}

int GetPlayerIndexForSteamId(char steamId[], int client)
{
	int pIndex = -1;
	if (!GetTrieValue(g_hTriePlayers, steamId, pIndex))
	{
		pIndex = g_iPlayers;
		SetTrieValue(g_hTriePlayers, steamId, pIndex, true);
		strcopy(g_sPlayerId[pIndex][0][0], 32, steamId);
		if (client != -1)
		{
			GetClientName(client, g_sPlayerName[pIndex][0][0], 64);
			strcopy(g_sPlayerNameSafe[pIndex][0][0], 20, g_sPlayerName[pIndex][0][0]);
			stripUnicode(g_sPlayerNameSafe[pIndex][0][0], 20);
		}
		g_iPlayers += 1;
		if (g_iPlayers >= 64)
		{
			g_iPlayers = 4;
		}
	}
	return pIndex;
}

int GetPlayerCharacter(int client)
{
	int tmpChr = GetEntProp(client, PropType 0, "m_survivorCharacter", 4, 0);
	int var1;
	if (tmpChr < 0)
	{
		char model[256];
		GetEntPropString(client, PropType 1, "m_ModelName", model, 256, 0);
		if (StrContains(model, "gambler", true) != -1)
		{
			tmpChr = 0;
		}
		else
		{
			if (StrContains(model, "coach", true) != -1)
			{
				tmpChr = 2;
			}
			if (StrContains(model, "mechanic", true) != -1)
			{
				tmpChr = 3;
			}
			if (StrContains(model, "producer", true) != -1)
			{
				tmpChr = 1;
			}
			if (StrContains(model, "namvet", true) != -1)
			{
				tmpChr = 0;
			}
			if (StrContains(model, "teengirl", true) != -1)
			{
				tmpChr = 1;
			}
			if (StrContains(model, "biker", true) != -1)
			{
				tmpChr = 3;
			}
			if (StrContains(model, "manager", true) != -1)
			{
				tmpChr = 2;
			}
			tmpChr = 0;
		}
	}
	return tmpChr;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "IsIndexSurvivor" (number 133)
bool IsWitch(int iEntity)
{
	int var1;
	if (iEntity > 0)
	{
		char strClassName[64];
		GetEdictClassname(iEntity, strClassName, 64);
		strOEC entType = 0;
		if (!GetTrieValue(g_hTrieEntityCreated, strClassName, entType))
		{
			return false;
		}
		return entType == 1;
	}
	return false;
}

bool IsCommon(int iEntity)
{
	int var1;
	if (iEntity > 0)
	{
		char strClassName[64];
		GetEdictClassname(iEntity, strClassName, 64);
		strOEC entType = 0;
		if (!GetTrieValue(g_hTrieEntityCreated, strClassName, entType))
		{
			return false;
		}
		return entType == 0;
	}
	return false;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "IsTankInGame" (number 136)
bool IsPlayerIncapacitated(int client)
{
	return GetEntProp(client, PropType 0, "m_isIncapacitated", 1, 0);
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "IsHangingFromLedge" (number 138)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "IsPlayerIncapacitatedAtAll" (number 139)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "AreClientsConnected" (number 140)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "GetUprightSurvivors" (number 141)
public Action Timer_WriteStats(Handle timer, any iTeam)
{
	WriteStatsToFile(iTeam, true);
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "WriteStatsToFile" (number 143)
int InitTries()
{
	g_hTriePlayers = CreateTrie();
	SetTrieValue(g_hTriePlayers, "BOT_0", any 0, true);
	SetTrieValue(g_hTriePlayers, "BOT_1", any 1, true);
	SetTrieValue(g_hTriePlayers, "BOT_2", any 2, true);
	SetTrieValue(g_hTriePlayers, "BOT_3", any 3, true);
	int var1 = g_sPlayerName;
	int var2 = g_sPlayerId;
	g_iPlayers = g_iPlayers + 4;
	int i = 0;
	while (i < 4)
	{
		i++;
	}
	g_hTrieWeapons = CreateTrie();
	SetTrieValue(g_hTrieWeapons, "weapon_pistol", any 4, true);
	SetTrieValue(g_hTrieWeapons, "weapon_pistol_magnum", any 4, true);
	SetTrieValue(g_hTrieWeapons, "weapon_pumpshotgun", any 1, true);
	SetTrieValue(g_hTrieWeapons, "weapon_shotgun_chrome", any 1, true);
	SetTrieValue(g_hTrieWeapons, "weapon_autoshotgun", any 1, true);
	SetTrieValue(g_hTrieWeapons, "weapon_shotgun_spas", any 1, true);
	SetTrieValue(g_hTrieWeapons, "weapon_hunting_rifle", any 3, true);
	SetTrieValue(g_hTrieWeapons, "weapon_sniper_military", any 3, true);
	SetTrieValue(g_hTrieWeapons, "weapon_sniper_awp", any 3, true);
	SetTrieValue(g_hTrieWeapons, "weapon_sniper_scout", any 3, true);
	SetTrieValue(g_hTrieWeapons, "weapon_smg", any 2, true);
	SetTrieValue(g_hTrieWeapons, "weapon_smg_silenced", any 2, true);
	SetTrieValue(g_hTrieWeapons, "weapon_smg_mp5", any 2, true);
	SetTrieValue(g_hTrieWeapons, "weapon_rifle", any 2, true);
	SetTrieValue(g_hTrieWeapons, "weapon_rifle_desert", any 2, true);
	SetTrieValue(g_hTrieWeapons, "weapon_rifle_ak47", any 2, true);
	SetTrieValue(g_hTrieWeapons, "weapon_rifle_sg552", any 2, true);
	SetTrieValue(g_hTrieWeapons, "weapon_rifle_m60", any 2, true);
	g_hTrieEntityCreated = CreateTrie();
	SetTrieValue(g_hTrieEntityCreated, "infected", any 0, true);
	SetTrieValue(g_hTrieEntityCreated, "witch", any 1, true);
	g_hTrieMaps = CreateTrie();
	SetTrieValue(g_hTrieMaps, "c1m4_atrium", any 0, true);
	SetTrieValue(g_hTrieMaps, "c2m5_concert", any 0, true);
	SetTrieValue(g_hTrieMaps, "c3m4_plantation", any 0, true);
	SetTrieValue(g_hTrieMaps, "c4m5_milltown_escape", any 0, true);
	SetTrieValue(g_hTrieMaps, "c5m5_bridge", any 0, true);
	SetTrieValue(g_hTrieMaps, "c6m3_port", any 0, true);
	SetTrieValue(g_hTrieMaps, "c7m3_port", any 0, true);
	SetTrieValue(g_hTrieMaps, "c8m5_rooftop", any 0, true);
	SetTrieValue(g_hTrieMaps, "c9m2_lots", any 0, true);
	SetTrieValue(g_hTrieMaps, "c10m5_houseboat", any 0, true);
	SetTrieValue(g_hTrieMaps, "c11m5_runway", any 0, true);
	SetTrieValue(g_hTrieMaps, "c12m5_cornfield", any 0, true);
	SetTrieValue(g_hTrieMaps, "c13m4_cutthroatcreek", any 0, true);
	return 0;
}


/* ERROR! Unrecognized opcode stradjust_pri */
 function "LeftPadString" (number 145)

/* ERROR! Unrecognized opcode stradjust_pri */
 function "RightPadString" (number 146)

/* ERROR! Unrecognized opcode stradjust_pri */
 function "FormatTimeAsDuration" (number 147)

/* ERROR! Unrecognized opcode stradjust_pri */
 function "FormatPercentage" (number 148)
int CheckGameMode()
{
	char tmpStr[24];
	GetConVarString(FindConVar("mp_gamemode"), tmpStr, 24);
	int var1;
	if (StrEqual(tmpStr, "coop", false))
	{
		g_bModeCampaign = 1;
		g_bModeScavenge = 0;
	}
	else
	{
		if (StrEqual(tmpStr, "scavenge", false))
		{
			g_bModeCampaign = 0;
			g_bModeScavenge = 1;
		}
		g_bModeCampaign = 0;
		g_bModeScavenge = 0;
	}
	return 0;
}

int IsMissionFinalMap()
{
	strMapType mapType = 0;
	if (!GetTrieValue(g_hTrieMaps, g_sMapName[g_iRound][0][0], mapType))
	{
		return 0;
	}
	return mapType == 0;
}


/* ERROR! Unrecognized opcode stradjust_pri */
 function "stripUnicode" (number 151)
int PrintDebug(int debugLevel, char Message[])
{
	if (GetConVarInt(g_hCvarDebug) >= debugLevel)
	{
		char DebugBuff[256];
		VFormat(DebugBuff, 256, Message, 3);
		LogMessage(DebugBuff);
	}
	return 0;
}

