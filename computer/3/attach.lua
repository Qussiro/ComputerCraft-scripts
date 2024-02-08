local i = 0
local total_burned = 0
local total_collected = 0

while true do
    local collected = 0
    local burned = 0
    local event, side = os.pullEvent("peripheral")
    i = i + 1
    print(("\n -=- Attached #%d -=-"):format(i))
    local modem = peripheral.wrap("bottom")
    local barrel = peripheral.wrap("front")
    local x, y = 0, 0

    local next = next
    local count_a = 0
    local count_g = 0

    local prev_slot = -1
    while true do
        local content = barrel.list()
        local orederd_keys = {}
        for k in pairs(content) do 
            table.insert(ordered_keys, k)
        end
        table.sort(ordered_keys)
        local slot, item = content[ordered_keys[1]]

        x, y = term.getCursorPos()

        if item == nil then
            break
        end
        
        if slot ~= prev_slot then
            local count = item.count
            if prev_slot == -1 then
                count = count + 1
            end
            prev_slot = slot
            
            if item.name == "create:andesite_cobblestone" then
                collected = collected + count
            else
                burned = burned + count
            end
            redstone.setOutput("front", true)
            sleep(0.5)
        end

        if item.name == "create:andesite_cobblestone" then
            redstone.setOutput("left", true)
            redstone.setOutput("front", false)
            term.setCursorPos(1, y)
            term.clearLine()
            write(("Andesite: %d"):format(item.count))
        else
            redstone.setOutput("left", false)
            redstone.setOutput("front", false)
            term.setCursorPos(1, y)
            term.clearLine()
            write(("Garbage: %d"):format(item.count))
        end 
    end
    term.setCursorPos(1, y)
    term.clearLine()

    total_collected = total_collected + collected
    total_burned = total_burned + burned
    modem.transmit(3, 0, "Empty")
    print(("\nCollected: %d\nBurned: %d"):format(collected, burned))
    print(("\nTotal collected: %d\nTotal Burned: %d"):format(total_collected,total_burned))
    print("(Going Down)")
    redstone.setOutput("left", false)
end
