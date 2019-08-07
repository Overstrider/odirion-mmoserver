function onLogin(player)
	if player:getLastLoginSaved() <= 0 then
		local backpack = player:addItem(1987)
		backpack:addItem(2674, 3)
		backpack:addItem(2050, 1)
		
		player:addItem(2650)
		player:addItem(2382)
	end
return true
end