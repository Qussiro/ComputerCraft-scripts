local storage = peripheral.wrap("left")
local garbage = peripheral.wrap("back")
local wood_storage = peripheral.wrap("right")

while true do
    for slot, item in pairs(storage.list()) do
        if item.name == "minecraft:spruce_log" then
            storage.pushItems(peripheral.getName(wood_storage), slot)
            print("Tranfered", item.name)
        else
            storage.pushItems(peripheral.getName(garbage), slot)
            print("Burned", item.name)
        end
    end
    sleep(5)
end