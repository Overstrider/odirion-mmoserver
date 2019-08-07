--------------------By Jpkulik!---------------------------- 
local keywordHandler = KeywordHandler:new() 
local npcHandler = NpcHandler:new(keywordHandler) 
NpcSystem.parseParameters(npcHandler) 



-- OTServ event handling functions start 
function onCreatureAppear(cid)                npcHandler:onCreatureAppear(cid) end 
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid) end 
function onCreatureSay(cid, type, msg)     npcHandler:onCreatureSay(cid, type, msg) end 
-- Set the greeting message. 
--npcHandler:setMessage(MESSAGE_GREET, HelloText) 
function onThink()                         npcHandler:onThink() end 
-- OTServ event handling functions end 
local function creatureSayCallback(cid, type, msg)
	
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	
	if (msgcontains(msg, 'bring') and msgcontains(msg, 'me') and msgcontains(msg, 'to') and msgcontains(msg, 'thule') and (not npcHandler:isFocused(cid))) then
		if doPlayerRemoveMoney(cid, 1000) == TRUE then
		doTeleportThing(cid,{x=2043, y=2259, z=6})
		npcHandler:addFocus(cid)
		else 
         selfSay('Sorry, you don\'t have enough money.') 
        end
       end		 
	return true
end		
---------------------------------------MENSAGES CONFIG-------------------------------------------- 
local HelloText = 'Hello |PLAYERNAME|. Welcome to my Boat!' 
local HelpText = 'Do you need help?I can tell you some {passage}.' 
local DestinationText = 'I can take you to {Thule}.'            
local CitysText = 'I can take you to {Thule}.'  
local JobText = 'Im an Captain, and this is my Boat.'                                                                  
---------------------------------------END MENSAGES CONFIG---------------------------------------- 



---------------------------------------CARLIN CONFIG---------------------------------------------- 
local CarlinPosition = {x=2043, y=2259, z=6}              ----> Destination from Carlin Boat <---- 
local CarlinCost = 1000                          ----> Cost to Travel for Carlin    <---- 
carlin = true                                            ---->TRUE:Working/FALSE:Not Working<---- 
---------------------------------------END CARLIN CONFIG------------------------------------------ 



---CARLIN----------------------------------------------------------------------------------------------------------------------------------------- 
local CarlinText = 'Do you want to Travel to Thule for 1000 gold coins?' 
local CarlinTextNo = 'Ok, come back when you want then!' 
local NoTravel = 'Sorry, i do not travel to this city..' 
local CarlinLvl = 1 
local CarlinPremium = false --True/false 

--Carlin-- 
if carlin == true then 
local travelNode = keywordHandler:addKeyword({'thule'},  
StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = CarlinText }) 
travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = CarlinPremium, level = CarlinLvl, cost = CarlinCost, destination = CarlinPosition }) 
travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = CarlinTextNo }) 
else 
local travelNode = keywordHandler:addKeyword({'thule'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = NoTravel }) 
end 
--End Carlin-- 


--------------------------------------------------------------------------------------------------------------------------------------------------- 




keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = DestinationText }) 
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = JobText }) 
keywordHandler:addKeyword({'citys'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = CityText }) 
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = HelpText }) 

-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback) 
npcHandler:addModule(FocusModule:new())

