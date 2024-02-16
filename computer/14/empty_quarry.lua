while true do
    redstone.setOutput("front", false)
    local event, side = os.pullEvent("peripheral")
    local quarry_storage = peripheral.wrap("back")
    local ore_storage = peripheral.wrap("left")

    if next(quarry_storage.list()) ~= nil then
        redstone.setOutput("front", true)
        sleep(0.5)
        redstone.setOutput("front", false)
        break
    end
    for slot, item in pairs(quarry_storage.list()) do
        quarry_storage.pushItems(peripheral.getName(ore_storage), slot)
        print("Tranfered ", item.name)
    end

end
