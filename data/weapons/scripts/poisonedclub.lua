local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatFormula(combat, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)
 
local condition = createConditionObject(CONDITION_POISON)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 1, 1000, -25)
setCombatCondition(combat, condition)
 
function onUseWeapon(cid, var)
    return doCombat(cid, combat, var)
end