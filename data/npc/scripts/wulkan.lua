local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
-- OTServ event handling functions end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)
shopModule:addSellableItem({'magic plate armor'},2472, 200000,'magic plate armor')
shopModule:addSellableItem({'demon armor'},2494, 150000,'demon armor')
shopModule:addSellableItem({'magic sword'},2400, 150000,'magic sword')
shopModule:addSellableItem({'stonecutter axe'},2431, 150000,'stonecutter axe')
shopModule:addSellableItem({'vanquisher'},6092, 100000,'vanquisher')
shopModule:addSellableItem({'golden legs'},2470, 50000,'golden legs')
shopModule:addSellableItem({'ancient legs'},6093, 45000,'ancient legs')
shopModule:addSellableItem({'demon helmet'},2493, 45000,'demon helmet')
shopModule:addSellableItem({'ancient helmet'},6089, 42000,'ancient helmet')
shopModule:addSellableItem({'ancient sword'},6090, 40000,'ancient sword')
shopModule:addSellableItem({'demonbone armor'},6087, 40000,'demonbone armor')
shopModule:addSellableItem({'helmet of the ancients'},2342, 40000,'helmet of the ancients')
shopModule:addSellableItem({'hellforged shield'},6088, 36000,'hellforged shield')
shopModule:addSellableItem({'daraman blade'},6073, 35000,'daraman blade')
shopModule:addSellableItem({'silver mace'},2424, 16500,'silver mace')
shopModule:addSellableItem({'demonbone boots'},6094, 14000,'demonbone boots')
shopModule:addSellableItem({'torn quicksand boots'},6081, 10000,'torn quicksand boots')
shopModule:addSellableItem({'demonbone helmet'},6086, 9000,'demonbone helmet')
shopModule:addSellableItem({'assassin blade'},6079, 6300,'assassin blade')
shopModule:addSellableItem({'ancient boots'},6091, 5000,'ancient boots')
shopModule:addSellableItem({'wood maul'},6074, 2000,'wood maul')
shopModule:addSellableItem({'soul dagger'},6083, 200,'soul dagger')
npcHandler:addModule(FocusModule:new())