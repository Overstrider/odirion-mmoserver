local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)

function onGetFormulaValues(cid, level, maglevel)
	local base = 200
	local variation = 40

	local min = math.max((base - variation), ((3 * maglevel + 2 * level) * (base - variation) / 100))
	local max = math.max((base + variation), ((3 * maglevel + 2 * level) * (base + variation) / 100))

	return min, max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local arr = {
 {0, 0, 0, 0, 0, 0, 0},
 {0, 0, 1, 1, 1, 0, 0},
 {0, 1, 1, 1, 1, 1, 0},
 {0, 1, 1, 3, 1, 1, 0},
 {0, 1, 1, 1, 1, 1, 0},
 {0, 0, 1, 1, 1, 0, 0},
 {0, 0, 0, 0, 0, 0, 0}
 }

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end