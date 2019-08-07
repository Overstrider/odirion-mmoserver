local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0, -0, -0, -0)

local condition = createConditionObject(CONDITION_POISON)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 2, 1500, -45)
addDamageCondition(condition, 2, 1500, -45)
addDamageCondition(condition, 2, 1500, -45)
addDamageCondition(condition, 2, 1500, -45)
addDamageCondition(condition, 2, 1500, -40)
addDamageCondition(condition, 2, 1500, -35)
addDamageCondition(condition, 2, 1500, -30)
addDamageCondition(condition, 3, 1500, -20)
addDamageCondition(condition, 3, 1500, -10)
addDamageCondition(condition, 3, 1500, -7)
addDamageCondition(condition, 3, 1500, -5)
addDamageCondition(condition, 4, 1500, -4)
addDamageCondition(condition, 6, 1500, -3)
addDamageCondition(condition, 9, 1500, -2)
addDamageCondition(condition, 12, 1500, -1)
setCombatCondition(combat, condition)

local arr = {
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end