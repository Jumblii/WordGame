
local composer = require( "composer" )
local native = require("native")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local chosenWords = {}
local snakeWords = ""
local score = composer.getVariable("score")
local scoreSet = false

local function chooseWords()
	local chosenWords = {}
	word = words[math.random(#words)]
	for i=1, 10 do
		word = words[math.random(#words)]
		word = string.lower(word)
		table.insert(chosenWords, word)
	end
	return chosenWords
end

local function textListener( event )
 
    if ( event.phase == "began" ) then
        -- User begins editing "defaultField"
 
    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- Output resulting text from "defaultField"
        print( event.target.text )
		for i=1, #chosenWords do
			if event.target.text == chosenWords[i] then
				local cWord = chosenWords[i]
				print("Good Job!")
				event.target.text = ""
				table.remove(chosenWords, i)
				--local spaces = ""
				--for j=1, #cWord do
				--	spaces = spaces.."-"
				--end
				--print(spaces)
				--table.insert(chosenWords, i, spaces)
				snakeWords = ""
				for i=1, #chosenWords do
					print(chosenWords[i])
					snakeWords = snakeWords..chosenWords[i]
				end
			end
		end
 
    elseif ( event.phase == "editing" ) then
        
    end
end

local function restartGame(event)
	composer.gotoScene("resetter")
	return true
end

local function backToMenu(event)
	composer.gotoScene("menu")
	return true
end

local function gameLoop()

	snake.text = snakeWords
	if snake.text == "" then
		textInput.isVisible = false
		greatWorkBanner.isVisible = true
		restartGameButton.isVisible = true
		timer.pause(gameLoopTimer)
	end
	
	return true
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	composer.removeScene("resetter")
	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local background = display.newImageRect(sceneGroup, "background.png", 360,570)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local title = display.newText(sceneGroup, "Word Snake", display.contentCenterX, 0, "Luckiestguy.ttf", 50)
    title:setFillColor(1, 0.7, 0)

	backToMenuButton = display.newImageRect(sceneGroup, "backToMenu.png", 30,30)
	backToMenuButton.x = 300
	backToMenuButton.y = 480
	backToMenuButton:addEventListener("tap", backToMenu)

	restartGameButton = display.newText(
			sceneGroup, "Play Again",
			display.contentCenterX , 
			display.contentCenterY + 50,
			"Luckiestguy.ttf",
			30)
	restartGameButton:addEventListener("tap", restartGame)
	restartGameButton.isVisible = false

	greatWorkBanner = display.newText(sceneGroup, "GREAT WORK!", display.contentCenterX, display.contentCenterY, "Luckiestguy.ttf", 45)
	greatWorkBanner.isVisible = false

	chosenWords = chooseWords()
	
	
	for i=1, #chosenWords do
		print(chosenWords[i])
		snakeWords = snakeWords..chosenWords[i]
	end

	snake = display.newText(sceneGroup,
								  snakeWords,
								  160,
								  180,
								  240,
								  300,
								  "Luckiestguy.ttf",
								  35)
	
	textInput = native.newTextField(display.contentCenterX, 320, 100,50)
	textInput:addEventListener("userInput", textListener)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase
	
	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
		if greatWorkBanner.isVisible==false then
			textInput.isVisible = true
			textInput.text = ""
		end
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		textInput.isVisible = false
		if greatWorkBanner.isVisible==true and scoreSet == false then
			score = score+1
			scoreSet=true
			composer.setVariable("score", score)
		end
	elseif ( phase == "did" ) then
		
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	timer.cancel(gameLoopTimer)
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
