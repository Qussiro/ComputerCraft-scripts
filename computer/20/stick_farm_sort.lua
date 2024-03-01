local storage = peripheral.wrap("left")
local garbage = peripheral.wrap("back")
local stick_storage = peripheral.wrap("right")

while true do
    for slot, item in pairs(storage.list()) do
        if item.name == "minecraft:stick" then
            storage.pushItems(peripheral.getName(stick_storage), slot)
            print("Tranfered", item.name)
        else
            storage.pushItems(peripheral.getName(garbage), slot)
            print("Burned", item.name)
        end
    end
    sleep(5)
end
