while true do
    local farm_storage = peripheral.wrap("left")
    local chest_wood = peripheral.wrap("right")
    local chest_sticks = peripheral.wrap("back")

    for slot, item in pairs(farm_storage.list()) do
        if item.name == "minecraft:spruce_log" then
            farm_storage.pushItems(peripheral.getName(chest_wood), slot)
            print("Tranfered wood")
        elseif item.name == "minecraft:stick" then
            farm_storage.pushItems(peripheral.getName(chest_sticks), slot)
            print("Tranfered sticks")
        end
    end
    
end