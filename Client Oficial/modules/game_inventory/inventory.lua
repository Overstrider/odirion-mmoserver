InventorySlotStyles = {
  [InventorySlotHead] = "HeadSlot",
  [InventorySlotNeck] = "NeckSlot",
  [InventorySlotBack] = "BackSlot",
  [InventorySlotBody] = "BodySlot",
  [InventorySlotRight] = "RightSlot",
  [InventorySlotLeft] = "LeftSlot",
  [InventorySlotLeg] = "LegSlot",
  [InventorySlotFeet] = "FeetSlot",
  [InventorySlotFinger] = "FingerSlot",
  [InventorySlotAmmo] = "AmmoSlot"
}

Icons = {}
Icons[PlayerStates.Poison] = { tooltip = tr('You are poisoned'), path = '/images/game/states/poisoned', id = 'condition_poisoned' }
Icons[PlayerStates.Burn] = { tooltip = tr('You are burning'), path = '/images/game/states/burning', id = 'condition_burning' }
Icons[PlayerStates.Energy] = { tooltip = tr('You are electrified'), path = '/images/game/states/electrified', id = 'condition_electrified' }
Icons[PlayerStates.Drunk] = { tooltip = tr('You are drunk'), path = '/images/game/states/drunk', id = 'condition_drunk' }
Icons[PlayerStates.ManaShield] = { tooltip = tr('You are protected by a magic shield'), path = '/images/game/states/magic_shield', id = 'condition_magic_shield' }
Icons[PlayerStates.Paralyze] = { tooltip = tr('You are paralysed'), path = '/images/game/states/slowed', id = 'condition_slowed' }
Icons[PlayerStates.Haste] = { tooltip = tr('You are hasted'), path = '/images/game/states/haste', id = 'condition_haste' }
Icons[PlayerStates.Swords] = { tooltip = tr('You may not logout during a fight'), path = '/images/game/states/logout_block', id = 'condition_logout_block' }
Icons[PlayerStates.Drowning] = { tooltip = tr('You are drowning'), path = '/images/game/states/drowning', id = 'condition_drowning' }
Icons[PlayerStates.Freezing] = { tooltip = tr('You are freezing'), path = '/images/game/states/freezing', id = 'condition_freezing' }
Icons[PlayerStates.Dazzled] = { tooltip = tr('You are dazzled'), path = '/images/game/states/dazzled', id = 'condition_dazzled' }
Icons[PlayerStates.Cursed] = { tooltip = tr('You are cursed'), path = '/images/game/states/cursed', id = 'condition_cursed' }
Icons[PlayerStates.PartyBuff] = { tooltip = tr('You are strengthened'), path = '/images/game/states/strengthened', id = 'condition_strengthened' }
Icons[PlayerStates.PzBlock] = { tooltip = tr('You may not logout or enter a protection zone'), path = '/images/game/states/protection_zone_block', id = 'condition_protection_zone_block' }
Icons[PlayerStates.Pz] = { tooltip = tr('You are within a protection zone'), path = '/images/game/states/protection_zone', id = 'condition_protection_zone' }
Icons[PlayerStates.Bleeding] = { tooltip = tr('You are bleeding'), path = '/images/game/states/bleeding', id = 'condition_bleeding' }
Icons[PlayerStates.Hungry] = { tooltip = tr('You are hungry'), path = '/images/game/states/hungry', id = 'condition_hungry' }

inventoryWindow = nil
inventoryPanel = nil
inventoryButton = nil
purseButton = nil
capLabel = nil
fightOffensiveBox = nil
fightBalancedBox = nil
fightDefensiveBox = nil
chaseModeButton = nil
standModeButton = nil
safeFightButton = nil
fightModeRadioGroup = nil
chaseModeRadioGroup = nil

function init()
	connect(LocalPlayer, {
		onInventoryChange = onInventoryChange,
		onBlessingsChange = onBlessingsChange,
		onFreeCapacityChange = onFreeCapacityChange,
		onStatesChange = onStatesChange
	})
	
	connect(g_game, {
		onGameStart = refresh,
		onGameEnd = offline,
		onFightModeChange = update,
		onChaseModeChange = update,
		onSafeFightChange = update,
		onWalk = check,
		onAutoWalk = check })

	g_keyboard.bindKeyDown('Ctrl+I', toggle)

	inventoryButton = modules.client_topmenu.addRightGameToggleButton('inventoryButton', tr('Inventory') .. ' (Ctrl+I)', '/images/topbuttons/inventory', toggle)
	inventoryButton:setOn(true)
	
	inventoryWindow = g_ui.loadUI('inventory', modules.game_interface.getRightPanel())
	inventoryWindow:disableResize()
	inventoryPanel = inventoryWindow:getChildById('contentsPanel')
	
	purseButton = inventoryPanel:getChildById('purseButton')
	local function purseFunction()
		local purse = g_game.getLocalPlayer():getInventoryItem(InventorySlotPurse)
		if purse then
			g_game.use(purse)
		end
	end
	purseButton.onClick = purseFunction

	capLabel = inventoryWindow:recursiveGetChildById('capLabel')
	
	fightOffensiveBox = inventoryWindow:recursiveGetChildById('fightOffensiveBox')
	fightBalancedBox = inventoryWindow:recursiveGetChildById('fightBalancedBox')
	fightDefensiveBox = inventoryWindow:recursiveGetChildById('fightDefensiveBox')
	chaseModeBox = inventoryWindow:recursiveGetChildById('chaseModeBox')
	standModeBox = inventoryWindow:recursiveGetChildById('standModeBox')
	safeFightBox = inventoryWindow:recursiveGetChildById('safeFightBox')
	
	fightModeRadioGroup = UIRadioGroup.create()
	fightModeRadioGroup:addWidget(fightOffensiveBox)
	fightModeRadioGroup:addWidget(fightBalancedBox)
	fightModeRadioGroup:addWidget(fightDefensiveBox)
	
	chaseModeRadioGroup = UIRadioGroup.create()
	chaseModeRadioGroup:addWidget(chaseModeBox)
	chaseModeRadioGroup:addWidget(standModeBox)
	
	connect(fightModeRadioGroup, { onSelectionChange = onSetFightMode })
	connect(chaseModeRadioGroup, { onSelectionChange = onSetChaseMode })
	connect(safeFightBox, { onCheckChange = onSetSafeFight })
	
	-- load condition icons
	for k,v in pairs(Icons) do
		g_textures.preload(v.path)
	end
	
	refresh()
	inventoryWindow:setup()
end

function terminate()
	disconnect(LocalPlayer, {
		onInventoryChange = onInventoryChange,
		onBlessingsChange = onBlessingsChange,
		onFreeCapacityChange = onFreeCapacityChange,
		onStatesChange = onStatesChange
	})

	disconnect(g_game, {
		onGameStart = refresh,
		onGameEnd = offline,
		onFightModeChange = update,
		onChaseModeChange = update,
		onSafeFightChange = update,
		onWalk = check,
		onAutoWalk = check })

	g_keyboard.unbindKeyDown('Ctrl+I')

	fightModeRadioGroup:destroy()
	chaseModeRadioGroup:destroy()
	inventoryWindow:destroy()
	inventoryButton:destroy()
end

function toggleAdventurerStyle(hasBlessing)
  for slot = InventorySlotFirst, InventorySlotLast do
    local itemWidget = inventoryPanel:getChildById('slot' .. slot)
    if itemWidget then
      itemWidget:setOn(hasBlessing)
    end
  end
end

function update()
	local fightMode = g_game.getFightMode()
	if fightMode == FightOffensive then
		fightModeRadioGroup:selectWidget(fightOffensiveBox)
	elseif fightMode == FightBalanced then
		fightModeRadioGroup:selectWidget(fightBalancedBox)
	else
		fightModeRadioGroup:selectWidget(fightDefensiveBox)
	end
	
	local chaseMode = g_game.getChaseMode()
	if chaseMode == ChaseOpponent then
		chaseModeRadioGroup:selectWidget(chaseModeBox)
	else
		chaseModeRadioGroup:selectWidget(standModeBox)
	end
	
	local safeFight = g_game.isSafeFight()
	safeFightBox:setChecked(not safeFight)
end

function refresh()
  local player = g_game.getLocalPlayer()
  for i = InventorySlotFirst, InventorySlotPurse do
    if g_game.isOnline() then
      onInventoryChange(player, i, player:getInventoryItem(i))
	  onFreeCapacityChange(player, player:getFreeCapacity())
	  onStatesChange(player, player:getStates(), 0)
    else
      onInventoryChange(player, i, nil)
    end
    toggleAdventurerStyle(player and Bit.hasBit(player:getBlessings(), Blessings.Adventurer) or false)
  end
  
	local char = g_game.getCharacterName()

	local lastCombatControls = g_settings.getNode('LastCombatControls')
	
	if not table.empty(lastCombatControls) then
		if lastCombatControls[char] then
			g_game.setFightMode(lastCombatControls[char].fightMode)
			g_game.setChaseMode(lastCombatControls[char].chaseMode)
			g_game.setSafeFight(lastCombatControls[char].safeFight)
			if lastCombatControls[char].pvpMode then
				g_game.setPVPMode(lastCombatControls[char].pvpMode)
			end
		end
	end

	-- Setting things
	update()
	
	purseButton:setVisible(g_game.getFeature(GamePurseSlot))
end

function toggle()
  if inventoryButton:isOn() then
    inventoryWindow:close()
    inventoryButton:setOn(false)
  else
    inventoryWindow:open()
    inventoryButton:setOn(true)
  end
end

function onMiniWindowClose()
  inventoryButton:setOn(false)
end

function toggleIcon(bitChanged)
  local content = inventoryWindow:recursiveGetChildById('conditionPanel')

  local icon = content:getChildById(Icons[bitChanged].id)
  if icon then
    icon:destroy()
  else
    icon = loadIcon(bitChanged)
    icon:setParent(content)
  end
end

function loadIcon(bitChanged)
  local icon = g_ui.createWidget('ConditionWidget', content)
  icon:setId(Icons[bitChanged].id)
  icon:setImageSource(Icons[bitChanged].path)
  icon:setTooltip(Icons[bitChanged].tooltip)
  return icon
end

function offline()
  inventoryWindow:recursiveGetChildById('conditionPanel'):destroyChildren()
  local lastCombatControls = g_settings.getNode('LastCombatControls')
  if not lastCombatControls then
    lastCombatControls = {}
  end

  local player = g_game.getLocalPlayer()
  if player then
    local char = g_game.getCharacterName()
    lastCombatControls[char] = {
      fightMode = g_game.getFightMode(),
      chaseMode = g_game.getChaseMode(),
      safeFight = g_game.isSafeFight()
    }

    if g_game.getFeature(GamePVPMode) then
      lastCombatControls[char].pvpMode = g_game.getPVPMode()
    end

    -- save last combat control settings
    g_settings.setNode('LastCombatControls', lastCombatControls)
  end
end

-- hooked events
function onInventoryChange(player, slot, item, oldItem)
  if slot > InventorySlotPurse then return end

  if slot == InventorySlotPurse then
    if g_game.getFeature(GamePurseSlot) then
      purseButton:setEnabled(item and true or false)
    end
    return
  end

  local itemWidget = inventoryPanel:getChildById('slot' .. slot)
  if item then
    itemWidget:setStyle('InventoryItem')
    itemWidget:setItem(item)
  else
    itemWidget:setStyle(InventorySlotStyles[slot])
    itemWidget:setItem(nil)
  end
end

function onBlessingsChange(player, blessings, oldBlessings)
  local hasAdventurerBlessing = Bit.hasBit(blessings, Blessings.Adventurer)
  if hasAdventurerBlessing ~= Bit.hasBit(oldBlessings, Blessings.Adventurer) then
    toggleAdventurerStyle(hasAdventurerBlessing)
  end
end

local function commafy(str)
	if (string.len(str) <= 3) then return str end
	str = tostring(str)
    return #str % 3 == 0 and str:reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or str:reverse():gsub("(%d%d%d)", "%1,"):reverse()
end

function onFreeCapacityChange(player, freeCapacity)
  capLabel:setText(freeCapacity)
end

function onStatesChange(player, now, old)
  if now == old then return end

  local bitsChanged = bit32.bxor(now, old)
  for i = 1, 32 do
    local pow = math.pow(2, i-1)
    if pow > bitsChanged then break end
    local bitChanged = bit32.band(bitsChanged, pow)
    if bitChanged ~= 0 then
      toggleIcon(bitChanged)
    end
  end
end


---

function onSetFightMode(self, selectedFightButton)
	if selectedFightButton == nil then return end
	local buttonId = selectedFightButton:getId()
	local fightMode
	
	if buttonId == 'fightOffensiveBox' then
		fightMode = FightOffensive
	elseif buttonId == 'fightBalancedBox' then
		fightMode = FightBalanced
	else
		fightMode = FightDefensive
	end
	
	-- changed here!
	
	g_game.setFightMode(fightMode)
end

function onSetChaseMode(self, selectedChaseButton)
	if selectedChaseButton == nil then return end
	local buttonId = selectedChaseButton:getId()
	local chaseMode
	
	if buttonId == 'chaseModeBox' then
		chaseMode = ChaseOpponent
	else
		chaseMode = DontChase
	end
	
	g_game.setChaseMode(chaseMode)
end

function onSetSafeFight(self, checked)
	g_game.setSafeFight(not checked)
end

function check()
  if modules.client_options.getOption('autoChaseOverride') then
    if g_game.isAttacking() and g_game.getChaseMode() == ChaseOpponent then
      g_game.setChaseMode(DontChase)
    end
  end
end
