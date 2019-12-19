
local function connectionConfirmDialog()
	local pl = LocalPlayer()
	if (pl._sconnectDialog) then return end //stop the panel being spammed 

	pl._sconnectDialog = true 
	local frame = vgui.Create("DFrame")
	frame:SetSize(0.15*ScrW(), 0.16*ScrH())
	frame:MakePopup()
	frame:Center()
	frame:ShowCloseButton(false)
	frame:SetTitle("sConnect Dialog")
	frame.Paint = function(self, w, h)
		local warntext = "Warning: Server is trying to connect you to\n"..sconnect.config.connection["IP"].."\nDo you wish to connect?"
		surface.SetFont("DermaDefault")
		local _, height = surface.GetTextSize(warntext)
		surface.SetDrawColor(56, 132, 255)
		surface.DrawRect(0, 0, w, 0.13*h)
		surface.SetDrawColor(134, 136, 140)
		surface.DrawRect(0, 0.13*h, w, h-0.13*h)
		draw.DrawText(warntext, "DermaDefault", w/2, h/2 - height/2, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	end

	function frame:OnClose()
		timer.Simple(2, function() //wait 2 seconds so they have time to get out of the zone thing
			pl._sconnectDialog = false
		end)
	end

	local close = vgui.Create("DButton", frame)
	close:SetSize(0.13*frame:GetWide(), 0.10*frame:GetTall())
	close:SetPos(0.86*frame:GetWide(), 0.016*frame:GetTall())
	close:SetText(" X ")
	close:SetTextColor(Color(255, 255, 255))

	close.Paint = function(self, w, h)
		surface.SetDrawColor(214, 109, 109)
		surface.DrawRect(0, 0, w, h)
	end

	close.DoClick = function()
		frame:Close()
	end

	local button = vgui.Create("DButton", frame)
	button:SetText("Connect")
	button:SetTextColor(Color(50, 255, 50))
	button:SetPos(frame:GetWide()/2 - button:GetWide()/2, 0.8*frame:GetTall())
	button:SetTextColor(Color(255, 255, 255))
	button.DoClick = function()
		net.Start("sconnect")
		net.SendToServer()
	end

	button.Paint = function(self, w, h)
		if(self:IsHovered() or self:IsDown()) then
			surface.SetDrawColor(0, 97, 255)
		else
			surface.SetDrawColor(56, 132, 255)
		end
		surface.DrawRect(0, 0, w, h)
	end
end
net.Receive("sconnectDialog", connectionConfirmDialog)
