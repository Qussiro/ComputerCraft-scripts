while true do
    local farm_storage = peripheral.wrap("back")
    local flux_storage = peripheral.wrap("left")

    for slot, item in pairs(farm_storage.list()) do
        if item.name == "supplementaries:flax" then
            local count = 0
            for _ in pairs(flux_storage.list()) do
                count = count + 1
            end
            if count < flux_storage.size() then
                farm_storage.pushItems(peripheral.getName(flux_storage), slot)
                print("Tranfered flax")
            end
        end
    end
end