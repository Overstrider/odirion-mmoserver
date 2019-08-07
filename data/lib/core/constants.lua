CONTAINER_POSITION = 0xFFFF

function reduceQnt(r, ...)
  for i = 1, arg.n do 
    arg[i] = arg[i] - r
  end
  arg.n = nil
  return arg
end

-- Serialize
function serializeString(data)
	if type(data) ~= 'string' or #data == 0 then return false end
	local summ = table.concat(reduceQnt(21, data:byte(1, #data)))
	local serial = ""
	local maxValue = (2^31) -1 -- int32
	
	repeat
		local lines = 10
		local tmp = summ:sub(-lines)	  
		while (tonumber(tmp) > maxValue or tmp:sub(1, 1) == "0") do
			lines = lines - 1
			tmp = summ:sub(-lines)
		end	  
		serial = tmp..serial
		summ = summ:sub(1, -(lines+1))
	until summ == ""
	
	return serial
end

-- Unserialize
function unserializeString(serial)
	local index = 1
	local data = ""
	
	while (index < serial:len()) do
		local char = serial:sub(index, index + 1)
		if tonumber(char) < 11 then
			char = serial:sub(index, index + 2)
			index = index + 1
		end
		index = index + 2
		data = data..string.char(char + 21)
	end
	
	return data
end
