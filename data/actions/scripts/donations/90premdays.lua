function onUse(cid, item, frompos, item2, topos)
	doRemoveItem(item.uid, 1)
	doPlayerAddPremiumDays(cid, 90)
	doPlayerSendTextMessage(cid, 22, "90 days of premium account have been added to your account, relog your whole account to activate it!")
end