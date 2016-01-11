#include <sourcemod>
 
public Plugin:myinfo =
{
	name = "Test Plugin",
	author = "Sir Francis Billard",
	description = "Juan Hit Knives",
	version = "1.0",
	url = "www.google.com"
};

public OnPluginStart()
{
   HookEvent("player_hurt", Event_PlayerHurt);
}
 
public Action:Event_PlayerHurt( player_hurt, "OneHitKnivesHook", false )
{

	event.GetString( "weapon" )

}
