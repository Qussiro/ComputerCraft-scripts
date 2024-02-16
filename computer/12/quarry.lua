local step_time = 1.3
local next_row = 0
local row = 0
local col = 0
local modem = peripheral.wrap("top")

function moveLeft()
    redstone.setOutput("back", false)
    redstone.setOutput("right", true)
    os.startTimer(step_time)
    local _ = os.pullEvent("timer")
    redstone.setOutput("right", false)
    redstone.setOutput("back", true)
    row = row + 1
    print("LEFT ", row)
end

function moveForward()
    redstone.setOutput("right", true)
    redstone.setOutput("back", true)
    os.startTimer(step_time)
    local _ = os.pullEvent("timer")
    modem.transmit(5, 0, "ON")
    col = col + 1
    print("FORWARD ", col)
end

function moveStart()
    modem.transmit(5, 0, "OFF")
    redstone.setOutput("right", false)
    redstone.setOutput("back", true)
    os.startTimer(col*step_time)
    local _ = os.pullEvent("timer")
    redstone.setOutput("back", false)
    redstone.setOutput("right", false)
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
    modem.transmit(5, 0, "OFF")
end

function reset()
    redstone.setOutput("back", false)
    redstone.setOutput("right", false)
end

-- while next_row ~= 3 do 
--     local i = 0
--     while i < next_row do
--         moveLeft()
--         i = i + 1
--     end
--     while col ~= 2 do
--         if col ~= 0 then
--             moveForward()
--         else 
--             col = col +1 

        
--         end
--         dig()
        
--     end
--     next_row = row + 1
--     moveStart()
-- end

moveForward()
dig()
moveStart()

moveLeft()

moveForward()
dig()
moveStart()