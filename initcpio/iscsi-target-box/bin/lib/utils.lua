local utils = { 
	jencode = function (data) 
		if data ~= nil then
			local json = require("cjson")
			return json.encode(data)
		else			
			return -1
		end
	end,
	jdecode = function (data)
		if data ~= nil then
			local json = require("cjson")
			return json.decode(data)
		else
			return -1
		end
	end
}
return utils