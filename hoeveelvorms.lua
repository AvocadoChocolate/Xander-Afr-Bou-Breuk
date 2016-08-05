-------------------------------------------------------------------------------
--
-- <scene>.lua
--
-------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

local answ1 = {}
local answ2 = {}
local answ3 = {}

local speech = {"Puik.", "Fantasties.", "Uitstekend."}
local dialog = {}
local speechtext = {}
local levels = {"thisorthat","vormwatpas","patrone","rangskik"}

local sceneGroup

local questions = {"flower.png","house.png","rocket.png"}
local shape1 = {"foval.png","roof.png","circle.png"}
local shape2 = {"fparrallel.png","door.png","regoprectangle.png"}
local shape3 = {"fsquare.png","window.png","triangle.png"}
local shape1Answ = {2,1,1}
local shape2Answ = {3,1,2}
local shape3Answ = {2,2,1}

local selected = math.random(3)
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20
-------------------------------------------------------------------------------

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
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
composer.removeScene("hoeveelvorms")
-- composer.removeScene("vormwatpas")

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

function touch( event )
local numbs = {"een.png","twee.png","drie.png","vier.png","vyf.png"}

    if event.phase == "began" then
	
        event.target.markY = event.target.y    -- store y location of object
        event.target.markX = event.target.x
        
        display.getCurrentStage():setFocus( event.target, event.id )
		event.target.isFocus = true
	
    elseif event.phase == "moved" then
	
        local y = (event.y - event.yStart) + event.target.markY
        local x = (event.x - event.xStart) + event.target.markX
        
        event.target.y =  y    -- move object based on calculations above
        event.target.x = x
        else
        event.target.isFocus = false
        display.getCurrentStage():setFocus( nil, event.id )
        
        --Has the number collided?
        if (hasCollided(answ1,event.target)) then
        	if (answ1.tag == event.target.tag) then
        		answ1.alpha = 0
        		
        		local Sound = audio.loadSound( "success.mp3" )
                    		audio.play( Sound )
        		
        		local n = display.newImage(numbs[answ1.tag])
        		n:scale(display.actualContentHeight/7/n.contentHeight,display.actualContentHeight/7/n.contentHeight)
        		n.x = answ1.x
        		n.y = answ1.y
        		sceneGroup:insert(n)
        		
        	end
        elseif (hasCollided(answ2,event.target)) then
        	if (answ2.tag == event.target.tag) then
        		answ2.alpha = 0
        		
        		local Sound = audio.loadSound( "success.mp3" )
                    		audio.play( Sound )
        		
        		local n = display.newImage(numbs[answ2.tag])
        		n:scale(display.actualContentHeight/7/n.contentHeight,display.actualContentHeight/7/n.contentHeight)
        		n.x = answ2.x
        		n.y = answ2.y
        		sceneGroup:insert(n)
        		
        	end
        elseif (hasCollided(answ3,event.target)) then
        	if (answ3.tag == event.target.tag) then
        		answ3.alpha = 0
        		
        		local Sound = audio.loadSound( "success.mp3" )
                    		audio.play( Sound )
        		
        		local n = display.newImage(numbs[answ3.tag])
        		n:scale(display.actualContentHeight/7/n.contentHeight,display.actualContentHeight/7/n.contentHeight)
        		n.x = answ3.x
        		n.y = answ3.y
        		sceneGroup:insert(n)
        		
        	end
        else
        	local Sound = audio.loadSound( "fail.mp3" )
                    		audio.play( Sound )
        end
        
        event.target.x = event.target.origx
        event.target.y = event.target.origy
        
        if (answ1.alpha == 0 and answ2.alpha == 0 and answ3.alpha == 0) then
        	                if counter%5 == 0 then
        	                counter = counter + 1
							timer.performWithDelay(1000,PlayX)
							else
							timer.performWithDelay(1000,NextLv)
							end
        end
        
    end
    
    return true
	end

function scene:show( event )
    sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is off screen and is about to move on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
        local background = display.newImage("background.png")
		print(counter)
		background.x = display.contentWidth/2
		background.y = display.contentHeight/2
		counter = counter + 1
		

		sceneGroup:insert(background)
		home = display.newImage("Home_button.png")
		home:scale(0.4,0.4)
		home.y = home.y + yInset*2
		home.x = home.x + xInset*1.5

		function goHome()
			composer.removeScene("hoeveelvorms")
			composer.gotoScene( "scene1")
			home.alpha = 0
			--audio.resume(backgroundMusicChannel)
			--timer.performWithDelay( 1000, (function(e) home.alpha = 0 end))
			return true
		end
		home:addEventListener("tap",goHome)
		sceneGroup:insert(home)
		sceneGroup:insert(display.newRect(display.contentWidth-display.contentWidth*1/12,display.contentHeight/2,display.contentWidth*1/6,display.actualContentHeight))
		
		
		
		local numbs = {"een.png","twee.png","drie.png","vier.png","vyf.png"}
		
		tshape1 = display.newImage(shape1[selected])
		tshape1:scale(display.actualContentHeight/7/tshape1.contentHeight,display.actualContentHeight/7/tshape1.contentHeight)
		tshape1.x = display.contentWidth/2 
		tshape1.y = display.actualContentHeight*2/8
		
		equal1 = display.newImage("equal.png")
		equal1:scale(display.actualContentHeight/7/equal1.contentHeight/2,display.actualContentHeight/7/equal1.contentHeight/2)
		equal1.x = tshape1.x + equal1.contentWidth*2
		equal1.y = tshape1.y
		
		answ1 = display.newImage("q.png")
		answ1:scale(display.actualContentHeight/7/answ1.contentHeight,display.actualContentHeight/7/answ1.contentHeight)
		answ1.x = equal1.x + answ1.contentWidth*2
		answ1.y = display.actualContentHeight*2/8
		answ1.tag = shape1Answ[selected]
		
		local myRectangle = display.newRect( display.contentWidth - tshape1.x + xInset*1.8, tshape1.y,equal1.contentWidth*4 + answ1.contentWidth*4,yInset*4 )
		myRectangle.strokeWidth = 1
		myRectangle:setFillColor( 1 )
		myRectangle:setStrokeColor( 204/255, 204/255, 204/255 )
		sceneGroup:insert(myRectangle)
		
		tshape2 = display.newImage(shape2[selected])
		tshape2:scale(display.actualContentHeight/7/tshape2.contentHeight,display.actualContentHeight/7/tshape2.contentHeight)
		tshape2.x = display.contentWidth/2
		tshape2.y = display.actualContentHeight*4/8
		
		equal2 = display.newImage("equal.png")
		equal2:scale(display.actualContentHeight/7/equal2.contentHeight/2,display.actualContentHeight/7/equal2.contentHeight/2)
		equal2.x = tshape2.x + equal2.contentWidth*2
		equal2.y = tshape2.y
		
		answ2 = display.newImage("q.png")
		answ2:scale(display.actualContentHeight/7/answ2.contentHeight,display.actualContentHeight/7/answ2.contentHeight)
		answ2.x = equal2.x + answ2.contentWidth*2
		answ2.y = display.actualContentHeight*4/8
		answ2.tag = shape2Answ[selected]
		
		local myRectangle = display.newRect( display.contentWidth - tshape2.x + xInset*1.8, tshape2.y,equal2.contentWidth*4 + answ2.contentWidth*4,yInset*4 )
		myRectangle.strokeWidth = 1
		myRectangle:setFillColor( 1 )
		myRectangle:setStrokeColor( 204/255, 204/255, 204/255 )
		sceneGroup:insert(myRectangle)
		
		tshape3 = display.newImage(shape3[selected])
		tshape3:scale(display.actualContentHeight/7/tshape3.contentHeight,display.actualContentHeight/7/tshape3.contentHeight)
		tshape3.x = display.contentWidth/2
		tshape3.y = display.actualContentHeight*6/8
		
		equal3 = display.newImage("equal.png")
		equal3:scale(display.actualContentHeight/7/equal3.contentHeight/2,display.actualContentHeight/7/equal3.contentHeight/2)
		equal3.x = tshape3.x + equal3.contentWidth*2
		equal3.y = tshape3.y
		
		answ3 = display.newImage("q.png")
		answ3:scale(display.actualContentHeight/7/answ3.contentHeight,display.actualContentHeight/7/answ3.contentHeight)
		answ3.x = equal3.x + answ3.contentWidth*2
		answ3.y = display.actualContentHeight*6/8
		answ3.tag = shape3Answ[selected]
		
		local myRectangle = display.newRect( display.contentWidth - tshape3.x + xInset*1.8, tshape3.y,equal3.contentWidth*4 + answ3.contentWidth*4,yInset*4 )
		myRectangle.strokeWidth = 1
		myRectangle:setFillColor( 1 )
		myRectangle:setStrokeColor( 204/255, 204/255, 204/255 )
		sceneGroup:insert(myRectangle)

		if shape3[selected] == "triangle.png" then
			tshape3.x = tshape3.x + 10
		end
		
		img = display.newImage(questions[selected])
		img:scale(display.actualContentHeight/img.contentHeight/1.5,display.actualContentHeight/img.contentHeight/1.5)
		img.x = display.actualContentWidth*0.2
		img.y = display.contentHeight/2
		
		if questions[selected] == "rocket.png" then
		img:scale(display.actualContentHeight/img.contentHeight/2,display.actualContentHeight/img.contentHeight/2)
		img.x = display.actualContentWidth*0.18
		end
		
		local timg = display.newImage("corners_vind.png")
		timg:scale(answ1.contentHeight*1.3/timg.contentHeight,answ1.contentHeight*1.3/timg.contentHeight)
		timg.x = answ1.x
		timg.y = answ1.y
		
		
		sceneGroup:insert(timg)

		
		
		

		local timg = display.newImage("corners_vind.png")
		timg:scale(answ2.contentHeight*1.3/timg.contentHeight,answ1.contentHeight*1.3/timg.contentHeight)
		timg.x = answ2.x
		timg.y = answ2.y
		sceneGroup:insert(timg)
		
		local timg = display.newImage("corners_vind.png")
		timg:scale(answ3.contentHeight*1.3/timg.contentHeight,answ1.contentHeight*1.3/timg.contentHeight)
		timg.x = answ3.x
		timg.y = answ3.y
		sceneGroup:insert(timg)
		
		--sceneGroup:insert(myRectangle)
		sceneGroup:insert(answ1)
		sceneGroup:insert(answ2)
		sceneGroup:insert(answ3)
		sceneGroup:insert(equal1)
		sceneGroup:insert(tshape1)
		sceneGroup:insert(equal2)
		sceneGroup:insert(tshape2)
		sceneGroup:insert(equal3)
		sceneGroup:insert(tshape3)
		sceneGroup:insert(img)
		
		for i = 1, #numbs do
			local img = display.newImage(numbs[i])
			img:scale(display.actualContentHeight/7/img.contentHeight,display.actualContentHeight/7/img.contentHeight)
			
			img.y = display.actualContentHeight/6*i
			img.x = display.actualContentWidth - display.contentWidth*1/12
			img.origx = img.x
			img.origy = img.y
			img.tag = i
			sceneGroup:insert(img)
			img:addEventListener("touch",touch)
		end
		
		
		
		drag = display.newImage("drag.png")
		drag.alpha = 0
		drag:scale(1/2,1/2)
		drag.y = display.contentHeight/2
		drag.x = display.contentWidth-display.contentWidth*1/6--drag.contentWidth*2.5
-- touch listener function
		local line = display.newLine(drag.x,0,drag.x,display.actualContentHeight)
		line:setStrokeColor(204/255,33/255,120/255)
		line.strokeWidth = 2
		sceneGroup:insert(line)
	function drag:touch( event )
    if event.phase == "began" then
	
        self.markY = self.y    -- store y location of object
        
        display.getCurrentStage():setFocus( event.target, event.id )
		event.target.isFocus = true
	
    elseif event.phase == "moved" then
	
        local y = (event.y - event.yStart) + self.markY
        
        if (y > 0 + event.target.contentHeight/2 and y < display.actualContentHeight - event.target.contentHeight/2) then
        self.y =  y    -- move object based on calculations above
        
        --Transform function
        group.y = (y-display.contentHeight/2)*3 + display.contentHeight/1.5
        end
        else
        event.target.isFocus = false
        display.getCurrentStage():setFocus( nil, event.id )
        
    end
    
    return true
	end

-- make 'myObject' listen for touch events
drag:addEventListener( "touch", drag )
		
        
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

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

-------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-------------------------------------------------------------------------------

return scene
