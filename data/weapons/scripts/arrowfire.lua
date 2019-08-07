local combatPoison = createCombatObject()
setCombatParam(combatPoison, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combatPoison, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatPoison, COMBAT_PARAM_DISTANCEEFFECT, 16)
setCombatFormula(combatPoison, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)
 
local poison = createConditionObject(CONDITION_FIRE)
setConditionParam(poison, CONDITION_PARAM_DELAYED, true)
for i = 1, 21 do
    addDamageCondition(poison, 1, 2000, (-22) + i)
end
setCombatCondition(combatPoison, poison)

local combatNormal = createCombatObject()
setCombatParam(combatNormal, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combatNormal, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatNormal, COMBAT_PARAM_DISTANCEEFFECT, 16)
setCombatFormula(combatNormal, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)
 
local normal = createConditionObject(COMBAT_PHYSICALDAMAGE)
setConditionParam(normal, CONDITION_PARAM_DELAYED, 1)
setCombatCondition(combatNormal, normal)
 

function onUseWeapon(cid, var)
    local bowsList = {5654}

    for index, id in ipairs(bowsList) do
        if getPlayerSlotItem(cid, CONST_SLOT_LEFT).itemid == id or getPlayerSlotItem(cid, CONST_SLOT_RIGHT).itemid == id then
            return doCombat(cid, combatPoison, var)
        end
    end
    
    return doCombat(cid, combatNormal, var)
end