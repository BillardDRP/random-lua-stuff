local WebsiteLink = "www.google.com" --Save the URL in an easy-to-configure variable
hook.Add( "PlayerSay", "WebsiteCommandHook", function( sender, text, teamchat ) --Hook on to player chat
if !sender:IsValid() then return end --Check if the sender of the chat exists, if not then bail
if text == "!website" then --If they type this then
	gui.OpenURL( WebsiteLink ) --Open this link in steam overlay
end ) --End the hook to prevent errors
