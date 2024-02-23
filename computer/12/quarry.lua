local step_time = 1.3
local next_row = 0
local secs = 0
local row = 0
local col = 0
local modem = peripheral.wrap("top")

function timer(time)
    local timer_id = os.startTimer(time)
    repeat
        local _, id = os.pullEvent("timer")
    until id == timer_id
end

function moveLeft()
    redstone.setOutput("back", false)
    redstone.setOutput("right", true)
    modem.transmit(5, 0, "OFF")
    timer(step_time)
    redstone.setOutput("right", false)
    redstone.setOutput("back", true)
    row = row + 1
    print("LEFT", row)
    sleep(0.3) -- top computer not solid block, need to wait a bit
end

function moveForward()
    modem.transmit(5, 0, "OFF")
    redstone.setOutput("right", true)
    redstone.setOutput("back", true)
    timer(step_time)
    modem.transmit(5, 0, "ON")
    col = col + 1
    print("FORWARD", col)
    sleep(0.3)
end

function moveStart()
    redstone.setOutput("back", true)
    redstone.setOutput("right", false)
    modem.transmit(5, 0, "OFF")
    timer(col*step_time)
    redstone.setOutput("back", false)
    redstone.setOutput("right", false)
    modem.transmit(5, 0, "OFF")
    timer(row*step_time)
    print(" ---- S T A R T ----")
    row = 0
    col = 0
end

function dig(time)
    secs = 0 
    modem.transmit(5, 0, "ON")
    redstone.setOutput("back", true)
    redstone.setOutput("right", false)
    print("Down")
    while secs < time do
        timer(1)
        secs = secs + 1
        local x, y = term.getCursorPos()
        term.setCursorPos(1, y)
        write(("Going down %ds"):format(time-secs))
        save_data()
    end
    print()
    up(24)
end

function up(time)
    modem.transmit(5, 0, "ON")
    redstone.setOutput("back", true)
    redstone.setOutput("right", true)
    print("Up")
    timer(time)
end

function reset()
    redstone.setOutput("back", false)
    redstone.setOutput("right", false)
end

function save_data()
    local file = io.open("coordinates.txt", "w")
    io.output(file)
    io.write(("%d\n%d\n%d"):format(row, col, secs))
    io.flush()
    io.close(file)
end

function read_data()
    local file, err = io.open("coordinates.txt", "r")
    if file ~= nil then
        row = tonumber(file:read())
        col = tonumber(file:read())
        secs = tonumber(file:read())
        io.close(file)
    else
        save_data()
    end
end

local t_row = 0
local t_col = 0
local input = true

function input()
    write("Row: ")
    t_row = tonumber(io.read())
    write("Col: ")
    t_col = tonumber(io.read())

    print(t_row, t_col)
end

function input_timer()
    timer(10)
    input = false
end

parallel.waitForAny(input, input_timer)
read_data()
if input then
    up(24) -- TODO(not working, stupid :D ): up time if not dig all the way: (secs*100/244)*24/100
    moveStart()
    local i = 0
    while i < t_row do
        moveLeft()
        i = i + 1
    end
    i = 0 
    while i < t_col do
        moveForward()
        i = i + 1
    end

    print(row, col)
else
    dig(secs)
end
save_data()

while next_row ~= 16 do 
    i = 0
    while i < next_row do
        moveLeft()
        i = i + 1
    end
    while col ~= 15 or input do
        if not (col == 0 or input) then
            moveForward()
        end
        input = false
        dig(244)
        save_data()
        -- dig(244) -- 244 from 61 to ~3 and +15 sec to be sure
    end
    next_row = row + 1
    moveStart()
    while not redstone.getInput("left") do
        sleep(0.5)
    end
end