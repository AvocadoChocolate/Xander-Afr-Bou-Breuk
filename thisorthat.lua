local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
end

local choose = { "butterfly.png", "car.png", "fish.png", "frog.png", "snowman.png", "tree.png" }
local numb = 1
local bigsmall = false
local left = true

local speech = {"Puik.", "Fantasties.", "Uitstekend."}
local dialog = {}
local speechtext = {}
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20
local levels = {"rangskik","hoeveelvorms","vormwatpas","patrone"}

local function NextLv(event)
 math.randomseed( os.time() )
					local n = math.random(#levels)
					
					if imgx then
					imgx:removeSelf()
 					imgx = nil
 					
 					 dialog:removeSelf()
 dialog = nil
 
 speechtext:removeSelf()
 speechtext = nil
 					end
 

					--composer.removeScene("rangskik")
composer.removeScene("thisorthat")
-- composer.removeScene("patrone")
-- composer.removeScene("hoeveelvorms")
-- composer.removeScene("vormwatpas")

composer.gotoScene( levels[n] )
 
end

local function playX(event)
imgx = display.newImage("X1.png")
imgx:scale(0.2,0.2)
imgx.x = display.contentWidth/2
imgx.y = display.contentHeight-imgx.contentHeight/2

dialog = display.newImage("speech.png")
dialog:scale(0.15,0.2)
dialog.x = display.contentWidth/2 - dialog.contentWidth/2 - imgx.contentWidth/2
dialog.y = display.contentHeight-imgx.contentHeight/2

math.randomseed( os.time() )
local rand = math.random (#speech)

speechtext = display.newText(speech[rand], dialog.x, dialog.y, native.systemFont, 16 )
speechtext.align = "center"
speechtext.x = dialog.x - dialog.contentWidth/10 
speechtext:setFillColor(0,0,0)

                    		local Sound = audio.loadSound( "success.mp3" )
                    		audio.play( Sound )
					
					if rand == 1 then
local Sound = audio.loadSound( "puik.mp3" )
                    		audio.play( Sound )
                    		elseif rand == 2 then
                    		local Sound = audio.loadSound( "fantasties.mp3" )
                    		audio.play( Sound )
                    		else
                    		local Sound = audio.loadSound( "uitstekend.mp3" )
                    		audio.play( Sound )
                    		end
					
timer.performWithDelay(1000,NextLv)
end

function checkComplete(event)
if (left == true) then
	if (event.x < display.contentWidth/2) then
	--Done
	local Sound = audio.loadSound( "success.mp3" )
                    		audio.play( Sound )
                    		
	if counter%5 == 0 then
	counter = counter + 1
timer.performWithDelay(1000,playX)
else
timer.performWithDelay(1000,NextLv)
end
	else
	local Sound = audio.loadSound( "fail.mp3" )
                    		audio.play( Sound )
	end
else
	if (event.x > display.contentWidth/2) then
	--Done
	local Sound = audio.loadSound( "success.mp3" )
                    		audio.play( Sound )
	if counter%5 == 0 then
timer.performWithDelay(1000,playX)
counter = counter + 1
else
timer.performWithDelay(1000,NextLv)
end
	else
	local Sound = audio.loadSound( "fail.mp3" )
                    		audio.play( Sound )
	--Not Done
	end
	end
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	print(counter)
	if phase == "will" then
	elseif phase == "did" then
		local background = display.newImage("background.png")
		background.x = display.contentWidth/2
		background.y = display.contentHeight/2
		counte = counter + 1
		numb = math.random(#choose)
		if (math.random() > 0.5) then
			bigsmall = true
		else
			bigsmall = false
		end
		
		if (math.random() > 0.5) then
			left = true
		else
			left = false
		end
		
		if bigsmall then
			if left then
				local s = audio.loadSound( "groter.mp3" )
				audio.setVolume(1)
				audio.play( s )
			else
				local s = audio.loadSound( "kleiner.mp3" )
				audio.setVolume(1)
				audio.play( s )
			end
		else
			if left then
				local s = audio.loadSound( "meer.mp3" )
				audio.setVolume(1)
				audio.play( s )
				
			else
				local s = audio.loadSound( "minder.mp3" )
				audio.setVolume(1)
				audio.play( s )
			end
		end
		
		--PLAY SOUND HERE
		
		local line = display.newImage("dashed_line.png")
		line:scale(display.actualContentHeight/line.contentHeight,display.actualContentHeight/line.contentHeight)
		line.x = display.contentWidth/2
		line.y = display.contentHeight/2
		
		local img1 = {}
		local img2 = {}
		
		sceneGroup:insert(background)
		home = display.newImage("Home_button.png")
		home:scale(0.4,0.4)
		home.y = home.y + yInset*2
		home.x = home.x + xInset*1.5

		function goHome()
			composer.removeScene("thisorthat")
			composer.gotoScene( "scene1" )
			home.alpha = 0
			--audio.resume(backgroundMusicChannel)
			--timer.performWithDelay( 1000, (function(e) home.alpha = 0 end))
			return true
		end
		home:addEventListener("tap",goHome)
		sceneGroup:insert(home)
		sceneGroup:insert(line)
		
		if (bigsmall == true) then
			img1 = display.newImage(choose[numb])
			img1:scale(display.actualContentWidth/3/img1.contentWidth,display.actualContentWidth/3/img1.contentWidth)

			
				img1.x = xInset*4
			
			img1.y = display.contentHeight/2
			sceneGroup:insert(img1)
			
			img2 = display.newImage(choose[numb])
			img2:scale(display.actualContentWidth/3/img2.contentWidth/2,display.actualContentWidth/3/img2.contentWidth/2)
			
			img2.x = display.actualContentWidth - xInset*4
			
			img2.y = display.contentHeight/2
			sceneGroup:insert(img2)
		else
			local amt1 = math.random(3,4)
			for i = 1, amt1 do
				img1 = display.newImage(choose[numb])
				img1:scale(display.actualContentWidth/3/img1.contentWidth/4,display.actualContentWidth/3/img1.contentWidth/4)
				local totalsize = img1.contentWidth*amt1
				local sizeToPlace = display.contentWidth/2
				local margins = sizeToPlace - totalsize
				img1.y = display.contentHeight/2
				img1.x = img1.contentWidth*i + 5*i - img1.contentWidth/2 + margins/amt1/2
				sceneGroup:insert(img1)
			end
			
			local amt2 = math.random(1,2)
			for i = 1, amt2 do
				img1 = display.newImage(choose[numb])
				img1:scale(display.actualContentWidth/3/img1.contentWidth/4,display.actualContentWidth/3/img1.contentWidth/4)
				local totalsize = img1.contentWidth*amt2
				local sizeToPlace = display.contentWidth/2
				local margins = sizeToPlace - totalsize
				img1.y = display.contentHeight/2
				img1.x = img1.contentWidth*i + 5*i + display.contentWidth/2 + margins/amt2/2
				sceneGroup:insert(img1)
			end
		end
		
		sceneGroup:addEventListener("tap",checkComplete)
		home.alpha = 1
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
	elseif phase == "did" then
	end	
end

function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene