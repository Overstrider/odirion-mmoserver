local storages = {
	{key = 851052, value = 2, mission = "Task of Yetis"},
}

function onStepIn(cid, item, position, fromPosition)
	if isPlayer(cid) then
		for i = 1, #storages do
			if getPlayerStorageValue(cid, storages[i].key) < storages[i].value then
				doTeleportThing(cid, fromPosition, true)
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Sorry, but you need done "..storages[i].mission.." to pass here.")
				return true
			end
		end
	end
return true
end