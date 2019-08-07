function onSay(cid, words, param, channelId)
		local str = ""

		for taskname, taskinfo in pairs(TaskSystem.MonsterList) do
			str = str.. "Task Info:\n"
			local taskStatus = getPlayerStorageValue(cid, taskinfo.storages.id)

			str = str.. "    Kill ".. taskinfo.count.. " ".. taskname.. "\n"
			if taskStatus == TaskSystem.StorageValue.inTask then
				local count = getPlayerStorageValue(cid, taskinfo.storages.count)
				str = str.. "    Status: Total [" .. count .. "/" .. taskinfo.count .. "]\n"
			elseif taskStatus == TaskSystem.StorageValue.finishedTask then
				str = str.. "    Status: Completed!\n"
			end

			str = str.. "\n"
		end

		doShowTextDialog(cid, 1950, str)
		return true
	end