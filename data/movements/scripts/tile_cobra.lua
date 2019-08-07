local tempo = 10 -- Tempo em Segundos

local poison = createConditionObject(CONDITION_POISON)
setConditionParam(poison, CONDITION_PARAM_DELAYED, 10)
setConditionParam(poison, CONDITION_PARAM_TICKS, tempo*1000)
addDamageCondition(poison, 40, 4000, -3)

function onStepIn(cid, item, position, fromPosition)
if isCreature(cid) then
if not getCreatureCondition(cid, CONDITION_POISON) then
setPlayerStorageValue(cid, 10051, 1)
doAddCondition(cid, poison)
end
end
return TRUE
end