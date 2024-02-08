while true do

    redstone.setOutput("back", false)
    local modem = peripheral.wrap("left")
    modem.open(1)

    local event, side, channel, reply, message, distance
    repeat
        event, side, channel, reply, message, distance = os.pullEvent("modem_message")
    until channel == 1

print("Pulling up")

    redstone.setOutput("back", true)

    local modem2 = peripheral.wrap("top")
    modem2.open(3)

    local event, side, channel, replyChannel, message, distance
    repeat
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    until channel == 3 

print("Done")

end

