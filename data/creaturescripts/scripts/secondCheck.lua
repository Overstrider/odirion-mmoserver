function onExtendedOpcode(player, opcode, buffer)
if player:getStorageValue(40011) == 1 then
		local playerId = player:getId()
		player:sendTextMessage(19, "Official client verification.")
		player:sendExtendedOpcode(10, 1)	
		player:setStorageValue(40010, 1)
		player:setStorageValue(40011, 0)
		addEvent(function(cid) 	
			if isPlayer(cid) and player:getStorageValue(40010) == 1 then		
				player:setStorageValue(40010, 0)
				player:setStorageValue(40011, 1)				
				player:sendDisconnectClient("Incomplete verification, the client is not official!")
				-- print("Player Kickado")
			else
				-- print("Player Liberado")
				player:setStorageValue(40011, 1)
				player:sendTextMessage(19, "Verification, always use the official client for your safety.")
			end
		end, 500, playerId)
		-- print("----------------------secondCheck")
end
end