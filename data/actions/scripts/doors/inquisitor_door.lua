local opendoor = 1226
local scroll_storage = 111111 -- Coloque Uma Não Utilizada
local storages = {
    [851034] = {mission = "Task of Dragons Lords", value = 2},
    [851047] = {mission = "Task of Behemoths", value = 2},
    [851048] = {mission = "Task of Warlocks", value = 2},
    [851049] = {mission = "Task of Demons", value = 2},
    [851050] = {mission = "Task of Hydras", value = 2},
    [851051] = {mission = "Task of Serpents Spawn", value = 2},
    [851052] = {mission = "Task of Icegiants Guards", value = 2},
    [851057] = {mission = "Task of Yetis", value = 2},
    [851053] = {mission = "Task of Obsidians Golems", value = 2},
}

function onUse(cid, item, frompos, item2, topos)
    if item.actionid == 52000 then
        pPos = getThingPos(item.uid)
        if getThingPos(cid).y < pPos.y then
            tpos = {x=pPos.x, y=pPos.y+1, z=pPos.z}
        else
            tpos = {x=pPos.x, y=pPos.y-1, z=pPos.z}
        end
        if getPlayerStorageValue(cid, scroll_storage) > 0 then
            doTeleportThing(cid, tpos)
            return false
        end
        ctrl = 0
        for index, result in pairs(storages) do
            if getPlayerStorageValue(cid, index) >= result.value then
                ctrl = ctrl + 1
            else
                doPlayerSendCancel(cid, "Sorry, but you don't have completed the "..result.mission..".")
                return true
            end
        end
        if ctrl >= #storages then
            doTeleportThing(cid, tpos)
            return false
        else
            doPlayerSendCancel(cid, 'Some error have occurred, please contact to the administrator.')
        end    
    else
        doPlayerSendTextMessage(cid,22,'You do not have access! Talk with {Lauder} to enter in Slayer Guild')
    end
return true
end