local condition = createConditionObject(CONDITION_LIGHT)
setConditionParam(condition, CONDITION_PARAM_LIGHT_LEVEL, 14)
setConditionParam(condition, CONDITION_PARAM_LIGHT_COLOR, 211)
setConditionParam(condition, CONDITION_PARAM_TICKS, -1)

function onEquip(cid, item, slot)
	doAddCondition(cid, condition)
return TRUE
end

function onDeEquip(cid, item, slot)
	doRemoveCondition(cid, CONDITION_LIGHT)

	function DeEquip(cid, item, slot)
	doRemoveCondition(cid, CONDITION_LIGHT)
return TRUE
end
end