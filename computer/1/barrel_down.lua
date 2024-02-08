while true do
    while true do
        barrel = peripheral.wrap("back")
        if barrel ~=nil then 
            break
        end
        sleep(0.5)
    end
    print("attached")
    
    redstone.setOutput("top", false)
    while barrel.getItemDetail(25) == nil do
        sleep(0.5)
    end 
    print("full")

    local modem = peripheral.find("modem") or error("No modem attached", 0)
    modem.transmit(1, 2, "Go go go")
end
