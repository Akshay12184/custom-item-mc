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

        if turtle.detect() then
            turtle.dig()
        end
    end
end


function refuel(amount)
    if turtle.getFuelLevel() == "unlimited" then 
        return 
    end
    local neededFuel = 10 * amount
    if turtle.getFuelLevel() < neededFuel then
        local fuelSlot = slot.fuel
        turtle.select(fuelSlot)
        local refueled = turtle.refuel(amount)
        if not refueled then
            print("Error: No fuel available in slot ", fuelSlot)
        end
    end
end


function back()
    for i=1, 10, 1 do
        if i == 9 then 
            torch() 
        end
        if (i - 5) % 10 == 0 and i > 9 then 
            torch() 
        end
        turtle.back()
        if i == 9 and other.close then
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