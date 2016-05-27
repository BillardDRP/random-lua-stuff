hook.Add("PostDrawOpaqueRenderables","PlayerBorders",function()
	--stencil work is done in postdrawopaquerenderables, where surface doesn't work correctly
	--workaround via 3D2D
	local pos = LocalPlayer():EyePos()+LocalPlayer():EyeAngles():Forward()*10
	local ang = LocalPlayer():EyeAngles()
	ang = Angle(ang.p+90,ang.y,0)
	for k, v in pairs(ents.FindByClass("prop_physics")) do
		render.ClearStencil()
		render.SetStencilEnable(true)
			render.SetStencilWriteMask(255)
			render.SetStencilTestMask(255)
			render.SetStencilReferenceValue(15)
			render.SetStencilFailOperation(STENCILOPERATION_KEEP)
			render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
			render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
			render.SetBlend(0) --don't visually draw, just stencil
			v:SetModelScale(1.0+math.Rand(0.01,0.013),0) --slightly fuzzy, looks better this way
			v:DrawModel()
			v:SetModelScale(1,0)
			render.SetBlend(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
			cam.Start3D2D(pos,ang,1)
					surface.SetDrawColor(math.Rand(200,255),math.Rand(200,255),math.Rand(200,255),255)
					surface.DrawRect(-ScrW(),-ScrH(),ScrW()*2,ScrH()*2)
			cam.End3D2D()
			v:DrawModel()
		render.SetStencilEnable(false)
	end
end)
