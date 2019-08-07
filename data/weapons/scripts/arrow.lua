local combatPoison = createCombatObject()
setCombatParam(combatPoison, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combatPoison, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combatPoison, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)

setCombatParam(combatPoison, COMBAT_PARAM_DISTANCEEFFECT, 17)

local poison = createConditionObject(CONDITION_POISON)
setConditionParam(poison, CONDITION_PARAM_DELAYED, true)
for i = 1, 21 do
    addDamageCondition(poison, 1, 2000, (-22) + i)
end
setCombatCondition(combatPoison, poison)

local combatNoPoison = createCombatObject()
setCombatParam(combatNoPoison, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combatNoPoison, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combatNoPoison, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)
setCombatParam(combatNoPoison, COMBAT_PARAM_DISTANCEEFFECT, 17)
-- [[ /\ COMBAT POISON /\ ]] --
 
local combatFire = createCombatObject()
setCombatParam(combatFire, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combatFire, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combatFire, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)

setCombatParam(combatFire, COMBAT_PARAM_DISTANCEEFFECT, 16)

local fire = createConditionObject(CONDITION_FIRE)
setConditionParam(fire, CONDITION_PARAM_DELAYED, true)
for i = 1, 21 do
    addDamageCondition(fire, 1, 2000, (-22) + i)
end
setCombatCondition(combatFire, fire)


local combatNoFire = createCombatObject()
setCombatParam(combatNoFire, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combatNoFire, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combatNoFire, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)
setCombatParam(combatNoFire, COMBAT_PARAM_DISTANCEEFFECT, 16)
-- [[ /\ COMBAT FIRE /\ ]] --

local combatBurst = createCombatObject()
setCombatParam(combatBurst, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combatBurst, COMBAT_PARAM_BLOCKSHIELD, 1)
setCombatParam(combatBurst, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatBurst, COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

setCombatParam(combatBurst, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BURSTARROW)

setCombatFormula(combatBurst, COMBAT_FORMULA_LEVELMAGIC, 0, 0, -0.55, 0)
local area = createCombatArea( { {1, 1, 1}, {1, 3, 1}, {1, 1, 1} } )
setCombatArea(combatBurst, area)
-- [[ /\ COMBAT BURST /\ ]] --

local combatEnergy = createCombatObject()
setCombatParam(combatEnergy, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combatEnergy, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combatEnergy, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)

setCombatParam(combatEnergy, COMBAT_PARAM_DISTANCEEFFECT, 18)

local energy = createConditionObject(CONDITION_ENERGY)
setConditionParam(energy, CONDITION_PARAM_DELAYED, true)
for i = 1, 21 do
    addDamageCondition(energy, 1, 2000, (-22) + i)
end
setCombatCondition(combatEnergy, energy)



local combatNoEnergy = createCombatObject()
setCombatParam(combatNoEnergy, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combatNoEnergy, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combatNoEnergy, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)
setCombatParam(combatNoEnergy, COMBAT_PARAM_DISTANCEEFFECT, 18)
-- Combat Energy --

 
local combatNormal = createCombatObject()
setCombatParam(combatNormal, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combatNormal, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combatNormal, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)

setCombatParam(combatNormal, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ARROW)
 
local normal = createConditionObject(COMBAT_PHYSICALDAMAGE)
setConditionParam(normal, CONDITION_PARAM_DELAYED, 1)
setCombatCondition(combatNormal, normal)
 
 
function onUseWeapon(cid, var)
	local player = Player(cid)
	local position = player:getPosition()
	local target = getCreatureTarget(cid)
	local list = {
		[5654] = {element = "Fire", comb = combatFire, combNo = combatNoFire, cond = CONDITION_FIRE},
		[5655] = {element = "Energy", comb = combatEnergy, combNo = combatNoEnergy, cond = CONDITION_ENERGY},
		[5656] = {element = "Poison", comb = combatPoison, combNo = combatNoPoison, cond = CONDITION_POISON},
		[7095] = {element = "Burst", comb = combatBurst, cond = false},
	} 
	item = nil
    if getPlayerSlotItem(cid, CONST_SLOT_LEFT).itemid > 0 then
        item = getPlayerSlotItem(cid, CONST_SLOT_LEFT).itemid
    elseif getPlayerSlotItem(cid, CONST_SLOT_RIGHT).itemid > 0 then
        item = getPlayerSlotItem(cid, CONST_SLOT_RIGHT).itemid
    end
    weapon = list[item]
	target = getCreatureTarget(cid)
    if weapon then
        if not weapon.cond or not getCreatureCondition(target, weapon.cond) then
			local bow = nil
			
			for a = 5, 6 do
				if getPlayerSlotItem(cid, a).itemid == 7095 then
					bow = getPlayerSlotItem(cid, a)
				end
			end
			
			if bow.itemid == 7095 then
				local amount = getItemAttribute(bow.uid, "charges")
				if amount > 1 then
					doItemSetAttribute(bow.uid, "charges", amount - 1)
				else
					doTransformItem(bow.uid, 2456)
				end
			end
            return doCombat(cid, weapon.comb, var)
        else
            return doCombat(cid, weapon.combNo, var)
        end
    else		
        return doCombat(cid, combatNormal, var)
    end 
end