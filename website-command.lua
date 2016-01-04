local WebsiteLink = "www.google.com"
hook.Add( "PlayerSay", "WebsiteCommandHook", function( sender, text, teamchat )
if !sender:IsValid() then return end
if text == "!website" then
	gui.OpenURL( WebsiteLink )
end
)
