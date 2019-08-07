local cfg = {
    name = "Paralyze Tri", -- Nome da Spell (Nome Clássico)
    vocs = {2, 6} -- Vocações que Podem Aprender
}
 
function onUse(cid, item, fromPosition, itemEx, toPosition)
    if isInArray(cfg.vocs, getPlayerVocation(cid)) then
        get = getPlayerLearnedInstantSpell(cid, cfg.name)
         if not get then
            local player = Player(cid)
            player:learnSpell(cfg.name)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Congratulations, you have been learned "..cfg.name.." successfully.")
            doSendMagicEffect(getThingPos(cid), 12)
            doRemoveItem(item.uid)
        else
            doPlayerSendCancel(cid, "You already learned this spell.")
        end
    else
        doPlayerSendCancel(cid, "Sorry, but you don't have vocation to learn this spell.")
    end
return true
end