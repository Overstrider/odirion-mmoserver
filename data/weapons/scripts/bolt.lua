-- [[ Poison Crossbow ]] --
local combatPoison = createCombatObject()
    setCombatParam(combatPoison, COMBAT_PARAM_BLOCKARMOR, 1)
    setCombatParam(combatPoison, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
    setCombatFormula(combatPoison, COMBAT_FORMULA_SKILL, 1, 0, 1, 0) 
local poison = createConditionObject(CONDITION_POISON)
    setConditionParam(poison, CONDITION_PARAM_DELAYED, true)
    for i = 1, 26 do
        addDamageCondition(poison, 1, 2000, (-27) + i)
    end
    setCombatCondition(combatPoison, poison)
-- [[ Poison Crossbow ]] --
 
-- [[ Fire Crossbow ]] --
local combatFire = createCombatObject()
    setCombatParam(combatFire, COMBAT_PARAM_BLOCKARMOR, 1)
    setCombatParam(combatFire, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
    setCombatFormula(combatFire, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)
local fire = createConditionObject(CONDITION_FIRE)
    setConditionParam(fire, CONDITION_PARAM_DELAYED, true)
    for i = 1, 26 do
        addDamageCondition(fire, 1, 2000, (-27) + i)
    end
    setCombatCondition(combatFire, fire)
-- [[ Fire Crossbow ]] --

-- [[ Energy Crossbow ]] --
local combatEnergy = createCombatObject()
    setCombatParam(combatEnergy, COMBAT_PARAM_BLOCKARMOR, 1)
    setCombatParam(combatEnergy, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
    setCombatFormula(combatEnergy, COMBAT_FORMULA_SKILL, 1, 0, 1, 0) 
local energy = createConditionObject(CONDITION_ENERGY)
    setConditionParam(energy, CONDITION_PARAM_DELAYED, true)
    for i = 1, 26 do
        addDamageCondition(energy, 1, 2000, (-27) + i)
    end
    setCombatCondition(combatEnergy, energy)
-- [[ Energy Crossbow ]] --
 
-- [[ Death Crossbow ]] --
local combatDeath = createCombatObject()
    setCombatParam(combatDeath, COMBAT_PARAM_BLOCKARMOR, 1)
    setCombatParam(combatDeath, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
    setCombatParam(combatDeath, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
    setCombatFormula(combatDeath, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)
local death = createConditionObject(COMBAT_PHYSICALDAMAGE)
    setConditionParam(death, CONDITION_PARAM_DELAYED, 1)
    setCombatCondition(combatDeath, death)
-- [[ Death Crossbow ]] -- 
 
local combatNormal = createCombatObject()
    setCombatParam(combatNormal, COMBAT_PARAM_BLOCKARMOR, 1)
    setCombatParam(combatNormal, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
	setCombatParam(combatNormal, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BOLT)
    setCombatFormula(combatNormal, COMBAT_FORMULA_SKILL, 1, 0, 1, 0) 
local normal = createConditionObject(COMBAT_PHYSICALDAMAGE)
    setConditionParam(normal, CONDITION_PARAM_DELAYED, 1)
    setCombatCondition(combatNormal, normal)

function onUseWeapon(cid, var)
	local player = Player(cid)
	local position = player:getPosition()
	local target = getCreatureTarget(cid)
    local crossbows = {
        [5651] = {comb = combatPoison, cond = CONDITION_POISON, shootEffect = 19},
        [5652] = {comb = combatEnergy, cond = CONDITION_ENERGY, shootEffect = 43},
        [5653] = {comb = combatFire, cond = CONDITION_FIRE, shootEffect = 23},
        [6344] = {comb = combatDeath, cond = CONDITION_DEATH, shootEffect = 27},
    }
    item = nil
    if getPlayerSlotItem(cid, CONST_SLOT_LEFT).itemid > 0 then
        item = getPlayerSlotItem(cid, CONST_SLOT_LEFT).itemid
    elseif getPlayerSlotItem(cid, CONST_SLOT_RIGHT).itemid > 0 then
        item = getPlayerSlotItem(cid, CONST_SLOT_RIGHT).itemid
    end
    weapon = crossbows[item]
    if weapon then	
		position:sendDistanceEffect(getCreaturePosition(target), weapon.shootEffect)
		-- doSendDistanceShoot(getThingPos(cid), target, weapon.shootEffect)
        if not getCreatureCondition(target, weapon.cond) then
            return doCombat(cid, weapon.comb, var)
        else
            return doCombat(cid, combatNormal, var)
        end
    else
		position:sendDistanceEffect(getCreaturePosition(target), CONST_ANI_BOLT)
        return doCombat(cid, combatNormal, var)
    end
end