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

local sheetInfo = require("animations")
		local myImageSheet = graphics.newImageSheet( "animations.png", sheetInfo:getSheet() )
		local cursprite

local physics = require("physics")
physics.start()
physics.setGravity( 0, 9.8 ) 
physics.setScale( 40 )
local laserSound = audio.loadSound( "CRASHCYM.mp3" )
local explosionSound = audio.loadSound( "METALBAN.mp3" )
local crashIsPlaying = false
local bulldozershow = true

local shapeHeight = display.contentHeight/8
local margin = shapeHeight/6
local shapeWidth = display.contentWidth/12

local sceneGroup
local drag
local box3
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20
local scaleF = (display.contentHeight*0.15)/display.contentHeight
local shapes = {}
for i=1,11 do
	if(i==2) then
	else
	shapes[#shapes+1] = i..".png"
	end
end
-------------------------------------------------------------------------------

function dragBody( event, params )
	local body = event.target
	local phase = event.phase
	local stage = display.getCurrentStage()
	if "began" == phase then
		stage:setFocus( body, event.id )
		body.isFocus = true
		initY =  event.y
		print(body.name)
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
		
		if(body.name == "dozer") then
			-- Update the joint to track the touch
			if(event.x<display.contentWidth-xInset * 2 and event.x> xInset * 2)then
				body.tempJoint:setTarget( event.x, initY )
			end
		elseif(body.name == "wrecking_ball")then
				if(event.x< display.contentWidth/2 + xInset*8 and event.x> display.contentWidth/2 - xInset*8)then
					body.tempJoint:setTarget( event.x, event.y)
				end
				--body.tempJoint:setTarget( event.x,event.y )
		elseif(body.name == "shape")then
			body.tempJoint:setTarget( event.x,event.y )
		end
		
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
	
	local explosionSound = audio.loadSound( "METALBAN.mp3" )
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
        
       function ShowBulldozer()
	
	dozer.x = 100
	dozer.y = 200
	physics.removeBody(box4)
	local nw, nh = dozer.contentWidth/2, dozer.contentHeight/2;
	local dozerCollisionFilter = {categoryBits = 4, maskBits= 3}
	physics.addBody( dozer, { density=1000, friction=3, bounce=0, shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh} ,filter=dozerCollisionFilter } )
	dozer.isFixedRotation = true
	function onLocalCollision( self, event )
		print( event.target )        --the first object in the collision
		print( event.other.name )         --the second object in the collision
		print( event.selfElement )   --the element (number) of the first object which was hit in the collision
		print( event.otherElement )  --the element (number) of the second object which was hit in the collision
		if(event.other.name ~= "floor") then
			if(crashIsPlaying == false) then
				local laserChannel = audio.play( laserSound ,{onComplete=function() crashIsPlaying = false end})
				crashIsPlaying = true
			end
		end
		
		end
		dozer.collision = onLocalCollision
			dozer:addEventListener( "collision", dozer )
	--local joint = physics.newJoint( "rope", dozer, box3, 0, 0,0,0 )
	box4:removeSelf()
	transition.to(dozer,{alpha=1})
	end

	function ShowBall()
	--box4:removeSelf()
	box4=display.newImage( "wrecking_ball.png" )
	box4.name = "wrecking_ball"
	box4.alpha =1
	box4:scale(0.3,0.3)
	box4.x = box3.x + xInset
	box4.y = box3.y+box4.contentHeight/2-yInset
	sceneGroup:insert(box4)
	physics.removeBody(dozer)
	local nw, nh = box4.contentWidth/2, box4.contentHeight/2;
	physics.addBody( box4,{density=100,friction=17, bounce=0, shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh} } )
	local joint = physics.newJoint( "pivot", box3, box4, box3.x, box3.y-box4.y )
	box4:addEventListener("touch",dragBody)
	function onLocalCollision( self, event )
		print( event.target )        --the first object in the collision
		print( event.other.name )         --the second object in the collision
		print( event.selfElement )   --the element (number) of the first object which was hit in the collision
		print( event.otherElement )  --the element (number) of the second object which was hit in the collision
		if(event.other.name ~= "floor") then
			if(crashIsPlaying == false) then
				local expChannel = audio.play( explosionSound ,{onComplete=function() crashIsPlaying = false end})
				crashIsPlaying = true
			end
		end
		
		end
	box4.collision = onLocalCollision
	box4:addEventListener( "collision", box4 )
	--box4:applyAngularImpulse( 10000 )
	--transition.to(box4,{alpha=1})
	transition.to(dozer,{alpha=0})
	end
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
			
			timer.performWithDelay( 1000, (function(e) home.alpha = 0 end))
		end
		home:addEventListener("tap",goHome)
		sceneGroup:insert(home)
		local wall1CollisionFilter = {categoryBits = 1, maskBits= 4}
		local wall2CollisionFilter = {categoryBits = 2, maskBits= 4}
		local dozerCollisionFilter = {categoryBits = 4, maskBits= 3}
		local box1 = display.newLine(display.contentWidth,display.contentHeight,display.contentWidth,0)
		sceneGroup:insert(box1)
		local box2 = display.newLine(0,display.contentHeight,0,0)
		sceneGroup:insert(box2)
		physics.addBody( box1, "static", { friction=1 ,filter=wall1CollisionFilter} )
		physics.addBody( box2, "static", { friction=1 ,filter=wall2CollisionFilter} )
        local floor = display.newImage( "floor.png", 0, display.contentHeight - display.contentHeight/5, true )
		floor.x = display.contentWidth/2
		floor:scale(1.2,1)
		physics.addBody( floor, "static", { friction=1.5 } )
		floor.name = "floor"
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
		dozer.name ="dozer"
		sceneGroup:insert(dozer)
		
		local nw, nh = dozer.contentWidth/2, dozer.contentHeight/2;
		
		dozer:addEventListener("touch",dragBody)
		physics.addBody( dozer, { density=500, friction=3, bounce=0, shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh},filter=dozerCollisionFilter } )
		dozer.isFixedRotation = true
		function onLocalCollision( self, event )
		print( event.target )        --the first object in the collision
		print( event.other.name )         --the second object in the collision
		print( event.selfElement )   --the element (number) of the first object which was hit in the collision
		print( event.otherElement )  --the element (number) of the second object which was hit in the collision
		if(event.other.name ~= "floor") then
			if(crashIsPlaying == false) then
				local laserChannel = audio.play( laserSound ,{onComplete=function() crashIsPlaying = false end})
				crashIsPlaying = true
			end
		end
		
		end
		dozer.collision = onLocalCollision
			dozer:addEventListener( "collision", dozer )
			local s = display.newImage("sign.png")
			s:scale(dozer.contentHeight/s.contentHeight,dozer.contentHeight/s.contentHeight)
			s.y = display.contentHeight - display.contentHeight/3
			s.x = display.contentWidth - display.contentWidth/8
			sceneGroup:insert(s)
        
        box3 = display.newRect( display.contentWidth/2,0,10,10 ) ; 
		box3:setFillColor(255,255,255,100)
		box3.alpha =0
		physics.addBody( box3, "static" ) ; 
	
		sceneGroup:insert(box3)
		
	
	
	--sceneGroup:insert(box4)
		-- local joint = physics.newJoint( "wheel", dozer, box3, box3.x, box3.y,1,0 )
		-- local pythLength = math.sqrt(math.pow(display.contentHeight,2)+math.pow(display.contentWidth/2,2))
		-- joint.maxLength = pythLength - xInset*3
		-- box4 = display.newImage("wrecking_ball.png")
		-- box4:scale(0.3,0.3)
		-- box4.x = box3.x + xInset
		-- box4.y = box3.y+box4.contentHeight/2
		-- box4.name = "wrecking_ball"
		
		--local nw, nh = box4.contentWidth*box4.xScale, box4.contentHeight*box4.yScale;
		--physics.addBody( box4,{density=100,friction=17, bounce=0, shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh} } )
		--box4.gravityScale = 0.25
		
		-- sceneGroup:insert(box4)
		 
		
		 -- box4:addEventListener("touch",dragBody)
		--box4:applyAngularImpulse( 5000 )

		-- box4.alpha = 0

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
			
			-- if i == #shapes/2-1 then
			-- l:scale(shapeHeight/l.contentWidth,shapeHeight/l.contentWidth)
			-- else
			-- l:scale(shapeHeight/l.contentHeight,shapeHeight/l.contentHeight)
			-- end
			l.x= 4*margin*i+shapeHeight*(i-1) --+ l.contentHeight/2
			l.y = 0
			l:scale(scaleF,scaleF)
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
		
					--if i == #shapes/2-1 then
						--event.target.xScale = event.target.contentWidth/100
						--event.target.yScale = event.target.contentWidth/100
			--event.target:scale(shapeHeight/event.target.contentHeight,shapeHeight/event.target.contentHeight)
			--else
				--event.target.xScale = event.target.contentWidth*event.target.xScale/100
				--event.target.yScale = event.target.contentHeight*event.target.yScale/100
			--event.target:scale(shapeHeight/event.target.contentHeight*2,shapeHeight/event.target.contentHeight*2)
			--end
					--event.target:scale(1 + scaleF*2 + scaleF,1 + scaleF*2 + scaleF)
					--event.target:scale(shapeHeight/event.target.contentWidth,shapeHeight/event.target.contentHeight)
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
					--event.target:scale(shapeHeight/event.target.contentWidth,shapeHeight/event.target.contentHeight)

					
					local iii = display.newImage( event.target.tag )

					iii:scale(scaleF + scaleF/2,scaleF+ scaleF/2)
					iii.y = event.y
					iii.x = event.x
					o = graphics.newOutline( 2, event.target.tag )

					-- for i=1,#o do
						-- if i % 2 == 0 then
							-- o[i] = o[i]*event.target.xScale
						-- else
							-- o[i] = o[i]*event.target.yScale
						-- end
					-- end

					--o:scale(iii.xScale,iii.yScale)
					local nw, nh = iii.contentWidth/2, iii.contentHeight/2
					physics.addBody( iii, { density=100, friction=1, bounce=0.5, shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh} } )

					self.x = self.origx
					self.y = self.origy
					iii.name ="shape"
					iii:addEventListener("touch",dragBody)
					iii.isFixedRotation = true

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
		sceneGroup:insert(drag)
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
	
	physics.stop()
	
		-- physics.removeBody("box1")
		-- physics.removeBody("box2")
		-- physics.removeBody("box3")
		-- physics.removeBody("box4")
		-- physics.removeBody("dozer")
		-- physics.removeBody("floor")
end

-------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-------------------------------------------------------------------------------

return scene
