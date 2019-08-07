local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
function onCreatureAppear(cid)          npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                      npcHandler:onThink()                        end
 
local cfg = {
    storage = 12122, -- Não precisa Mexer
    tasksto = 12123, -- Não precisa Mexer
    count = {100, 70}, -- Quantos Thorins
    pacote = {id = 6224, count = 100}, -- Pacote Intacto e Quantidade
    hydra = {id = 6224, count = 100, city = "Kvenland"},
}
 
function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
 
    if msgcontains(msg, 'mission') then
        if getPlayerStorageValue(cid, cfg.storage) < 1 then
            npcHandler:say('Kill 100 Tar priests and show that you are not afraid to face death face to face Are you ready?')
            talk_state = 1
        elseif getPlayerStorageValue(cid, cfg.storage) == 1 then
            if getPlayerStorageValue(cid, cfg.tasksto) < cfg.count[1] then
                npcHandler:say('You killed '..getPlayerStorageValue(cid, cfg.tasksto)..' tar priest by now, come back when you kill '..cfg.count[1]..'.')
                talk_state = 0
            else
                npcHandler:say('Congratulations you have successfully completed this mission, i have a task a little more difficult this time, would you do it?')
                talk_state = 2
            end
        elseif getPlayerStorageValue(cid, cfg.storage) == 2 then
            if getPlayerStorageValue(cid, cfg.tasksto) < cfg.count[2] then
                npcHandler:say('You killed '..getPlayerStorageValue(cid, cfg.tasksto)..' manticore by now, come back when you kill '..cfg.count[2]..'.')
                talk_state = 0
            else
                npcHandler:say('Congratulations you have successfully completed this mission, i have a task a little more difficult this time, would you do it?')
                talk_state = 3
            end
 
        elseif getPlayerStorageValue(cid, cfg.storage) == 3 then
            npcHandler:say('Did you bring the item I ordered?')
            talk_state = 4
                   
        end
   
    -- [[ Mino Furious ]] --
    elseif msgcontains(msg, 'yes') and talk_state == 1 then
        npcHandler:say('I see you have courage, kill 100 Tar Priests and if you manage to stay alive Come Back here, and ill give you your second mission.')
        setPlayerStorageValue(cid, cfg.storage, 1)
        setPlayerStorageValue(cid, cfg.tasksto, 0)
        talk_state = 0
           
    -- [[ Mino Leaders ]] --
    elseif msgcontains(msg, 'yes') and talk_state == 2 then
        npcHandler:say('Do you have enough strength to kill 70 Manticores?')
        setPlayerStorageValue(cid, cfg.storage, 2)
        setPlayerStorageValue(cid, cfg.tasksto, 0)
        talk_state = 0
       
    -- [[ Ativando Missão dos Itens ]] --
    elseif msgcontains(msg, 'yes') and talk_state == 3 then
        npcHandler:say('Your cold blood can prove your loyalty, and its time to get your hands dirty, bring me 100 Hydra Claw and I think Ill have a reply to your entry into the town of Kvenland.')
        talk_state = 4
           
    -- [[ Trazendo Itens ]] --
    elseif msgcontains(msg, 'yes') and talk_state == 4 then
        if getPlayerItemCount(cid, cfg.hydra.id) >= cfg.hydra.count then
            doPlayerRemoveItem(cid, cfg.hydra.id, cfg.hydra.count)
            npcHandler:say('All right then, now you have access to the city of '..cfg.hydra.city..'.')
            setPlayerStorageValue(cid, cfg.storage, 6)
            talk_state = 0
        else
            npcHandler:say('Do not try to curl up, where the '..cfg.hydra.count..' '..ItemType(cfg.hydra.id):getName()..'?')
            talk_state = 0
        end
 
    end
 
return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())