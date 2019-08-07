function getListShop(player)
	local resultId = db.storeQuery("SELECT * FROM `znote_shop_orders` where account_id = "..player:getAccountId().." ORDER BY `znote_shop_orders`.`id` ASC")
	if resultId == false or resultId == -1 then
		player:sendExtendedOpcode(191, 1)
		return player:sendTextMessage(MESSAGE_INFO_DESCR,"You don't have any orders.")
	end
	if (resultId ~= false or resultId == -1) then
		repeat	
			local id = result.getNumber(resultId, "id")					
			local itemid = result.getNumber(resultId, "itemid")			
			player:sendExtendedOpcode(190, "{"..id..", '"..getItemName(itemid).."', '"..itemid.."'}")					
		until not result.next(resultId)
		result.free(resultId)
	end
	player:sendExtendedOpcode(191, 1)
return true
end

function sendItemShop(player, id)
	local resultId = db.storeQuery("SELECT itemid FROM `znote_shop_orders` WHERE `id` = "..id.." AND `account_id` = "..player:getAccountId().." ORDER BY `id` ASC")
	if resultId == false or resultId == -1 then
		player:sendExtendedOpcode(191, 1)
		return player:sendTextMessage(MESSAGE_INFO_DESCR,"You don't have any orders.")
	end
	if (resultId ~= false or resultId ~= -1) then				
			local itemid = result.getNumber(resultId, "itemid")
			player:addItem(itemid)
			db.asyncQuery("DELETE FROM `znote_shop_orders` WHERE `znote_shop_orders`.`id` = "..id.." and account_id = "..player:getAccountId().."")	
		result.free(resultId)
	end
return true
end

function onSay(player, words, param)
	local split = param:split(" ")
	if split[1] == "list" then
		getListShop(player)
	elseif split[1] == "remove" then
		if not split[2] then		
			return true		
		end
		sendItemShop(player, split[2])
		getListShop(player)	
	end
	return false
end