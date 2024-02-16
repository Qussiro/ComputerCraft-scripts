while true do
    local event, side = os.pullEvent("peripheral")
    local count = 0
    local storage = peripheral.wrap("left")
    for _ in pairs(storage.list()) do
        count = count + 1
    end
    print(count)
  end
