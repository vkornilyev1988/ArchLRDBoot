local socket = require("ljsocket")

print("goto http://127.0.0.1:5001")

do -- server
    local info = socket.find_first_address("*", 5001)

    local server = assert(socket.create(info.family, info.socket_type, info.protocol))
    server:set_blocking(false)
    assert(server:set_option("nodelay", true, "tcp"))
    assert(server:set_option("reuseaddr", true))
    assert(server:bind(info))
    assert(server:listen())

    local body = "<html><body><h1>hello world</h1></body></html>"

    local header =
    "[HTTP/1.1 200 OK\r\n"..
    "Server: masrv/0.1.0\r\n"..
    "Date: Thu, 28 Mar 2013 22:16:09 GMT\r\n"..
    "Content-Type: text/html\r\n"..
    "Connection: Keep-Alive\r\n"..
    "Content-Length: "..#body.."\r\n"..
    "Last-Modified: Wed, 21 Sep 2011 14:34:51 GMT\r\n"..
    "Accept-Ranges: bytes\r\n" ..
    "\r\n"

    local content = header .. body

    while true do
        local client, err = server:accept()

        if client then
            assert(client:set_blocking(false))
            assert(client:send(content))

            print("client connected ", client)

            local str, err = client:receive()

            if str then
                print(str)
                client:close()
            elseif err == "closed" then
                client:close()
            elseif err ~= "timeout" then
                error(err)
            end
        elseif err ~= "timeout" then
            error(err)
        end
    end
end