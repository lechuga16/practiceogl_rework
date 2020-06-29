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
 int g_iDominators = 53;
 Address g_pDominatorsAddress;
 Handle g_hCvarDominators;
public Plugin myinfo =
{
	name = "Dominators Control",
	description = "Changes bIsDominator flag for infected classes. Allows to have native-order qu",
	author = "vintik",
	version = "1.1",
	url = "https://bitbucket.org/vintik/various-plugins"
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

public int OnPluginStart()
{
	char sGame[256];
	GetGameFolderName(sGame, 256);
	if (!StrEqual(sGame, "left4dead2", false))
	{
		SetFailState("Plugin 'Dominators Control' supports Left 4 Dead 2 only!");
	}
	Handle hGConf = LoadGameConfigFile("l4d2_dominators");
	int var1;
	if (hGConf)
	{
		SetFailState("Can't find 'bIsDominator' signature!");
	}
	g_hCvarDominators = CreateConVar("l4d2_dominators", "53", "Which infected class is considered as dominator (bitmask: 1 - smoker, 2 - boomer, 4 - hunter, 8 - spitter, 16 - jockey, 32 - charger)", 262208, false, 0, false, 0);
	int iCvarValue = GetConVarInt(g_hCvarDominators);
	if (!IsValidCvarValue(iCvarValue))
	{
		SetConVarInt(g_hCvarDominators, 53, false, false);
		iCvarValue = 53;
	}
	if (iCvarValue != g_iDominators)
	{
		g_iDominators = iCvarValue;
		SetDominators();
	}
	HookConVarChange(g_hCvarDominators, ConVarChanged 1);
	return 0;
}

public int OnPluginEnd()
{
	g_iDominators = 53;
	SetDominators();
	return 0;
}

public int OnCvarDominatorsChange(Handle hCvar, char sOldVal[], char sNewVal[])
{
	int iNewVal = StringToInt(sNewVal, 10);
	if (g_iDominators == iNewVal)
	{
		return 0;
	}
	if (IsValidCvarValue(iNewVal))
	{
		g_iDominators = iNewVal;
		SetDominators();
	}
	else
	{
		PrintToChatAll("[SM] Incorrect value of 'sm_dominators'! min: 0, max: %d", 63);
		SetConVarString(hCvar, sOldVal, false, false);
	}
	return 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "IsValidCvarValue" (number 6)
int SetDominators()
{
	bool bIsDominator = 0;
	int i = 0;
	while (i < 6)
	{
		bIsDominator = g_iDominators & 1 << i != 0;
		StoreToAddress(i + g_pDominatorsAddress, bIsDominator, NumberType 0);
		i++;
	}
	return 0;
}

