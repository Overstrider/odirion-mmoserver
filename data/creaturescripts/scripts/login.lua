local function onMovementRemoveProtection(cid, oldPosition, time)
	local player = Player(cid)
	if not player then
		return true
	end

	local playerPosition = player:getPosition()
	if (playerPosition.x ~= oldPosition.x or playerPosition.y ~= oldPosition.y or playerPosition.z ~= oldPosition.z) or player:getTarget() then
		player:setStorageValue(Storage.combatProtectionStorage, 0)
		return true
	end

	addEvent(onMovementRemoveProtection, 1000, cid, oldPosition, time - 1)
end

local function sendFood(cid)
local player = Player(cid)
	if not player then
		return true
	end
player:sendExtendedOpcode(30, player:getFeed())
addEvent(sendFood, 1000, cid)
return true
end

function onLogin(player)
	local loginStr = "Welcome to " .. configManager.getString(configKeys.SERVER_NAME) .. "!"
	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. " Please choose your outfit."
		player:sendOutfitWindow()
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end

		loginStr = string.format("Your last visit was on %s.", os.date("%a %b %d %X %Y", player:getLastLoginSaved()))
	end
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)

	local playerId = player:getId()
	
	addEvent(sendFood, 100, playerId)
	addEvent(sendMarket, 100, playerId)

	-- Stamina
	nextUseStaminaTime[playerId] = 1

	-- EXP Stamina
	nextUseXpStamina[playerId] = 1

	-- Rewards notice
	local rewards = #player:getRewardList()
	if(rewards > 0) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have %d %s in your reward chest.", rewards, rewards > 1 and "rewards" or "reward"))
	end

	-- Update player id
	local stats = player:inBossFight()
	if stats then
		stats.playerId = player:getId()
	end
	
	-- db.query('INSERT INTO `players_online` (`player_id`) VALUES (' .. player:getGuid() .. ')')
	
	player:sendTextMessage(19, "Official client verification.")
	player:setUniqueCliente(0)
	addEvent(function(cid) 	
		if isPlayer(cid) and player:getUniqueCliente() == 0 then			
			player:sendDisconnectClient("Incomplete verification, the client is not official!")
		else
			player:sendTextMessage(19, "Verification, always use the official client for your safety.")
		end
	end, 3000, playerId)

	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("taskSystemOnKill")	
	player:registerEvent("DropLoot")
	player:registerEvent("BossParticipation")
	-- player:registerEvent("LoginServer") --Sistema de SubServers

	if player:getStorageValue(Storage.combatProtectionStorage) <= os.time() then
		player:setStorageValue(Storage.combatProtectionStorage, os.time() + 10)
		onMovementRemoveProtection(playerId, player:getPosition(), 10)
	end
	
	
	local foodCondition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	local condition = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	if condition then
		local oldTicks = condition:getTicks()
		player:removeCondition(foodCondition)

		local vocation = player:getVocation()
		if not vocation then
		return nil
		end

		foodCondition:setTicks(oldTicks)
		foodCondition:setParameter(CONDITION_PARAM_HEALTHGAIN, vocation:getHealthGainAmount() + getConfigInfo("regenHealth"))
		foodCondition:setParameter(CONDITION_PARAM_HEALTHTICKS, vocation:getHealthGainTicks() * 1000)
		foodCondition:setParameter(CONDITION_PARAM_MANAGAIN, vocation:getManaGainAmount() + getConfigInfo("regenMana"))
		foodCondition:setParameter(CONDITION_PARAM_MANATICKS, vocation:getManaGainTicks() * 1000)

		player:addCondition(foodCondition)
	end			
	
	-- if getGlobalStorageValue(2018) < #Game.getPlayers() then
		-- setGlobalStorageValue(2018, #Game.getPlayers())
		-- player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "Online Record Today is "..getGlobalStorageValue(2018).." Players")
	-- end
	
	if player:getPremiumDays() > 0 then
		player:setStorageValue(30360, 1)
	else
		if player:getStorageValue(30360) == 1 then
			player:setStorageValue(30360, 0)
			player:teleportTo(player:getTown():getTemplePosition())
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your premium account is gone.")
		end
	end
		
	
	player:setStorageValue(3631, 1)
	player:setStorageValue(40011, 1)
	
	return true
end