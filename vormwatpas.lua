---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

local animals = {1,2,3,4,5}
local images = {}
local sceneGroup
local img
local speech = {"Puik.", "Fantasties.", "Uitstekend."}
local dialog = {}
local speechtext = {}
local levels = {"thisorthat","hoeveelvorms","patrone","rangskik"}
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20
local function shuffleTable( t )
    local rand = math.random 
    assert( t, "shuffleTable() expected a table, got nil" )
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end

local sheetInfo = require("animations")
		local myImageSheet = graphics.newImageSheet( "animations.png", sheetInfo:getSheet() )
		local cursprite

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

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

					-- composer.removeScene("rangskik")
-- composer.removeScene("thisorthat")
-- composer.removeScene("patrone")
-- composer.removeScene("hoeveelvorms")
composer.removeScene("vormwatpas")

composer.gotoScene( levels[n] )
 
end

local function PlayX(event)
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

timer.performWithDelay(1000,NextLv)

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
end

local function hasCollided( obj1, obj2 )
    if ( obj1 == nil ) then  -- Make sure the first object exists
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
        return false
    end

    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

    return (left or right) and (up or down)
end

local function move( event )
    if event.phase == "began" then
		
        event.target.markX = event.target.x    -- store x location of object
        
        display.getCurrentStage():setFocus( event.target, event.id )
		event.target.isFocus = true
		
		local chosen = math.random(1,3)
		
		local index = {}
		
		if (chosen == 1) then
			index = {15,16,17,18,19,20,21}
		elseif (chosen == 2) then
			index = {22,23,24,25,26,27,28,29,30}
		else
			index = {31,32,33,34,35,36}
		end
		
		cursprite = display.newSprite( myImageSheet , {frames=index,loopDirection = "bounce"} )
		
		curspritescale = (event.target.contentWidth-10)/cursprite.contentWidth
		cursprite:scale(curspritescale,curspritescale)
		cursprite.x = event.target.x
		cursprite.y = event.target.y
		cursprite:play()
	elseif event.target.isFocus then
	
    	if event.phase == "moved" then
			cursprite.x = event.target.x
        	local x = (event.x - event.xStart) + event.target.markX
        
        	event.target.x = x    -- move object based on calculations above
    	elseif event.phase == "ended" or event.phase == "cancelled"  then
             cursprite:removeSelf()
             cursprite = nil
             justmoved = event.target.tag
              -- here the focus is removed from the last position
                    display.getCurrentStage():setFocus( nil )
                    event.target.isFocus = false
                    
                    if (hasCollided(event.target,images[1]) and event.target.tag == images[1].tag) then
                    	event.target.alpha = 0
                    	if counter%5 == 0 then
                    		counter = counter + 1
							timer.performWithDelay(1000,PlayX)
							else
							timer.performWithDelay(1000,NextLv)
							end
						
						local img = display.newImage("corners_vind_correct.png")
						img.x = images[1].x
						img.y = images[1].y
						img:scale(0.26,0.3)
						--sceneGroup:insert(img)
						img:toFront()
						transition.to(img,{delay = 500,alpha = 0})
						
						local Sound = audio.loadSound( "success.mp3" )
                    		audio.play( Sound )
                    else
                    	event.target.x = event.target.markX
                    	
                    	local imgt = display.newImage("corners_vind_error.png")
						imgt.x = images[1].x
						imgt.y = images[1].y
						imgt:scale(0.26,0.3)
						sceneGroup:insert(imgt)
						imgt:toFront()
						transition.to(imgt,{delay = 500,alpha = 0})
						
						local Sound = audio.loadSound( "fail.mp3" )
                    		audio.play( Sound )
                    end
    	end
    end
    
    return true
end

function scene:show( event )
    sceneGroup = self.view
    local phase = event.phase
    --print(counter)
    back = display.newImage("background.png")
    back:scale((display.actualContentWidth-10)/back.width,(display.actualContentHeight-1)/back.height)
    back.x = display.contentWidth/2
    back.y = display.contentHeight/2
    sceneGroup:insert(back)
	home = display.newImage("Home_button.png")
		home:scale(0.4,0.4)
		home.y = home.y + yInset*2
		home.x = home.x + xInset*1.5

		function goHome()
			composer.removeScene("vormwatpas")
			composer.gotoScene( "scene1")
			home.alpha = 0
			--audio.resume(backgroundMusicChannel)
			--timer.performWithDelay( 1000, (function(e) home.alpha = 0 end))
			return true
		end
		home:addEventListener("tap",goHome)
		sceneGroup:insert(home)
    if phase == "will" then
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
        local s = audio.loadSound( "pas.mp3" )
				audio.play( s )
				
				shuffleTable(animals)
				local nn = animals[1]
				
				math.randomseed( os.time() )
					local n = nn

                    while n == nn do
                        n = math.random(1,5)
                    end
				
				animals[1] = n
				for i=1,#animals do
                print(animals[i])
                end
        home.alpha = 1
        counter = counter + 1
        --shuffleTable(animals)
        
        local margin = display.contentWidth*0.10
        local position = display.contentWidth*0.2
        
        --local rand = math.random(7)
        --rand = 1
        
        for i=1,#animals do
        local myRectangle = display.newRect( margin + position*(i-1), display.contentHeight/2, display.contentWidth/5, 100 )

        if i ~= 1 then
             myRectangle:setFillColor( 1 )
        else
            myRectangle:setFillColor( 0.5)
        end
		myRectangle.strokeWidth = 1
		
		myRectangle:setStrokeColor( 0.8 )
		sceneGroup:insert(myRectangle)
		
        local image = display.newImage( animals[i] .. ".png" )
		image:setFillColor( 0.5, 0.5, 0.5, 0.5 )
		image.x = margin + position*(i-1)
		image:scale(0.25,0.25)
		image.y = display.contentHeight/2
		sceneGroup:insert(image)
		
        images[i] = display.newImage(animals[i] .. ".png")
        
        images[i].x = margin + position*(i-1)
        images[i]:scale(0.25,0.25)
        images[i].y = display.contentHeight/2
        images[i].tag = animals[i]
        
        if i ~= 1 then
        	images[i]:addEventListener( "touch", move )
        	else
        	img = display.newImage("corners_vind.png")
        	img.x = images[i].x
        	img.y = images[i].y
        	img:scale(0.26,0.3)
        	sceneGroup:insert(img)
        end
        sceneGroup:insert(images[i])
        end 
        
        img:toFront()      
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
        -- Called when the scene is now off screen
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
