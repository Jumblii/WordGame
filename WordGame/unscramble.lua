
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


local dLettersOne = {}
local dLettersTwo = {}
local dLettersThree = {}
local dLettersFour = {}
local dLettersFive = {}
local answerSheet = {}
local finishedWords = 0
local score = composer.getVariable("score")


local function restartGame(event)
	composer.gotoScene("resetter")
	return true
end

local function checkOne()
	local answer = ""
	for i=1, #dLettersOne do
		for j=1, #dLettersOne do
			if dLettersOne[j].position == i then
				answer = answer..dLettersOne[j].text
			end
		end
	end
	if answer == answerSheet[1] then
		for i=1, #dLettersOne do
			dLettersOne[i].isVisible=false	
		end
		return true
	else 
		return false
	end
end

local function checkTwo()
	local answer = ""
	for i=1, #dLettersTwo do
		for j=1, #dLettersTwo do
			if dLettersTwo[j].position == i then
				answer = answer..dLettersTwo[j].text
			end
		end
	end

	if answer == answerSheet[2] then
		for i=1, #dLettersTwo do
			dLettersTwo[i].isVisible=false
		end
		return true
	else 
		return false
	end
end
local function checkThree()
	local answer = ""
	for i=1, #dLettersThree do
		for j=1, #dLettersThree do
			if dLettersThree[j].position == i then
				answer = answer..dLettersThree[j].text
			end
		end
	end

	if answer == answerSheet[3] then
		for i=1, #dLettersThree do
			dLettersThree[i].isVisible=false	
		end
		return true
	else 
		return false
	end
end

local function checkFour()
	local answer = ""
	for i=1, #dLettersFour do
		for j=1, #dLettersFour do
			if dLettersFour[j].position == i then
				answer = answer..dLettersFour[j].text
			end
		end
	end

	if answer == answerSheet[4] then
		for i=1, #dLettersFour do
			dLettersFour[i].isVisible=false	
		end
		return true
	else 
		return false
	end
end

local function checkFive()
	local answer = ""
	for i=1, #dLettersFive do
		for j=1, #dLettersFive do
			if dLettersFive[j].position == i then
				answer = answer..dLettersFive[j].text
			end
		end
	end

	if answer == answerSheet[5] then
		for i=1, #dLettersFive do
			dLettersFive[i].isVisible=false
		end
		return true
	else 
		return false
	end
end

local function checkWin() --method to check taps, answer
	

	local oneFin = checkOne()
	local twoFin = checkTwo()
	local threeFin = checkThree()
	local fourFin = checkFour()
	local fiveFin = checkFive()
	
	if oneFin==true 
		and twoFin==true 
		and threeFin==true 
		and fourFin==true 
		and fiveFin==true then
		greatWorkBanner.isVisible = true
		restartGameButton.isVisible = true
		score = score+1
		composer.setVariable("score", score)
	end
	return true
end

local function chooseWord()
	local chosenWord = ""
	local letterList = {}
	chosenWord = words[math.random(#words)]
	while string.len(chosenWord) <= 4 or string.len(chosenWord)>6 do
		--print(chosenWord)
		chosenWord = words[math.random(#words)]
	end
	chosenWord = string.upper(chosenWord)
	print(chosenWord)
	table.insert(answerSheet, chosenWord)
	for i=1, string.len(chosenWord) do
		table.insert(letterList, chosenWord:sub(i,i))
	end
	return letterList
end

local function backToMenu(event)
	composer.gotoScene("menu")
	return true
end


local function tapListenerOne(event)
	event.target:setFillColor(1,1,0)
	event.target.tapped = true
	
	--print(event.target.position)
	for i=1, #dLettersOne do
		if dLettersOne[i] ~= event.target and dLettersOne[i].tapped==true then
			local x = dLettersOne[i].x
			local y = dLettersOne[i].y
			local pos = dLettersOne[i].position
			dLettersOne[i].x = event.target.x
			dLettersOne[i].y = event.target.y
			dLettersOne[i].position = event.target.position
			dLettersOne[i].tapped = false
			dLettersOne[i]:setFillColor(1,1,1)
			event.target.x = x
			event.target.y = y
			event.target.position = pos
			event.target.tapped = false
			event.target:setFillColor(1,1,1)
			
		end
	end
	checkWin()
	return true
end

local function tapListenerTwo(event)
	event.target:setFillColor(1,1,0)
	event.target.tapped = true
	for i=1, #dLettersTwo do
		if dLettersTwo[i] ~= event.target and dLettersTwo[i].tapped==true then
			local x = dLettersTwo[i].x
			local y = dLettersTwo[i].y
			local pos = dLettersTwo[i].position
			dLettersTwo[i].x = event.target.x
			dLettersTwo[i].y = event.target.y
			dLettersTwo[i].position = event.target.position
			dLettersTwo[i].tapped = false
			dLettersTwo[i]:setFillColor(1,1,1)
			event.target.x = x
			event.target.y = y
			event.target.position = pos
			event.target.tapped = false
			event.target:setFillColor(1,1,1)
		end
	end
	checkWin()
	return true
end

local function tapListenerThree(event)
	event.target:setFillColor(1,1,0)
	event.target.tapped = true
	for i=1, #dLettersThree do
		if dLettersThree[i] ~= event.target and dLettersThree[i].tapped==true then
			local x = dLettersThree[i].x
			local y = dLettersThree[i].y
			local pos = dLettersThree[i].position
			dLettersThree[i].x = event.target.x
			dLettersThree[i].y = event.target.y
			dLettersThree[i].position = event.target.position
			dLettersThree[i].tapped = false
			dLettersThree[i]:setFillColor(1,1,1)
			event.target.x = x
			event.target.y = y
			event.target.position = pos
			event.target.tapped = false
			event.target:setFillColor(1,1,1)
		end
	end
	checkWin()
	return true
end

local function tapListenerFour(event)
	event.target:setFillColor(1,1,0)
	event.target.tapped = true
	for i=1, #dLettersFour do
		if dLettersFour[i] ~= event.target and dLettersFour[i].tapped==true then
			local x = dLettersFour[i].x
			local y = dLettersFour[i].y
			local pos = dLettersFour[i].position
			dLettersFour[i].x = event.target.x
			dLettersFour[i].y = event.target.y
			dLettersFour[i].position = event.target.position
			dLettersFour[i].tapped = false
			dLettersFour[i]:setFillColor(1,1,1)
			event.target.x = x
			event.target.y = y
			event.target.position = pos
			event.target.tapped = false
			event.target:setFillColor(1,1,1)
		end
	end
	checkWin()
	return true
end

local function tapListenerFive(event)
	event.target:setFillColor(1,1,0)
	event.target.tapped = true
	for i=1, #dLettersFive do
		if dLettersFive[i] ~= event.target and dLettersFive[i].tapped==true then
			local x = dLettersFive[i].x
			local y = dLettersFive[i].y
			local pos = dLettersFive[i].position
			dLettersFive[i].x = event.target.x
			dLettersFive[i].y = event.target.y
			dLettersFive[i].position = event.target.position
			dLettersFive[i].tapped = false
			dLettersFive[i]:setFillColor(1,1,1)
			event.target.x = x
			event.target.y = y
			event.target.position = pos
			event.target.tapped = false
			event.target:setFillColor(1,1,1)
		end
	end
	checkWin()
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

	local title = display.newText(sceneGroup, "Unscramble", display.contentCenterX, 0, "Luckiestguy.ttf", 50)
    title:setFillColor(1, 0.7, 0)

	backToMenuButton = display.newImageRect(sceneGroup, "backToMenu.png", 30,30)
	backToMenuButton.x = 300
	backToMenuButton.y = 480
	backToMenuButton:addEventListener("tap", backToMenu)
	local words  = {}
	
	for i=1, 5 do
		local word = chooseWord()
		table.insert(words, word)
	end
	
	for i=1, #words do
		words[i] = shuffle(words[i])
	end

	
	print(table.getn(words))
	for i=1, #words[1] do
		dLettersOne[i] = display.newText(sceneGroup, words[1][i], display.contentCenterX-(140-(40*i)), 80+(60*1), "Luckiestguy.ttf", 50)
		dLettersOne[i]:addEventListener("tap", tapListenerOne)
		dLettersOne[i].tapped = false
		dLettersOne[i].position = i
	end
	for i=1, #words[2] do
		dLettersTwo[i] = display.newText(sceneGroup, words[2][i], display.contentCenterX-(140-(40*i)), 80+(60*2), "Luckiestguy.ttf", 50)
		dLettersTwo[i]:addEventListener("tap", tapListenerTwo)
		dLettersTwo[i].tapped = false
		dLettersTwo[i].position = i
	end
	for i=1, #words[3] do
		dLettersThree[i] = display.newText(sceneGroup, words[3][i], display.contentCenterX-(140-(40*i)), 80+(60*3), "Luckiestguy.ttf", 50)
		dLettersThree[i]:addEventListener("tap", tapListenerThree)
		dLettersThree[i].tapped = false
		dLettersThree[i].position = i
	end
	for i=1, #words[4] do
		dLettersFour[i] = display.newText(sceneGroup, words[4][i], display.contentCenterX-(140-(40*i)), 80+(60*4), "Luckiestguy.ttf", 50)
		dLettersFour[i]:addEventListener("tap", tapListenerFour)
		dLettersFour[i].tapped = false
		dLettersFour[i].position = i
	end
	for i=1, #words[5] do
		dLettersFive[i] = display.newText(sceneGroup, words[5][i], display.contentCenterX-(140-(40*i)), 80+(60*5), "Luckiestguy.ttf", 50)
		dLettersFive[i]:addEventListener("tap", tapListenerFive)
		dLettersFive[i].tapped = false
		dLettersFive[i].position = i
	end
	greatWorkBanner = display.newText(sceneGroup, "GREAT WORK!", display.contentCenterX, display.contentCenterY, "Luckiestguy.ttf", 45)
	greatWorkBanner.isVisible = false

	restartGameButton = display.newText(
			sceneGroup, "Play Again",
			display.contentCenterX , 
			display.contentCenterY + 50,
			"Luckiestguy.ttf",
			30)
	restartGameButton:addEventListener("tap", restartGame)
	restartGameButton.isVisible = false
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		--gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	--timer.cancel(gameLoopTimer)
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
