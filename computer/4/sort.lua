local height = 2
local width = 6
local row = 0
local col = 0

function go_to_next_chest()
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

local input_chest = peripheral.wrap("front")
local need_to_sort = false
while not need_to_sort do
    local count = 0
    for _ in pairs(input_chest.list()) do
        count = count + 1
    end
    if count > 0 do
        need_to_sort = true
    end
    sleep(5)
end
turtle.turnLeft()
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
    
    if not empty then
        go_to_next_chest()
    end
end
print("Done")
while row > 0 do
    turtle.down()
    row = row - 1
end
if col > 0 then
    turtle.turnRight()
end
while col > 0 do
    turtle.forward()
    col = col - 1
end
turtle.forward()
turtle.forward()
