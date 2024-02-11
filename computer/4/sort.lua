function go_to_next_chest()
    if row < height - 1 then
        turtle.up()
        row = row + 1
    else
        while row > 0 do
            turtle.down()
        end
        turtle.turnLeft()
        turtle.forward()
        turtle.turnRight()
        col = col + 1
    end
end

local width = 2
local height = 2
local row = 0
local col = 0

local empty = false
while ~empty do
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

    slot = 16
    while slot > 0 do
        if turtle.getItemCount(slot) > 0 do
            empty = false
            break
        end
    end
end
