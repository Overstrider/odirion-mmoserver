-- Annihilator script by GriZzm0
-- Room check and monster removal by Tworn

--Variables used:

-- player?pos  = The position of the players before teleport.
-- player?  = Get the thing from playerpos.
--player?level = Get the players levels.
--questslevel  = The level you have to be to do this quest.
--questtatus?  = Get the quest status of the players.
--demon?pos  = The position of the demons.
--nplayer?pos  = The position where the players should be teleported too.
--trash= position to send the demons to when clearing, 1 sqm in middle of nowhere is enough
-- starting = Upper left point of the annihilator room area.
-- ending = Bottom right point of the annihilator room area.

--UniqueIDs used:

--5000 = The switch.
--5001 = Demon Armor chest.
--5002 = Magic Sword chest.
--5003 = Stonecutter Axe chest.
--5004 = Present chest.
local questlevel = 100
local playerPos = {
  {x=33225, y=31671, z=13},
  {x=33224, y=31671, z=13},
  {x=33223, y=31671, z=13},
  {x=33222, y=31671, z=13}
}

local demonPos = {
  {x=33219, y=31657, z=13},
  {x=33221, y=31657, z=13},
  {x=33220, y=31661, z=13},
  {x=33222, y=31661, z=13},
  {x=33223, y=31659, z=13},
  {x=33224, y=31659, z=13}
}

local pDestiny = {
  {x=33222, y=31659, z=13},
  {x=33221, y=31659, z=13},
  {x=33220, y=31659, z=13},
  {x=33219, y=31659, z=13},
}

function onUse(cid, item, frompos, item2, topos)
  if item.uid == 5000 then
    v = 0
    for p = 1, #playerPos do
      getPlayer = getTopCreature(playerPos[p])
      if getPlayer.uid > 0 then
        if isPlayer(getPlayer.uid) then
          if getPlayerLevel(getPlayer.uid) >= questlevel then
            if getPlayerStorageValue(getPlayer.uid, 8160) == -1 then
              v = v + 1
            else
              doPlayerSendCancel(cid, "The player "..getCreatureName(getPlayer.uid).." already done this quest.")
              return true
            end
          else
            doPlayerSendCancel(cid, "The player "..getCreatureName(getPlayer.uid).." don't have level enough.")
            return true
          end
        else
          doPlayerSendCancel(cid, "Sorry, but only players can do this quest.")
          return true
        end
      else
        doPlayerSendCancel(cid, "This quest requeres 4 players.")
        return true
      end
    end
    if v == 4 then
      for m = 1, #demonPos do
        doSummonCreature("Demon", demonPos[m])
      end
      for x = 1, #playerPos do
        pid = getTopCreature(playerPos[x]).uid
        if pid > 0 then
          doSendMagicEffect(getThingPos(pid), 2)
          doTeleportThing(pid, pDestiny[x])
          doSendMagicEffect(getThingPos(pid), 10)
        end
      end
      if item.itemid == 1945 then
        doTransformItem(item.uid, 1946)
      else
        doTransformItem(item.uid,1945)
      end
    end   
  end
  if item.uid == 5001 then
    queststatus = getPlayerStorageValue(cid,100)
    if queststatus == -1 then
      if getPlayerFreeCap(cid) <= 100 then
        doPlayerSendTextMessage(cid,22,"You need 100 cap or more to loot this!")
      return TRUE
      end
      doPlayerSendTextMessage(cid,22,"You have found a demon armor.")
      doPlayerAddItem(cid,2494,1)
      setPlayerStorageValue(cid,100,1)
    else
      doPlayerSendTextMessage(cid,22,"It is empty.")
    end
  end
  if item.uid == 5002 then
    queststatus = getPlayerStorageValue(cid,100)
    if queststatus ~= 1 then
      if getPlayerFreeCap(cid) <= 100 then
        doPlayerSendTextMessage(cid,22,"You need 100 cap or more to loot this!")
      return TRUE
      end
      doPlayerSendTextMessage(cid,22,"You have found a magic sword.")
      doPlayerAddItem(cid,2400,1)
      setPlayerStorageValue(cid,100,1)
    else
      doPlayerSendTextMessage(cid,22,"It is empty.")
    end
  end
  if item.uid == 5003 then
    queststatus = getPlayerStorageValue(cid,100)
    if queststatus ~= 1 then
      if getPlayerFreeCap(cid) <= 100 then
        doPlayerSendTextMessage(cid,22,"You need 100 cap or more to loot this!")
      return TRUE
      end
      doPlayerSendTextMessage(cid,22,"You have found a stonecutter axe.")
      doPlayerAddItem(cid,2431,1)
      setPlayerStorageValue(cid,100,1)
    else
      doPlayerSendTextMessage(cid,22,"It is empty.")
    end
  end
  if item.uid == 5004 then
    queststatus = getPlayerStorageValue(cid,100)
    if queststatus ~= 1 then
      if getPlayerFreeCap(cid) <= 100 then
        doPlayerSendTextMessage(cid,22,"You need 100 cap or more to loot this!")
      return TRUE
      end
      doPlayerSendTextMessage(cid,22,"You have found a present.")
      doPlayerAddItem(cid,2326,1)
      setPlayerStorageValue(cid,100,1)
    else
      doPlayerSendTextMessage(cid,22,"It is empty.")
    end
  end
return 1
end