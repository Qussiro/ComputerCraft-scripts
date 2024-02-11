function go_to_next_chest()
    if col < width - 1 then
        turtle.turnRight()
        turtle.forward()
        turtle.forward()
        turtle.turnLeft()
        col = col + 1
    else
        turtle.turnLeft()
        local i = col
        while i >= 0 do
            turtle.forward()
            turtle.forward()
            i = i - 1
        end
        turtle.down()
        turtle.turnRight()
        col = 0
        row = row + 1
    end
end

local width = 2
local height = 2
local row = 0
local col = 0
local count = 16

while count > 0 do
    turtle.select(count)
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
    count = count - 1
end
