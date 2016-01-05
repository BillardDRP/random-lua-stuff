--Used to draw drug effects for RTD "Drugged" roll
net.Receive( "RTD_DrawDrugEffects", function( len, ply )
	DrawSharpen( 1.2, 1.2 )
	DrawMotionBlur( 0.4, 0.8, 0.01 )
	timer.Simple( 20, function()
		DrawSharpen( 0, 0 )
		DrawMotionBlur( 0, 0, 0 )
	end )
end )
