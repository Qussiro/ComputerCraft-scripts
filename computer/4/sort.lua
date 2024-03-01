local height = 5
local width = 8
local row = 0
local col = 0

function go_to_next_chest()
    print("Going to chest", col*height+row+2)
    if row < height - 1 then
        turtle.up()
        row = row + 1
    else
        while row > 0 do
            turtle.down()
            row = row - 1
        end
        turtle.turnLeft()
        turtle.forward()
        turtle.turnRight()
        col = col + 1
    end
end

function go_to_previous_chest()
    print("Going to chest", col*height+row)
    if row > 0 then
        turtle.down()
        row = row - 1
    else
        while row < height - 1 do
            turtle.up()
            row = row + 1
        end
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
        col = col - 1
    end
end

while true do
    print("Waiting for items...")
    local input_chest = peripheral.wrap("left")
    local need_to_sort = false
    local count = 0
    while next(input_chest.list()) == nil do
        sleep(5)
    end

    turtle.forward()
    turtle.turnLeft()
    local fuel_chest = peripheral.wrap("front")
    print("Fuel level:", turtle.getFuelLevel())
    while turtle.getFuelLevel() < 150 and next(fuel_chest.list()) ~= nil do
        print(("Refueling: %d%%"):format(turtle.getFuelLevel()/150*100))
        turtle.suck(1)
        turtle.refuel(1)
    end
    print(("Refueling: %d%%"):format(turtle.getFuelLevel()/150*100))

    if turtle.getFuelLevel() < 150 then
        print("Not enough fuel!!!")
        break
    end

    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()

    input_chest = peripheral.wrap("front")
    while next(input_chest.list()) ~= nil and count ~= 16 do
        turtle.suck()
        count = count + 1
    end
    
    print("Going to chest 1")
    turtle.turnLeft()
    turtle.forward()
    turtle.forward()
    turtle.turnRight()
    local empty = false
    while not empty do
        local slot = 16
        while slot > 0 do
            turtle.select(slot)
            item = turtle.getItemDetail()
            if item ~= nil then
                local chest = peripheral.wrap("front")
                local content = chest.list()
                for _, chest_item in pairs(content) do
                    if chest_item.name == item.name then
                        print("Dropping", item.name)
                        turtle.drop()
                        break
                    end
                end
            end
            slot = slot - 1
        end

        empty = true
        slot = 16
        while slot > 0 do
            if turtle.getItemCount(slot) > 0 then
                empty = false
                break
            end
            slot = slot - 1
        end
        if col >= width - 1 and row >= height - 1 then
            break
        end
        if not empty then
            go_to_next_chest()
        end
    end

    while not empty do
        empty = true
        local slot = 16
        while slot > 0 do
            turtle.select(slot)
            item = turtle.getItemDetail()
            if item ~= nil then
                print("Dropping", item.name)
                turtle.drop()
            end
            item = turtle.getItemDetail()
            if item ~= nil then
                empty = false
            end
            slot = slot - 1
        end
        
        if col == 0 and row == 0 then
            break
        end
        if not empty then
            go_to_previous_chest()
        end
    end

    print("Going back...")
    while row > 0 do
        turtle.down()
        row = row - 1
    end
    turtle.turnRight()
    while col > 0 do
        turtle.forward()
        col = col - 1
    end
    turtle.forward()
    turtle.forward()
    turtle.turnRight()
    slot = 16
    print("Remaining items:")
    while slot > 0 do
        turtle.select(slot)
        local item = turtle.getItemDetail()
        if item ~= nil then
            print("    ", item.name)
        end
        turtle.drop()
        slot = slot - 1
    end
    turtle.turnLeft()
end
