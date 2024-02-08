while true do
    turtle.turnLeft()
    if math.random() > 0.5 then
        turtle.forward()
    else turtle.back()
    end
    sleep(0.5)
end
