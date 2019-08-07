local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
function onCreatureAppear(cid)          npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                      npcHandler:onThink()                        end
 
local cfg = {
    storage = 12120, -- Não precisa Mexer
    tasksto = 12121, -- Não precisa Mexer
    countMino = 100, -- Quantos Minotaurs Precisa Matar
    pacote = {id = 2663, count = 1}, -- Pacote Intacto e Quantidade
}
 
function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
 
    if msgcontains(msg, 'mission') then
        if getPlayerStorageValue(cid, cfg.storage) < 1 then
            npcHandler:say('You may already know that some people from overseas do not look at us with good eyes, Thorin is afraid that a possible traitor enters his city and destroys his accomplishments, but i belive that not all warriors are like that, and im ready to proove him so, if you agree to perfom certains tasks that proove your skills as a warrior and your loyalty to us. Are you willing to try?')
            talk_state = 1
        elseif getPlayerStorageValue(cid, cfg.storage) == 1 then
            if getPlayerStorageValue(cid, cfg.tasksto) < cfg.countMino then
                npcHandler:say('You killed '..getPlayerStorageValue(cid, cfg.tasksto)..' minotaur furious by now, come back when you kill '..cfg.countMino..'.')
                talk_state = 0
            else
                npcHandler:say('Congratulations you have successfully completed this mission, i have a task a little more difficult this time, would you do it?')
                talk_state = 2
            end
        elseif getPlayerStorageValue(cid, cfg.storage) == 2 then
            if getPlayerStorageValue(cid, cfg.tasksto) < cfg.countMino then
                npcHandler:say('You killed '..getPlayerStorageValue(cid, cfg.tasksto)..' minotaur leaders by now, come back when you kill '..cfg.countMino..'.')
                talk_state = 0
            else
                npcHandler:say('Congratulations you have successfully completed this mission, i have a task a little more difficult this time, would you do it?')
                talk_state = 3
            end
           
        elseif getPlayerStorageValue(cid, cfg.storage) == 3 then
            npcHandler:say('Your mission has already been given, delivered to the npc Sirius at the entrance of the city of Dundeya, 100 horn minotaurs and a dragon scale mail, in return he will give you a package that should not be breached and should be brought to me immediately, I am waiting.')
            talk_state = 0
           
        elseif getPlayerStorageValue(cid, cfg.storage) == 4 then
            npcHandler:say('What takes my young man, I hate to wait, I hope my package is intact, you brought him, correct?')
            talk_state = 5
       
        end
   
    -- [[ Mino Furious ]] --
    elseif msgcontains(msg, 'yes') and talk_state == 1 then
        npcHandler:say('I see you have courage, kill 100 Minotaur Furious and if you manage to stay alive Come Back here, and ill give you your second mission.')
        setPlayerStorageValue(cid, cfg.storage, 1)
        setPlayerStorageValue(cid, cfg.tasksto, 0)
        talk_state = 0
           
    -- [[ Mino Leaders ]] --
    elseif msgcontains(msg, 'yes') and talk_state == 2 then
        npcHandler:say('Do you have enough strength to kill 100 minotaurs leaders?')
        setPlayerStorageValue(cid, cfg.storage, 2)
        setPlayerStorageValue(cid, cfg.tasksto, 0)
        talk_state = 0
       
    -- [[ Ativando Missão dos Itens ]] --
    elseif msgcontains(msg, 'yes') and talk_state == 3 then
        npcHandler:say('Its time for you to prove that you are cold-blooded and willing to give up material stuff, delivered to Sirius npc at the entrance to the city of Dundeya, 100 minotaur horn and a dragon scale mail, in exchange he will give you a package that should not Be violated and must be brought to me immediately, can I trust you?')
        talk_state = 4
 
        elseif msgcontains(msg, 'yes') and talk_state == 4 then
            npcHandler:say('Okay, then go.')
            setPlayerStorageValue(cid, cfg.storage, 3)
            setPlayerStorageValue(cid, cfg.tasksto, 0)
            talk_state = 0
           
    -- [[ Trazendo Itens ]] --
    elseif msgcontains(msg, 'yes') and talk_state == 5 then
        if getPlayerItemCount(cid, cfg.pacote.id) >= cfg.pacote.count then
            doPlayerRemoveItem(cid, cfg.pacote.id, cfg.pacote.count)
            npcHandler:say('All right then, now you have access to the city of Dundeya.')
            setPlayerStorageValue(cid, cfg.storage, 5)
            talk_state = 0
        else
            npcHandler:say('Do not try to curl up, wheres the package you promised me?')
            talk_state = 0
        end
    end
 
return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())