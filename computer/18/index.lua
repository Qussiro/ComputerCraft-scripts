local height = 5
local width = 8
local row = 0
local col = 0

local index = {}

function go_to_next_chest()
    print("Going to chest", col*height+row+1)
    if row < height - 1 then
        turtle.up()
        row = row + 1
    else
        while row > 0 do
            turtle.down()
            row = row - 1
        end
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
        col = col + 1
    end
end

function save_index()
    local file = io.open("index.txt", "w")
    file:write(textutils.serialize(index))
    file:flush()
    io.close(file)
end

function load_index()
    local file, err = io.open("index.txt", "r")
    if err ~= nil then
        print(err)
    end
    if file ~= nil then
        index = textutils.unserialise(file:read("all"))
    else
        save_index()
    end
end

function update()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.turnLeft()
    
    index = {}
    while col < width and row < height do
        local chest = peripheral.wrap("front")
        local content = chest.list()
        for _, chest_item in pairs(content) do
            if index[chest_item.name] == nil then
                index[chest_item.name] = {}
            end
            index[chest_item.name][col*height+row+1] = true
        end
        go_to_next_chest()
    end
    
    print("Going back...")
    turtle.turnLeft()
    while col > 0 do
        turtle.forward()
        col = col - 1
    end
    turtle.forward()
    turtle.forward()
    turtle.forward()
end

function get_info()
    while true do
        io.write("Enter item id: ")
        local name = io.read()
        if name == "-update" then break end
        if index[name] ~= nil then
            for chest, _ in pairs(index[name]) do
                print("  ", chest)
            end
        end
    end
end

function timer()
    local timer_id = os.startTimer(10*60)
    repeat
        local _, id = os.pullEvent("timer")
    until id == timer_id
end

load_index()
while true do
    parallel.waitForAny(get_info, timer)
    turtle.turnRight()
    local fuel_chest = peripheral.wrap("front")
    print("Fuel level:", turtle.getFuelLevel())
    while turtle.getFuelLevel() < 150 and next(fuel_chest.list()) ~= nil do
        print(("Refueling: %d%%"):format(turtle.getFuelLevel()/150*100))
        turtle.suck(1)
        turtle.refuel(1)
    end
    print(("Refueling: %d%%"):format(turtle.getFuelLevel()/150*100))
    turtle.turnLeft()

    if turtle.getFuelLevel() < 150 then
        print("Not enough fuel!!!")
        break
    end
    update()
    save_index()
end
