local handle = io.popen("/usr/bin/lsof /dev/nbd0")
local result = handle:read("*a")
handle:close()
io.write(result)
