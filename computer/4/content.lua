local content = peripheral.wrap("back").list()
local keys = {}
for k in pairs(content) do
    table.insert(keys, k)
end
table.sort(keys)
--for i, k in pairs(keys) do
--    print(i, k)
--end

local key = keys[1]
local item = content[key]
print(key, item.name)
