local address = "http://localhost:6969"

local headers = {}
headers["command"] = "git-repo"

local count = 0
while true do
    count = count + 1
    print(count, http.get(address, headers).readAll())
end

