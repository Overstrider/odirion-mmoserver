local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
function onCreatureAppear(cid)          npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                      npcHandler:onThink()                        end
 
local cfg = {
    storage = 12120, -- Não precisa Mexer
    pacote = {id = 2663, count = 1}, -- Pacote Intacto e Quantidade
    dsm = 2492, -- ID da DSM
    minoHorn = {id = 5786, count = 100}, -- ID das Horns e Quantidade
}
 
function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
 
    if msgcontains(msg, 'mission') then
        if getPlayerStorageValue(cid, cfg.storage) == 3 then
            npcHandler:say('I think freya already warned you about what you should bring me, did you bring what I want?')
            talk_state = 1
        else
            npcHandler:say('Thank you, you showed that you have no attachment to material things, go back and talk to freyya that everything will be solved and you will be very welcome in dundeya city.')
            talk_state = 0
        end
   
    -- [[ Entrega dos Itens ]] --
    elseif msgcontains(msg, 'yes') and talk_state == 1 then
        if getPlayerItemCount(cid, cfg.dsm) >= 1 then
            if getPlayerItemCount(cid, cfg.minoHorn.id) >= cfg.minoHorn.count then
                doPlayerAddItem(cid, cfg.pacote.id, cfg.pacote.count)
                doPlayerRemoveItem(cid, cfg.dsm, 1)
                doPlayerRemoveItem(cid, cfg.minoHorn.id, cfg.minoHorn.count)
                setPlayerStorageValue(cid, cfg.storage, 4)
                npcHandler:say('Very good! Now please take this present to Freyya, Im sure she will have already convinced Thorin to release her entry into our town. Beware, without this freyya present you will not be sorry to deny help, it does not support poorly done services.')
                talk_state = 0
            else
                npcHandler:say('Do not try to fool me, you do not have '..cfg.minoHorn.count..' '..ItemType(cfg.minoHorn.id):getName()..', come back when you have all.')
                talk_state = 0
            end
        else
            npcHandler:say('Do not try to fool me, you do not have any '..ItemType(cfg.dsm):getName()..', come back when you have.')
            talk_state = 0
        end
    end
 
return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())