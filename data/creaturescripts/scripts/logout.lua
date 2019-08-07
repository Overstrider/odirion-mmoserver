function onLogout(player)
		local tempo = os.time() - os.date(player:getLastLoginSaved())
		if os.time() - os.date(player:getLastLoginSaved()) <= 3 then
			player:sendTextMessage(19, "Wait "..(4 - tempo).." seconds to desconnect.")
		return false
		end
		
		if nextUseStaminaTime[playerId] ~= nil then
			nextUseStaminaTime[playerId] = nil
		end

		local stats = player:inBossFight()
		if stats then
			-- Player logged out (or died) in the middle of a boss fight, store his damageOut and stamina
			local boss = Monster(stats.bossId)
			if boss then
				local dmgOut = boss:getDamageMap()[playerId]
				if dmgOut then
					stats.damageOut = (stats.damageOut or 0) + dmgOut.total
				end
				stats.stamina = player:getStamina()
			end
		end
		
		local resultId = db.storeQuery("SELECT * FROM `players_uniqueCliente` WHERE `playerName` LIKE '%"..player:getName().."%' AND `uniqueCliente` LIKE '"..player:getUniqueCliente().."'")
		if resultId == false then
			db.query("INSERT INTO `players_uniqueCliente` (`playerName`, `uniqueCliente`) VALUES ('"..player:getName().."', '"..player:getUniqueCliente().."');")
			result.free(resultId)
		end
return true
end
	
