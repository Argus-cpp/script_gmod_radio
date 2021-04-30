timer.Simple(1, function()
	if SERVER then
		AddCSLuaFile('cl_policeradio.lua')
		AddCSLuaFile('policeradio_config.lua')

		include('policeradio_config.lua')
		include('sv_policeradio.lua')
	else
		include('policeradio_config.lua')
		include('cl_policeradio.lua')
	end
end)