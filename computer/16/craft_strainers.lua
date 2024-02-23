local basin = peripheral.wrap("front")
local sticks_storage = peripheral.wrap("back")

while true do
    local _, block = turtle.inspect()
    if block.name == "create:basin" then
        break
    end
end

function process()
    local _, item = next(sticks_storage.list())
    if item == nil or item.count < 6 then
        return
    end 
    local canvas_count = 0
    for i, item in pairs(basin.list()) do
        if item.name == "farmersdelight:canvas" then
            canvas_count = canvas_count + item.count
        end
    end
    if canvas_count < 3 then
        return
    end
    turtle.select(16)
    turtle.suck()
    if turtle.getItemDetail().name == "farmersdelight:canvas" then
        turtle.transferTo(5, 1)
        turtle.transferTo(6, 1)
        turtle.transferTo(7, 1)
        turtle.drop()
    else
        turtle.select(15)
        turtle.suck()
        turtle.transferTo(5, 1)
        turtle.transferTo(6, 1)
        turtle.transferTo(7, 1)
        turtle.drop()
        turtle.select(16)
        turtle.drop()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.select(1)
    turtle.suck(1)
    turtle.select(2)
    turtle.suck(1)
    turtle.select(3)
    turtle.suck(1)
    turtle.select(9)
    turtle.suck(1)
    turtle.select(10)
    turtle.suck(1)
    turtle.select(11)
    turtle.suck(1)
    turtle.craft()
    turtle.turnLeft()
    turtle.drop()
    turtle.turnLeft()
end

while true do
    process()
end