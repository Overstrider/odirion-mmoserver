function onUseWeapon(cid, var)
	return doCombat(cid, combat, var)
end

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 18)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_BLOCKSHIELD, true)
combat:setFormula(COMBAT_FORMULA_SKILL, 1, 0, 1, 0)

function onUseWeapon(player, variant)
	return combat:execute(player, variant)
end
