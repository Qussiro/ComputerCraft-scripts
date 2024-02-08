local width = 2
local height = 2
local row = 0
local col = 0

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

local count = 16
while count > 0 do
    if row + 1 >= height and col + 1 >= width then
        assert(false, "Item not found")
    end
    turtle.select(count)
    turtle.drop()
    if turtle.getItemCount() > 0 then
        go_to_next_chest()
    end     
end
