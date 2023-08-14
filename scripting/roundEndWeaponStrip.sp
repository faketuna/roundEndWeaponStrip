#include <sourcemod>
#include <sdktools>

#define PLUGIN_VERSION "0.0.1"

public Plugin:myinfo =
{
    name = "Round end weapon strip",
    author = "faketuna",
    description = "The simple plugin to strip weapon on round end.",
    version = PLUGIN_VERSION,
    url = "https://short.f2a.dev/s/github"
};

public OnPluginStart() {
    HookEvent("round_end", OnRoundEnd, EventHookMode_Pre);
}


public OnRoundEnd(Handle: event, const String: name[], bool: dontBroadcast) {
    for(new i = 1; i <= MaxClients; i++) {
        if (IsClientInGame(i)) {
            stripPlayer(i);
        }
    }
}

stripPlayer(client) {
    for(new i = 0; i < 5; i++) {
        new weapon = -1;
        while((weapon = GetPlayerWeaponSlot(client, i)) != -1) {
            if(IsValidEntity(weapon)) {
                RemovePlayerItem(client, weapon);
            }
        }
    }
}