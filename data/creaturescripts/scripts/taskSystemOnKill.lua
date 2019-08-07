function onKill(cid, target, lastHit)
		if isPlayer(cid) or isPlayer(getCreatureMaster(cid)) and isMonster(target) then
			local taskName = TaskSystem:GetTaskNameByMonsterName(getCreatureName(target))
			if not taskName then
                return true
            end
			local partyMembers = getPartyMembers(cid)
			if TaskSystem:IsSharedPartyEnabled(cid, partyMembers) then
				for index, sid in ipairs(partyMembers) do
					if getPlayerStorageValue(sid, 16661) ~= target then
						if getDistanceBetween(getCreaturePosition(cid), getCreaturePosition(sid)) <= 7 then
							-- print('[Task Message] Killer: '..getCreatureName(cid)..' kill a '..getCreatureName(target)..' and tasked for '..getCreatureName(sid)..'.')
							TaskSystem:AddTaskCountOnKillToPlayer(sid, taskName)
							setPlayerStorageValue(sid, 16661, target)
						else
							-- print('[Task Message] Killer: '..getCreatureName(cid)..' kill a '..getCreatureName(target)..' and NOT tasked for '..getCreatureName(sid)..'.')
						end
					end
				end
			else
				if TaskSystem:IsSharedPartyEnabled(cid, partyMembers) then
					for index, sid in ipairs(partyMembers) do
						doPlayerSendTextMessage(sid, MESSAGE_STATUS_CONSOLE_ORANGE, "You have exceeded the limit of players or do not have enough players in the party to count for all players, only one will receive a monster count." )					
					end
				end
				if getPlayerStorageValue(cid, 16661) ~= target then
					TaskSystem:AddTaskCountOnKillToPlayer(cid, taskName)
					setPlayerStorageValue(cid, 16661, target)
				end
			end
		end
		return true
	end