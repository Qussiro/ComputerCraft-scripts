local modem = peripheral.wrap("top")
modem.open(5)

while true do
    local _, _, _, _, message = os.pullEvent("modem_message")
    if message == true then
        redstone.setOutput("back", true)
        print("Up/Down")
    elseif message == false then
        redstone.setOutput("back", false)
        print("Forward/Backward")
    else 
        assert(false, "Invalid " .. message)
    end
end
