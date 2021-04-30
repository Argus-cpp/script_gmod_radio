hook.Add("HUDPaint", 'draw_radio_status', function()
	
	local IsHave = false

	for _, v in pairs(POLICE_RADIO_CONFIG.TEAMS) do
		if table.HasValue(v, LocalPlayer():Team()) then IsHave =  true break end
	end 

	if IsHave then
		local IsActive = LocalPlayer():GetNWBool('RadioActive')

		if IsActive then
			surface.SetMaterial(Material('materials/police_radio/radio_on.png'))
		else
			surface.SetMaterial(Material('materials/police_radio/radio_off.png'))
		end
		surface.SetDrawColor(255,255,255)
		surface.DrawTexturedRect(ScrW()-64, ScrH()/2-32, 64, 64)
	end
end)

