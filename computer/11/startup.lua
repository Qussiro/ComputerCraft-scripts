local modem = peripheral.wrap("top")
modem.open(5)
local _ = os.pullEvent("modem_message")
redstone.setOutput("back", true)
print("Up/Down")
local _ = os.pullEvent("modem_message")
redstone.setOutput("back", false)
print("Forward/Backward")

