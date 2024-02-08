local address = "http://localhost:6969"

local headers = {}
headers["command"] = "git-repo"

print(http.get(address, headers).readAll())

