
local composer = require( "composer" )
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local resultF = ""
local resultS = ""
local dFirsts = {}
local dSeconds = {}
local chosenWords = {}
local score = composer.getVariable("score")
local scoreSet = false

local function chooseWords()
	local chosenWords = {}
	for i=1, 10 do
		local word = ""
		local n = 1
		repeat
				word = words[math.random(#words)]
				n = string.len(word)
		until (n>2 and n%2==0)
		table.insert(chosenWords, word)
	end
	return chosenWords
end

local function halveWords(chosenWords)
	firstHalves = {}
	secondHalves = {}
	for i=1, #chosenWords do
		n = string.len(chosenWords[i])
		table.insert(firstHalves, string.sub(chosenWords[i], 1, n/2))
		table.insert(secondHalves, string.sub(chosenWords[i], (n/2)+1, n))
	end
	return firstHalves, secondHalves
end



local function resetTapped(array)
	for i=1, #array do
		array[i]:setFillColor(1,1,1)
		array[i].tapped = false
	end
	return true
end

local function tapListener(event)
 
    -- Code executed when the button is tapped
    --print( "Object tapped: " .. tostring(event.target.text) )  -- "event.target" is the tapped object
	event.target:setFillColor(1,1,0)
	event.target.tapped = true
	for i=1, #dFirsts do
		if dFirsts[i]==event.target then
			resultF = event.target.text
		end
	end
	for i=1, #dSeconds do
		if dSeconds[i]==event.target then
			resultS = event.target.text
		end
	end
	
	--print("First is: "..resultF)
	--print("second is: "..resultS)
	--print(tostring(event.target.tapped))

    return true
end

local function restartGame(event)
	composer.gotoScene("resetter")
	return true
end

local function backToMenu(event)
	composer.gotoScene("menu")
	return true
end

local function gameLoop() --method to check taps, answer
	local tapsF = 0 --taps on first halves
	local tapsS = 0 --taps on second halves	
	for i=1, #dFirsts do
		if dFirsts[i].tapped == true then
			tapsF = tapsF+1
		end
	end
	--print("tapsF = "..tostring(tapsF))
	if tapsF > 1 then
		resetTapped(dFirsts)
		resetTapped(dSeconds)
		tapsF = 0
		resultF = ""
		resultS = ""
	end
	for i=1, #dSeconds do
		if dSeconds[i].tapped == true then
			tapsS = tapsS+1
		end
	end	
	--print("tapsS = "..tostring(tapsS))
	if tapsS > 1 then
		resetTapped(dSeconds)
		resetTapped(dFirsts)
		tapsS = 0
		resultF = ""
		resultS = ""
	end
	if tapsF+tapsS>2 then
		resetTapped(dFirsts)
		resetTapped(dSeconds)
		resultF = ""
		resultS = ""
	end
	
	for i=1, #chosenWords do
		if resultF..resultS == chosenWords[i] then
			--print("Great Work")
			for j=1,#dFirsts do
				if dFirsts[j].tapped == true then
					dFirsts[j].isVisible = false
				end
				if dSeconds[j].tapped == true then
					dSeconds[j].isVisible = false
				end
			end	
			resetTapped(dFirsts)
			resetTapped(dSeconds)
			resultF = ""
			resultS = ""
		end
	end
	local finished = 0
	for i=1, #dFirsts do 
		if dFirsts[i].isVisible==false then
			finished = finished+1
		end
	end
	if finished == #dFirsts then
		greatWorkBanner.isVisible = true
		restartGameButton.isVisible = true
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

	local title = display.newText(sceneGroup, "Join Halves", display.contentCenterX, 0, "Luckiestguy.ttf", 50)
    title:setFillColor(1, 0.7, 0)

	chosenWords = chooseWords()
	local firstHalves, secondHalves = halveWords(chosenWords)
	shuffle(firstHalves)
	shuffle(secondHalves)
	

	for i=1, #firstHalves do
		--print(firstHalves[i].."-"..secondHalves[i])
		dFirsts[i] = display.newText(sceneGroup, firstHalves[i], display.contentCenterX-(80), 40+(40*i), "Luckiestguy.ttf", 40)
		dFirsts[i].tapped = false
		dFirsts[i]:addEventListener( "tap", tapListener )
		dSeconds[i] = display.newText(sceneGroup, secondHalves[i], display.contentCenterX+(80), 40+(40*i), "Luckiestguy.ttf", 40)
		dFirsts[i].tapped = false
		dSeconds[i]:addEventListener( "tap", tapListener )
	end	

	greatWorkBanner = display.newText(sceneGroup, "GREAT WORK!", display.contentCenterX, display.contentCenterY, "Luckiestguy.ttf", 45)
	greatWorkBanner.isVisible = false

	restartGameButton = display.newText(
			sceneGroup, "Play Again",
			display.contentCenterX , 
			display.contentCenterY + 50,
			"Luckiestguy.ttf",
			30)
	backToMenuButton = display.newImageRect(sceneGroup, "backToMenu.png", 30,30)
	backToMenuButton.x = 300
	backToMenuButton.y = 480
	restartGameButton.isVisible=false
	restartGameButton:addEventListener("tap", restartGame)
	backToMenuButton:addEventListener("tap", backToMenu)
	
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		halvesGameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase
	
	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		
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
	timer.cancel(halvesGameLoopTimer)
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
