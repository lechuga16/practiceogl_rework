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
 Extension __ext_sdkhooks = 1020;
 Extension __ext_sdktools = 1064;
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
 char g_csSIClassName[9][0];
 bool g_bLateLoad;
 Handle g_hForwardSkeet;
 Handle g_hForwardSkeetHurt;
 Handle g_hForwardSkeetMelee;
 Handle g_hForwardSkeetMeleeHurt;
 Handle g_hForwardSkeetSniper;
 Handle g_hForwardSkeetSniperHurt;
 Handle g_hForwardSkeetGL;
 Handle g_hForwardHunterDeadstop;
 Handle g_hForwardSIShove;
 Handle g_hForwardBoomerPop;
 Handle g_hForwardLevel;
 Handle g_hForwardLevelHurt;
 Handle g_hForwardCrown;
 Handle g_hForwardDrawCrown;
 Handle g_hForwardTongueCut;
 Handle g_hForwardSmokerSelfClear;
 Handle g_hForwardRockSkeeted;
 Handle g_hForwardRockEaten;
 Handle g_hForwardHunterDP;
 Handle g_hForwardJockeyDP;
 Handle g_hForwardDeathCharge;
 Handle g_hForwardClear;
 Handle g_hForwardVomitLanded;
 Handle g_hForwardBHopStreak;
 Handle g_hForwardAlarmTriggered;
 Handle g_hTrieWeapons;
 Handle g_hTrieEntityCreated;
 Handle g_hTrieAbility;
 Handle g_hWitchTrie;
 Handle g_hRockTrie;
 Handle g_hCarTrie;
 float g_fSpawnTime[66];
 float g_fPinTime[66][2];
 int g_iSpecialVictim[66];
 int g_iHunterShotDmgTeam[66];
 int g_iHunterShotDmg[66][66];
 float g_fHunterShotStart[66][66];
 float g_fHunterTracePouncing[66];
 float g_fHunterLastShot[66];
 int g_iHunterLastHealth[66];
 int g_iHunterOverkill[66];
 bool g_bHunterKilledPouncing[66];
 int g_iPounceDamage[66];
 float g_fPouncePosition[66][3];
 float g_fVictimLastShove[66][66];
 int g_iChargerHealth[66];
 float g_fChargeTime[66];
 int g_iChargeVictim[66];
 float g_fChargeVictimPos[66][3];
 int g_iVictimCharger[66];
 int g_iVictimFlags[66];
 int g_iVictimMapDmg[66];
 bool g_bBoomerHitSomebody[66];
 int g_iBoomerGotShoved[66];
 int g_iBoomerVomitHits[66];
 float g_fWitchShotStart[66];
 bool g_bSmokerClearCheck[66];
 int g_iSmokerVictim[66];
 int g_iSmokerVictimDamage[66];
 bool g_bSmokerShoved[66];
 int g_iTankRock[66];
 int g_iRocksBeingThrown[10];
 int g_iRocksBeingThrownCount;
 bool g_bIsHopping[66];
 bool g_bHopCheck[66];
 int g_iHops[66];
 float g_fLastHop[66][3];
 float g_fHopTopVelocity[66];
 float g_fLastCarAlarm;
 int g_iLastCarAlarmReason[66];
 int g_iLastCarAlarmBoomer;
 Handle g_hCvarReport;
 Handle g_hCvarAllowMelee;
 Handle g_hCvarAllowSniper;
 Handle g_hCvarAllowGLSkeet;
 Handle g_hCvarDrawCrownThresh;
 Handle g_hCvarSelfClearThresh;
 Handle g_hCvarHunterDPThresh;
 Handle g_hCvarJockeyDPThresh;
 Handle g_hCvarHideFakeDamage;
 Handle g_hCvarDeathChargeHeight;
 Handle g_hCvarInstaTime;
 Handle g_hCvarBHopMinStreak;
 Handle g_hCvarBHopMinInitSpeed;
 Handle g_hCvarBHopContSpeed;
 Handle g_hCvarPounceInterrupt;
 int g_iPounceInterrupt = 150;
 Handle g_hCvarChargerHealth;
 Handle g_hCvarWitchHealth;
 Handle g_hCvarMaxPounceDistance;
 Handle g_hCvarMinPounceDistance;
 Handle g_hCvarMaxPounceDamage;
public Plugin myinfo =
{
	name = "Skill Detection (skeets, crowns, levels)",
	description = "Detects and reports skeets, crowns, levels, highpounces, etc.",
	author = "Tabun",
	version = "0.9.19",
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

bool operator>(_:,Float:)(int oper1, float oper2)
{
	return __FLOAT_GT__(float(oper1), oper2);
}

bool operator<(Float:,_:)(float oper1, int oper2)
{
	return __FLOAT_LT__(oper1, float(oper2));
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
		HookEvent("server_spawn", EventHook 3, EventHookMode 2);
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

Handle L4D2Direct_GetGameConf()
{
	static Handle g_hGameConf_l4d2dir;
	if (!g_hGameConf_l4d2dir)
	{
		g_hGameConf_l4d2dir = LoadGameConfigFile("l4d2_direct");
	}
	return g_hGameConf_l4d2dir;
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

public APLRes AskPluginLoad2(Handle myself, bool late, char error[], int err_max)
{
	RegPluginLibrary("skill_detect");
	g_hForwardSkeet = CreateGlobalForward("OnSkeet", ExecType 0, 2, 2);
	g_hForwardSkeetHurt = CreateGlobalForward("OnSkeetHurt", ExecType 0, 2, 2, 2, 2);
	g_hForwardSkeetMelee = CreateGlobalForward("OnSkeetMelee", ExecType 0, 2, 2);
	g_hForwardSkeetMeleeHurt = CreateGlobalForward("OnSkeetMeleeHurt", ExecType 0, 2, 2, 2, 2);
	g_hForwardSkeetSniper = CreateGlobalForward("OnSkeetSniper", ExecType 0, 2, 2);
	g_hForwardSkeetSniperHurt = CreateGlobalForward("OnSkeetSniperHurt", ExecType 0, 2, 2, 2, 2);
	g_hForwardSkeetGL = CreateGlobalForward("OnSkeetGL", ExecType 0, 2, 2);
	g_hForwardSIShove = CreateGlobalForward("OnSpecialShoved", ExecType 0, 2, 2, 2);
	g_hForwardHunterDeadstop = CreateGlobalForward("OnHunterDeadstop", ExecType 0, 2, 2);
	g_hForwardBoomerPop = CreateGlobalForward("OnBoomerPop", ExecType 0, 2, 2, 2, 4);
	g_hForwardLevel = CreateGlobalForward("OnChargerLevel", ExecType 0, 2, 2);
	g_hForwardLevelHurt = CreateGlobalForward("OnChargerLevelHurt", ExecType 0, 2, 2, 2);
	g_hForwardCrown = CreateGlobalForward("OnWitchCrown", ExecType 0, 2, 2);
	g_hForwardDrawCrown = CreateGlobalForward("OnWitchDrawCrown", ExecType 0, 2, 2, 2);
	g_hForwardTongueCut = CreateGlobalForward("OnTongueCut", ExecType 0, 2, 2);
	g_hForwardSmokerSelfClear = CreateGlobalForward("OnSmokerSelfClear", ExecType 0, 2, 2, 2);
	g_hForwardRockSkeeted = CreateGlobalForward("OnTankRockSkeeted", ExecType 0, 2, 2);
	g_hForwardRockEaten = CreateGlobalForward("OnTankRockEaten", ExecType 0, 2, 2);
	g_hForwardHunterDP = CreateGlobalForward("OnHunterHighPounce", ExecType 0, 2, 2, 2, 4, 4, 2, 2);
	g_hForwardJockeyDP = CreateGlobalForward("OnJockeyHighPounce", ExecType 0, 2, 2, 4, 2);
	g_hForwardDeathCharge = CreateGlobalForward("OnDeathCharge", ExecType 0, 2, 2, 4, 4, 2);
	g_hForwardClear = CreateGlobalForward("OnSpecialClear", ExecType 0, 2, 2, 2, 2, 4, 4, 2);
	g_hForwardVomitLanded = CreateGlobalForward("OnBoomerVomitLanded", ExecType 0, 2, 2);
	g_hForwardBHopStreak = CreateGlobalForward("OnBunnyHopStreak", ExecType 0, 2, 2, 4);
	g_hForwardAlarmTriggered = CreateGlobalForward("OnCarAlarmTriggered", ExecType 0, 2, 2, 2);
	g_bLateLoad = late;
	return APLRes 0;
}

public int OnPluginStart()
{
	HookEvent("round_start", EventHook 47, EventHookMode 2);
	HookEvent("scavenge_round_start", EventHook 47, EventHookMode 2);
	HookEvent("round_end", EventHook 45, EventHookMode 2);
	HookEvent("player_spawn", EventHook 43, EventHookMode 1);
	HookEvent("player_hurt", EventHook 35, EventHookMode 0);
	HookEvent("player_death", EventHook 33, EventHookMode 0);
	HookEvent("ability_use", EventHook 7, EventHookMode 1);
	HookEvent("lunge_pounce", EventHook 29, EventHookMode 1);
	HookEvent("player_shoved", EventHook 41, EventHookMode 1);
	HookEvent("player_jump", EventHook 39, EventHookMode 1);
	HookEvent("player_jump_apex", EventHook 37, EventHookMode 1);
	HookEvent("player_now_it", EventHook 31, EventHookMode 1);
	HookEvent("boomer_exploded", EventHook 9, EventHookMode 1);
	HookEvent("witch_spawn", EventHook 57, EventHookMode 1);
	HookEvent("witch_killed", EventHook 55, EventHookMode 1);
	HookEvent("witch_harasser_set", EventHook 53, EventHookMode 1);
	HookEvent("tongue_grab", EventHook 49, EventHookMode 1);
	HookEvent("tongue_pull_stopped", EventHook 51, EventHookMode 1);
	HookEvent("choke_start", EventHook 21, EventHookMode 1);
	HookEvent("choke_stopped", EventHook 23, EventHookMode 1);
	HookEvent("jockey_ride", EventHook 27, EventHookMode 1);
	HookEvent("charger_carry_start", EventHook 15, EventHookMode 1);
	HookEvent("charger_carry_end", EventHook 13, EventHookMode 1);
	HookEvent("charger_impact", EventHook 17, EventHookMode 1);
	HookEvent("charger_pummel_start", EventHook 19, EventHookMode 1);
	HookEvent("player_incapacitated_start", EventHook 25, EventHookMode 1);
	HookEvent("triggered_car_alarm", EventHook 11, EventHookMode 1);
	CreateConVar("sm_skill_detect_version", "0.9.19", "Skill detect plugin version.", 401664, false, 0, false, 0);
	g_hCvarReport = CreateConVar("sm_skill_report_enable", "0", "Whether to report in chat (see sm_skill_report_flags).", 262144, true, 0, true, 1);
	g_hCvarAllowMelee = CreateConVar("sm_skill_skeet_allowmelee", "1", "Whether to count/forward melee skeets.", 262144, true, 0, true, 1);
	g_hCvarAllowSniper = CreateConVar("sm_skill_skeet_allowsniper", "1", "Whether to count/forward sniper/magnum headshots as skeets.", 262144, true, 0, true, 1);
	g_hCvarAllowGLSkeet = CreateConVar("sm_skill_skeet_allowgl", "1", "Whether to count/forward direct GL hits as skeets.", 262144, true, 0, true, 1);
	g_hCvarDrawCrownThresh = CreateConVar("sm_skill_drawcrown_damage", "500", "How much damage a survivor must at least do in the final shot for it to count as a drawcrown.", 262144, true, 0, false, 0);
	g_hCvarSelfClearThresh = CreateConVar("sm_skill_selfclear_damage", "200", "How much damage a survivor must at least do to a smoker for him to count as self-clearing.", 262144, true, 0, false, 0);
	g_hCvarHunterDPThresh = CreateConVar("sm_skill_hunterdp_height", "400", "Minimum height of hunter pounce for it to count as a DP.", 262144, true, 0, false, 0);
	g_hCvarJockeyDPThresh = CreateConVar("sm_skill_jockeydp_height", "300", "How much height distance a jockey must make for his 'DP' to count as a reportable highpounce.", 262144, true, 0, false, 0);
	g_hCvarHideFakeDamage = CreateConVar("sm_skill_hidefakedamage", "0", "If set, any damage done that exceeds the health of a victim is hidden in reports.", 262144, true, 0, true, 1);
	g_hCvarDeathChargeHeight = CreateConVar("sm_skill_deathcharge_height", "400", "How much height distance a charger must take its victim for a deathcharge to be reported.", 262144, true, 0, false, 0);
	g_hCvarInstaTime = CreateConVar("sm_skill_instaclear_time", "0.75", "A clear within this time (in seconds) counts as an insta-clear.", 262144, true, 0, false, 0);
	g_hCvarBHopMinStreak = CreateConVar("sm_skill_bhopstreak", "3", "The lowest bunnyhop streak that will be reported.", 262144, true, 0, false, 0);
	g_hCvarBHopMinInitSpeed = CreateConVar("sm_skill_bhopinitspeed", "150", "The minimal speed of the first jump of a bunnyhopstreak (0 to allow 'hops' from standstill).", 262144, true, 0, false, 0);
	g_hCvarBHopContSpeed = CreateConVar("sm_skill_bhopkeepspeed", "300", "The minimal speed at which hops are considered succesful even if not speed increase is made.", 262144, true, 0, false, 0);
	g_hCvarPounceInterrupt = FindConVar("z_pounce_damage_interrupt");
	HookConVarChange(g_hCvarPounceInterrupt, ConVarChanged 5);
	g_iPounceInterrupt = GetConVarInt(g_hCvarPounceInterrupt);
	g_hCvarChargerHealth = FindConVar("z_charger_health");
	g_hCvarWitchHealth = FindConVar("z_witch_health");
	g_hCvarMaxPounceDistance = FindConVar("z_pounce_damage_range_max");
	g_hCvarMinPounceDistance = FindConVar("z_pounce_damage_range_min");
	g_hCvarMaxPounceDamage = FindConVar("z_hunter_max_pounce_bonus_damage");
	if (!g_hCvarMaxPounceDistance)
	{
		g_hCvarMaxPounceDistance = CreateConVar("z_pounce_damage_range_max", "1000.0", "Not available on this server, added by l4d2_skill_detect.", 262144, true, 0, false, 0);
	}
	if (!g_hCvarMinPounceDistance)
	{
		g_hCvarMinPounceDistance = CreateConVar("z_pounce_damage_range_min", "300.0", "Not available on this server, added by l4d2_skill_detect.", 262144, true, 0, false, 0);
	}
	if (!g_hCvarMaxPounceDamage)
	{
		g_hCvarMaxPounceDamage = CreateConVar("z_hunter_max_pounce_bonus_damage", "49", "Not available on this server, added by l4d2_skill_detect.", 262144, true, 0, false, 0);
	}
	g_hTrieWeapons = CreateTrie();
	SetTrieValue(g_hTrieWeapons, "hunting_rifle", any 0, true);
	SetTrieValue(g_hTrieWeapons, "sniper_military", any 0, true);
	SetTrieValue(g_hTrieWeapons, "sniper_awp", any 0, true);
	SetTrieValue(g_hTrieWeapons, "sniper_scout", any 0, true);
	SetTrieValue(g_hTrieWeapons, "pistol_magnum", any 1, true);
	SetTrieValue(g_hTrieWeapons, "grenade_launcher_projectile", any 2, true);
	g_hTrieEntityCreated = CreateTrie();
	SetTrieValue(g_hTrieEntityCreated, "tank_rock", any 1, true);
	SetTrieValue(g_hTrieEntityCreated, "witch", any 0, true);
	SetTrieValue(g_hTrieEntityCreated, "trigger_hurt", any 2, true);
	SetTrieValue(g_hTrieEntityCreated, "prop_car_alarm", any 3, true);
	SetTrieValue(g_hTrieEntityCreated, "prop_car_glass", any 4, true);
	g_hTrieAbility = CreateTrie();
	SetTrieValue(g_hTrieAbility, "ability_lunge", any 0, true);
	SetTrieValue(g_hTrieAbility, "ability_throw", any 1, true);
	g_hWitchTrie = CreateTrie();
	g_hRockTrie = CreateTrie();
	g_hCarTrie = CreateTrie();
	if (g_bLateLoad)
	{
		int client = 1;
		while (client <= MaxClients)
		{
			int var1;
			if (client > 0)
			{
				SDKHook(client, SDKHookType 2, SDKHookCB 75);
				client++;
			}
			client++;
		}
	}
	return 0;
}

public int CvarChange_PounceInterrupt(Handle convar, char oldValue[], char newValue[])
{
	g_iPounceInterrupt = GetConVarInt(convar);
	return 0;
}

public int OnClientPostAdminCheck(int client)
{
	SDKHook(client, SDKHookType 2, SDKHookCB 75);
	return 0;
}

public int OnClientDisconnect(int client)
{
	SDKUnhook(client, SDKHookType 2, SDKHookCB 75);
	return 0;
}

public Action Event_RoundStart(Handle event, char name[], bool dontBroadcast)
{
	g_iRocksBeingThrownCount = 0;
	int i = 1;
	while (i <= MaxClients)
	{
		g_bIsHopping[i] = 0;
		int j = 1;
		while (j <= MaxClients)
		{
			g_fVictimLastShove[i][0][0][j] = 0;
			j++;
		}
		i++;
	}
	return Action 0;
}

public Action Event_RoundEnd(Handle event, char name[], bool dontBroadcast)
{
	ClearTrie(g_hCarTrie);
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerHurt" (number 23)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerSpawn" (number 24)
public Action Event_IncapStart(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	int attackent = GetEventInt(event, "attackerentid");
	int dmgtype = GetEventInt(event, "type");
	char classname[24];
	if (IsValidEntity(attackent))
	{
		GetEdictClassname(attackent, classname, 24);
		if (GetTrieValue(g_hTrieEntityCreated, classname, ))
		{
			g_iVictimFlags[client] = g_iVictimFlags[client][0][0] | 16;
		}
	}
	float flow = GetSurvivorDistance(client);
	if (dmgtype & 16384)
	{
		g_iVictimFlags[client] = g_iVictimFlags[client][0][0] | 4;
	}
	if (__FLOAT_LT__(flow, 900))
	{
		g_iVictimFlags[client] = g_iVictimFlags[client][0][0] | 128;
	}
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "TraceAttack_Hunter" (number 26)
public Action TraceAttack_Charger(int victim, &int attacker, &int inflictor, &float damage, &int damagetype, &int ammotype, int hitbox, int hitgroup)
{
	int victimA = GetEntPropEnt(victim, PropType 0, "m_carryVictim", 0);
	if (victimA != -1)
	{
		g_iSpecialVictim[victim] = victimA;
	}
	else
	{
		g_iSpecialVictim[victim] = GetEntPropEnt(victim, PropType 0, "m_pummelVictim", 0);
	}
	return Action 0;
}

public Action TraceAttack_Jockey(int victim, &int attacker, &int inflictor, &float damage, &int damagetype, &int ammotype, int hitbox, int hitgroup)
{
	g_iSpecialVictim[victim] = GetEntPropEnt(victim, PropType 0, "m_jockeyVictim", 0);
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DSwitch' al tipo 'Lysis.DJump'. */
 function "Event_PlayerDeath" (number 29)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerShoved" (number 30)
public Action Event_LungePounce(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	int victim = GetClientOfUserId(GetEventInt(event, "victim"));
	g_fPinTime[client][0][0][0] = GetGameTime();
	ResetHunter(client);
	int var1;
	if (__FLOAT_EQ__(0, g_fPouncePosition[client][0][0][0]))
	{
		return Action 0;
	}
	float endPos[3];
	GetClientAbsOrigin(client, endPos);
	float fHeight = FloatSub(g_fPouncePosition[client][0][0][8], endPos[8]);
	float fMin = GetConVarFloat(g_hCvarMinPounceDistance);
	float fMax = GetConVarFloat(g_hCvarMaxPounceDistance);
	float fMaxDmg = GetConVarFloat(g_hCvarMaxPounceDamage);
	int distance = RoundToNearest(GetVectorDistance(g_fPouncePosition[client][0][0], endPos, false));
	float fDamage = FloatAdd(1, FloatMul(FloatDiv(FloatSub(float(distance), fMin), FloatSub(fMax, fMin)), fMaxDmg));
	if (__FLOAT_LT__(fDamage, 0))
	{
		fDamage = 0;
	}
	else
	{
		if (__FLOAT_GT__(fDamage, FloatAdd(1, fMaxDmg)))
		{
			fDamage = FloatAdd(1, fMaxDmg);
		}
	}
	Handle pack = CreateDataPack();
	WritePackCell(pack, client);
	WritePackCell(pack, victim);
	WritePackFloat(pack, fDamage);
	WritePackFloat(pack, fHeight);
	CreateTimer(0,05, Timer_HunterDP, pack, 0);
	return Action 0;
}

public Action Timer_HunterDP(Handle timer, Handle pack)
{
	ResetPack(pack, false);
	int client = ReadPackCell(pack);
	int victim = ReadPackCell(pack);
	float fDamage = ReadPackFloat(pack);
	float fHeight = ReadPackFloat(pack);
	CloseHandle(pack);
	HandleHunterDP(client, victim, g_iPounceDamage[client][0][0], fDamage, fHeight, false);
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_PlayerJumped" (number 33)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Timer_CheckHop" (number 34)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Timer_CheckHopStreak" (number 35)
public Action Event_PlayerJumpApex(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	if (g_bIsHopping[client][0][0])
	{
		float fVel[3];
		GetEntPropVector(client, PropType 1, "m_vecVelocity", fVel, 0);
		fVel[8] = 0;
		float fLength = GetVectorLength(fVel, false);
		if (__FLOAT_GT__(fLength, g_fHopTopVelocity[client][0][0]))
		{
			g_fHopTopVelocity[client] = fLength;
		}
	}
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_JockeyRide" (number 37)
public Action Event_AbilityUse(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	char abilityName[64];
	GetEventString(event, "ability", abilityName, 64);
	int var1;
	if (client > 0)
	{
		return Action 0;
	}
	strAbility ability = 0;
	if (!GetTrieValue(g_hTrieAbility, abilityName, ability))
	{
		return Action 0;
	}
	switch (ability)
	{
		case 0: {
			ResetHunter(client);
			GetClientAbsOrigin(client, g_fPouncePosition[client][0][0]);
		}
		case 1: {
			g_iRocksBeingThrown[g_iRocksBeingThrownCount] = client;
			if (g_iRocksBeingThrownCount < 9)
			{
				g_iRocksBeingThrownCount += 1;
			}
		}
		default: {
		}
	}
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_ChargeCarryStart" (number 39)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_ChargeImpact" (number 40)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_ChargePummelStart" (number 41)
public Action Event_ChargeCarryEnd(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	int var1;
	if (client < 1)
	{
		return Action 0;
	}
	g_fPinTime[client][0][0][4] = GetGameTime();
	CreateTimer(0,1, Timer_ChargeCarryEnd, client, 2);
	return Action 0;
}

public Action Timer_ChargeCarryEnd(Handle timer, any client)
{
	g_iChargeVictim[client] = 0;
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Timer_ChargeCheck" (number 44)
public Action Timer_DeathChargeCheck(Handle timer, any client)
{
	int var1;
	if (client > any 0)
	{
		return Action 0;
	}
	PrintDebug(3, "Checking charge victim: %i - %i - flags: %i (alive? %i)", g_iVictimCharger[client], client, g_iVictimFlags[client], IsPlayerAlive(client));
	int flags = g_iVictimFlags[client][0][0];
	if (!IsPlayerAlive(client))
	{
		float pos[3];
		GetClientAbsOrigin(client, pos);
		float fHeight = FloatSub(g_fChargeVictimPos[client][0][0][8], pos[8]);
		int var3;
		if (flags & 4)
		{
			HandleDeathCharge(g_iVictimCharger[client][0][0], client, fHeight, GetVectorDistance(g_fChargeVictimPos[client][0][0], pos, false), flags & 1);
		}
	}
	else
	{
		int var9;
		if (flags & 128)
		{
			g_iVictimFlags[client] = g_iVictimFlags[client][0][0] | 256;
			CreateTimer(3, Timer_DeathChargeCheck, client, 2);
		}
	}
	return Action 0;
}

int ResetHunter(int client)
{
	g_iHunterShotDmgTeam[client] = 0;
	int i = 1;
	while (i <= MaxClients)
	{
		g_iHunterShotDmg[client][0][0][i] = 0;
		g_fHunterShotStart[client][0][0][i] = 0;
		i++;
	}
	g_iHunterOverkill[client] = 0;
	return 0;
}

public int OnEntityCreated(int entity, char classname[])
{
	int var1;
	if (entity < 1)
	{
		return 0;
	}
	strOEC classnameOEC = 0;
	if (!GetTrieValue(g_hTrieEntityCreated, classname, classnameOEC))
	{
		return 0;
	}
	switch (classnameOEC)
	{
		case 1: {
			char rock_key[12];
			FormatEx(rock_key, 10, "%x", entity);
			int rock_array[3];
			int tank = ShiftTankThrower();
			int var2;
			if (tank > 0)
			{
				g_iTankRock[tank] = entity;
				rock_array[4] = tank;
			}
			SetTrieArray(g_hRockTrie, rock_key, rock_array, 3, true);
			SDKHook(entity, SDKHookType 11, SDKHookCB 117);
			SDKHook(entity, SDKHookType 10, SDKHookCB 87);
		}
		case 3: {
			char car_key[12];
			FormatEx(car_key, 10, "%x", entity);
			SDKHook(entity, SDKHookType 2, SDKHookCB 79);
			SDKHook(entity, SDKHookType 10, SDKHookCB 83);
			SDKHook(entity, SDKHookType 7, SDKHookCB 69);
		}
		case 4: {
			SDKHook(entity, SDKHookType 2, SDKHookCB 81);
			SDKHook(entity, SDKHookType 10, SDKHookCB 85);
			SDKHook(entity, SDKHookType 7, SDKHookCB 71);
		}
		default: {
		}
	}
	return 0;
}

public int OnEntitySpawned_CarAlarm(int entity)
{
	if (!IsValidEntity(entity))
	{
		return 0;
	}
	char car_key[12];
	FormatEx(car_key, 10, "%x", entity);
	char target[48];
	GetEntPropString(entity, PropType 1, "m_iName", target, 48, 0);
	SetTrieValue(g_hCarTrie, target, entity, true);
	SetTrieValue(g_hCarTrie, car_key, any 0, true);
	HookSingleEntityOutput(entity, "OnCarAlarmStart", EntityOutput 59, false);
	return 0;
}

public int OnEntitySpawned_CarAlarmGlass(int entity)
{
	if (!IsValidEntity(entity))
	{
		return 0;
	}
	char car_key[12];
	FormatEx(car_key, 10, "%x", entity);
	char parent[48];
	GetEntPropString(entity, PropType 1, "m_iParent", parent, 48, 0);
	int parentEntity = 0;
	if (GetTrieValue(g_hCarTrie, parent, parentEntity))
	{
		if (IsValidEntity(parentEntity))
		{
			SetTrieValue(g_hCarTrie, car_key, parentEntity, true);
			char car_key_p[12];
			FormatEx(car_key_p, 10, "%x_A", parentEntity);
			if (GetTrieValue(g_hCarTrie, car_key_p, ))
			{
				FormatEx(car_key_p, 10, "%x_B", parentEntity);
			}
			SetTrieValue(g_hCarTrie, car_key_p, entity, true);
		}
	}
	return 0;
}

public int OnEntityDestroyed(int entity)
{
	char witch_key[12];
	FormatEx(witch_key, 10, "%x", entity);
	int rock_array[3];
	if (GetTrieArray(g_hRockTrie, witch_key, rock_array, 3, 0))
	{
		CreateTimer(0,34, Timer_CheckRockSkeet, entity, 0);
		SDKUnhook(entity, SDKHookType 11, SDKHookCB 117);
		return 0;
	}
	int witch_array[72];
	if (GetTrieArray(g_hWitchTrie, witch_key, witch_array, 72, 0))
	{
		CreateTimer(0,15, Timer_WitchKeyDelete, entity, 0);
		SDKUnhook(entity, SDKHookType 3, SDKHookCB 77);
		return 0;
	}
	return 0;
}

public Action Timer_WitchKeyDelete(Handle timer, any witch)
{
	char witch_key[12];
	FormatEx(witch_key, 10, "%x", witch);
	RemoveFromTrie(g_hWitchTrie, witch_key);
	return Action 0;
}

public Action Timer_CheckRockSkeet(Handle timer, any rock)
{
	int rock_array[3];
	char rock_key[12];
	FormatEx(rock_key, 10, "%x", rock);
	if (!GetTrieArray(g_hRockTrie, rock_key, rock_array, 3, 0))
	{
		return Action 0;
	}
	RemoveFromTrie(g_hRockTrie, rock_key);
	if (0 < rock_array[0])
	{
		HandleRockSkeeted(rock_array[8], rock_array[4]);
	}
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "Event_PlayerBoomed" (number 53)
public Action Timer_BoomVomitCheck(Handle timer, any client)
{
	HandleVomitLanded(client, g_iBoomerVomitHits[client][0][0]);
	g_iBoomerVomitHits[client] = 0;
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "Event_BoomerExploded" (number 55)
public Action Event_WitchSpawned(Handle event, char name[], bool dontBroadcast)
{
	int witch = GetEventInt(event, "witchid");
	SDKHook(witch, SDKHookType 3, SDKHookCB 77);
	int witch_dmg_array[72];
	char witch_key[12];
	FormatEx(witch_key, 10, "%x", witch);
	witch_dmg_array[264] = GetConVarInt(g_hCvarWitchHealth);
	SetTrieArray(g_hWitchTrie, witch_key, witch_dmg_array, 72, false);
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_WitchKilled" (number 57)
public Action Event_WitchHarasserSet(Handle event, char name[], bool dontBroadcast)
{
	int witch = GetEventInt(event, "witchid");
	char witch_key[12];
	FormatEx(witch_key, 10, "%x", witch);
	int witch_dmg_array[72];
	if (!GetTrieArray(g_hWitchTrie, witch_key, witch_dmg_array, 72, 0))
	{
		int i = 0;
		while (i <= 65)
		{
			witch_dmg_array[i] = 0;
			i++;
		}
		witch_dmg_array[264] = GetConVarInt(g_hCvarWitchHealth);
		witch_dmg_array[272] = 1;
		SetTrieArray(g_hWitchTrie, witch_key, witch_dmg_array, 72, false);
	}
	else
	{
		witch_dmg_array[272] = 1;
		SetTrieArray(g_hWitchTrie, witch_key, witch_dmg_array, 72, true);
	}
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "OnTakeDamageByWitch" (number 59)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "OnTakeDamagePost_Witch" (number 60)
public Action Timer_CheckWitchCrown(Handle timer, Handle pack)
{
	ResetPack(pack, false);
	int attacker = ReadPackCell(pack);
	int witch = ReadPackCell(pack);
	bool bOneShot = ReadPackCell(pack);
	CloseHandle(pack);
	CheckWitchCrown(witch, attacker, bOneShot);
	return Action 0;
}

int CheckWitchCrown(int witch, int attacker, bool bOneShot)
{
	char witch_key[12];
	FormatEx(witch_key, 10, "%x", witch);
	int witch_dmg_array[72];
	if (!GetTrieArray(g_hWitchTrie, witch_key, witch_dmg_array, 72, 0))
	{
		PrintDebug(0, "Witch Crown Check: Error: Trie entry missing (entity: %i, oneshot: %i)", witch, bOneShot);
		return 0;
	}
	int chipDamage = 0;
	int iWitchHealth = GetConVarInt(g_hCvarWitchHealth);
	if (bOneShot)
	{
		witch_dmg_array[284] = 1;
	}
	int var1;
	if (witch_dmg_array[268])
	{
		PrintDebug(0, "Witch Crown Check: Failed: bungled: %i / crowntype: %i (entity: %i)", witch_dmg_array[268], witch_dmg_array[284], witch);
		PrintDebug(1, "Witch Crown Check: Further details: attacker: %N, attacker dmg: %i, teamless dmg: %i", attacker, witch_dmg_array[attacker], witch_dmg_array);
		return 0;
	}
	PrintDebug(0, "Witch Crown Check: crown shot: %i, harrassed: %i (full health: %i / drawthresh: %i / oneshot %i)", witch_dmg_array[280], witch_dmg_array[272], iWitchHealth, GetConVarInt(g_hCvarDrawCrownThresh), bOneShot);
	int var3;
	if (!witch_dmg_array[272])
	{
		if (GetConVarBool(g_hCvarHideFakeDamage))
		{
			chipDamage = 0;
			int i = 0;
			while (i <= 65)
			{
				if (!(attacker == i))
				{
					chipDamage = witch_dmg_array[i] + chipDamage;
				}
				i++;
			}
			witch_dmg_array[attacker] = iWitchHealth - chipDamage;
		}
		HandleCrown(attacker, witch_dmg_array[attacker]);
	}
	else
	{
		if (GetConVarInt(g_hCvarDrawCrownThresh) <= witch_dmg_array[280])
		{
			int i = 0;
			while (i <= 65)
			{
				if (attacker == i)
				{
					chipDamage = witch_dmg_array[i] - witch_dmg_array[280] + chipDamage;
					i++;
				}
				else
				{
					chipDamage = witch_dmg_array[i] + chipDamage;
					i++;
				}
				i++;
			}
			if (GetConVarBool(g_hCvarHideFakeDamage))
			{
				if (chipDamage >= iWitchHealth)
				{
					chipDamage = iWitchHealth + -1;
					witch_dmg_array[280] = 1;
				}
				else
				{
					witch_dmg_array[280] = iWitchHealth - chipDamage;
				}
				if (GetConVarInt(g_hCvarDrawCrownThresh) > witch_dmg_array[280])
				{
					return 0;
				}
			}
			HandleDrawCrown(attacker, witch_dmg_array[280], chipDamage);
		}
	}
	return 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "TraceAttack_Rock" (number 63)
public int OnTouch_Rock(int entity)
{
	char rock_key[12];
	FormatEx(rock_key, 10, "%x", entity);
	int rock_array[3];
	rock_array[0] = -1;
	SetTrieArray(g_hRockTrie, rock_key, rock_array, 3, true);
	SDKUnhook(entity, SDKHookType 10, SDKHookCB 87);
	return 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_TonguePullStopped" (number 65)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "Event_TongueGrab" (number 66)
public Action Event_ChokeStart(Handle event, char name[], bool dontBroadcast)
{
	int attacker = GetClientOfUserId(GetEventInt(event, "userid"));
	if (__FLOAT_EQ__(0, g_fPinTime[attacker][0][0][0]))
	{
		g_fPinTime[attacker][0][0][0] = GetGameTime();
	}
	g_fPinTime[attacker][0][0][4] = GetGameTime();
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "Event_ChokeStop" (number 68)
public int Hook_CarAlarmStart(char output[], int caller, int activator, float delay)
{
	PrintDebug(0, "calarm trigger: caller %i / activator %i / delay: %.2f", caller, activator, delay);
	return 0;
}

public Action Event_CarAlarmGoesOff(Handle event, char name[], bool dontBroadcast)
{
	g_fLastCarAlarm = GetGameTime();
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "OnTakeDamage_Car" (number 71)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "OnTouch_Car" (number 72)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "OnTakeDamage_CarGlass" (number 73)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJump'. */
 function "OnTouch_CarGlass" (number 74)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "Timer_CheckAlarm" (number 75)
int HandlePop(int attacker, int victim, int shoveCount, float timeAlive)
{
	Call_StartForward(g_hForwardBoomerPop);
	Call_PushCell(attacker);
	Call_PushCell(victim);
	Call_PushCell(shoveCount);
	Call_PushFloat(timeAlive);
	Call_Finish(0);
	return 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "HandleLevel" (number 77)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "HandleLevelHurt" (number 78)
int HandleDeadstop(int attacker, int victim)
{
	Call_StartForward(g_hForwardHunterDeadstop);
	Call_PushCell(attacker);
	Call_PushCell(victim);
	Call_Finish(0);
	return 0;
}

int HandleShove(int attacker, int victim, int zombieClass)
{
	Call_StartForward(g_hForwardSIShove);
	Call_PushCell(attacker);
	Call_PushCell(victim);
	Call_PushCell(zombieClass);
	Call_Finish(0);
	return 0;
}

int HandleSkeet(int attacker, int victim, bool bMelee, bool bSniper, bool bGL)
{
	if (bSniper)
	{
		Call_StartForward(g_hForwardSkeetSniper);
		Call_PushCell(attacker);
		Call_PushCell(victim);
		Call_Finish(0);
	}
	else
	{
		if (bGL)
		{
			Call_StartForward(g_hForwardSkeetGL);
			Call_PushCell(attacker);
			Call_PushCell(victim);
			Call_Finish(0);
		}
		if (bMelee)
		{
			Call_StartForward(g_hForwardSkeetMelee);
			Call_PushCell(attacker);
			Call_PushCell(victim);
			Call_Finish(0);
		}
		Call_StartForward(g_hForwardSkeet);
		Call_PushCell(attacker);
		Call_PushCell(victim);
		Call_Finish(0);
	}
	return 0;
}

int HandleNonSkeet(int attacker, int victim, int damage, bool bOverKill, bool bMelee, bool bSniper)
{
	if (bSniper)
	{
		Call_StartForward(g_hForwardSkeetSniperHurt);
		Call_PushCell(attacker);
		Call_PushCell(victim);
		Call_PushCell(damage);
		Call_PushCell(bOverKill);
		Call_Finish(0);
	}
	else
	{
		if (bMelee)
		{
			Call_StartForward(g_hForwardSkeetMeleeHurt);
			Call_PushCell(attacker);
			Call_PushCell(victim);
			Call_PushCell(damage);
			Call_PushCell(bOverKill);
			Call_Finish(0);
		}
		Call_StartForward(g_hForwardSkeetHurt);
		Call_PushCell(attacker);
		Call_PushCell(victim);
		Call_PushCell(damage);
		Call_PushCell(bOverKill);
		Call_Finish(0);
	}
	return 0;
}

int HandleCrown(int attacker, int damage)
{
	Call_StartForward(g_hForwardCrown);
	Call_PushCell(attacker);
	Call_PushCell(damage);
	Call_Finish(0);
	return 0;
}

int HandleDrawCrown(int attacker, int damage, int chipdamage)
{
	Call_StartForward(g_hForwardDrawCrown);
	Call_PushCell(attacker);
	Call_PushCell(damage);
	Call_PushCell(chipdamage);
	Call_Finish(0);
	return 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "HandleTongueCut" (number 85)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "HandleSmokerSelfClear" (number 86)
int HandleRockEaten(int attacker, int victim)
{
	Call_StartForward(g_hForwardRockEaten);
	Call_PushCell(attacker);
	Call_PushCell(victim);
	Call_Finish(0);
	return 0;
}

int HandleRockSkeeted(int attacker, int victim)
{
	if (GetConVarBool(g_hCvarReport))
	{
		CPrintToChatAll("{green}★ {olive}%N {blue}skeeted {default}a tank rock", attacker);
	}
	Call_StartForward(g_hForwardRockSkeeted);
	Call_PushCell(attacker);
	Call_PushCell(victim);
	Call_Finish(0);
	return 0;
}

int HandleHunterDP(int attacker, int victim, int actualDamage, float calculatedDamage, float height, bool playerIncapped)
{
	int var1;
	if (GetConVarBool(g_hCvarReport))
	{
		int var2;
		if (attacker > 0)
		{
			var10 = 1;
		}
		else
		{
			var10 = 0;
		}
		Call_PushCell(var10);
		Call_Finish(0);
		return 0;
	}
	Call_StartForward(g_hForwardHunterDP);
	Call_PushCell(attacker);
	Call_PushCell(victim);
	Call_PushCell(actualDamage);
	Call_PushFloat(calculatedDamage);
	Call_PushFloat(height);
	int var9;
	if (__FLOAT_GE__(height, GetConVarFloat(g_hCvarHunterDPThresh)))
	{
		var9 = 1;
	}
	else
	{
		var9 = 0;
	}
	Call_PushCell(var9);
	int var10;
	if (playerIncapped)
	{
		var10 = 1;
	}
	else
	{
		var10 = 0;
	}
	Call_PushCell(var10);
	Call_Finish(0);
	return 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "HandleJockeyDP" (number 90)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "HandleDeathCharge" (number 91)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "HandleClear" (number 92)
int HandleVomitLanded(int attacker, int boomCount)
{
	Call_StartForward(g_hForwardVomitLanded);
	Call_PushCell(attacker);
	Call_PushCell(boomCount);
	Call_Finish(0);
	return 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DJump' al tipo 'Lysis.DJumpCondition'. */
 function "HandleBHopStreak" (number 94)
int HandleCarAlarmTriggered(int survivor, int infected, int reason)
{
	Call_StartForward(g_hForwardAlarmTriggered);
	Call_PushCell(survivor);
	Call_PushCell(infected);
	Call_PushCell(reason);
	Call_Finish(0);
	return 0;
}

float GetSurvivorDistance(int client)
{
	return L4D2Direct_GetFlowDistance(client);
}


/* ERROR! Unrecognized opcode dec */
 function "ShiftTankThrower" (number 97)
int PrintDebug(int debuglevel, char Message[])
{
	char DebugBuff[256];
	VFormat(DebugBuff, 256, Message, 3);
	LogMessage(DebugBuff);
	return 0;
}

bool IsWitch(int entity)
{
	if (!IsValidEntity(entity))
	{
		return false;
	}
	char classname[24];
	strOEC classnameOEC = 0;
	GetEdictClassname(entity, classname, 24);
	int var1;
	if (!GetTrieValue(g_hTrieEntityCreated, classname, classnameOEC))
	{
		return false;
	}
	return true;
}

