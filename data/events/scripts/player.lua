-- Internal Use
-- EXAMPLE = 26052

-- No move items with actionID 8000
-- Players cannot throw items on teleports if set to true
local blockTeleportTrashing = true

local function getHours(seconds)
	return math.floor((seconds/60)/60)
end

local function getMinutes(seconds)
	return math.floor(seconds/60)
end

local function getTime(seconds)
	local hours, minutes = getHours(seconds), getMinutes(seconds)
	if (minutes > 59) then
		minutes = minutes-hours*60
	end

	if (minutes < 10) then
		minutes = "0" ..minutes
	end

	return hours..":"..minutes.. "h"
end

function Player:onLook(thing, position, distance)
	local description = "You see " .. thing:getDescription(distance)
	
	if thing:isCreature() then

	else
	local itemType = thing:getType()
		if (itemType and itemType:getImbuingSlots() > 0) then
			local imbuingSlots = "("
			for i = 1, itemType:getImbuingSlots() do
				local specialAttr = thing:getSpecialAttribute(i)
				local time = 0
				if (thing:getSpecialAttribute(i+3)) then
					time = getTime(thing:getSpecialAttribute(i+3))
				end

				if (specialAttr and specialAttr ~= 0) then
					if (i ~= itemType:getImbuingSlots()) then
						imbuingSlots = imbuingSlots.. "" ..specialAttr.." " ..time..", "
					else
						imbuingSlots = imbuingSlots.. "" ..specialAttr.." " ..time..")."
					end
				else
					if (i ~= itemType:getImbuingSlots()) then
						imbuingSlots = imbuingSlots.. "Empty Slot, "
					else
						imbuingSlots = imbuingSlots.. "Empty Slot)."
					end
				end
			end
			description = string.gsub(description, "It weighs", imbuingSlots.. "\nIt weighs")
		end
	end
	
	if self:getGroup():getAccess() then
		if thing:isItem() then
			description = string.format("%s\nItem ID: %d", description, thing:getId())

			local actionId = thing:getActionId()
			if actionId ~= 0 then
				description = string.format("%s, Action ID: %d", description, actionId)
			end

			local uniqueId = thing:getAttribute(ITEM_ATTRIBUTE_UNIQUEID)
			if uniqueId > 0 and uniqueId < 65536 then
				description = string.format("%s, Unique ID: %d", description, uniqueId)
			end

			local itemType = thing:getType()

			local transformEquipId = itemType:getTransformEquipId()
			local transformDeEquipId = itemType:getTransformDeEquipId()
			if transformEquipId ~= 0 then
				description = string.format("%s\nTransforms to: %d (onEquip)", description, transformEquipId)
			elseif transformDeEquipId ~= 0 then
				description = string.format("%s\nTransforms to: %d (onDeEquip)", description, transformDeEquipId)
			end

			local decayId = itemType:getDecayId()
			if decayId ~= -1 then
				description = string.format("%s\nDecays to: %d", description, decayId)
			end
		elseif thing:isCreature() then
			local str = "%s\nHealth: %d / %d"
			if thing:getMaxMana() > 0 then
				str = string.format("%s, Mana: %d / %d", str, thing:getMana(), thing:getMaxMana())
			end
			description = string.format(str, description, thing:getHealth(), thing:getMaxHealth()) .. "."
		end

		local position = thing:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)

		if thing:isCreature() then
			if thing:isPlayer() then
				description = string.format("%s\nIP: %s.", description, Game.convertIpToString(thing:getIp()))
				description = string.format("%s\nuniqueClient: %s.", description, thing:getUniqueCliente())
			end
		end
	end
	-- local itemname = string.len(thing:getName()) >= 1 and thing:getName() or "Sem Nome"
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
	-- self:sendExtendedOpcode(10, itemname.."@"..thing:getId())
end

function Player:onLookInBattleList(creature, distance)
	local description = "You see " .. creature:getDescription(distance)
	if self:getGroup():getAccess() then
		local str = "%s\nHealth: %d / %d"
		if creature:getMaxMana() > 0 then
			str = string.format("%s, Mana: %d / %d", str, creature:getMana(), creature:getMaxMana())
		end
		description = string.format(str, description, creature:getHealth(), creature:getMaxHealth()) .. "."

		local position = creature:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)

		if creature:isPlayer() then
			description = string.format("%s\nIP: %s", description, Game.convertIpToString(creature:getIp()))
		end
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInTrade(partner, item, distance)
	self:sendTextMessage(MESSAGE_INFO_DESCR, "You see " .. item:getDescription(distance))
end

function Player:onLookInShop(itemType, count)
	return true
end

function Player:onMoveItem(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	-- No move items with actionID 8000
	if item:getActionId() == NOT_MOVEABLE_ACTION then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end

	-- Check two-handed weapons
	if toPosition.x ~= CONTAINER_POSITION then
		return true
	end

	-- if item:getTopParent() == self and bit.band(toPosition.y, 0x40) == 0 then
		-- local itemType, moveItem = ItemType(item:getId())
		-- if bit.band(itemType:getSlotPosition(), SLOTP_TWO_HAND) ~= 0 and toPosition.y == CONST_SLOT_LEFT then
			-- moveItem = self:getSlotItem(CONST_SLOT_RIGHT)
		-- elseif itemType:getWeaponType() == WEAPON_SHIELD and toPosition.y == CONST_SLOT_RIGHT then
			-- moveItem = self:getSlotItem(CONST_SLOT_LEFT)
			-- if moveItem and bit.band(ItemType(moveItem:getId()):getSlotPosition(), SLOTP_TWO_HAND) == 0 then
				-- return true
			-- end
		-- end

		-- if moveItem then
			-- local parent = item:getParent()
			-- if parent:getSize() == parent:getCapacity() then
				-- self:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM))
				-- return false
			-- else
				-- return moveItem:moveTo(parent)
			-- end
		-- end
	-- end

	-- Reward System
	-- if toPosition.x == CONTAINER_POSITION then
		-- local containerId = toPosition.y - 64
		-- local container = self:getContainerById(containerId)
		-- if not container then
			-- return true
		-- end

		-- Do not let the player insert items into either the Reward Container or the Reward Chest
		-- local itemId = container:getId()
		-- if itemId == ITEM_REWARD_CONTAINER or itemId == ITEM_REWARD_CHEST then
			-- self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			-- return false
		-- end

		-- The player also shouldn't be able to insert items into the boss corpse
		-- local tile = Tile(container:getPosition())
		-- for _, item in ipairs(tile:getItems() or { }) do
			-- if item:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == 2^31 - 1 and item:getName() == container:getName() then
				-- self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				-- return false
			-- end
		-- end
	-- end

	-- Do not let the player move the boss corpse.
	-- if item:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == 2^31 - 1 then
		-- self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		-- return false
	-- end

	-- Players cannot throw items on reward chest
	local tile = Tile(toPosition)
	if tile and tile:getItemById(ITEM_REWARD_CHEST) then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		self:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	-- Players cannot throw items on teleports
	-- if blockTeleportTrashing and toPosition.x ~= CONTAINER_POSITION then
		-- local thing = Tile(toPosition):getItemByType(ITEM_TYPE_TELEPORT)
		-- if thing then
			-- self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			-- self:getPosition():sendMagicEffect(CONST_ME_POFF)
			-- return false
		-- end
	-- end

	--[[-- Do not stop trying this test
	-- No move parcel very heavy
	if item:getWeight() > 90000 and item:getId() == ITEM_PARCEL then 
		self:sendCancelMessage('YOU CANNOT MOVE PARCELS TOO HEAVY.')
		return false 
	end

	-- No move if item count > 26 items
	if tile and tile:getItemCount() > 26 then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end

	if tile and tile:getItemById(370) then -- Trapdoor
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		self:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end ]]
	return true
end

function Player:onMoveCreature(creature, fromPosition, toPosition)
	return true
end

function Player:onReport(message)
	if self:getAccountType() == ACCOUNT_TYPE_NORMAL then
		return false
	end

	local name = self:getName()
	local file = io.open("data/reports/" .. name .. " report.txt", "a")

	if not file then
		self:sendTextMessage(MESSAGE_EVENT_DEFAULT, "There was an error when processing your report, please contact a gamemaster.")
		return true
	end

	io.output(file)
	io.write("------------------------------\n")
	io.write("Name: " .. name)
	local playerPosition = self:getPosition()
	io.write(" [Player Position: " .. playerPosition.x .. ", " .. playerPosition.y .. ", " .. playerPosition.z .. "]\n")
	io.write("Comment: " .. message .. "\n")
	io.close(file)

	self:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Your report has been sent to " .. configManager.getString(configKeys.SERVER_NAME) .. ".")
	return true
end

function Player:onTurn(direction)
	if self:getGroup():getAccess() and self:getDirection() == direction then
		local nextPosition = self:getPosition()
		nextPosition:getNextPosition(direction)

		self:teleportTo(nextPosition, true)
	end

	return true
end

function Player:onTradeRequest(target, item)
	return true
end

function Player:onTradeAccept(target, item, targetItem)
	return true
end

local soulCondition = Condition(CONDITION_SOUL, CONDITIONID_DEFAULT)
soulCondition:setTicks(4 * 60 * 1000)
soulCondition:setParameter(CONDITION_PARAM_SOULGAIN, 1)

function useStaminaImbuing(playerId, itemuid)
	local player = Player(playerId)
	if not player then
		return false
	end

	local item = Item(itemuid)
	if not item then
		return false
	end

	for i = 1, item:getType():getImbuingSlots() do
		if (item:isActiveImbuement(i+3)) then
			local staminaMinutes = item:getSpecialAttribute(i+3)/60
			if (staminaMinutes > 0) then
				local currentTime = os.time()
				local timePassed = currentTime - item:getSpecialAttribute(i+6)
				if timePassed > 0 then
					if timePassed > 60 then
						if staminaMinutes > 2 then
							staminaMinutes = staminaMinutes - 2
						else
							staminaMinutes = 0
						end

						item:setSpecialAttribute(i+6, currentTime + 120)
					else
						staminaMinutes = staminaMinutes - 1
						item:setSpecialAttribute(i+6, currentTime + 60)
					end
				end

				item:setSpecialAttribute(i+3, staminaMinutes*60)
				if (staminaMinutes <= 0) then
					player:removeCondition(CONDITION_HASTE, item:getId() + i)
					player:removeCondition(CONDITION_ATTRIBUTES, item:getId() + i)
					item:setSpecialAttribute(i, 0, i+3, 0, i+6, 0)
				end
			end
		end
	end
end


local function useStamina(player)
	local staminaMinutes = player:getStamina()
	if staminaMinutes == 0 then
		return
	end

	local playerId = player:getId()
	local currentTime = os.time()
	local timePassed = currentTime - nextUseStaminaTime[playerId]
	if timePassed <= 0 then
		return
	end

	if timePassed > 60 then
		if staminaMinutes > 2 then
			staminaMinutes = staminaMinutes - 2
		else
			staminaMinutes = 0
		end
		nextUseStaminaTime[playerId] = currentTime + 120
	else
		staminaMinutes = staminaMinutes - 1
		nextUseStaminaTime[playerId] = currentTime + 60
	end
	player:setStamina(staminaMinutes)
end

local function useStaminaXp(player)
	local staminaMinutes = player:getExpBoostStamina()
	if staminaMinutes == 0 then
		return
	end

	local playerId = player:getId()
	local currentTime = os.time()
	local timePassed = currentTime - nextUseXpStamina[playerId]
	if timePassed <= 0 then
		return
	end

	if timePassed > 60 then
		if staminaMinutes > 2 then
			staminaMinutes = staminaMinutes - 2
		else
			staminaMinutes = 0
		end
		nextUseXpStamina[playerId] = currentTime + 120
	else
		staminaMinutes = staminaMinutes - 1
		nextUseXpStamina[playerId] = currentTime + 60
	end
	player:setExpBoostStamina(staminaMinutes)
end

function Player:onCombatSpell(normalDamage, elementDamage, elementType, changeDamage)
	-- Imbuement
	local weapon = self:getSlotItem(CONST_SLOT_LEFT)
	if not weapon or weapon:getType():getWeaponType() == WEAPON_SHIELD then
		weapon = self:getSlotItem(CONST_SLOT_RIGHT)
		if not weapon or weapon:getType():getWeaponType() == WEAPON_SHIELD then
			weapon = nil
		end
	end

	if normalDamage < 0 then
		for slot = 1, 10 do
			local nextEquip = self:getSlotItem(slot)
			if nextEquip and nextEquip:getType():getImbuingSlots() > 0 then
				for i = 1, nextEquip:getType():getImbuingSlots() do
					local slotEnchant = nextEquip:getSpecialAttribute(i)
					if (slotEnchant and type(slotEnchant) == 'string') then
						local percentDamage, enchantPercent = 0, nextEquip:getImbuementPercent(slotEnchant)
						local typeEnchant = nextEquip:getImbuementType(i) or ""
						if (typeEnchant ~= "" and typeEnchant ~= "skillShield" and not typeEnchant:find("absorb") and typeEnchant ~= "speed") then
							useStaminaImbuing(self:getId(), nextEquip:getUniqueId())
						end

						if (typeEnchant == "firedamage" or typeEnchant == "earthdamage" or typeEnchant == "icedamage" or typeEnchant == "energydamage" or typeEnchant == "deathdamage") then
							local weaponType = nextEquip:getType():getWeaponType()
							if weaponType ~= WEAPON_NONE and weaponType ~= WEAPON_SHIELD and weaponType ~= WEAPON_AMMO then
								percentDamage = normalDamage*(enchantPercent/100)
								-- normalDamage = normalDamage - percentDamage
								elementDamage = nextEquip:getType():getAttack()*(enchantPercent/100)
							end
						end

						if (typeEnchant == "firedamage") then
							elementType = COMBAT_FIREDAMAGE
						elseif (typeEnchant == "earthdamage") then
							elementType = COMBAT_EARTHDAMAGE
						elseif (typeEnchant == "icedamage") then
							elementType = COMBAT_ICEDAMAGE
						elseif (typeEnchant == "energydamage") then
							elementType = COMBAT_ENERGYDAMAGE
						elseif (typeEnchant == "deathdamage") then
							elementType = COMBAT_DEATHDAMAGE
						end
					end
				end
			end
		end
	end
	
	return normalDamage, elementDamage, elementType, changeDamage
end

function Player:onUseWeapon(normalDamage, elementType, elementDamage)
	-- Imbuement
	local weapon = self:getSlotItem(CONST_SLOT_LEFT)
	if not weapon or weapon:getType():getWeaponType() == WEAPON_SHIELD then
		weapon = self:getSlotItem(CONST_SLOT_RIGHT)
		if not weapon or weapon:getType():getWeaponType() == WEAPON_SHIELD then
			weapon = nil
		end
	end

	for slot = 1, 10 do
		local nextEquip = self:getSlotItem(slot)
		if nextEquip and nextEquip:getType():getImbuingSlots() > 0 then
			for i = 1, nextEquip:getType():getImbuingSlots() do
				local slotEnchant = nextEquip:getSpecialAttribute(i)
				if (slotEnchant) then
					local percentDamage, enchantPercent = 0, nextEquip:getImbuementPercent(slotEnchant)
					local typeEnchant = nextEquip:getImbuementType(i) or ""
					if (typeEnchant ~= "" and typeEnchant ~= "skillShield" and not typeEnchant:find("absorb") and typeEnchant ~= "speed") then
						useStaminaImbuing(self:getId(), nextEquip:getUniqueId())
					end

					if (typeEnchant ~= "hitpointsleech" and typeEnchant ~= "manapointsleech" and typeEnchant ~= "criticaldamage" 
						and typeEnchant ~= "skillShield" and typeEnchant ~= "magiclevelpoints" and not typeEnchant:find("absorb") and typeEnchant ~= "speed") then
						local weaponType = nextEquip:getType():getWeaponType()
						if weaponType ~= WEAPON_NONE and weaponType ~= WEAPON_SHIELD and weaponType ~= WEAPON_AMMO then
							percentDamage = normalDamage*(enchantPercent/100)
							normalDamage = normalDamage - percentDamage
							elementDamage = nextEquip:getType():getAttack()*(enchantPercent/100)
						end
					end

					if (typeEnchant == "hitpointsleech") then
						local healAmountHP = normalDamage*(enchantPercent/100)
						self:addHealth(math.abs(healAmountHP))
					elseif (typeEnchant == "manapointsleech") then
						local healAmountMP = normalDamage*(enchantPercent/100)
						self:addMana(math.abs(healAmountMP))
					end

					if (typeEnchant == "firedamage") then
						elementType = COMBAT_FIREDAMAGE
					elseif (typeEnchant == "earthdamage") then
						elementType = COMBAT_EARTHDAMAGE
					elseif (typeEnchant == "icedamage") then
						elementType = COMBAT_ICEDAMAGE
					elseif (typeEnchant == "energydamage") then
						elementType = COMBAT_ENERGYDAMAGE
					elseif (typeEnchant == "deathdamage") then
						elementType = COMBAT_DEATHDAMAGE
					end
				end
			end
		end
	end
	
	return normalDamage, elementType, elementDamage
end

function Player:onMove()
	local haveImbuingBoots = self:getSlotItem(CONST_SLOT_FEET) and self:getSlotItem(CONST_SLOT_FEET):getType():getImbuingSlots() or 0
	if haveImbuingBoots > 0 then
		local bootsItem = self:getSlotItem(CONST_SLOT_FEET)
		for slot = 1, haveImbuingBoots do
			local slotEnchant = bootsItem:getSpecialAttribute(slot)
			if (slotEnchant and type(slotEnchant) == 'string') then
				local typeEnchant = bootsItem:getImbuementType(slot) or ""
				if (typeEnchant == "speed") then
					useStaminaImbuing(self:getId(), bootsItem:getUniqueId())
				end
			end
		end
	end
	return true
end


function Player:onEquipImbuement(item)
	local itemType = item:getType()
	for i = 1, itemType:getImbuingSlots() do
		local slotEnchant = item:getSpecialAttribute(i)
		if (slotEnchant and type(slotEnchant) == 'string') then
			conditionHaste = Condition(CONDITION_HASTE, item:getId() + i)
			conditionSkill = Condition(CONDITION_ATTRIBUTES, item:getId() + i)
			local skillValue = item:getImbuementPercent(slotEnchant)
			local typeEnchant = item:getImbuementType(i) or ""
			if (typeEnchant == "skillSword") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_SWORD, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "skillAxe") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_AXE, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "skillClub") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_CLUB, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "skillDist") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_DISTANCE, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "skillShield") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_SHIELD, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "magiclevelpoints") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "speed") then					
				self:changeSpeed(self:getBaseSpeed() * (skillValue/100))
			elseif (typeEnchant == "criticaldamage") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, 10)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "hitpointsleech") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, 100)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "manapointsleech") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, 100)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, skillValue)
				self:addCondition(conditionSkill)
			end
		end
	end

	return true
end

function Player:onDeEquipImbuement(item)
	for i = 1, item:getType():getImbuingSlots() do
		self:changeSpeed(-self:getSpeed())
		self:changeSpeed(self:getBaseSpeed())
		self:removeCondition(CONDITION_ATTRIBUTES, item:getId() + i)
	end

	return true
end

function Player:onGainExperience(source, exp, rawExp)	
	if self:getLevel() >= 1 and self:getLevel() <= 20 then
		return exp * 5
	elseif self:getLevel() >= 21 and self:getLevel() <= 40 then
		return exp * 4
	elseif self:getLevel() >= 41 and self:getLevel() <= 60 then
		return exp * 3
	elseif self:getLevel() >= 61 and self:getLevel() <= 70 then
		return exp * 2
	elseif self:getLevel() >= 71 and self:getLevel() <= 80 then
		return exp * 1.5
	elseif self:getLevel() >= 81 then
		return exp * 1
	end	
end

function Player:onLoseExperience(exp)
	if self:getLevel() >= 1 and self:getLevel() <= 20 then
		return exp * 5
	elseif self:getLevel() >= 21 and self:getLevel() <= 40 then
		return exp * 4
	elseif self:getLevel() >= 41 and self:getLevel() <= 60 then
		return exp * 3
	elseif self:getLevel() >= 61 and self:getLevel() <= 70 then
		return exp * 2
	elseif self:getLevel() >= 71 and self:getLevel() <= 80 then
		return exp * 1.5
	elseif self:getLevel() >= 81 then
		return exp * 1
	end	
end

function Player:onGainSkillTries(skill, tries)
	if APPLY_SKILL_MULTIPLIER == false then
		return tries
	end

	if skill == SKILL_MAGLEVEL then		
		return (tries * 2) * getConfigInfo("rateMagic")		
	end
	return (tries * 5) * getConfigInfo("rateSkill")
end
