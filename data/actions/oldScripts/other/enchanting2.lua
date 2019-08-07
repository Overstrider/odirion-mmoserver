local t = {
	useOn = 7121,
	newId = 6353
}
function onUse(cid, item, fromPosition, itemEx, toPosition)
    if doPlayerRemoveItem(cid,2342,1) then
		doRemoveItem(item.uid, 1)
		doPlayerAddItem(cid, 6353, 1)
		doCreatureSay(cid, 'You recharged your ' .. ItemType(item.itemid):getName(), TALKTYPE_ORANGE_1)

	else
		doCreatureSay(cid, 'You must use it on a ' .. ItemType(t.useOn):getName(), TALKTYPE_ORANGE_1)
	end
	return true
end