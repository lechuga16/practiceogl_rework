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
 Extension __ext_left4downtown = 1164;
 Extension __ext_sdktools = 1216;
 SharedPlugin __pl_readyup = 1524;
 SharedPlugin __pl_pause = 1620;
 Extension __ext_sdkhooks = 1664;
 Handle hCvarTimerStartDelay;
 Handle hCvarHordeCountdown;
 Handle hCvarMinProgressThreshold;
 float timerStartDelay;
 float hordeCountdown;
 float minProgress;
 float aliveSince[66];
 float startingSurvivorCompletion;
 int z_max_player_zombies;
 int hordeDelayChecks;
 L4D2SI zombieclass[66];
public Plugin myinfo =
{
	name = "L4D2 Antibaiter",
	description = "Makes you think twice before attempting to bait that shit",
	author = "Visor",
	version = "1.3",
	url = "https://github.com/Attano/L4D2-Competitive-Framework"
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
	MarkNativeAsOptional("PbReadRepeatedInt");
	MarkNativeAsOptional("PbReadRepeatedFloat");
	MarkNativeAsOptional("PbReadRepeatedBool");
	MarkNativeAsOptional("PbReadRepeatedString");
	MarkNativeAsOptional("PbReadRepeatedColor");
	MarkNativeAsOptional("PbReadRepeatedAngle");
	MarkNativeAsOptional("PbReadRepeatedVector");
	MarkNativeAsOptional("PbReadRepeatedVector2D");
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

float operator-(_:,Float:)(int oper1, float oper2)
{
	return FloatSub(float(oper1), oper2);
}

bool operator!=(Float:,Float:)(float oper1, float oper2)
{
	return FloatCompare(oper1, oper2) != 0;
}

bool operator>(Float:,Float:)(float oper1, float oper2)
{
	return FloatCompare(oper1, oper2) > 0;
}

bool operator>=(Float:,Float:)(float oper1, float oper2)
{
	return FloatCompare(oper1, oper2) >= 0;
}

bool operator>=(Float:,_:)(float oper1, int oper2)
{
	return FloatCompare(oper1, float(oper2)) >= 0;
}

bool operator>=(_:,Float:)(int oper1, float oper2)
{
	return FloatCompare(float(oper1), oper2) >= 0;
}

bool operator<=(Float:,Float:)(float oper1, float oper2)
{
	return FloatCompare(oper1, oper2) <= 0;
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

Address L4D2Direct_GetCDirector()
{
	static Address TheDirector;
	if (!TheDirector)
	{
		TheDirector = GameConfGetAddress(L4D2Direct_GetGameConf(), "CDirector");
	}
	return TheDirector;
}

Address L4D2Direct_GetCDirectorScavengeMode()
{
	static Address pScavengeModeDirector;
	if (!pScavengeModeDirector)
	{
		int offs = GameConfGetOffset(L4D2Direct_GetGameConf(), "CDirectorScavengeMode");
		if (offs == -1)
		{
			return Address 0;
		}
		pScavengeModeDirector = L4D2Direct_GetCDirector() + offs;
		pScavengeModeDirector = LoadFromAddress(pScavengeModeDirector, NumberType 2);
	}
	return pScavengeModeDirector;
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

Address L4D2Direct_GetTankCountAddr()
{
	static Address pTankCount;
	if (!pTankCount)
	{
		int offs = GameConfGetOffset(L4D2Direct_GetGameConf(), "CDirector::m_iTankCount");
		if (offs == -1)
		{
			return Address 0;
		}
		pTankCount = L4D2Direct_GetCDirector() + offs;
	}
	return pTankCount;
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

int CTimer_Start(CountdownTimer timer, float duration)
{
	CTimer_SetTimestamp(timer, FloatAdd(GetGameTime(), duration));
	CTimer_SetDuration(timer, duration);
	return 0;
}

int CTimer_Invalidate(CountdownTimer timer)
{
	CTimer_SetTimestamp(timer, -1);
	return 0;
}

bool CTimer_HasStarted(CountdownTimer timer)
{
	return CTimer_GetTimestamp(timer) >= 0;
}

bool CTimer_IsElapsed(CountdownTimer timer)
{
	return GetGameTime() >= CTimer_GetTimestamp(timer);
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

int L4D2Direct_GetTankCount()
{
	return LoadFromAddress(L4D2Direct_GetTankCountAddr(), NumberType 2);
}

CountdownTimer L4D2Direct_GetMobSpawnTimer()
{
	static Address pMobSpawnTimer;
	if (!pMobSpawnTimer)
	{
		int offs = GameConfGetOffset(L4D2Direct_GetGameConf(), "CDirector::MobSpawnTimer");
		if (offs == -1)
		{
			return CountdownTimer 0;
		}
		pMobSpawnTimer = L4D2Direct_GetCDirector() + offs;
	}
	return pMobSpawnTimer;
}

CountdownTimer L4D2Direct_GetScavengeRoundSetupTimer()
{
	static Address pRoundSetupTimer;
	if (!pRoundSetupTimer)
	{
		int offs = GameConfGetOffset(L4D2Direct_GetGameConf(), "CDirectorScavengeMode::RoundSetupTimer");
		if (offs == -1)
		{
			return CountdownTimer 0;
		}
		pRoundSetupTimer = L4D2Direct_GetCDirectorScavengeMode() + offs;
	}
	return pRoundSetupTimer;
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

public int __pl_pause_SetNTVOptional()
{
	MarkNativeAsOptional("IsInPause");
	return 0;
}

public int OnPluginStart()
{
	hCvarTimerStartDelay = CreateConVar("l4d2_antibaiter_delay", "20", "Delay in seconds before the antibait algorithm kicks in", 262144, false, 0, false, 0);
	hCvarHordeCountdown = CreateConVar("l4d2_antibaiter_horde_timer", "60", "Countdown in seconds to the panic horde", 262144, false, 0, false, 0);
	hCvarMinProgressThreshold = CreateConVar("l4d2_antibaiter_progress", "0.03", "Minimum progress the survivors must make to reset the antibaiter timer", 262144, false, 0, false, 0);
	CreateTimer(1, AntibaiterThink, any 0, 1);
	return 0;
}

public int OnConfigsExecuted()
{
	z_max_player_zombies = GetConVarInt(FindConVar("z_max_player_zombies"));
	timerStartDelay = GetConVarFloat(hCvarTimerStartDelay);
	hordeCountdown = GetConVarFloat(hCvarHordeCountdown);
	minProgress = GetConVarFloat(hCvarMinProgressThreshold);
	return 0;
}

public int OnRoundIsLive()
{
	int i = 1;
	while (i <= MaxClients)
	{
		if (IsInfected(i))
		{
			if (IsPlayerAlive(i))
			{
				zombieclass[i] = GetZombieClass(i);
				aliveSince[i] = GetGameTime();
			}
		}
		i++;
	}
	return 0;
}

public Action AntibaiterThink(Handle timer)
{
	int var1;
	if (IsInReady())
	{
		hordeDelayChecks = 0;
		HideCountdown();
		StopCountdown();
		return Action 3;
	}
	int eligibleZombies = 0;
	int i = 1;
	while (i <= MaxClients)
	{
		int var2;
		if (!IsInfected(i))
		{
		}
		else
		{
			if (IsPlayerAlive(i))
			{
				zombieclass[i] = GetZombieClass(i);
				int var3;
				if (zombieclass[i][0][0] > L4D2SI 0)
				{
					eligibleZombies++;
				}
			}
			else
			{
				aliveSince[i] = -1082130432;
				hordeDelayChecks = 0;
				HideCountdown();
				StopCountdown();
			}
		}
		i++;
	}
	if (eligibleZombies > z_max_player_zombies)
	{
		return Action 0;
	}
	if (z_max_player_zombies == eligibleZombies)
	{
		float survivorCompletion = GetMaxSurvivorCompletion();
		float progress = FloatSub(survivorCompletion, startingSurvivorCompletion);
		int var4;
		if (progress <= minProgress)
		{
			if (IsCountdownRunning())
			{
				if (HasCountdownElapsed())
				{
					HideCountdown();
					LaunchHorde();
					hordeDelayChecks = 0;
				}
			}
			else
			{
				InitiateCountdown();
			}
		}
		else
		{
			if (!hordeDelayChecks)
			{
				startingSurvivorCompletion = survivorCompletion;
			}
			if (progress > minProgress)
			{
				startingSurvivorCompletion = survivorCompletion;
				hordeDelayChecks = 0;
			}
			hordeDelayChecks += 1;
			HideCountdown();
			StopCountdown();
		}
	}
	return Action 3;
}

public int L4D_OnEnterGhostState(int client)
{
	zombieclass[client] = GetZombieClass(client);
	aliveSince[client] = GetGameTime();
	return 0;
}

int InitiateCountdown()
{
	int i = 1;
	while (i <= MaxClients)
	{
		int var1;
		if (IsClientInGame(i))
		{
			ShowVGUIPanel(i, "ready_countdown", Handle 0, true);
			i++;
		}
		i++;
	}
	CTimer_Start(CountdownPointer(), hordeCountdown);
	return 0;
}

bool IsCountdownRunning()
{
	return CTimer_HasStarted(CountdownPointer());
}

bool HasCountdownElapsed()
{
	return CTimer_IsElapsed(CountdownPointer());
}

int StopCountdown()
{
	CTimer_Invalidate(CountdownPointer());
	return 0;
}

int HideCountdown()
{
	int i = 1;
	while (i <= MaxClients)
	{
		int var1;
		if (IsClientInGame(i))
		{
			ShowVGUIPanel(i, "ready_countdown", Handle 0, false);
			i++;
		}
		i++;
	}
	return 0;
}

int LaunchHorde()
{
	int client = -1;
	int i = 1;
	while (i <= MaxClients)
	{
		int var1;
		if (IsClientInGame(i))
		{
			client = i;
			if (client != -1)
			{
				char command[28];
				int flags = GetCommandFlags(command);
				SetCommandFlags(command, flags & -16385);
				FakeClientCommand(client, command);
				SetCommandFlags(command, flags);
			}
			return 0;
		}
		i++;
	}
	if (client != -1)
	{
		char command[28];
		int flags = GetCommandFlags(command);
		SetCommandFlags(command, flags & -16385);
		FakeClientCommand(client, command);
		SetCommandFlags(command, flags);
	}
	return 0;
}

CountdownTimer CountdownPointer()
{
	return L4D2Direct_GetScavengeRoundSetupTimer();
}

float GetMaxSurvivorCompletion()
{
	float flow = 0;
	int i = 1;
	while (i <= MaxClients)
	{
		int var1;
		if (IsSurvivor(i))
		{
			int var2;
			if (flow > L4D2Direct_GetFlowDistance(i))
			{
				var2 = flow;
			}
			else
			{
				var2 = L4D2Direct_GetFlowDistance(i);
			}
			flow = var2;
			i++;
		}
		i++;
	}
	return FloatDiv(flow, L4D2Direct_GetMapMaxFlowDistance());
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "IsSurvivor" (number 43)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "IsInfected" (number 44)
L4D2SI GetZombieClass(int client)
{
	return GetEntProp(client, PropType 0, "m_zombieClass", 4, 0);
}

bool IsIncapped(int client)
{
	return GetEntProp(client, PropType 0, "m_isIncapacitated", 4, 0);
}

bool IsPanicEventInProgress()
{
	CountdownTimer pPanicCountdown = L4D2_GetCDirectorScriptedEventManager() + 300;
	if (!CTimer_IsElapsed(pPanicCountdown))
	{
		return true;
	}
	if (CTimer_HasStarted(L4D2Direct_GetMobSpawnTimer()))
	{
		return RoundFloat(CTimer_GetRemainingTime(L4D2Direct_GetMobSpawnTimer())) <= 10;
	}
	return false;
}

Address L4D2_GetCDirectorScriptedEventManager()
{
	static Address pScriptedEventManager;
	if (!pScriptedEventManager)
	{
		int offs = GameConfGetOffset(L4D2Direct_GetGameConf(), "CDirectorScriptedEventManager");
		if (offs == -1)
		{
			return Address 0;
		}
		pScriptedEventManager = L4D2Direct_GetCDirector() + offs;
		pScriptedEventManager = LoadFromAddress(pScriptedEventManager, NumberType 2);
	}
	return pScriptedEventManager;
}

