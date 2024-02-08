local address = "http://localhost:6969"

local headers = {}
local path = ...
headers["command"] = "set-repo " .. path

print(http.get(address, headers).readAll())

