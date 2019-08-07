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

function creatureSayCallback(cid, type, msg)
if (msgcontains(msg, "djanni'hah") or msgcontains(msg, "DJANNI'HAH")) and (not npcHandler:isFocused(cid)) then
npcHandler:say("I am already talking to one of you creeps. So shut up until it is your turn, "..getCreatureName(cid) ..".", cid, 100)
npcHandler:addFocus(cid)
return true
end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

shopModule:addSellableItem({'sword ring'}, 2207, 100, 'sword ring') 
shopModule:addSellableItem({'club ring'}, 2209, 100, 'club ring') 
shopModule:addSellableItem({'axe ring'}, 2208, 100, 'axe ring') 
shopModule:addSellableItem({'power ring'}, 2166, 50, 'power ring') 
shopModule:addSellableItem({'stealth ring'}, 2165, 200, 'stealth ring')
shopModule:addSellableItem({'stone skin amulet'}, 2197, 500, 'stone skin amulet') 
shopModule:addSellableItem({'elven amulet'}, 2198, 100, 'elven amulet') 
shopModule:addSellableItem({'bronze amulet'}, 2172, 50, 'bronze amulet') 
shopModule:addSellableItem({'garlic necklace'}, 2199, 50, 'garlic necklace')  
shopModule:addSellableItem({'magic light wand'}, 2162, 35, 'magic light wand') 
shopModule:addSellableItem({'orb'}, 2176, 750, 'orb') 
shopModule:addSellableItem({'mind stone'}, 2178, 100, 'mind stone') 
shopModule:addSellableItem({'life crystal'}, 2177, 50, 'life crystal') 

shopModule:addBuyableItem({'sword ring'}, 2207, 500, 'sword ring') 
shopModule:addBuyableItem({'club ring'}, 2209, 500, 'club ring') 
shopModule:addBuyableItem({'axe ring'}, 2208, 500, 'axe ring') 
shopModule:addBuyableItem({'power ring'}, 2166, 100, 'power ring') 
shopModule:addBuyableItem({'stealth ring'}, 2165, 5000, 'stealth ring')
shopModule:addBuyableItem({'stone skin amulet'}, 2197, 5000, 'stone skin amulet') 
shopModule:addBuyableItem({'elven amulet'}, 2198, 500, 'elven amulet') 
shopModule:addBuyableItem({'bronze amulet'}, 2172, 100, 'bronze amulet') 
shopModule:addBuyableItem({'garlic necklace'}, 2199, 100, 'garlic necklace')
shopModule:addBuyableItem({'magic light wand'}, 2162, 120, 'magic light wand') 