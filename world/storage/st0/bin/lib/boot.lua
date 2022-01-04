local lrdboot = {
	direxists = function(dir)   if type(require('lfs_ffi').attributes(dir)) == "table"  and require('lfs_ffi').attributes(dir).mode == "directory" then return true else return false end end,
	filexists = function(file) print(file)   if type(require('lfs_ffi').attributes(file)) == "table" and require('lfs_ffi').attributes(file).mode == "file"  then return true else return false end end,
	getnbd = function(num) if num ~= nil then return num*3-3+1 end end,
	check = function(command) local handle = io.popen(command) local result = handle:read()  handle:close();  return result end,
	
}
 

	lrdboot.stop = function(inifile,mac)
			print("PAR", mac, cfg)
		--inifile[mac] = cfg[mac]
		if inifile[mac] ~= nil and inifile[mac].tid ~=nil then
			local num=lrdboot.getnbd(inifile[mac].tid)
			local freestate = function()	

		           for i = 0, 2 do
				print(num+i)
				local count=0
				while lrdboot.check("/usr/bin/lsof -t /dev/nbd" .. num+i .. " 2>/dev/null") ~= nil do
					if count == 3 then break end
						local handle = io.popen("/usr/bin/lsof -t /dev/nbd" .. num+i .. " 2>/dev/null");
						local result = handle:read("*a");
						handle:close();
				        	local ln = 1
						for line, newline in result:gmatch"([^\r\n]*)([\r\n]*)" do
							if line ~= "" and lrdboot.direxists("/proc/" .. line) then
							    print("/proc/" .. line .. "/comm" ,"r")
							    local file = io.open("/proc/" .. line .. "/comm" ,"r");
							    local comm = file:read();
							    file:close()
							    if comm == "tgtd" then
								     local handle  = io.popen("/usr/bin/tgtadm --op delete --force --mode target --tid "..inifile[mac].tid);
                        	                                     local hndlerr = handle:read();
                                	                             handle:close();
                                        	                    print(comm, line, hdnerr)
							    elseif comm == "qemu-nbd" then
								if count < 2 then
								    local handle  = io.popen("/usr/bin/qemu-nbd -d /dev/nbd"..num+i);
								     handle:close(); 			
	
								elseif count >= 2 then
								    local handle  = io.popen("/usr/bin/kill -9 " .. line);
								     handle:close(); 			
		
								end
								--if 
								    print(comm, line, hdnerr)
							    end
								local img_path=inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].writebackset..'/nbd'..num+i..'.qcow2' -- then require("lfs_ffi").rmdir(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')
								-- if filexists(img_path) then 
								print(img_path)
								print('img'..tostring(i+1)..'_supper')
								if inifile[mac]['img'..tostring(i+1)..'_supper'] ~= nil and inifile[mac]['img'..tostring(i+1)..'_supper'] == true then else
 									print("RESULT: ",img_path)
									os.remove(img_path)
								end;

						   	    ln = ln + #newline:gsub("\n+", "\0%0\0"):gsub(".%z.", "."):gsub("%z", "")
							end
						end

						count = count +1
					end
				end
			end
			freestate()				--print( inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset)
			if lrdboot.direxists(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')) then
			
				if inifile[mac].img1 ~= nil and lrdboot.direxists(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')) and lrdboot.direxists(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')..'/'..inifile[mac].img1) and lrdboot.check("/usr/bin/lsof -t "..inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')..'/'..inifile[mac].img1) ~= nil then
					freestate()
				end							
				if inifile[mac].img2 ~= nil and lrdboot.direxists(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')) and lrdboot.direxists(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')..'/'..inifile[mac].img2) and lrdboot.check("/usr/bin/lsof -t "..inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')..'/'..inifile[mac].img2) ~= nil then
					freestate()
				end							
				if inifile[mac].img3 ~= nil and lrdboot.direxists(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')) and lrdboot.direxists(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')..'/'..inifile[mac].img3) and lrdboot.check("/usr/bin/lsof -t "..inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')..'/'..inifile[mac].img3) ~= nil then
					freestate()
				end							

				-- if lrdboot.direxists(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')) then require("lfs_ffi").rmdir(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')) end	


			end
			local statue=0
			print('/sbin/mount -t zfs | grep "' .. inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].imgset..'@'..mac..'" 2>/dev/null')
			while lrdboot.check('/sbin/mount -t zfs | grep "' .. inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].imgset..'@'..mac..'" 2>/dev/null') ~= nil do  
				if statue == 10 then break end
				local handle  = io.popen("/sbin/umount -f "..inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_'));
				handle:close();
				statue = statue + 1
			end
			local statue=0
			while  lrdboot.check("/usr/bin/zfs list -o name -t snap "..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].imgset..'@'..mac.." 2>/dev/null") ~= nil do
					if statue == 10 then break end
					local handle  = io.popen("/usr/bin/zfs destroy -f "..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].imgset..'@'..mac);  handle:close();
		  		statue = statue + 1
			end
				
		--	if  inifile[mac].img1 ~= nil and require("lfs_ffi").attributes(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].writebackset..'/nbd'..num+i).mode == "file" then 	
		--			os.remove(inifile['storage'].dir..'/'inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].writebackset..'/nbd',num+i))
		--	end
		
		
			
		end
	end

	lrdboot.start = function(inifile, mac) 
                        if  lrdboot.check("/usr/bin/zfs list -o name -t snap "..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].imgset..'@'..mac) == nil then
                                local handle  = io.popen("/usr/bin/zfs snap "..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].imgset..'@'..mac);  handle:close();
                                if lrdboot.direxists(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')) == false then
                                	require("lfs_ffi").mkdir(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_'))
                                end
                                if lrdboot.check('/sbin/mount -t zfs | grep "' .. inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].imgset..'@'..mac..'" 2>/dev/null') == nil then
                                	print("/sbin/mount -t zfs ".. inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].imgset..'@'..mac .. " " ..inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_'))
                                	local handle  = io.popen("/sbin/mount -t zfs ".. inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].imgset..'@'..mac .. " " ..inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_'));
					handle:close();
                                end
                                local num = lrdboot.getnbd(inifile[mac].tid)
                                local handle  = io.popen("/usr/bin/tgtadm --lld iscsi --op new --mode target --tid " .. inifile[mac].tid .. " --targetname " .. inifile.main.iqn .. ":" .. mac:gsub(':','-'))
		                handle:close();	
		                print("/usr/bin/tgtadm --lld iscsi --op new --mode target --tid " .. inifile[mac].tid .. " --targetname " .. inifile.main.iqn .. ":" .. mac:gsub(':','-'))
                                 for i = 0, 2 do
                                   if inifile[mac]['img'..tostring(i+1)] ~= nil then
                                 	local img_path=inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].writebackset..'/nbd'..num+i..'.qcow2' -- then require("lfs_ffi").rmdir(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')	
	                                 	if inifile[mac]['img'..tostring(i+1)..'_supper'] ~= nil and inifile[mac]['img'..tostring(i+1)..'_supper'] == true then 
	                                 		print(img_path,' SUPPER')
		                                 	if lrdboot.filexists(img_path) then
		                                 		local handle  = io.popen("/usr/bin/qemu-img info "..img_path)
		                                 		-- print(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')..'/'..inifile[mac]['img'..tostring(i+1)])
		                                 		local lineoutput = handle:read("*a"):match(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')..'/'..inifile[mac]['img'..tostring(i+1)]);
		                                 		handle:close();
		                                 		if lineoutput ~= nil then
		                                 			os.remove(img_path)
		                                 			print("/usr/bin/qemu-img create -F qcow2 -f qcow2 -b " .. inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].imgset..'/'.. inifile[mac]['img'..tostring(i+1)] .. " " .. img_path)
		                                 			local handle  = io.popen("/usr/bin/qemu-img create -F qcow2 -f qcow2 -b " .. inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].imgset..'/'.. inifile[mac]['img'..tostring(i+1)] .. " " .. img_path)
		                                 			handle:close();

		                                 		end
		                                 		print(lineoutput)
		                                 	end	                                 		
	                                 	else
		                                 	if lrdboot.filexists(img_path) then
		                                 		local handle  = io.popen("/usr/bin/qemu-img info "..img_path)
		                                 		-- print(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')..'/'..inifile[mac]['img'..tostring(i+1)])
		                                 		local lineoutput = handle:read("*a"):match(inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')..'/'..inifile[mac]['img'..tostring(i+1)]);
		                                 		handle:close();
		                                 		if lineoutput == nil then
		                                 			os.remove(img_path)
		                                 			local handle  = io.popen("/usr/bin/qemu-img create -F qcow2 -f qcow2 -b " .. inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')..'/'.. inifile[mac]['img'..tostring(i+1)] .. " " .. img_path)
		                                 			handle:close();
		                                 		end
		                                 		print(lineoutput)
		                                 	 else

		                                 			os.remove(img_path)
		                                 			local handle  = io.popen("/usr/bin/qemu-img create -F qcow2 -f qcow2 -b " .. inifile['storage'].dir..'/'..inifile[mac].pool..'/'..inifile['pool/'..inifile[mac].pool].snapset..'/'..mac:gsub(':','_')..'/'.. inifile[mac]['img'..tostring(i+1)] .. " " .. img_path)
		                                 			handle:close();
		                                 	end
		                                
		                                 	-- if lrdboot.filexists(img_path) then
		                                end
		                                 			local handle  = io.popen("/usr/bin/qemu-nbd -D " .. inifile[mac].tid .. " -c /dev/nbd" .. tostring(num+i) .. " " .. img_path)
		                                 			handle:close();	
		                                 			print("NIM", tostring(num),"/usr/bin/tgtadm --lld iscsi --op new --mode logicalunit --tid ".. inifile[mac].tid .." --lun ".. tostring(i+1) .."  --backing-store /dev/nbd" ..tostring(num+i))
		                                 			local handle  = io.popen("/usr/bin/tgtadm --lld iscsi --op new --mode logicalunit --tid ".. inifile[mac].tid .." --lun ".. tostring(i+1) .."  --backing-store /dev/nbd" ..tostring(num+i))
		                                 			handle:close();	                                 			
		                                 	-- end
	                                 	-- end

                                   
 
                                   end
                                 end

                        end
                    	local handle  = io.popen("tgtadm --lld iscsi --mode target --op bind --tid " .. inifile[mac].tid .. " --initiator-address ALL 2>/dev/null")
		        handle:close();					
	end
-- }
		lrdboot.test = function(inifile,mac) print(inifile,mac) end
return lrdboot
