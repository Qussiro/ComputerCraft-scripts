while true do
    local farm_storage = peripheral.wrap("left")
    local wood_storage = peripheral.wrap("right")
    local sticks_storage = peripheral.wrap("back")
    
    for slot, item in pairs(farm_storage.list()) do
        if next(farm_storage.list()) == nil then 
            break
        end
        if item.name == "minecraft:spruce_log" then
            local count = 0
            for _ in pairs(wood_storage.list()) do
                count = count + 1
            end
            if count < wood_storage.size() then
                if next(farm_storage.list()) == nil then 
                    break
                end
                farm_storage.pushItems(peripheral.getName(wood_storage), slot)
                print("Tranfered wood")
            end
        elseif item.name == "minecraft:stick" then
            if next(farm_storage.list()) == nil then 
                break
            end
            farm_storage.pushItems(peripheral.getName(sticks_storage), slot)

            print("Tranfered sticks ")
        end
    end
end