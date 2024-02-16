local step_time = 1.2
local next_row = 0
local row = 0
local col = 0

function moveLeft()
    redstone.setOutput("back", false)
    os.startTimer(step_time)
    redstone.setOutput("right", true)
    local _ = os.pullEvent("timer")
    redstone.setOutput("right", false)
    redstone.setOutput("back", true)
    row = row + 1
    print("LEFT ", row)
end

function moveStart()
    redstone.setOutput("right", false)
    redstone.setOutput("back", true)
    os.startTimer(row*step_time)
    local _ = os.pullEvent("timer")
    redstone.setOutput("back", false)
    redstone.setOutput("right", false)
    print(" ---- S T A R T ----")
    row = 0
    col = 0
end

function moveForward()
    redstone.setOutput("right", true)
    os.startTimer(step_time)
    redstone.setOutput("back", true)
    local _ = os.pullEvent("timer")
    redstone.setOutput("back", false)
    redstone.setOutput("right", false)
    col = col + 1
    print("FORWARD ", col)
end

function dig()
    local modem = peripheral.wrap("top")
    modem.transmit(5, 0, "Down")
    redstone.setOutput("back", true)
    print("Down")
    os.startTimer(10) -- 244 from 61 to ~3
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

while row ~= 3 do 
    local i = 0
    while i < next_row do
        moveLeft()
    end
    while col ~= 2 do
        if col ~= 0 then
            moveForward()
        else 
            col = col +1 

        --reset()
        --dig()
    end
    next_row = row + 1
    moveStart()
end
