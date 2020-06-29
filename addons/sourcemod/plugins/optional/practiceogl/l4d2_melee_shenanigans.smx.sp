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
 Extension __ext_core = 68;
 int MaxClients;
 Extension __ext_left4downtown = 2220;
 Extension __ext_sdkhooks = 2272;
 Extension __ext_sdktools = 2316;
 ConVar hDropMethod;
 int iDropMethod;
public Plugin myinfo =
{
	name = "Shove Shenanigans - REVAMPED",
	description = "Stops Shoves slowing the Tank and Charger, gives control over what happens when a Survivor is punched while having a melee out.",
	author = "Sir",
	version = "1.2",
	url = ""
};
public void __ext_core_SetNTVOptional()
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
	MarkNativeAsOptional("BfWriteEntity");
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
	MarkNativeAsOptional("BfWrite.WriteBool");
	MarkNativeAsOptional("BfWrite.WriteByte");
	MarkNativeAsOptional("BfWrite.WriteChar");
	MarkNativeAsOptional("BfWrite.WriteShort");
	MarkNativeAsOptional("BfWrite.WriteWord");
	MarkNativeAsOptional("BfWrite.WriteNum");
	MarkNativeAsOptional("BfWrite.WriteFloat");
	MarkNativeAsOptional("BfWrite.WriteString");
	MarkNativeAsOptional("BfWrite.WriteEntity");
	MarkNativeAsOptional("BfWrite.WriteAngle");
	MarkNativeAsOptional("BfWrite.WriteCoord");
	MarkNativeAsOptional("BfWrite.WriteVecCoord");
	MarkNativeAsOptional("BfWrite.WriteVecNormal");
	MarkNativeAsOptional("BfWrite.WriteAngles");
	MarkNativeAsOptional("BfRead.ReadBool");
	MarkNativeAsOptional("BfRead.ReadByte");
	MarkNativeAsOptional("BfRead.ReadChar");
	MarkNativeAsOptional("BfRead.ReadShort");
	MarkNativeAsOptional("BfRead.ReadWord");
	MarkNativeAsOptional("BfRead.ReadNum");
	MarkNativeAsOptional("BfRead.ReadFloat");
	MarkNativeAsOptional("BfRead.ReadString");
	MarkNativeAsOptional("BfRead.ReadEntity");
	MarkNativeAsOptional("BfRead.ReadAngle");
	MarkNativeAsOptional("BfRead.ReadCoord");
	MarkNativeAsOptional("BfRead.ReadVecCoord");
	MarkNativeAsOptional("BfRead.ReadVecNormal");
	MarkNativeAsOptional("BfRead.ReadAngles");
	MarkNativeAsOptional("BfRead.BytesLeft.get");
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
	MarkNativeAsOptional("Protobuf.ReadInt");
	MarkNativeAsOptional("Protobuf.ReadFloat");
	MarkNativeAsOptional("Protobuf.ReadBool");
	MarkNativeAsOptional("Protobuf.ReadString");
	MarkNativeAsOptional("Protobuf.ReadColor");
	MarkNativeAsOptional("Protobuf.ReadAngle");
	MarkNativeAsOptional("Protobuf.ReadVector");
	MarkNativeAsOptional("Protobuf.ReadVector2D");
	MarkNativeAsOptional("Protobuf.GetRepeatedFieldCount");
	MarkNativeAsOptional("Protobuf.SetInt");
	MarkNativeAsOptional("Protobuf.SetFloat");
	MarkNativeAsOptional("Protobuf.SetBool");
	MarkNativeAsOptional("Protobuf.SetString");
	MarkNativeAsOptional("Protobuf.SetColor");
	MarkNativeAsOptional("Protobuf.SetAngle");
	MarkNativeAsOptional("Protobuf.SetVector");
	MarkNativeAsOptional("Protobuf.SetVector2D");
	MarkNativeAsOptional("Protobuf.AddInt");
	MarkNativeAsOptional("Protobuf.AddFloat");
	MarkNativeAsOptional("Protobuf.AddBool");
	MarkNativeAsOptional("Protobuf.AddString");
	MarkNativeAsOptional("Protobuf.AddColor");
	MarkNativeAsOptional("Protobuf.AddAngle");
	MarkNativeAsOptional("Protobuf.AddVector");
	MarkNativeAsOptional("Protobuf.AddVector2D");
	MarkNativeAsOptional("Protobuf.RemoveRepeatedFieldValue");
	MarkNativeAsOptional("Protobuf.ReadMessage");
	MarkNativeAsOptional("Protobuf.ReadRepeatedMessage");
	MarkNativeAsOptional("Protobuf.AddMessage");
	VerifyCoreVersion();
	return void 0;
}

public bool StrEqual(char str1[], char str2[], bool caseSensitive)
{
	return strcmp(str1, str2, caseSensitive) == 0;
}

public void OnPluginStart()
{
	HookEvent("player_hurt", EventHook 17, EventHookMode 1);
	hDropMethod = CreateConVar("l4d2_melee_drop_method", "2", "What to do when a Tank punches a Survivor that's holding out a melee weapon? 0: Nothing. 1: Drop Melee Weapon. 2: Force Switch to Primary Weapon.", 0, false, 0, false, 0);
	iDropMethod = GetConVarInt(hDropMethod);
	ConVar.AddChangeHook(hDropMethod, ConVarChanged 9);
	return void 0;
}

public Action PlayerHit(Handle event, char event_name[], bool dontBroadcast)
{
	int Player = GetClientOfUserId(GetEventInt(event, "userid", 0));
	char Weapon[256];
	GetEventString(event, "weapon", Weapon, 256, "");
	int var1;
	if (IsSurvivor(Player))
	{
		int activeweapon = GetEntPropEnt(Player, PropType 0, "m_hActiveWeapon", 0);
		if (IsValidEdict(activeweapon))
		{
			char weaponname[64];
			GetEdictClassname(activeweapon, weaponname, 64);
			int var2;
			if (StrEqual(weaponname, "weapon_melee", false))
			{
				switch (iDropMethod)
				{
					case 0: {
						return Action 0;
					}
					case 1: {
						SDKHooks_DropWeapon(Player, activeweapon, NULL_VECTOR, NULL_VECTOR);
					}
					case 2: {
						int PrimaryWeapon = GetPlayerWeaponSlot(Player, 0);
						SetEntPropEnt(Player, PropType 0, "m_hActiveWeapon", PrimaryWeapon, 0);
					}
					default: {
					}
				}
			}
		}
	}
	return Action 0;
}

public Action L4D_OnShovedBySurvivor(int shover, int shovee, float vector[3])
{
	int var1;
	if (!IsSurvivor(shover))
	{
		return Action 0;
	}
	if (IsTankOrCharger(shovee))
	{
		return Action 3;
	}
	return Action 0;
}

public Action L4D2_OnEntityShoved(int shover, int shovee_ent, int weapon, float vector[3], bool bIsHunterDeadstop)
{
	int var1;
	if (!IsSurvivor(shover))
	{
		return Action 0;
	}
	if (IsTankOrCharger(shovee_ent))
	{
		return Action 3;
	}
	return Action 0;
}


/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "IsSurvivor" (number 6)

/* ERROR! No se puede convertir un objeto de tipo 'Lysis.DReturn' al tipo 'Lysis.DJumpCondition'. */
 function "IsInfected" (number 7)
public bool IsTankOrCharger(int client)
{
	if (!IsPlayerAlive(client))
	{
		return false;
	}
	if (GetEntProp(client, PropType 0, "m_zombieClass", 4, 0) == 8)
	{
		return true;
	}
	if (GetEntProp(client, PropType 0, "m_zombieClass", 4, 0) == 6)
	{
		return true;
	}
	return false;
}

public void ConVarChange(ConVar convar, char oldValue[], char newValue[])
{
	iDropMethod = StringToInt(newValue, 10);
	return void 0;
}

