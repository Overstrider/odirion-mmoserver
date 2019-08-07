local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combat, COMBAT_PARAM_BLOCKSHIELD, 1)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatFormula(combat, COMBAT_FORMULA_SKILL, 1.0, 0, 1.0, 0)


-- function getSlottedItems(player)
    -- local weapon = nil
	
	-- for a = 5, 6 do
		-- if pushThing(player:getSlotItem(a)).itemid ~= 0 then
			-- weapon = pushThing(player:getSlotItem(a)).itemid
		-- end
	-- end
    -- return ItemType( weapon ):getElementType()
-- end
 
 
function onUseWeapon(cid, var)
	
	return doCombat(cid, combat, var)
end  