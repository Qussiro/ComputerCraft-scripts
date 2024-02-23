local unsorted = peripheral.wrap("bottom")
local garbage = peripheral.wrap("right")
local ores = peripheral.wrap("left")

while true do
    if next(unsorted.list()) == nil then 
        sleep(0.5)
    end
    for slot, item in pairs(unsorted.list()) do
        if string.find(item.name, "stone") ~= nil and item.name ~= "minecraft:redstone" or
            string.find(item.name, "diorite") ~= nil or
            string.find(item.name, "granite") ~= nil or
            string.find(item.name, "andesite") ~= nil or
            string.find(item.name, "slab") ~= nil or
            string.find(item.name, "log") ~= nil or
            string.find(item.name, "planks") ~= nil or
            item.name == "minecraft:dirt" or
            item.name == "minecraft:gravel" 
        then
            unsorted.pushItems(peripheral.getName(garbage), slot)
            print("Burned", item.name)
        else
            unsorted.pushItems(peripheral.getName(ores), slot)
            print("Tranfered", item.name)
        end
    end
end