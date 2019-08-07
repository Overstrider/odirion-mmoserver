local rewards = {
{"rateExp", 0.1, 10, "1.0", "/images/game/xpBoost"},
{"rateSkill", 0.1, 10, "1.0", "/images/game/skillBoost"},
{"rateMagic", 0.1, 10, "1.0", "/images/game/magicBoost"},
{"rateRespaw", 0.1, 10, "1.0", "/images/game/Respawn"}, 
{"rateLoot", 1, 3, "1", "/images/game/lootBoost"},
{"regenMana", 1, 3, "0", "/images/game/Mana"},
{"regenHealth", 1, 3, "0", "/images/game/Health"}
}

function verificarBoost()
	for x = 1, #rewards do
		setRate(rewards[x][1], rewards[x][4])
	end
	
	local tableRewards = {}
	while #tableRewards < 3 do
		local select = math.random(1, 7)
		if not isInArray(tableRewards, select) then
			table.insert(tableRewards, select)
		end
	end
	
	table.sort(tableRewards, function(a,b) return a<b end)
	table.concat(tableRewards, ", ")
	
	local firstReward, secondReward, threeReward = 0
	
	firstReward = tableRewards[1]
	secondReward = tableRewards[2]
	threeReward = tableRewards[3]
	
	local recordMediaFirst = math.floor(getRecord() / rewards[firstReward][3])						
	local recordMediaSecond = math.floor(getRecord() / rewards[secondReward][3])
	local recordMediaThree = math.floor(getRecord() / rewards[threeReward][3])

	if recordMediaFirst > 0 then
		setRate(rewards[firstReward][1], rewards[firstReward][4] + rewards[firstReward][2] * math.floor(getGlobalStorageValue(2018) / recordMediaFirst))
	else
		setRate(rewards[firstReward][1], rewards[firstReward][4])
	end

	if recordMediaSecond > 0 then
		setRate(rewards[secondReward][1], rewards[secondReward][4] + rewards[secondReward][2] * math.floor(getGlobalStorageValue(2018) / recordMediaSecond))
	else
		setRate(rewards[secondReward][1], rewards[secondReward][4])
	end

	if recordMediaThree > 0 then							
		setRate(rewards[threeReward][1], rewards[threeReward][4] + rewards[threeReward][2] * math.floor(getGlobalStorageValue(2018) / recordMediaThree))
	else
		setRate(rewards[threeReward][1], rewards[threeReward][4])
	end
	
	-- broadcastMessage(string.format("%s First, %s Second, %s Three", rewards[firstReward][1], rewards[secondReward][1], rewards[threeReward][1]), MESSAGE_STATUS_WARNING)

	-- setGlobalStorageValue(2018, 0)
	-- setGlobalStorageValue(7646, os.time() + 3600)

return true
end

function onThink(interval)
-- if getGlobalStorageValue(7646) < os.time() then  		
        -- if tonumber("14") == tonumber(os.date("%H")) then
			-- print("Verificando Atributos")
		-- end
	-- end		
return true
end