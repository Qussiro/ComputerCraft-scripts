local barrel = peripheral.wrap("front")
local chest = peripheral.wrap("right")
local barrel_count = 0

function save_data()
    local file = io.open("barrels_data.txt", "w")
    io.output(file)
    io.write(barrel_count)
    io.flush()
    io.close(file)
end

function read_data()
    local file, err = io.open("barrels_data.txt", "r")
    if file ~= nil then
        barrel_count = tonumber(file:read())
        io.close(file)
    else
        save_data()
    end
end

read_data()

while true do
    local _, data = turtle.inspect()
    if data.name == "minecraft:chest" then
        turtle.turnLeft()
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
    save_data()
end
