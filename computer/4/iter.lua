local barrel = peripheral.wrap("back")
for i, k in pairs(barrel.list()) do
    print(i, k.name)
end
