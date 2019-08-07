local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
local npcHandlerfocus = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)                  npcHandler:onCreatureAppear(cid)                        end
function onCreatureDisappear(cid)               npcHandler:onCreatureDisappear(cid)                     end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                                              npcHandler:onThink()    end

function LuboSayCallback (cid, type, msg)
if (getPlayerStorageValue(cid, Storage.ParadoxTower.Padreia) ~= 1) then
   return true
end

		if msgcontains(msg, 'hello') then
        npcHandler:say('Welcome to my adventurer shop, '..getPlayerName(cid)..' ! What do you need? Ask me for a trade to look at my wares.', cid)
        talk_state = 1	
		npcHandler:addFocus(cid)
		elseif msgcontains(msg, 'crunor\'s cottage') then
        npcHandler:say('Ah yes, I remember my grandfather talking about that name. This house used to be an inn a long time ago. My family bought it from some of these flower', cid)
        talk_state = 1
		elseif msgcontains(msg, 'flower guys') and talk_state == 1 then
            npcHandler:say('Oh, I mean druids of course. They sold the cottage to my family after some of them died in an accident or something like that.', cid)
                talk_state = 2
		elseif msgcontains(msg, 'accident') and talk_state == 2 then
            npcHandler:say('As far as I can remember the story, a pet escaped its stable behind the inn. It got somehow involved with powerfull magic at a ritual and was transformed in some way.', cid)
                talk_state = 3
		elseif msgcontains(msg, 'stable') and talk_state == 3 then
            npcHandler:say('My grandpa told me, in the old days there were some behind this cottage. Nothing big though, just small ones, for chicken or rabbits.', cid)
                setPlayerStorageValue(cid, Storage.ParadoxTower.Lubo, 1)
				talk_state = 4
		elseif msgcontains(msg, 'bye') and (talk_state >= 1 and talk_state <= 4) then
			npcHandler:say('Farewell.')

			talk_state = 0
		end
	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, LuboSayCallback)
