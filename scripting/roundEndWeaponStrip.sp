#include <sdktools>

#define PLUGIN_VERSION "0.0.1"

#pragma newdecls required;

public Plugin myinfo =
{
    name = "Round end weapon strip",
    author = "faketuna",
    description = "The simple plugin to strip weapon on round end.",
    version = PLUGIN_VERSION,
    url = "https://short.f2a.dev/s/github"
};

ConVar g_hPluginEnabled

public void OnPluginStart() {
    g_hPluginEnabled = CreateConVar("rews_enabled", "1", "Enable/Disable Round end weapon strip.")
    HookEvent("round_end", OnRoundEnd, EventHookMode_Pre);
}


public void OnRoundEnd(Handle event, const char[] name, bool dontBroadcast) {
    if (!GetConVarBool(g_hPluginEnabled)) {
        return;
    }
    for(int i = 1; i <= MaxClients; i++) {
        if (IsClientInGame(i)) {
            stripPlayer(i);
        }
    }
}

void stripPlayer(int client) {
    for(int i = 0; i < 5; i++) {
        int weaponSlot = -1;
        while((weaponSlot = GetPlayerWeaponSlot(client, i)) != -1) {
            if(IsValidEntity(weaponSlot)) {
                RemovePlayerItem(client, weaponSlot);
            }
        }
    }
}