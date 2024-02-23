while true do
    local farm_storage = peripheral.wrap("left")
    local stick_storage = peripheral.wrap("right")
    
    for slot, item in pairs(farm_storage.list()) do
        if item.name == "minecraft:stick" then
            local count = 0
            for _ in pairs(stick_storage.list()) do
                count = count + 1
            end
            if count < stick_storage.size() then
                farm_storage.pushItems(peripheral.getName(stick_storage), slot)
                print("Tranfered sticks")
            end
        end
    end
end