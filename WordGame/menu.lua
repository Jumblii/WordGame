
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoJoinHalves()
	composer.gotoScene("joinHalves")
end

local function gotoUnscramble()
	composer.gotoScene("unscramble")
end

local function gotoWordSnake()
	composer.gotoScene("wordSnake")
end

local function gotoMedals()
	composer.gotoScene("medals")
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	
	local background = display.newImageRect(sceneGroup, "background.png", 360,570)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local title = display.newText(sceneGroup, "Word Game", display.contentCenterX, 0, "Luckiestguy.ttf", 53)
    title:setFillColor(1, 0.7, 0)

	local jhButton = display.newText(sceneGroup, "Join Halves", display.contentCenterX, 120, "Luckiestguy.ttf", 36)
	jhButton:setFillColor(1,0.7,0)

	local unButton = display.newText(sceneGroup, "Unscramble", display.contentCenterX, 180, "Luckiestguy.ttf", 36)
	unButton:setFillColor(1,0.7,0)

	local wsButton = display.newText(sceneGroup, "Word Snake", display.contentCenterX, 240, "Luckiestguy.ttf", 36)
	wsButton:setFillColor(1,0.7,0)

	local albumButton = display.newText(sceneGroup, "Medals", display.contentCenterX, 400, "Luckiestguy.ttf", 34)
	albumButton:setFillColor(1,0.7,0)

	jhButton:addEventListener("tap", gotoJoinHalves)
	unButton:addEventListener("tap", gotoUnscramble)
	wsButton:addEventListener("tap", gotoWordSnake)
	albumButton:addEventListener("tap", gotoMedals)

	composer.setVariable("score", 0)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

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
