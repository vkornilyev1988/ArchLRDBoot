local zfs = {
	echo = "Hello, WOrld",
	pool = {
		name = "st0",
		mtdir= "/storage/st0",
		img="st0/img",
		wb="st0/wb",
		snap="st0/snap"
		
	},
	opt = {
	},
	cmd = {
		zpool="/usr/sbin/zpool",
		zfs="/usr/bin/zfs",
		load=function(path)
			print(path);
		end,
		snaplist = function() return os.execute("/usr/bin/uname -a")  end
	}
}
return zfs
