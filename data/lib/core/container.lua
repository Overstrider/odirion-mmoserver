function Container.isContainer(self)
	return true
end

function Container.getItems(self, ret)
    ret = ret or {}
    for index = self:getSize()-1, 0, -1 do
        local item = self:getItem(index)
        if ItemType(item:getId()):isContainer() then
            ret[#ret+1] = item
            item:getItems(ret)
        else
            ret[#ret+1] = item
        end
    end
    return ret
end
