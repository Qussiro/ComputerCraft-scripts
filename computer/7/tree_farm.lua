while true do
    local farm_storage = peripheral.wrap("left")
    local wood_storage = peripheral.wrap("right")
    local sticks_storage = peripheral.wrap("back")
   
    for slot, item in pairs(farm_storage.list()) do
        if item.name == "minecraft:spruce_log" then
            local count = 0
            for _ in pairs(wood_storage.list()) do
                count = count + 1
            end
            if count < wood_storage.size() then
                farm_storage.pushItems(peripheral.getName(wood_storage), slot)
                print("Tranfered wood")
            end
        elseif item.name == "minecraft:stick" then
            farm_storage.pushItems(peripheral.getName(sticks_storage), slot)
            print("Tranfered sticks")
        end
    end
    
end