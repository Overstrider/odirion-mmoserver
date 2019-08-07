function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end
    local split = param:split(",")
    local target = Player(split[1])
    local val = split[2]
    if #split == 2 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Storage number "..val.." of player "..split[1].." is: "..getPlayerStorageValue(target, val).."")
    elseif #split == 3 then
        setPlayerStorageValue(target, val, split[3])
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Storage number "..val.." of player "..split[1].." is now: "..getPlayerStorageValue(target, val).."")  
    else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Invalid number of parameters")
    end
end