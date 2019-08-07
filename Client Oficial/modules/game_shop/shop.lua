dofile('ui/uistoreacceptbox')
tableList = {}
function init()
	g_ui.importStyle('ui/acceptwindow')
	
	shopButtons = modules.client_topmenu.addRightGameToggleButton('shopButtons', tr('Shop') .. '', '/images/shop/shop', openWindow)
	ProtocolGame.registerExtendedOpcode(190, receberLista)	
	ProtocolGame.registerExtendedOpcode(191, receberLista)

	shopWindow = g_ui.displayUI('shop')
	shopWindow:hide()
	
	shopTabContent = shopWindow:getChildById('shopTabContent')	
end

function removeItem(itemID)
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk('!shop remove '..itemID)
    g_game.talk('!shop list')
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Confirm'), tr("You confirm this action?"),
  { { text=tr('Yes'), callback=acceptFunc },
    { text=tr('No'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

function receberLista(protocol, opcode, buffer)
	if opcode == 190 then	
		table.insert(tableList, loadstring("return "..buffer)())		
	elseif opcode == 191 then
		-- print(#tableList)
		if #tableList == 0 then hide() return true end			
		local children = shopTabContent:getChildren()
		for k = 1, #children do
			children[k]:destroy()
		end
		for i = 1, #tableList do
		local productLabel = g_ui.createWidget('ShopButton', shopTabContent)
			productLabel:setId(tableList[i][1])		
			productLabel:setIcon("/images/shop/offer/"..tableList[i][3])	
			productLabel:setText(tableList[i][2])
		end
		tableList = {}
		show()
	end
return true
end

function openWindow()
	g_game.talk("!shop list")
end

function toggle()
  if not shopWindow:isVisible() then	
    show()
  else
    hide()
  end
end

function show()
  if not g_game.isOnline() then
    return
  end
  shopWindow:show()
  shopWindow:raise()
  shopWindow:focus()
end

function terminate()
	shopWindow:destroy()
	ProtocolGame.unregisterExtendedOpcode(190)
	ProtocolGame.unregisterExtendedOpcode(191)
end

function cancel()
  reload()
  hide()
end

function reload()
  unload()
  load()
end

function hide()
  shopWindow:hide()
end

function unload()

end

function string.table(str, separator)
    local ret = {}
    for w in string.gmatch(str, "([^"..separator.."]+)") do
        table.insert(ret, w)
    end
    return ret
end