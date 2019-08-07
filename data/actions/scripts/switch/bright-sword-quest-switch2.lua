local id = {
	pedra = 1304,
	parede = 1025,
	anel = 2166,
	barrel = 1774,
}

function onUse(cid, item, frompos, item2, topos)
	gatepos = {x=32614, y=32206, z=10}
	getgate = getTileItemById(gatepos, id.pedra)

	barrilpos = {x=32614, y=32209, z=10}
	getbarril = getTileItemById(barrilpos, id.barrel)

	anelpos = {x=32613, y=32220, z=10}
	getanel = getTileItemById(anelpos, id.anel)

	pedrapos = {x=32614, y=32221, z=10}
	getpedra = getTileItemById(pedrapos, id.parede)

	fogopos = {x=32616, y=32222, z=10, stackpos=1}
	getfogo = getThingfromPos(fogopos)

	paredepos = {x=32603, y=32216, z=9, stackpos=1}
	getparede = getThingfromPos(fogopos)

	parede1pos = {x=32604, y=32216, z=9, stackpos=1}
	getparede1 = getThingfromPos(fogopos)

	barril = {x=32613, y=32220, z=10, stackpos=1} -- power ring

	if item.uid == 15045 and item.itemid == 1945 and getgate.uid > 0 and getbarril.uid > 0 and getanel.uid > 0 then
		doRemoveItem(getgate.uid, 1)
		doRemoveItem(getanel.uid, 1)
		if getpedra.uid > 0 then
			doRemoveItem(getpedra.uid,1)
		end
		doDecayItem(doCreateItem(1492,1,anelpos)) -- criando fogo1
		doDecayItem(doCreateItem(1492,1,fogopos)) -- criando fogo2
		doCreateItem(1026,1,paredepos) -- criando parede
		doCreateItem(1026,1,parede1pos) -- criando parede2
		addEvent(doCreateItem, (300*1000), id.pedra, 1, gatepos) -- recriando pedra
		addEvent(doCreateItem, (300*1000), id.parede, 1, pedrapos) -- recriando parede
		addEvent(function()
			doRemoveItem(getTileItemById(barrilpos, id.barrel).uid)
		end, 300* 1000)
		doTransformItem(item.uid,item.itemid+1)
	elseif item.uid == 15045 and item.itemid == 1946 and getgate.itemid == 1304 then
		doTransformItem(item.uid,item.itemid-1)
		doPlayerSendCancel(cid, "Lever prepared for use.")
	else
		doPlayerSendCancel(cid,"Sorry not possible.")
	end
  return 1
end