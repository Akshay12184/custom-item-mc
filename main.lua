branch = {
    amount = 5,
    length = 20,
    space  = 5
}

slot = {
    fuel  = 1,
    torch = 2,
    fill  = 3
}

other = {
    torch = true,
    close = true
}

function main()
    for i=1, branch.amount, 1 do
        refuel(1+(branch.space+branch.length*4)/96)
        forward(1)
        turnAround()
        torch()
        turnAround()
        forward(branch.space)
        turnLeft()
        forward(branch.length)
        back(branch.length)
        turnAround()
        forward(branch.length)
        back(branch.length)
        turnLeft()
    end
end

function forward(length)
    for i=1, length, 1 do
        while turtle.detect() or turtle.detectUp() do
            turtle.dig()
            turtle.digUp()
            sleep(0.5)
        end
        if not turtle.detectDown() then
            turtle.select(slot.fill)
            turtle.placeDown()
        end
        turtle.forward()
    end
end

function refuel(amount)
    if turtle.getFuelLevel() == "unlimited" then 
        return 
    end
    if turtle.getFuelLevel() < 96*amount then
        turtle.select(slot.fuel)
        turtle.refuel(amount)
    end
end

function back(length)
    for i=1, length, 1 do
        if i == 9 then 
            torch() 
        end
        if (i - 8) % 16 == 0 and i > 9 then 
            torch() 
        end
        turtle.back()
        if i == length - 1 and other.close then
            turtle.select(slot.fill)
            turtle.placeUp()
        end
    end
end

function turnLeft()
    turtle.turnLeft()
end

function turnRight()
    turtle.turnRight()
end

function turnAround()
    turtle.turnRight()
    turtle.turnRight()
end

function torch()
    if other.torch then
        turtle.select(slot.torch)
        turtle.place()
    end
end

main()
