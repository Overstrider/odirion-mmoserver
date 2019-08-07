local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combat, COMBAT_PARAM_BLOCKSHIELD, 1)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combat, COMBAT_FORMULA_SKILL, 1.0, 0, 1.0, 0)
 
 
function onUseWeapon(cid, var)
	local icerapier = nil			
	for a = 5, 6 do
		if getPlayerSlotItem(cid, a).itemid == 2396 then
			icerapier = getPlayerSlotItem(cid, a)
		end
	end
	doCombat(cid, combat, var)
    doRemoveItem(icerapier.uid, 1)
	return true
end  