resource.AddSingleFile('materials/police_radio/radio_off.png')
resource.AddSingleFile('materials/police_radio/radio_on.png')

local function playerCanUse(ply)
	local canUse = false
	local id = 0
	for k, v in pairs(POLICE_RADIO_CONFIG.TEAMS) do
		if table.HasValue(v, ply:Team()) then canUse = true id = k break end
	end

	return canUse, id
end

// Radio hook
hook.Add('PlayerCanHearPlayersVoice', 'police_only', function(lis, talker)
	local canUse, id = playerCanUse(talker)
	if talker:GetNWBool('RadioActive') and canUse then
		if lis:GetNWBool('RadioActive') and table.HasValue(POLICE_RADIO_CONFIG.TEAMS[id], lis:Team()) then
			return true
		end
	end
	//if talker.radioActive and !lis.radioActive then return false end
	if talker:GetNWBool('RadioActive') and !lis:GetNWBool('RadioActive') then return false end
end)

// Enable/disable radio
hook.Add( "PlayerButtonDown", "turn_police_radio", function( ply, key )
	if ( key == POLICE_RADIO_CONFIG.turnradio ) then
		local CanUse, _ = playerCanUse(ply)
		if CanUse then
			if  ply:GetNWBool('RadioActive') then
				//ply.radioActive = false
				ply:ChatPrint("Рация выключена!")
				ply:SetNWBool("RadioActive", false)
				//ply:SendLua([[LocalPlayer().radioActive = false]])
			else
				//ply.radioActive = true
				ply:ChatPrint("Рация включена!")
				ply:SetNWBool("RadioActive", true)
				//ply:SendLua([[LocalPlayer().radioActive = true]])
			end
		end
	end
end )

--[[-------------------------------------------------------------------------
						Disable radio hooks
---------------------------------------------------------------------------]]

hook.Add('OnPlayerChangedTeam', 'turn_p_radio', function( ply )
	ply.radioActive = false
	ply:SendLua([[LocalPlayer().radioActive = false]])
end)

hook.Add('PlayerDeath', 'turn_p_radio_death', function( ply )
	ply.radioActive = false
	ply:SendLua([[LocalPlayer().radioActive = false]])
end)

hook.Add('PlayerSpawn', 'turn_p_radio_death', function( ply )
	ply.radioActive = false
	ply:SendLua([[LocalPlayer().radioActive = false]])
end)