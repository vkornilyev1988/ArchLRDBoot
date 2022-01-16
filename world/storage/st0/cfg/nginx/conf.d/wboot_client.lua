-- socket = require"socket"
-- socket.unix = require"socket.unix"
-- c = assert(socket.unix())
-- c:connect("/tmp/socket.sock")
-- c:settimeout(0)
-- while 1 do

--     local l = io.read()
--         assert(c:send(l .. "\n"))

-- end
-- c:disconnect()
local socket = require"socket"
local recvt, sendt = {}, {}
socket.unix = require"socket.unix"
local master = socket.unix()
master:settimeout(0.2)
local request_method = ngx.var.request_method
local function check_keys(mac)
    local inifile = require"ini".load("/etc/wboot/wdb.ini")
    local boot_info = [[#!ipxe

set keep-san 1
chain http://${next-server}:8081/BootApi?GenBoot=cmd_booting_free()&mac=${net0/mac}
    ]] 
    if inifile[mac].ipv4 ~= nil then boot_info = boot_info .. [[

set net0/ip ]] .. inifile[mac].ipv4 end;
    if inifile[mac].mask ~= nil then boot_info = boot_info .. [[

set net0/netmask ]] .. inifile[mac].mask end;
    if inifile[mac].ipv6 ~= nil then boot_info = boot_info .. [[

set net0/ipv6 ]] .. inifile[mac].ipv4 end;
    if inifile[mac].dns1 ~= nil then boot_info = boot_info .. [[

set dns ]] .. inifile[mac].dns1 end;
    if inifile[mac].name ~= nil then boot_info = boot_info .. [[

set hostname ]] .. inifile[mac].name end;
local iscsi_port,next_server,wks_hostname


    if inifile[mac].iscsi_port ~= nil then iscsi_port = inifile[mac].iscsi_port else iscsi_port = "3260" end
    if inifile[mac].nextserver ~= nil then next_server = inifile[mac].nextserver else next_server = "${next-server}" end

    boot_info = boot_info .. [[

set root_path iscsi]]..":"..next_server..":4:"..iscsi_port..":"..inifile[mac].imgboot..":"..inifile.main.iqn .. ":" .. mac:gsub(':','-')
    return boot_info
end

function sleep(s)
  local ntime = os.time() + s
  repeat until os.time() > ntime
end    


 

        if request_method == "GET" then
                local arg = ngx.req.get_uri_args()["GenBoot"] or 0
           if arg ~= 0 then 
                if ngx.req.get_uri_args()["GenBoot"] ~= nil and ngx.req.get_uri_args()["mac"] ~=nil then 
                    local mac = ngx.req.get_uri_args()["mac"]
                    local WaitBooting, BootOpt = [[#!ipxe
echo Booting ...
sleep 1]], check_keys(mac)..[[

sanboot ${root_path} || reboot]]
                        -- ngx.say(ngx.req.get_uri_args()["mac"]) 
                        -- loadfile("/etc/nginx/conf.d/wboot_client.lua")
                            obj = master:connect("/tmp/socket.sock")
                            if obj ~=nil then
                                local l = "{\"mac\":\""..mac.."\",\"command\":\""..ngx.req.get_uri_args()["GenBoot"].."\"}"
        
                                    if l == "close()" then master:close() end
                                    assert(master:send(l .. "\n"))
                                    local data,err
                                    while data == nil do
                                        data,err = master:receive()
                                        local count = 0

                                            if data == "1" or data == "0"  then
                                                ngx.say(WaitBooting)
                                            elseif data == "2" then
                                                ngx.say(BootOpt)
					    elseif data == "-1" then
					        ngx.say([[#!ipxe
echo Clearing...
]])
                                            elseif data == nil then
                                                --print("NIL")       
                                                sleep(0.01)
                                            else
                                                ngx.say(data)
                                            end
                                        master:send("wait\n")    
                                    end
                            end
                                 master:close()
                                 obj = nil
                end
        else ngx.say("Hello <b>world</b>!") end

        elseif request_method == "POST" then
                ngx.req.read_body()
                local arg = ngx.req.get_post_args()["GenBoot"] or 0
        end
      
        -- ngx.say("HELLO")

        --assert(obj == nil)
-- print'before'
-- --socket.select(recvt, sendt)
-- print'after'
-- while 1 do
--     print('REsult',master:receive())
--     local l = io.read()
--         if l == "close()" then master:close() end
--         assert(master:send(l .. "\n"))
--         local data,err
--         while data == nil do
--             data,err = master:receive()
--             local count = 0

--                 if data == "1"  then
--                     print(WaitBooting)
--                 elseif data == "2"then
--                     print(BootOpt)
--                 elseif data == nil then
--                     --print("NIL")       
--                     sleep(0.01)
--                 else
--                     print(data)
--                 end

--         end
        
-- end
