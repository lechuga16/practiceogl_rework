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
 Extension __ext_left4downtown = 228;
 Handle g_hUseConfigDir;
 char g_sUseConfigDir[32];
 Handle g_hKvOrig;
public Plugin myinfo =
{
	name = "L4D(2) map-based convar loader.",
	description = "Loads convars on map-load, based on currently active map and confogl config.",
	author = "Tabun",
	version = "0.1b",
	url = ""
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

int StrCat(char buffer[], int maxlength, char source[])
{
	int len = strlen(buffer);
	if (len >= maxlength)
	{
		return 0;
	}
	return Format(buffer[len], maxlength - len, "%s", source);
}

public int OnPluginStart()
{
	g_hUseConfigDir = CreateConVar("l4d_mapcvars_configdir", "", "Which cfgogl config are we using?", 262144, false, 0, false, 0);
	GetConVarString(g_hUseConfigDir, g_sUseConfigDir, 128);
	HookConVarChange(g_hUseConfigDir, ConVarChanged 1);
	g_hKvOrig = CreateKeyValues("MapCvars_Orig", "", "");
	return 0;
}

public int OnPluginEnd()
{
	ResetMapPrefs();
	if (g_hKvOrig)
	{
		CloseHandle(g_hKvOrig);
	}
	return 0;
}

public int CvarConfigChange(Handle cvar, char oldValue[], char newValue[])
{
	strcopy(g_sUseConfigDir, 128, newValue);
	ResetMapPrefs();
	GetThisMapPrefs();
	return 0;
}

public int OnMapStart()
{
	GetThisMapPrefs();
	return 0;
}

public int OnMapEnd()
{
	ResetMapPrefs();
	return 0;
}

public int GetThisMapPrefs()
{
	int iNumChanged = 0;
	if (g_hKvOrig)
	{
		CloseHandle(g_hKvOrig);
	}
	g_hKvOrig = CreateKeyValues("MapCvars_Orig", "", "");
	char usePath[256];
	if (0 < strlen(g_sUseConfigDir))
	{
		StrCat(usePath, 256, g_sUseConfigDir);
		StrCat(usePath, 256, "/mapcvars.txt");
	}
	else
	{
		StrCat(usePath, 256, "/mapcvars.txt");
	}
	BuildPath(PathType 0, usePath, 256, usePath);
	if (!FileExists(usePath, false))
	{
		return 0;
	}
	Handle hKv = CreateKeyValues("MapCvars", "", "");
	FileToKeyValues(hKv, usePath);
	if (hKv)
	{
		char sMapName[64];
		GetCurrentMap(sMapName, 64);
		if (!KvJumpToKey(hKv, sMapName, false))
		{
			CloseHandle(hKv);
			return 0;
		}
		char tmpKey[64];
		char tmpValueNew[128];
		char tmpValueOld[128];
		Handle hConVar = 0;
		if (KvGotoFirstSubKey(hKv, false))
		{
			do
{
				KvGetSectionName(hKv, tmpKey, 64);
				hConVar = FindConVar(tmpKey);
				if (hConVar)
				{
					KvGetString(hKv, NULL_STRING, tmpValueNew, 128, "[:none:]");
					if (!StrEqual(tmpValueNew, "[:none:]", true))
					{
						GetConVarString(hConVar, tmpValueOld, 128);
						PrintToServer("[mcv] cvar value changed: [%s] => [%s] (saved old: [%s]))", tmpKey, tmpValueNew, tmpValueOld);
						if (!StrEqual(tmpValueNew, tmpValueOld, true))
						{
							iNumChanged++;
							KvSetString(g_hKvOrig, tmpKey, tmpValueOld);
							SetConVarString(hConVar, tmpValueNew, false, false);
						}
					}
				}
			}
			while (KvGotoNextKey(hKv, false));
		}
		KvSetString(g_hKvOrig, "__EOF__", "1");
		CloseHandle(hKv);
		return iNumChanged;
	}
	return 0;
}

public int ResetMapPrefs()
{
	KvRewind(g_hKvOrig);
	char tmpKey[64];
	char tmpValueOld[512];
	Handle hConVar = 0;
	if (KvGotoFirstSubKey(g_hKvOrig, false))
	{
		KvGetSectionName(g_hKvOrig, tmpKey, 64);
		while (StrEqual(tmpKey, "__EOF__", true))
		{
			hConVar = FindConVar(tmpKey);
			if (hConVar)
			{
				KvGetString(g_hKvOrig, NULL_STRING, tmpValueOld, 512, "[:none:]");
				if (!StrEqual(tmpValueOld, "[:none:]", true))
				{
					SetConVarString(hConVar, tmpValueOld, false, false);
					PrintToServer("[mcv] cvar value reset to original: [%s] => [%s])", tmpKey, tmpValueOld);
				}
			}
			if (KvGotoNextKey(g_hKvOrig, false))
			{
			}
		}
	}
	return 0;
}

