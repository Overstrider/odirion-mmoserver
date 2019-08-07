function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
	local effect = tonumber(param)
	player:getPosition():sendMagicEffect(effect)
	return false
end
