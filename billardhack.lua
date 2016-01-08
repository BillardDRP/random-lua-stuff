--draw.RoundedBox( number cornerRadius, number x, number y, number width, number height, table color )

hook.Add( "HUDPaint", "BillardHack_Crosshair" function()
	draw.RoundedBox( 2, ScrW(), ScrH(), 30, 2, Color( 255, 0, 0, 180 ) )
	draw.RoundedBox( 2, ScrW(), ScrH(), 2, 30, Color( 255, 0, 0, 180 ) )
end )
