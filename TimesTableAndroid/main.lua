--Times Table Android

function love.load()
	love.window.setTitle("Times Table")
	love.window.setMode(1,2) --force portrait mode
	circleCenterX = 0
	circleCenterY = 0
	circleRadius = 0
	timesTableNumber = 2
	numberOfLines = 144
	circleCircumferenceInRad = 2*math.pi
	arcLength = circleCircumferenceInRad/numberOfLines -- in Rads
	incrementButton = {label = "UP", x = 10, y = 30, width = 100, height = 50}
	decrementButton = {label = "DOWN", x = 10, y = 90, width = 100, height = 50}
	exitButton = {label = "EXIT", x = 275, y = 30, width = 100, height = 50}
end

function love.draw()
	-- Draw increment Button
	love.graphics.setColor(0, 1, 0) -- green
	love.graphics.rectangle("line", incrementButton.x, incrementButton.y, incrementButton.width, incrementButton.height)
	-- Draw decrement Button
	love.graphics.setColor(0, 0, 1) -- blue
	love.graphics.rectangle("line", decrementButton.x, decrementButton.y, decrementButton.width, decrementButton.height)
	-- Draw EXIT Button
	love.graphics.setColor(1, 0, 0) -- red
	love.graphics.rectangle("line", exitButton.x, exitButton.y, exitButton.width, exitButton.height)
	-- Draw button labels
	love.graphics.setColor(1, 1, 1) -- white
	love.graphics.printf(incrementButton.label, incrementButton.x, incrementButton.y + incrementButton.height / 3, incrementButton.width, "center")
	love.graphics.printf(decrementButton.label, decrementButton.x, decrementButton.y + decrementButton.height / 3, decrementButton.width, "center")
	love.graphics.printf(exitButton.label, exitButton.x, exitButton.y + exitButton.height / 3, exitButton.width, "center")
	-- Draw Times Table
	love.graphics.circle("fill", circleCenterX-circleRadius, circleCenterY, 3)
	love.graphics.circle("fill", circleCenterX+circleRadius, circleCenterY, 3)
	love.graphics.circle("fill", circleCenterX, circleCenterY-circleRadius, 3)
	love.graphics.circle("fill", circleCenterX, circleCenterY+circleRadius, 3)
	love.graphics.print("Times Table Number: ", 10, 10)
	love.graphics.print(timesTableNumber, 150, 10)
	numberOfNodesToDraw = timesTableNumber-1
	-- this will be needed to draw past 2PI, by default 2 times table works, but for higher numbers we'll need to rotate the starting point and redraw the arcs to fill in the gaps
	-- for each times table number higher than 2, we'll need to increase the number of nodes and redraw at a different starting point in the circle(assuming it's just a mutiple of PI)
	startingOffset = circleCircumferenceInRad/numberOfNodesToDraw
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

function love.mousepressed(x, y, button, istouch, presses)
	if istouch then 
		if incrementButtonOnCLick(x, y) then
			timesTableNumber = timesTableNumber + 1
		end
		if decrementButtonOnCLick(x, y) and timesTableNumber > 2  then --stop from decrementing when it's less than 2 then
			timesTableNumber = timesTableNumber - 1
		end
		if exitButtonOnCLick(x, y) then
			love.event.quit() --Close the app
		end
	end
end

function love.resize(w, h)
-- get real dimensions
  circleCenterX = w / 2
  circleCenterY = h / 2
  circleRadius = (w / 2) - 10 --offset so that there is a gap in between the circle and the screen
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

function exitButtonOnCLick(x, y)
	if x > exitButton.x and x < (exitButton.x + exitButton.width) and
	   y > exitButton.y and y < (exitButton.y + exitButton.height) then
		return true
	end
end

