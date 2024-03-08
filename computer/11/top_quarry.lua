local modem = peripheral.wrap("top")
modem.open(5)

function save_state()
    local file = io.open("state.txt", "w")
    io.output(file)
    io.write(("%d\n"):format(
        fromBoolean(redstone.getOutput("back"))
    ))
    io.flush()
    io.close(file)
end

function read_state()
    local file, err = io.open("state.txt", "r")
    if file ~= nil then
        redstone.setOutput("back", toBoolean(file:read()))
        io.close(file)
    else
        save_state()
    end
end

function toBoolean(variable)
    assert(type(variable) == "string", type(variable))
    if variable == "0" then 
        return false 
    end
    return true
end

function fromBoolean(variable)
    if variable == true then 
        return 1
    end
    return 0
end

read_state()
while true do
    local _, _, _, _, message = os.pullEvent("modem_message")
    if message == true then
        redstone.setOutput("back", true)
        print("Up/Down")
    elseif message == false then
        redstone.setOutput("back", false)
        print("Forward/Backward")
    else 
        assert(false, "Invalid " .. message)
    end
    save_state()
end
