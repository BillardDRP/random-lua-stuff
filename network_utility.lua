NU = {}
NU.SendStringToClient = function( theFile, theString )
	if not theFile then return end
	util.AddNetworkString( tostring( theFile ) )
	net.Start( tostring( theFile ) )
	net.WriteString( tostring( theString ) )
	net.Send()
end
