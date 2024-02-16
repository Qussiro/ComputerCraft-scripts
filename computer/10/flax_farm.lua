while true do
    local farm_storage = peripheral.wrap("back")
    local flux_storage = peripheral.wrap("left")

    for slot, item in pairs(farm_storage.list()) do
        if item.name == "supplementaries:flax" then
            farm_storage.pushItems(peripheral.getName(flux_storage), slot)
            print("Tranfered flax")
        end
    end
end