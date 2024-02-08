local address = "http://localhost:6969"

local headers = {}
headers["command"] = "git-pull"

print(http.get(address, headers).readAll())

