util.AddNetworkString("sconnect")
util.AddNetworkString("sconnectDialog")

local function connect(ply)
	if sconnect.config.connection["HasPassword"] then
		ply:ConCommand("connect "..sconnect.config.connection["IP"].."; password "..sconnect.config.connection["Password"])
	else
		ply:ConCommand("connect "..sconnect.config.connection["IP"])
	end
end

net.Receive("sconnect", function(len, ply)
	connect(ply)
end)

if(sconnect.enabled) then //If you want to disable it after having it running, you'll need to restart your server as luarefresh doesnt remove hooks
	hook.Add("Initialize", "sconnect_area_check", function()
		local pos1 = sconnect.config.area["Pos1"]
		local pos2 = sconnect.config.area["Pos2"]
		timer.Create("sconnect_area_timer", 0.5, 0, function()
			for k, v in ipairs(ents.FindInBox(pos1, pos2)) do
				if(v:IsPlayer() and v:Alive()) then
					net.Start("sconnectDialog")
					net.Send(v)
				end
			end//end k/v loop
		end)//end timer
	end)//end hook
end