
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function backToMenu(event)
	composer.gotoScene("menu")
	return true
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

	local title = display.newText(sceneGroup, "Medals", display.contentCenterX, 0, "Luckiestguy.ttf", 50)
    title:setFillColor(1, 0.7, 0)

	backToMenuButton = display.newImageRect(sceneGroup, "backToMenu.png", 30,30)
	backToMenuButton.x = 300
	backToMenuButton.y = 480
	backToMenuButton:addEventListener("tap", backToMenu)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
		score = composer.getVariable("score")
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		--print(score)
		--score=3
		local bronzeAlpha = 0.4 + score*0.06
		local silverAlpha = 0.4 + score*0.03
		local goldAlpha = 0.4 + score*0.012
		local bronzeOutput = 0
		local silverOutput = 0
		local goldOutput = 0
		if score>10 then
			bronzeOutput = 10
		else bronzeOutput = score
		end
		if score>20 then
			silverOutput = 20
		else silverOutput = score
		end
		if score>50 then
			goldOutput = 50
		else goldOutput = score
		end
		
		bronzeScore = display.newText(sceneGroup, bronzeOutput.."/10", display.contentCenterX, 170, "Luckiestguy.ttf", 30)
		local bronze = display.newCircle( sceneGroup, display.contentCenterX, 100, 40 )
		bronze:setFillColor(0.565, 0.349, 0.137, bronzeAlpha)	
		bronzeNo = display.newText(sceneGroup, "3", display.contentCenterX, 100, "Luckiestguy.ttf", 60)
		bronzeNo:setFillColor(0.665,0.449,0.237)

		silverScore = display.newText(sceneGroup, silverOutput.."/20", display.contentCenterX, 320, "Luckiestguy.ttf", 30)
		local silver = display.newCircle( sceneGroup, display.contentCenterX, 250, 50 )
		silver:setFillColor(0.8,0.8,0.8, silverAlpha)	
		silverNo = display.newText(sceneGroup, "2", display.contentCenterX, 250, "Luckiestguy.ttf", 70)
		silverNo:setFillColor(0.9,0.9,0.9)
		
		goldScore = display.newText(sceneGroup, goldOutput.."/50", display.contentCenterX, 480, "Luckiestguy.ttf", 30)
		local gold = display.newCircle( sceneGroup, display.contentCenterX, 400, 60 )
		gold:setFillColor(1,0.6,0, goldAlpha)
		goldNo = display.newText(sceneGroup, "1", display.contentCenterX, 400, "Luckiestguy.ttf", 90)
		goldNo:setFillColor(1,0.7,0)
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
		display.remove(bronzeScore)
		display.remove(bronze)
		display.remove(bronzeNo)

		display.remove(silverScore)
		display.remove(silver)
		display.remove(silverNo)	

		display.remove(goldScore)
		display.remove(gold)
		display.remove(goldNo)
			
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
