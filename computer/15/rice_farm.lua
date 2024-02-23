while true do
    local basin = peripheral.wrap("left")
    local straw_storage = peripheral.wrap("right")

    for slot, item in pairs(straw_storage.list()) do
        if item.name == "farmersdelight:straw" then
            straw_storage.pushItems(peripheral.getName(basin), slot)
            print("Tranfered straw")
        end
    end
    sleep(5)
end