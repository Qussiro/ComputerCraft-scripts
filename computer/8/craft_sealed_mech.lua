local rubber = peripheral.wrap("front")
local kinetic = peripheral.wrap("left")
function process()
    local _, item = next(rubber.list())
    if item == nil or item.count < 2 then
        return
    end 
    if next(kinetic.list()) == nil then
        return
    end
    turtle.select(5)
    turtle.suck(1)
    turtle.select(7)
    turtle.suck(1)
    turtle.turnLeft()
    turtle.select(6)
    turtle.suck(1)
    turtle.turnRight()
    turtle.craft()
    turtle.turnRight()
    turtle.drop()
    turtle.turnLeft()    
end

while true do
    process()
end
