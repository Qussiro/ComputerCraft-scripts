while true do
    redstone.setOutput("front", false)
    local event, side = os.pullEvent("peripheral")
    local quarry_storage = peripheral.wrap("back")
    local ore_storage = peripheral.wrap("left")
    

    if next(quarry_storage.list()) == nil then
        redstone.setOutput("front", true)
        print("Empty")
        sleep(1)
        redstone.setOutput("front", false)
    else
        for slot, item in pairs(quarry_storage.list()) do
            if quarry_storage.list() == nil then 
                break
            end
            local count = 0;
            while count < item.count do
                count = count + quarry_storage.pushItems(peripheral.getName(ore_storage), slot)
                sleep(0.5)
            end
            print("Tranfered", item.name)
        end
        redstone.setOutput("front", true)
        print("Empty")
        sleep(1)
        redstone.setOutput("front", false)
    end
end
