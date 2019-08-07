function onExtendedOpcode(player, opcode, buffer)
	if opcode == 10 then
		player:setStorageValue(40010, 0) 			
	elseif opcode == 45 then
		player:setUniqueCliente(buffer)
	end
end
