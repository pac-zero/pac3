util.AddNetworkString("pac.net.TogglePartDrawing")
function pac.TogglePartDrawing(ent, b, who) --serverside interface to clientside function of the same name
	net.Start("pac.net.TogglePartDrawing")
	net.WriteEntity(ent)
	net.WriteBit(b)
	if not who then
		net.Broadcast()
	else
		net.Send(who)
	end
end

util.AddNetworkString("pac.net.InPAC3Editor")
util.AddNetworkString("pac.net.InPAC3Editor.ClientNotify")
net.Receive( "pac.net.InPAC3Editor.ClientNotify", function( length, client )
	b = (net.ReadBit() == 1)
	net.Start("pac.net.InPAC3Editor")
	net.WriteEntity(client)
	net.WriteBit(b)
	net.Broadcast()
end )

util.AddNetworkString("pac.net.InAnimEditor")
util.AddNetworkString("pac.net.InAnimEditor.ClientNotify")
net.Receive( "pac.net.InAnimEditor.ClientNotify", function( length, client )
	b = (net.ReadBit() == 1)
	net.Start("pac.net.InAnimEditor")
	net.WriteEntity(client)
	net.WriteBit(b)
	net.Broadcast()
end )

util.AddNetworkString("pac.net.SetCollisionGroup.ClientNotify")
net.Receive( "pac.net.SetCollisionGroup.ClientNotify", function(len,ply)
	local target = Entity(net.ReadInt(13))
	local group = net.ReadInt(7)
	if ply==target and (group == COLLISION_GROUP_PLAYER or group == COLLISION_GROUP_WEAPON) then
		target:SetCollisionGroup(group)
	end
end )

util.AddNetworkString("pac.net.TouchFlexes.ClientNotify")
net.Receive( "pac.net.TouchFlexes.ClientNotify", function( length, client )
	local index = net.ReadInt(13)
	local ent = Entity(index)
	local target = ent:GetFlexWeight(1) or 0
	if ent and ent:IsValid() and ent.GetFlexNum and ent:GetFlexNum() > 0 then ent:SetFlexWeight(1,target) end
end )
