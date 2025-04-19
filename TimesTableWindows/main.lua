--Times Table Windows

function love.load()
	love.window.setTitle("Times Table")
	windowSize = 1080
	circleRadiusOffset = 32
	love.window.setMode(windowSize, windowSize)
	circleCenterX = windowSize / 2
	circleCenterY = windowSize / 2
	circleRadius = (windowSize-circleRadiusOffset) / 2
	timesTableNumber = 2
	numberOfLines = 144
	circleCircumfrenceInRad = 2*math.pi
	arcLength = circleCircumfrenceInRad/numberOfLines -- in Rads
	incrementButton = {x = 10, y = 30, width = 100, height = 50}
	decrementButton = {x = 10, y = 90, width = 100, height = 50}
end

function love.draw()
	-- Draw increment Button
	love.graphics.setColor(0, 1, 0) -- green
	love.graphics.rectangle("fill", incrementButton.x, incrementButton.y, incrementButton.width, incrementButton.height)
	-- Draw decrement Button
	love.graphics.setColor(0, 0, 1) -- blue
	love.graphics.rectangle("fill", decrementButton.x, decrementButton.y, decrementButton.width, decrementButton.height)
	-- Draw button labels
	love.graphics.setColor(0, 0, 0) -- black
	love.graphics.print("Increment", incrementButton.x + 18, incrementButton.y + 18)
	love.graphics.print("Decrement", decrementButton.x + 18, decrementButton.y + 18)
	
	love.graphics.setColor(1, 1, 1) -- white
	love.graphics.print("Times Table Number: ", 10, 10)
	love.graphics.print(timesTableNumber, 140, 10)
	numberOfNodesToDraw = timesTableNumber-1
	-- this will be needed to draw past 2PI, by default 2 times table works, but for higher numbers we'll need to rotate the starting point and redraw the arcs to fill in the gaps
	-- for each times table number higher than 2, we'll need to increase the number of nodes and redraw at a different starting point in the circle(assuming it's just a mutiple of PI)
	startingOffset = circleCircumfrenceInRad/(numberOfNodesToDraw) 
	for i=0,numberOfNodesToDraw do
		for j=1,numberOfLines do
			love.graphics.arc( 
				"line", -- style of arc
				"closed", -- type of arc
				circleCenterX,
				circleCenterY, 
				circleRadius, 
				(arcLength * (timesTableNumber * j)) - (startingOffset * i),
				(arcLength * j) - (startingOffset * i)
			)
		end
	end
end

function love.mousepressed(x, y, button, intouch, presses)
	if button == 1 then
		if incrementButtonOnCLick(x, y) then
			timesTableNumber = timesTableNumber + 1
		end
		if decrementButtonOnCLick(x,y) and timesTableNumber > 2  then --stop from decrementing when it's less than 2
			timesTableNumber = timesTableNumber - 1 
		end
	end
end

function incrementButtonOnCLick(x, y)
	if x > incrementButton.x and x < (incrementButton.x + incrementButton.width) and
	   y > incrementButton.y and y < (incrementButton.y + incrementButton.height) then
		return true
	end
end

function decrementButtonOnCLick(x, y)
	if x > decrementButton.x and x < (decrementButton.x + decrementButton.width) and
	   y > decrementButton.y and y < (decrementButton.y + decrementButton.height) then
		return true
	end
end