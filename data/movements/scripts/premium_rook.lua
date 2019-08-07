local c = {
	leave = "east", -- Direção da Saída/Expulsão
}
 
function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
	if player then
		ppos = player:getPosition()
		if player:getPremiumDays() > 0 then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Welcome to Premium Area.')
			ppos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
			player:teleportTo(ppos, 1)
		else
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'You need Premium Account to pass.')
			ppos:sendMagicEffect(CONST_ME_MAGIC_RED)
			exitpos = doLeaveSwattFunc(cid)
			player:teleportTo(exitpos, 1)
		end
	end
return true
end

function doLeaveSwattFunc(cid)
	local player = Player(cid)
	p = player:getPosition()
	if c.leave == "north" then
		pos = {x=p.x, y=p.y-1, z=p.z}
	elseif c.leave == "south" then
		pos = {x=p.x, y=p.y+1, z=p.z}
	elseif c.leave == "east" then
		pos = {x=p.x+1, y=p.y, z=p.z}
	elseif c.leave == "west" then
		pos = {x=p.x-1, y=p.y, z=p.z}
	end	
return pos
end