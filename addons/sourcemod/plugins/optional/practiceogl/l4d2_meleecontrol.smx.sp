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
 Extension __ext_core = 64;
 int MaxClients;
 Extension __ext_sdktools = 184;
 Extension __ext_geoip = 228;
 Extension __ext_sdkhooks = 280;
 Extension __ext_smsock = 324;
 int OUT_SERVER = 1;
 int OUT_CHAT = 2;
 int OUT_LOG = 4;
 int CHANNEL_ALL = -1;
 char CHANNEL_GENERAL_NAME[2] = "General";
 char SETTINGS_NAME_KEY[2] = "_name";
 char SETTINGS_FLAG_KEY[2] = "_flag";
 bool g_bIsModuleSetup;
 Handle g_hChannelsTrie;
 int g_iNextChannel_Flag = 1;
 int g_iNextChannel_Index = 1;
 int g_iOutputFlags;
 int g_iChannelFlags;
 char CALL_ON_START[4] = "OnPluginStartEx";
 Handle g_hEventForwards[12];
 bool g_bIsPluginEnabled;
 char PUBLIC_TRIGGER[1] = "!";
 char PRIVAT_TRIGGER[1] = "/";
 int MAX_COMMAND_LENGTH = 64;
 Handle g_aSayCommands;
 int SurvivorCount;
 int SurvivorIndex[65];
 int InfectedCount;
 int InfectedIndex[65];
 int SpectateCount;
 int SpectateIndex[65];
 float REBUILD_DELAY = 1050253722;
 int g_iDebugChannel;
 char DEBUG_CHANNEL_NAME[4] = "ClientIndexes";
 char CLASSNAME_CHANGELEVEL[5] = "\x05";
 char CLASSNAME_FINALETRIGGER[4] = "\x05";
 Handle g_hGetPlayerFlowDistance = 5;
 bool g_bIsModuleSetup = 5;
 int FLOWTYPE_DEFAULT = 5;
 char GAMECONFIG_INFECTED_FLOW[7] = "\x05";
 Handle g_hGetInfectedFlowDistance = 5;
 int ZOMBIECLASS_TANK = 5;
 char GAMECONFIG_PLAYER_FLOW[8] = "\x05";
 char CLASSNAME_TANK[2] = "Tank";
 char NETPROP_FRUSTRATION[4] = "m_frustration";
 char NETPROP_INCAPACITATED[5] = "m_isIncapacitated";
 char NETPROP_ZOMBIECLASS[4] = "m_zombieClass";
 int g_iOffset_Frustration;
 int g_iOffset_Incapacitated;
 int g_iTankClient;
 bool g_bIsTankInPlay;
 Handle g_hFwd_TankSpawn;
 Handle g_hFwd_TankKilled;
 Handle g_hFwd_TankPassed;
 int g_iDebugChannel;
 char DEBUG_CHANNEL_NAME[3] = "TankManager";
 char TEAMNAME_SPECTATOR[3] = "%s_%s";
 char TEAMNAME_SURVIVORS[3] = "%s_%s";
 char TEAMNAME_SURVIVOR[3] = "%s_%s";
 char TEAMNAME_SPECTATORS[3] = "%s_%s";
 char TEAMNAME_INFECTED[3] = "%s_%s";
 int g_nonFatiguedMeleePenalty = 1;
 Handle g_hNonFatiguedMeleePenalty_CVAR;
 int MAX_EXISTING_FATIGUE = 3;
 float MELEE_DURATION = 1058642330;
 bool soundHookDelay[65];
 int g_iDebugChannel;
 char DEBUG_CHANNEL_NAME[4] = "MeleeFatigue";
 char MELEE_SOUND_NAME_SEARCH[2] = "Swish";
 bool g_bIsZACKLoaded;
public Plugin myinfo =
{
	name = "L4D2 Melee Fatigue Control",
	description = "Allows players to set custom fatigue levels.",
	author = "Blade",
	version = "0.0.2",
	url = "http://code.google.com/p/metafogl/"
};
public int __ext_core_SetNTVOptional()
{
	MarkNativeAsOptional("GetFeatureStatus");
	MarkNativeAsOptional("RequireFeature");
	MarkNativeAsOptional("AddCommandListener");
	MarkNativeAsOptional("RemoveCommandListener");
	VerifyCoreVersion();
	return 0;
}

bool StrEqual(char str1[], char str2[], bool caseSensitive)
{
	return strcmp(str1, str2, caseSensitive) == 0;
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

public int _H_D_Channel_CvarChange(Handle convar, char oldValue[], char newValue[])
{
	g_iChannelFlags = StringToInt(newValue, 10);
	return 0;
}

public int _H_D_Output_CvarChange(Handle convar, char oldValue[], char newValue[])
{
	g_iOutputFlags = StringToInt(newValue, 10);
	return 0;
}

public Action _H_D_Status_Command(int client, int args)
{
	int channelFlag;
	char channelName[64];
	char buffer[64];
	char result[2048];
	int channelCounter = 0;
	Format(result, 2048, "\n==================================================\n");
	Format(result, 2048, "%s%s\n\n  Debug status:\n    Current channel flag: %i\n    Current output flag: %i\n\n", result, "L4D2 Melee Fatigue Control", g_iChannelFlags, g_iOutputFlags);
	Format(result, 2048, "%s  Channel Listing:\n    Index. Name - Flag \n    -----\n", result);
	int i = 0;
	while (i < g_iNextChannel_Index)
	{
		Format(buffer, 64, "%s%s", i, SETTINGS_FLAG_KEY);
		if (GetTrieValue(g_hChannelsTrie, buffer, channelFlag))
		{
			Format(buffer, 64, "%s%s", i, SETTINGS_NAME_KEY);
			if (!GetTrieString(g_hChannelsTrie, buffer, channelName, 64, 0))
			{
			}
			else
			{
				Format(result, 2048, "%s    %i. \"%s\" - %i\n", result, i, channelName, channelFlag);
				channelCounter++;
			}
		}
		i++;
	}
	Format(result, 2048, "%s    -----\n    Total channels: %i\n\n", result, channelCounter);
	Format(result, 2048, "%s==================================================\n", result);
	if (client)
	{
		ReplyToCommand(client, "[%s] Debug status printed to console", "l4d2_meleecontrol");
		PrintToConsole(client, result);
	}
	else
	{
		PrintToServer(result);
	}
	return Action 3;
}

int DebugAddChannel(char channelName[])
{
	if (!SetupModule())
	{
		ThrowError("Unable to set up debug trie!");
	}
	int channelIndex = g_iNextChannel_Index;
	int channelFlag = g_iNextChannel_Flag;
	char buffer[64];
	Format(buffer, 64, "%s%s", channelIndex, SETTINGS_FLAG_KEY);
	SetTrieValue(g_hChannelsTrie, buffer, channelFlag, true);
	Format(buffer, 64, "%s%s", channelIndex, SETTINGS_NAME_KEY);
	SetTrieString(g_hChannelsTrie, buffer, channelName, true);
	g_iNextChannel_Index += 1;
	g_iNextChannel_Flag = g_iNextChannel_Flag * 2;
	return channelIndex;
}


/* ERROR! Índice fuera de los límites de la matriz. */
 function "DebugPrintToAll" (number 7)
bool SetupModule()
{
	if (g_bIsModuleSetup)
	{
		return true;
	}
	g_hChannelsTrie = CreateTrie();
	if (g_hChannelsTrie)
	{
		char buffer[64];
		Format(buffer, 64, "%s%s", 0, SETTINGS_FLAG_KEY);
		SetTrieValue(g_hChannelsTrie, buffer, any 0, true);
		Format(buffer, 64, "%s%s", 0, SETTINGS_NAME_KEY);
		SetTrieString(g_hChannelsTrie, buffer, CHANNEL_GENERAL_NAME, true);
		Handle cvar = CreateConVarEx("debug_channel", "0", "Sum of debug channel flags. -1 - Log all channels, 0 - General channel only, 0+ - Log channel of flag", 262144, false, 0, false, 0);
		g_iChannelFlags = GetConVarInt(cvar);
		HookConVarChange(cvar, ConVarChanged 57);
		cvar = CreateConVarEx("debug_output", "0", "Sum of debug output flags. 0 - No logging, 1 - Print to server, 2 - Print to chat, 4 - Log to SM logs", 262144, false, 0, false, 0);
		g_iOutputFlags = GetConVarInt(cvar);
		HookConVarChange(cvar, ConVarChanged 59);
		RegAdminCmdEx("debug_status", _H_D_Status_Command, 16384, "Writes report of channels and what is current listen to", "", 262144);
		g_bIsModuleSetup = 1;
		return true;
	}
	return false;
}


/* ERROR! Índice fuera de los límites de la matriz. */
 function "OnPluginStart" (number 9)
public int OnPluginEnd()
{
	Call_StartForward(g_hEventForwards[0][0]);
	Call_Finish(0);
	return 0;
}

public int OnMapStart()
{
	Call_StartForward(g_hEventForwards[12][0]);
	Call_Finish(0);
	return 0;
}

public int OnMapEnd()
{
	Call_StartForward(g_hEventForwards[16][0]);
	Call_Finish(0);
	return 0;
}

public int OnClientConnected(int client)
{
	Call_StartForward(g_hEventForwards[20][0]);
	Call_PushCell(client);
	Call_Finish(0);
	return 0;
}

public int OnClientPutInServer(int client)
{
	Call_StartForward(g_hEventForwards[24][0]);
	Call_PushCell(client);
	Call_Finish(0);
	return 0;
}

public int OnClientDisconnect_Post(int client)
{
	Call_StartForward(g_hEventForwards[28][0]);
	Call_PushCell(client);
	Call_Finish(0);
	return 0;
}

public int OnClientPostAdminCheck(int client)
{
	Call_StartForward(g_hEventForwards[32][0]);
	Call_PushCell(client);
	Call_Finish(0);
	return 0;
}

public int OnEntityCreated(int entity, char classname[])
{
	int var1;
	if (entity <= 2048)
	{
		Call_StartForward(g_hEventForwards[36][0]);
		Call_PushCell(entity);
		Call_PushString(classname);
		Call_Finish(0);
	}
	return 0;
}

public int OnEntityDestroyed(int entity)
{
	int var1;
	if (entity <= 2048)
	{
		Call_StartForward(g_hEventForwards[40][0]);
		Call_PushCell(entity);
		Call_Finish(0);
	}
	return 0;
}

public Action OnPlayerRunCmd(int client, &int buttons, &int impulse, float vel[3], float angles[3], &int weapon)
{
	Call_StartForward(g_hEventForwards[44][0]);
	Call_PushCell(client);
	Call_PushCellRef(buttons);
	Call_PushCellRef(impulse);
	Call_PushArray(vel, 3);
	Call_PushArray(angles, 3);
	Call_PushCellRef(weapon);
	Call_Finish(0);
	return Action 0;
}

bool HookPublicEvent(EVENT_TYPE type, Function func)
{
	Handle fwd = GetEventForward(type);
	if (fwd)
	{
		return AddToForward(fwd, Handle 0, func);
	}
	return false;
}

bool UnhookPublicEvent(EVENT_TYPE type, Function func)
{
	Handle fwd = GetEventForward(type);
	if (fwd)
	{
		return RemoveFromForward(fwd, Handle 0, func);
	}
	return false;
}

int SetPluginState(bool enabled)
{
	if (enabled == g_bIsPluginEnabled)
	{
		return 0;
	}
	g_bIsPluginEnabled = enabled;
	if (enabled)
	{
		Call_StartForward(g_hEventForwards[4][0]);
		Call_Finish(0);
	}
	else
	{
		Call_StartForward(g_hEventForwards[8][0]);
		Call_Finish(0);
	}
	return 0;
}

Handle GetEventForward(EVENT_TYPE type)
{
	int i = 0;
	while (i < 12)
	{
		if (type == i)
		{
			return g_hEventForwards[i][0][0];
		}
		i++;
	}
	return Handle 0;
}

public int _H_CommandManager_OnPluginStart()
{
	g_aSayCommands = CreateArray(MAX_COMMAND_LENGTH, 0);
	AddCommandListener(CommandListener 3, "say");
	AddCommandListener(CommandListener 3, "say_team");
	return 0;
}

public Action H_CM_Say_Command(int client, char command[], int argc)
{
	int var1;
	if (argc == 1)
	{
		return Action 0;
	}
	char buffer[128];
	bool bHide;
	GetCmdArg(1, buffer, 128);
	int pos;
	int var2 = StrContains(buffer, PRIVAT_TRIGGER, true);
	pos = var2;
	if (var2)
	{
		int var3 = StrContains(buffer, PUBLIC_TRIGGER, true);
		pos = var3;
		if (var3)
		{
			return Action 0;
		}
		bHide = 0;
	}
	else
	{
		bHide = 1;
	}
	strcopy(buffer, 128, buffer[pos + 1]);
	if (FindStringInArray(g_aSayCommands, buffer) != -1)
	{
		if (StrContains(buffer, "l4d2_meleecontrol", false) == -1)
		{
			Format(buffer, 128, "%s_%s", "l4d2_meleecontrol", buffer);
		}
		FakeClientCommandEx(client, buffer);
		if (bHide)
		{
			return Action 3;
		}
	}
	return Action 0;
}

public int _H_ClientIndexes_OnPluginStart()
{
	HookPublicEvent(EVENT_TYPE 1, _CI_OnPluginEnabled);
	HookPublicEvent(EVENT_TYPE 2, _CI_OnPluginDisabled);
	HookPublicEvent(EVENT_TYPE 3, _CI_OnMapStart);
	HookPublicEvent(EVENT_TYPE 4, _CI_OnMapEnd);
	g_iDebugChannel = DebugAddChannel(DEBUG_CHANNEL_NAME);
	DebugPrintToAllEx("Module is now setup");
	return 0;
}

public int _CI_OnPluginEnabled()
{
	RebuildIndex();
	HookEvent("round_start", EventHook 41, EventHookMode 2);
	HookEvent("round_end", EventHook 41, EventHookMode 2);
	HookEvent("player_team", EventHook 41, EventHookMode 2);
	HookEvent("player_spawn", EventHook 39, EventHookMode 2);
	HookEvent("player_disconnect", EventHook 39, EventHookMode 2);
	HookEvent("player_death", EventHook 39, EventHookMode 2);
	HookEvent("player_bot_replace", EventHook 39, EventHookMode 2);
	HookEvent("bot_player_replace", EventHook 39, EventHookMode 2);
	DebugPrintToAllEx("Module is now loaded");
	return 0;
}

public int _CI_OnPluginDisabled()
{
	UnhookEvent("round_start", EventHook 41, EventHookMode 2);
	UnhookEvent("round_end", EventHook 41, EventHookMode 2);
	UnhookEvent("player_team", EventHook 41, EventHookMode 2);
	UnhookEvent("player_spawn", EventHook 39, EventHookMode 2);
	UnhookEvent("player_disconnect", EventHook 39, EventHookMode 2);
	UnhookEvent("player_death", EventHook 39, EventHookMode 2);
	UnhookEvent("player_bot_replace", EventHook 39, EventHookMode 2);
	UnhookEvent("bot_player_replace", EventHook 39, EventHookMode 2);
	ResetCounts();
	DebugPrintToAllEx("Module is now unloaded");
	return 0;
}

public int _CI_OnMapStart()
{
	ResetCounts();
	DebugPrintToAllEx("Map start, resetting indexes");
	return 0;
}

public int _CI_OnMapEnd()
{
	ResetCounts();
	DebugPrintToAllEx("Map end, resetting indexes");
	return 0;
}

public int _CI_Event_TempStop_Event(Handle event, char name[], bool dontBroadcast)
{
	DebugPrintToAllEx("Event \"%s\" was fired, rebuild indexes in %f secs", name, REBUILD_DELAY);
	ResetCounts();
	CreateTimer(REBUILD_DELAY, _CI_RebuildIndex_Timer, any 0, 0);
	return 0;
}

public int _CI_Event(Handle event, char name[], bool dontBroadcast)
{
	DebugPrintToAllEx("Event \"%s\" was fired, rebuild indexes", name);
	RebuildIndex();
	return 0;
}

public Action _CI_RebuildIndex_Timer(Handle timer)
{
	DebugPrintToAllEx("Rebuild index timer executed, rebuilding indexes");
	RebuildIndex();
	return Action 0;
}

int RebuildIndex()
{
	ResetCounts();
	if (!IsServerProcessing())
	{
		return 0;
	}
	int team;
	int i = 1;
	while (i <= MaxClients)
	{
		if (IsClientInGame(i))
		{
			team = GetClientTeam(i);
			switch (team)
			{
				case 1: {
					SpectateIndex[SpectateCount] = i;
					SpectateCount += 1;
				}
				case 2: {
					if (!IsPlayerAlive(i))
					{
					}
					else
					{
						SurvivorIndex[SurvivorCount] = i;
						SurvivorCount += 1;
					}
				}
				case 3: {
					InfectedIndex[InfectedCount] = i;
					InfectedCount += 1;
				}
				default: {
				}
			}
		}
		i++;
	}
	DebugPrintToAllEx("Indexes is now rebuild. Survivor count: %i, Infected count: %i, Spectate count: %i", 1468, 1732, 1996);
	return 0;
}

int ResetCounts()
{
	SurvivorCount = 0;
	InfectedCount = 0;
	SpectateCount = 0;
	return 0;
}

int DebugPrintToAllEx(char format[])
{
	char buffer[1024];
	VFormat(buffer, 1024, format, 2);
	DebugPrintToAll(g_iDebugChannel, buffer);
	return 0;
}

public int _H_TankManager_OnPluginStart()
{
	HookPublicEvent(EVENT_TYPE 1, _H_TM_OnPluginEnabled);
	HookPublicEvent(EVENT_TYPE 2, _H_TM_OnPluginDisabled);
	g_iOffset_Frustration = FindSendPropInfo(CLASSNAME_TANK, NETPROP_FRUSTRATION, 0, 0, 0);
	g_iOffset_Incapacitated = FindSendPropInfo(CLASSNAME_TANK, NETPROP_INCAPACITATED, 0, 0, 0);
	g_iDebugChannel = DebugAddChannel(DEBUG_CHANNEL_NAME);
	DebugPrintToAllEx("Module is now setup");
	return 0;
}

public int _H_TM_OnPluginEnabled()
{
	g_bIsTankInPlay = 0;
	g_iTankClient = 0;
	HookEvent("tank_spawn", EventHook 75, EventHookMode 1);
	HookEvent("player_death", EventHook 71, EventHookMode 1);
	HookEvent("round_start", EventHook 69, EventHookMode 1);
	HookPublicEvent(EVENT_TYPE 7, _H_TM_OnClientDisconnect_Post);
	g_hFwd_TankSpawn = CreateForward(ExecType 0);
	g_hFwd_TankKilled = CreateForward(ExecType 0);
	g_hFwd_TankPassed = CreateForward(ExecType 0);
	DebugPrintToAllEx("Module is now loaded");
	return 0;
}

public int _H_TM_OnPluginDisabled()
{
	UnhookEvent("tank_spawn", EventHook 75, EventHookMode 1);
	UnhookEvent("player_death", EventHook 71, EventHookMode 1);
	UnhookEvent("round_start", EventHook 69, EventHookMode 1);
	UnhookPublicEvent(EVENT_TYPE 7, _H_TM_OnClientDisconnect_Post);
	g_bIsTankInPlay = 0;
	g_iTankClient = 0;
	RemoveAllFromForward(g_hFwd_TankSpawn, Handle 0);
	CloseHandle(g_hFwd_TankSpawn);
	RemoveAllFromForward(g_hFwd_TankKilled, Handle 0);
	CloseHandle(g_hFwd_TankKilled);
	RemoveAllFromForward(g_hFwd_TankPassed, Handle 0);
	CloseHandle(g_hFwd_TankPassed);
	DebugPrintToAllEx("Module is now unloaded");
	return 0;
}

public int _H_TM_OnClientDisconnect_Post(int client)
{
	int var1;
	if (!g_bIsTankInPlay)
	{
		return 0;
	}
	DebugPrintToAllEx("Tank client left the game, find new tank client");
	CreateTimer(0,1, _H_TM_TankKilled_Timer, client, 0);
	return 0;
}

public int _H_TM_RoundStart_Event(Handle event, char name[], bool dontBroadcast)
{
	DebugPrintToAllEx("Round start; reset vars");
	g_bIsTankInPlay = 0;
	return 0;
}

public int _H_TM_TankSpawn_Event(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	g_iTankClient = client;
	if (g_bIsTankInPlay)
	{
		DebugPrintToAllEx("Tank spawned, updated tank client var. Client %i: \"%N\"", client, client);
		Call_StartForward(g_hFwd_TankPassed);
		Call_Finish(0);
		return 0;
	}
	DebugPrintToAllEx("Tank spawned, tank is now in play. Client %i: \"%N\"", client, client);
	g_bIsTankInPlay = 1;
	Call_StartForward(g_hFwd_TankSpawn);
	Call_Finish(0);
	return 0;
}

public int _H_TM_TankKilled_Event(Handle event, char name[], bool dontBroadcast)
{
	if (!g_bIsTankInPlay)
	{
		return 0;
	}
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	if (g_iTankClient != client)
	{
		return 0;
	}
	DebugPrintToAllEx("Tank was killed, find new tank client. Client %i: \"%N\"", client, client);
	CreateTimer(0,1, _H_TM_TankKilled_Timer, client, 0);
	return 0;
}

public Action _H_TM_TankKilled_Timer(Handle timer, any oldtankclient)
{
	if (oldtankclient != g_iTankClient)
	{
		return Action 0;
	}
	int tankclient = FindTankClient();
	int var1;
	if (tankclient)
	{
		g_iTankClient = tankclient;
		DebugPrintToAllEx("Found new tank client. Client %i: \"%N\"", tankclient, tankclient);
		Call_StartForward(g_hFwd_TankPassed);
		Call_Finish(0);
		return Action 0;
	}
	DebugPrintToAllEx("Tank was killed and is no longer in play. Forward event");
	g_bIsTankInPlay = 0;
	Call_StartForward(g_hFwd_TankKilled);
	Call_Finish(0);
	return Action 0;
}

int FindTankClient()
{
	int client = 1;
	while (client <= MaxClients)
	{
		int var1;
		if (!IsClientInGame(client))
		{
			client++;
		}
		client++;
	}
	return 0;
}

int DebugPrintToAllEx(char format[])
{
	char buffer[1024];
	VFormat(buffer, 1024, format, 2);
	DebugPrintToAll(g_iDebugChannel, buffer);
	return 0;
}

Handle CreateConVarEx(char name[], char defaultValue[], char description[], int flags, bool hasMin, float min, bool hasMax, float max)
{
	char buffer[256];
	Format(buffer, 256, TEAMNAME_SPECTATOR, "l4d2_meleecontrol", name);
	return CreateConVar(buffer, defaultValue, description, flags, hasMin, min, hasMax, max);
}

int RegAdminCmdEx(char cmd[], ConCmd callback, int adminflags, char description[], char group[], int flags)
{
	char buffer[256];
	Format(buffer, 256, "%s_%s", "l4d2_meleecontrol", cmd);
	RegAdminCmd(buffer, callback, adminflags, description, group, flags);
	return 0;
}

public int _MeleeFatigue_OnPluginStart()
{
	HookPublicEvent(EVENT_TYPE 1, _MF_OnPluginEnabled);
	HookPublicEvent(EVENT_TYPE 2, _MF_OnPluginDisabled);
	CreateIntConVar(3560, "melee_penalty", "Sets the value to be added to a survivor's shove penalty.  This _only_ gets added when that survivor is not already fatigued (so basically, setting this to a large value will make the survivors become fatigued more quickly, but the cooldown effect won't change once fatigue has set in)", g_nonFatiguedMeleePenalty);
	UpdateNonFatiguedMeleePenalty();
	g_iDebugChannel = DebugAddChannel(DEBUG_CHANNEL_NAME);
	DebugPrintToAllEx("Module is now setup.", 3832);
	return 0;
}

int CreateIntConVar(&Handle conVar, char cvarName[], char cvarDescription[], int initialValue)
{
	char buffer[12];
	IntToString(initialValue, buffer, 10);
	conVar = CreateConVarEx(cvarName, buffer, cvarDescription, 262400, false, 0, false, 0);
	if (!conVar)
	{
		ThrowError("Unable to create enable cvar named %s!", cvarName);
	}
	return 0;
}

public int _MF_OnPluginEnabled()
{
	UpdateNonFatiguedMeleePenalty();
	AddNormalSoundHook(NormalSHook 5);
	HookConVarChange(g_hNonFatiguedMeleePenalty_CVAR, ConVarChanged 79);
	DebugPrintToAllEx("Module is now loaded");
	return 0;
}

public int _MF_OnPluginDisabled()
{
	RemoveNormalSoundHook(NormalSHook 5);
	UnhookConVarChange(g_hNonFatiguedMeleePenalty_CVAR, ConVarChanged 79);
	DebugPrintToAllEx("Module is now unloaded");
	return 0;
}

public int _MF_MeleePenalty_CvarChange(Handle convar, char oldValue[], char newValue[])
{
	DebugPrintToAllEx("melee penalty changed. Old value %s, new value %s", oldValue, newValue);
	UpdateNonFatiguedMeleePenalty();
	return 0;
}

public Action HookSound_Callback(int Clients[64], &int NumClients, char StrSample[256], &int Entity)
{
	if (!ShouldPerformCustomFatigueLogic(StrSample, Entity))
	{
		return Action 0;
	}
	soundHookDelay[Entity] = 1;
	CreateTimer(MELEE_DURATION, ResetsoundHookDelay, Entity, 0);
	int shovePenalty = L4D_GetMeleeFatigue(Entity) + -1;
	if (0 > shovePenalty)
	{
		shovePenalty = 0;
	}
	DebugPrintToAllEx("Current shove penalty: %i", shovePenalty);
	if (shovePenalty >= MAX_EXISTING_FATIGUE)
	{
		DebugPrintToAllEx("Current shove penalty is %i, aborting", shovePenalty);
		return Action 0;
	}
	int newFatigue = g_nonFatiguedMeleePenalty + shovePenalty;
	L4D_SetMeleeFatigue(Entity, newFatigue);
	DebugPrintToAllEx("Set shove penalty to %i", newFatigue);
	return Action 0;
}

int L4D_GetMeleeFatigue(int client)
{
	return GetEntProp(client, PropType 0, "m_iShovePenalty", 4);
}

int L4D_SetMeleeFatigue(int client, int value)
{
	SetEntProp(client, PropType 0, "m_iShovePenalty", value, 4);
	return 0;
}

public Action ResetsoundHookDelay(Handle timer, any client)
{
	soundHookDelay[client] = 0;
	return Action 0;
}

bool ShouldPerformCustomFatigueLogic(char StrSample[256], int entity)
{
	if (g_nonFatiguedMeleePenalty <= 1)
	{
		return false;
	}
	if (entity > 64)
	{
		return false;
	}
	if (soundHookDelay[entity][0][0])
	{
		return false;
	}
	if (StrContains(StrSample, MELEE_SOUND_NAME_SEARCH, false) == -1)
	{
		return false;
	}
	return true;
}

int UpdateNonFatiguedMeleePenalty()
{
	g_nonFatiguedMeleePenalty = GetConVarInt(g_hNonFatiguedMeleePenalty_CVAR);
	DebugPrintToAllEx("Updated non fatigued melee penalty global var; %b", 3556);
	return 0;
}

int DebugPrintToAllEx(char format[])
{
	char buffer[1024];
	VFormat(buffer, 1024, format, 2);
	DebugPrintToAll(g_iDebugChannel, buffer);
	return 0;
}

public APLRes AskPluginLoad2(Handle myself, bool late, char error[], int err_max)
{
	if (!IsDedicatedServer())
	{
		strcopy(error, err_max, "Plugin only support dedicated servers");
		return APLRes 1;
	}
	char buffer[128];
	GetGameFolderName(buffer, 128);
	if (!StrEqual(buffer, "left4dead2", false))
	{
		strcopy(error, err_max, "Plugin only support Left 4 Dead 2");
		return APLRes 1;
	}
	return APLRes 0;
}

public int OnPluginStartEx()
{
	DebugPrintToAll(0, "[Main] Setting up...");
	char buffer[128];
	Format(buffer, 128, "%s version", "L4D2 Melee Fatigue Control");
	Handle convar = CreateConVarEx("version", "0.0.2", buffer, 262400, false, 0, false, 0);
	SetConVarString(convar, "0.0.2", false, false);
	if (GetMaxEntities() > 2048)
	{
		ThrowError("Max entities exceeded, %d. Plugin needs a recompile with a updated max entity const, current value %d.", GetMaxEntities(), 2048);
	}
	_MeleeFatigue_OnPluginStart();
	Format(buffer, 128, "Sets whether %s is enabled", "L4D2 Melee Fatigue Control");
	convar = CreateConVarEx("enable", "0", buffer, 262400, false, 0, false, 0);
	if (!convar)
	{
		ThrowError("Unable to create main enable cvar!");
	}
	int var1;
	if (GetConVarBool(convar))
	{
		SetConVarBool(convar, false, false, false);
		DebugPrintToAll(0, "[Main] Unable to enable rotoblin, running on a listen server!");
	}
	else
	{
		SetPluginState(GetConVarBool(convar));
	}
	HookConVarChange(convar, ConVarChanged 85);
	DebugPrintToAll(0, "[Main] Done setting up!");
	return 0;
}

public int OnAllPluginsLoaded()
{
	if (LibraryExists("zack"))
	{
		g_bIsZACKLoaded = 1;
	}
	else
	{
		g_bIsZACKLoaded = 0;
	}
	return 0;
}

public int OnLibraryRemoved(char name[])
{
	if (StrEqual(name, "zack", true))
	{
		g_bIsZACKLoaded = 0;
	}
	return 0;
}

public int OnLibraryAdded(char name[])
{
	if (StrEqual(name, "zack", true))
	{
		g_bIsZACKLoaded = 1;
	}
	return 0;
}

public int _Main_Enable_CvarChange(Handle convar, char oldValue[], char newValue[])
{
	DebugPrintToAll(0, "[Main] Enable cvar was changed. Old value %s, new value %s", oldValue, newValue);
	int var1;
	if (GetConVarBool(convar))
	{
		SetConVarBool(convar, false, false, false);
		DebugPrintToAll(0, "[Main] Unable to enable rotoblin, running on a listen server!");
		PrintToChatAll("[%s] Unable to enable %s! %s only support dedicated servers", 5336, 5356, 5384);
		return 0;
	}
	SetPluginState(StringToInt(newValue, 10));
	return 0;
}

