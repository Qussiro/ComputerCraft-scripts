local step_time = 1.3
local next_row = 0
local row = 0
local col = 0
local modem = peripheral.wrap("top")

function moveLeft()
    redstone.setOutput("back", false)
    redstone.setOutput("right", true)
    modem.transmit(5, 0, "OFF")
    os.startTimer(step_time)
    local _ = os.pullEvent("timer")
    redstone.setOutput("right", false)
    redstone.setOutput("back", true)
    row = row + 1
    print("LEFT ", row)
    sleep(0.3) -- top computer not solid block, need to wait a bit
end

function moveForward()
    modem.transmit(5, 0, "OFF")
    redstone.setOutput("right", true)
    redstone.setOutput("back", true)
    os.startTimer(step_time)
    local _ = os.pullEvent("timer")
    modem.transmit(5, 0, "ON")
    col = col + 1
    print("FORWARD ", col)
end

function moveStart()
    redstone.setOutput("back", true)
    redstone.setOutput("right", false)
    modem.transmit(5, 0, "OFF")
    os.startTimer(col*step_time)
    local _ = os.pullEvent("timer")
    redstone.setOutput("back", false)
    redstone.setOutput("right", false)
    modem.transmit(5, 0, "OFF")
    os.startTimer(row*step_time)
    local _ = os.pullEvent("timer")
    print(" ---- S T A R T ----")
    row = 0
    col = 0
end

function dig()
    modem.transmit(5, 0, "ON")
    redstone.setOutput("back", true)
    redstone.setOutput("right", false)
    print("Down")
    os.startTimer(5) -- 244 from 61 to ~3
    local _ = os.pullEvent("timer")
    redstone.setOutput("right", true)
    print("Up")
    os.startTimer(5) -- 24 from ~3 to 61 
    local _ = os.pullEvent("timer")
    print("Done")
end

function reset()
    redstone.setOutput("back", false)
    redstone.setOutput("right", false)
end

while next_row ~= 2 do 
    local i = 0
    while i < next_row do
        moveLeft()
        i = i + 1
    end
    while col ~= 2 do
        if col ~= 0 then
            moveForward()
        else 
            col = col + 1 
        end
        dig()
        
    end
    next_row = row + 1
    moveStart()
    while not redstone.getInput("left") do
        sleep(0.5)
    end
    
end
