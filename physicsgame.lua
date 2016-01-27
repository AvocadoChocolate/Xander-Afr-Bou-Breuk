-------------------------------------------------------------------------------
--
-- <scene>.lua
--
-------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

local group = display.newGroup()
local box2
local correctsign
function toggleMusic()
		if (isPlaying) then
		audio.pause(backgroundMusicChannel)
		isPlaying = false
		music:toFront()
		else
		 backgroundMusicMenu = audio.loadStream( "music.mp3" )
		audio.play( backgroundMusicMenu, { loops=1, fadein=3000 } )
		isPlaying = true
		musicO:toFront()
		end
		return true
end
local sheetInfo = require("animations")
		local myImageSheet = graphics.newImageSheet( "animations.png", sheetInfo:getSheet() )
		local cursprite

local physics = require("physics")
physics.start()

physics.setScale( 40 )

local bulldozershow = true

local shapeHeight = display.contentHeight/8
local margin = shapeHeight/6

local sceneGroup
local drag
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20

local shapes = {"f1.png","f2.png","f3.png",
"f4.png","f5.png","r1.png",
"h3.png","h4.png","r2.png","r3.png","r4.png","i1.png"}

-------------------------------------------------------------------------------

function dragBody( event, params )
	local body = event.target
	local phase = event.phase
	local stage = display.getCurrentStage()
	if "began" == phase then
		stage:setFocus( body, event.id )
		body.isFocus = true
		-- Create a temporary touch joint and store it in the object for later reference
		if params and params.center then
			-- drag the body from its center point
			body.tempJoint = physics.newJoint( "touch", body, body.x, body.y )
		else
			-- drag the body from the point where it was touched
			body.tempJoint = physics.newJoint( "touch", body, event.x, event.y )
		end

	elseif body.isFocus then
		if "moved" == phase then
			-- Update the joint to track the touch
			body.tempJoint:setTarget( event.x, event.y )
		elseif "ended" == phase or "cancelled" == phase then
			stage:setFocus( body, nil )
			body.isFocus = false
			-- Remove the joint when the touch ends			
			body.tempJoint:removeSelf()
		end
	end
	-- Stop further propagation of touch event
	return true
end

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end
local backgroundMusicMenu = audio.loadStream( "music.mp3" )
local backgroundMusicChannelMenu = audio.play( backgroundMusicMenu, { loops=1, fadein=3000 } )
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
        
       
        local cans = {}
        
        local background = display.newImage("Breek_bg.png",display.contentWidth/2,display.contentHeight/2,false)
        sceneGroup:insert(background)
        home = display.newImage("Home_button.png")
		home:scale(0.4,0.4)
		home.y = home.y + yInset*2
		home.x = home.x + xInset*1.5

		function goHome()
			composer.removeScene("physicsgame")
			composer.gotoScene( "scene1" , "fade", 500)
			home.alpha = 0
			audio.pause(backgroundMusicChannel)
			timer.performWithDelay( 1000, (function(e) home.alpha = 0 end))
		end
		home:addEventListener("tap",goHome)
		sceneGroup:insert(home)
        local floor = display.newImage( "floor.png", 0, display.contentHeight - display.contentHeight/5, true )
		floor.x = display.contentWidth/2
		physics.addBody( floor, "static", { friction=0.5 } )

		sceneGroup:insert(floor)
		--physics.setDrawMode( "hybrid" )
		--for i = 1, 7 do
		--	for j = 1, 6 do
		--	cans[i] = display.newImage( "soda_can.png", 190 + (i*24), 270 - (j*40) )
		--	cans[i]:addEventListener("touch",dragBody)
		--	sceneGroup:insert(cans[i])
		--	physics.addBody( cans[i], { density=0.2, friction=0.1, bounce=0.5 } )
		--	end
		--end
		
		dozer = display.newImage( "bulldozer_game.png", 100 , 200)
		dozer:scale(0.2,0.2)
		sceneGroup:insert(dozer)
		
		local nw, nh = dozer.contentWidth*dozer.xScale, dozer.contentHeight*dozer.yScale*2;
		
			dozer:addEventListener("touch",dragBody)
			physics.addBody( dozer, { density=1000, friction=0.1, bounce=0, shape={-nw,-nh,nw,-nh,nw,nh+10,-nw,nh+10} } )
			dozer.isFixedRotation = true
			
			local s = display.newImage("sign.png")
			s:scale(dozer.contentHeight/s.contentHeight,dozer.contentHeight/s.contentHeight)
			s.y = display.contentHeight - display.contentHeight/3
			s.x = display.contentWidth - display.contentWidth/8
			sceneGroup:insert(s)
        

        local box1 = display.newRect( display.contentWidth - xInset*5,0,10,10 ) ; box1:setFillColor(255,255,255,100)
physics.addBody( box1, "static" ) ; 

sceneGroup:insert(box1)
 
box2 = display.newImage("wrecking_ball.png")
box2:scale(0.2,0.2)
box2.x = box1.x
box2.y = box1.y+box2.contentHeight/2
local nw, nh = box2.contentWidth*box2.xScale, box2.contentHeight*box2.yScale*2;
physics.addBody( box2,{density=100, bounce=0, shape={-nw,-nh,nw,-nh,nw,nh+10,-nw,nh+10} } )
sceneGroup:insert(box2)
 
local joint = physics.newJoint( "pivot", box1, box2, box1.x, box1.y-box2.y )
 box2:addEventListener("touch",dragBody)
--box2:applyAngularImpulse( 5000 )

box2.alpha = 0

local opt = display.newImage("Breek_menu.png")
local sss = home.contentHeight*2/opt.contentHeight
opt:scale(sss,sss)
opt.x = home.x
sceneGroup:insert(opt)
opt.y = display.contentHeight/3

 correctsign = display.newImage("Correct_Done.png")
local sss = opt.contentHeight/2/correctsign.contentHeight
correctsign:scale( sss, sss)
correctsign.y = opt.y-opt.contentHeight/4
correctsign.x = opt.x
sceneGroup:insert(correctsign)



opt:addEventListener( "tap", (function(e)
	if bulldozershow == true then
	ShowBall()
	bulldozershow = false
	correctsign.y = opt.y+opt.contentHeight/4
	else
		ShowBulldozer()
		bulldozershow = true
		correctsign.y = opt.y-opt.contentHeight/4
	end
 end) )

				
					local rect = display.newRect(display.contentWidth/2 ,display.contentHeight - display.contentHeight/12,display.contentWidth,display.contentHeight/6)
					sceneGroup:insert(rect)
				
		for i = -(#shapes/2), #shapes/2-1 do
		print(#shapes/2+i+1)
			local l = display.newImage(shapes[#shapes/2+i+1])
			
			if i == #shapes/2-1 then
			l:scale(shapeHeight/l.contentWidth,shapeHeight/l.contentWidth)
			else
			l:scale(shapeHeight/l.contentHeight,shapeHeight/l.contentHeight)
			end
			l.x= 4*margin*i+shapeHeight*(i-1) --+ l.contentHeight/2
			l.y = 0
			l.tag = shapes[#shapes/2+i+1]
			l.origx = l.x
			l.origy = l.y
			group:insert(l)
			
			function l:touch( event )
				if event.phase == "began" then
	
					event.target.markY = event.target.y    -- store y location of object
					event.target.markX = event.target.x
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
		
					if i == #shapes/2-1 then
						--event.target.xScale = event.target.contentWidth/100
						--event.target.yScale = event.target.contentWidth/100
			event.target:scale(shapeHeight/event.target.contentHeight,shapeHeight/event.target.contentHeight)
			else
				--event.target.xScale = event.target.contentWidth*event.target.xScale/100
				--event.target.yScale = event.target.contentHeight*event.target.yScale/100
			event.target:scale(shapeHeight/event.target.contentHeight*2,shapeHeight/event.target.contentHeight*2)
			end
					
					curspritescale = (event.target.contentWidth-10)/cursprite.contentWidth
					cursprite:scale(curspritescale,curspritescale)
					cursprite.x = event.target.x
					cursprite.y = event.target.y
					group:insert(cursprite)
					cursprite:play()
					
	
				elseif event.phase == "moved" then
	
					local y = (event.y - event.yStart) + event.target.markY
					local x = (event.x - event.xStart) + event.target.markX
					
					cursprite.x = event.target.x
					cursprite.y = event.target.y
		
					event.target.y = y    -- move object based on calculations above
					event.target.x = x
					else
						cursprite:removeSelf()
             			cursprite = nil
					
					display.getCurrentStage():setFocus( nil, event.id )
					event.target.isFocus = false
					event.target:scale(0.5,0.5)

					
					local iii = display.newImage( event.target.tag )

					iii:scale(event.target.xScale,event.target.yScale)
					iii.y = event.y
					iii.x = event.x
					o = graphics.newOutline( 2, event.target.tag )

					for i=1,#o do
						if i % 2 == 0 then
							o[i] = o[i]*event.target.xScale
						else
							o[i] = o[i]*event.target.yScale
						end
					end

					--o:scale(iii.xScale,iii.yScale)
					local nw, nh = iii.contentWidth/2, iii.contentHeight/2
					physics.addBody( iii, { density=0.2, friction=0.1, bounce=0.5, shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh} } )

					self.x = self.origx
					self.y = self.origy

					iii:addEventListener("touch",dragBody)


					sceneGroup:insert(iii)
					iii:toBack( )
					background:toBack( )
				end
	
				return true
			end	
	
			l:addEventListener( "touch", l )
	
		end
		
		
		
		drag = display.newImage("drag.png")
		drag:scale(1/3,1/3)
		drag.rotation = 90
		drag.x = display.contentWidth/2 + xInset *4
		drag.y = display.contentHeight - display.contentHeight/6

		local y = drag.x
		group.y = display.contentHeight - display.contentHeight/12
		group.x = drag.x - xInset*8
-- touch listener function
	function drag:touch( event )
	    if event.phase == "began" then
		
	        self.markX = self.x    -- store y location of object
	        
	        display.getCurrentStage():setFocus( event.target, event.id )
			event.target.isFocus = true
		
	    elseif event.phase == "moved" then
		
	        local x = (event.x - event.xStart) + self.markX
	        
	        if (x > display.contentWidth/8 + event.target.contentWidth/2 and x < display.actualContentWidth - event.target.contentWidth/2) then
		        self.x =  x    -- move object based on calculations above
		        
		        --Transform function
		        group.x = x*2 - xInset*8
	        end
	        else
		        event.target.isFocus = false
		        display.getCurrentStage():setFocus( nil, event.id )
	        
	    end 
	return true
	end

		drag:addEventListener( "touch", drag )
		local line = display.newLine(0,drag.y,display.contentWidth,drag.y)
		line:setStrokeColor(204/255,33/255,120/255)
		line.strokeWidth = 2
		sceneGroup:insert(line)
		
		sceneGroup:insert(group)
		local whitespace = display.newRect(0,display.contentHeight - display.contentHeight/12,display.contentWidth/4,display.contentHeight/5)
		
		whitespace:toFront()
		sceneGroup:insert(whitespace)
		sceneGroup:insert(drag)
		music = display.newImage("Music_off.png")
		music:scale(0.4,0.4)
		music.y = display.actualContentHeight - yInset*2
		music.x = music.x+ xInset*1.5
		music:addEventListener("tap",toggleMusic)
		sceneGroup:insert(music)
		musicO = display.newImage("Music_on.png")
		musicO:scale(0.4,0.4)
		musicO.y = display.actualContentHeight - yInset*2
		musicO.x = musicO.x+ xInset*1.5
		musicO:addEventListener("tap",toggleMusic)
		sceneGroup:insert(musicO)
		isPlaying=true



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

function ShowBulldozer()
	dozer:setLinearVelocity( 0, 0 )
	dozer.x = 100
	dozer.y = 200
	transition.to(box2,{alpha=0})
	transition.to(dozer,{alpha=1})
	end

	function ShowBall()
	transition.to(box2,{alpha=1})
	transition.to(dozer,{alpha=0})
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
