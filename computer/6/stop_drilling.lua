local hopper = peripheral.wrap("back")

while true do
    if hopper.getItemDetail(5).count == 64 then
        print("Hopper is Full")
        redstone.setOutput("front", true)
    else
        print("Hopper is empty")
        redstone.setOutput("front", false)
    end
    sleep(0.5)
end
