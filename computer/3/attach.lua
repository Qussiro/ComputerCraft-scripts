local i = 0
local total_burned = 0
local total_collected = 0

function save_data()
    local file = io.open("andesite_data.txt", "w")
    io.output(file)
    io.write(("%d\n%d\n%d"):format(i, total_burned, total_collected))
    io.flush()
    io.close(file)
end

function read_data()
    local file, err = io.open("andesite_data.txt", "r")
    if file ~= nil then
        i = tonumber(file:read())
        total_burned = tonumber(file:read())
        total_collected = tonumber(file:read())
        io.close(file)
    else
        save_data()
    end
end

read_data()

while true do
    local collected = 0
    local burned = 0
    local event, side = os.pullEvent("peripheral")
    i = i + 1
    print(("\n -=- Attached #%d -=-"):format(i))
    local modem = peripheral.wrap("back")
    local barrel = peripheral.wrap("right")
    local andesite = peripheral.wrap("front")
    local garbage = peripheral.wrap("left")
    local x, y = term.getCursorPos()

    for slot, item in pairs(barrel.list()) do
        if item.name == "create:andesite_cobblestone" then
            local count = 0
            while count < item.count do
                count = count + barrel.pushItems(peripheral.getName(andesite), slot)
                collected = collected + count
                term.setCursorPos(1, y)
                term.clearLine()
                if item.count-count > 0 then
                    write(("Andesite: %d"):format(item.count-count))
                end
                total_collected = total_collected + collected
                save_data()
                sleep(0.5)
            end
        else
            local count = 0
            while count < item.count do
                count = count + barrel.pushItems(peripheral.getName(garbage), slot)
                burned = burned + count
                term.setCursorPos(1, y)
                term.clearLine()
                if item.count-count > 0 then
                    write(("Garbage: %d"):format(item.count-count))
                end
                total_burned = total_burned + burned
                save_data()
                sleep(0.5)
            end
        end
    end

    term.setCursorPos(1, y)
    term.clearLine()

    total_collected = total_collected + collected
    total_burned = total_burned + burned
    save_data()
    modem.transmit(3, 0, "Empty")
    print(("\nCollected: %d\nBurned: %d"):format(collected, burned))
    print(("\nTotal collected: %d\nTotal Burned: %d"):format(total_collected,total_burned))
    print("(Going Down)")
end
