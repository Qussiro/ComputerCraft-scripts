local farm_storage = nil
local storage = peripheral.wrap("right")
local first_sapling_slot = false
function check_slot(slot, item)
    local count = 0
    if item.name == "minecraft:spruce_sapling" and first_sapling_slot then
        first_sapling_slot = false
        return
    end
    while count < item.count do
        count = count + farm_storage.pushItems(peripheral.getName(storage), slot)
        sleep(0.5)
    end
end


while true do
    local signal_count = 0
    while signal_count ~= 50 do
        os.pullEvent("redstone")
        if redstone.getInput("back") then
            signal_count = signal_count + 1
            print("Circles passed: ", signal_count)
        end
    end
    redstone.setOutput("front", true)

    sleep(0.5)
    farm_storage = peripheral.wrap("left")
    first_sapling_slot = true
    for slot, item in pairs(farm_storage.list()) do
        check_slot(slot, item)
        print("Tranfered", item.name)
    end
    redstone.setOutput("front", false)
end