local barrel = peripheral.wrap("front")
local chest = peripheral.wrap("back")
local barrel_count = 0

while true do
    if getName(peripheral.wrap("right")) == "minecraft:chest" then
        break
    end
    turtle.turnLeft()
end

while true do
    for slot, item in pairs(barrel.list()) do
        if item.name ~= "minecraft:barrel" then
            barrel.pushItems(peripheral.getName(chest), slot)
        end
    end
    turtle.suck()
    turtle.dig()
    turtle.place()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.select(2)
    turtle.drop()
    turtle.select(1)
    turtle.turnLeft()
    turtle.turnLeft()
    barrel_count = barrel_count + 1
    print(("-- %d fricking barrels later --"):format(barrel_count))
end
