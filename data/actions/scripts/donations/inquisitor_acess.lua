local scroll_storage = 111111 -- Coloque Uma Não Utilizada

function onUse(cid, item, itemEx, toPosition)
	if(getPlayerStorageValue(cid, scroll_storage) == 1) then
		doPlayerSendTextMessage(cid, 22, "You already have Inquisitor Guild Acess!")
	else
		doRemoveItem(item.uid, 1)
		setPlayerStorageValue(cid, scroll_storage, 1)
		doPlayerSendTextMessage(cid, 22, "You now have access to Inquisitor Guild!")
	end
return true
end