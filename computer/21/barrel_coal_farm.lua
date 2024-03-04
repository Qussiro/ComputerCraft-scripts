local storage = peripheral.wrap("front")
local barrel_solver = peripheral.wrap("back")
local garbage = peripheral.wrap("left")
local coal_farm = peripheral.wrap("right")

while true do
    for slot, item in pairs(barrel_solver.list()) do
        if item.name == "minecraft:barrel" then
            barrel_solver.pushItems(peripheral.getName(coal_farm), slot)
            print("Tranfered", item.name)
        elseif item.name == "minecraft:papper" then
            barrel_solver.pushItems(peripheral.getName(garbage), slot)
            print("Burned", item.name)
        else
            barrel_solver.pushItems(peripheral.getName(storage), slot)
            
            print("Tranfered", item.name)
        end
        sleep(0.5)
    end
end
    
