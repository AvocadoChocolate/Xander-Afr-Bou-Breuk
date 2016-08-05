local composer = require( "composer" )
local scene = composer.newScene()
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20
local group = display.newGroup()
--5 should fit on the scene, with a margin equivalent of 1 of the vorms
local backgroundMusicMenu = audio.loadStream( "music.mp3" )
local shapeHeight = display.contentHeight/6

local margin = shapeHeight/6

local sceneGroup
local drag
function toggleMusic()
		if (isPlayingVWP) then
		audio.pause(backgroundMusicChannel)
		isPlayingVWP = false
		music:toFront()
		else
		 backgroundMusicMenu = audio.loadStream( "music.mp3" )
		 local backgroundMusicChannelMenu = audio.play( backgroundMusicMenu, { loops=1, fadein=3000,onComplete = function() isPlayingVWP = false 
		music:toFront()
		end } )
		--audio.play( backgroundMusicMenu, { loops=1, fadein=3000 } )
		isPlayingVWP = true
		musicO:toFront()
		end
		return true
end
local addme = {}
local remme = {}
local complete = false
local started = false

local sheetInfo = require("animations")
		local myImageSheet = graphics.newImageSheet( "animations.png", sheetInfo:getSheet() )
		local cursprite

local shapes = {"rectangle.png","circle2.png","circle3.png","circle4.png",
"circle5.png","circle6.png","square.png","triangle1.png",
"triangle2.png","triangle3.png","triangle4.png","triangle5.png"}

local questions = {"voltooi_vorm_1.png","voltooi_vorm_2.png","voltooi_vorm_3.png",
"voltooi_vorm_4.png","voltooi_vorm_5.png","voltooi_vorm_6.png"}

local n = {1,2,3,4,6}
local answ = 0
local amount = 0

local numb = n[voltooivormvar]

local collide = {}

local function removeCorrect()
	for i=1,#remme do
	transition.to(remme[i],{alpha = 0})
	end

	for i=1,#addme do
	transition.to(addme[i],{alpha = 1})
	end

	if answ == amount then
	voltooivormvar = voltooivormvar + 1

	if voltooivormvar <= #n then
			--audio:pause(backgroundMusicChannelMenu)
			timer.performWithDelay( 500, (function(e) composer.removeScene("voltooivorm")
			composer.gotoScene( "voltooivorm" , "fade", 500) end) )
			else
			if(complete == false) then
			    complete = true
				n = {1,3,4,6}
				answ = 0
				amount = 0

				numb = n[voltooivormvar]
				voltooivormvar = 1
				addme = {}
				remme = {}

				audio:pause(backgroundMusicChannelMenu)
				timer.performWithDelay(500,function()composer.removeScene("voltooivorm")
				composer.gotoScene( "scene1")end)
			end
			

		end
	end
end

local function removeWrong(obj)
	for i=1,#remme do
	transition.to(remme[i],{alpha = 0})
	end

	for i=1,#addme do
	transition.to(addme[i],{alpha = 1})
	end

	if answ == amount then
	voltooivormvar = voltooivormvar + 1

	if voltooivormvar <= #n then
			audio:pause(backgroundMusicChannelMenu)
			timer.performWithDelay( 500, (function(e) composer.removeScene("voltooivorm")
			composer.gotoScene( "voltooivorm" , "fade", 500) end) )
			else
			if(complete==false) then
			    complete = true
				n = {1,3,4,6}
				answ = 0
				amount = 0

				numb = n[voltooivormvar]
				voltooivormvar = 1
				addme = {}
				remme = {}

				audio:pause(backgroundMusicChannelMenu)
				timer.performWithDelay(500,function()composer.removeScene("voltooivorm")
				composer.gotoScene( "scene1")end)
			end
			
		end
	end
	
	transition.to(cursprite.orig,{x = cursprite.orig.origx,y = cursprite.orig.origy, xScale = 0.25, yScale = 0.25})
end

local function showCorrect(obj)
	cursprite = display.newSprite( myImageSheet , {frames={1,2,3,4,5,6,7},loopDirection = "bounce", time = 600, loopCount = 1,onComplete=function() display.getCurrentStage():setFocus( nil ) end} )
	display.getCurrentStage():setFocus( cursprite )		
	curspritescale = (obj.contentWidth-10)/cursprite.contentWidth/2
	cursprite:scale(curspritescale,curspritescale)
	cursprite.x = obj.x
	cursprite.y = obj.y
	--group:insert(cursprite)
	cursprite:play()
	
	remme[#remme+1] = cursprite
	
	local d = display.newImage("Correct_Done.png")
d.alpha = 0
d:scale(d.contentWidth/cursprite.contentWidth/8,d.contentWidth/cursprite.contentWidth/8)
d.x = cursprite.x
d.y = cursprite.y
sceneGroup:insert(d)
addme[#addme+1] = d
	
	timer.performWithDelay( 300, removeCorrect)
	
	answ = answ + 1
end

local function showWrong(obj)
	cursprite = display.newSprite( myImageSheet , {frames={8,9,10,11,12,13,14},loopDirection = "bounce", time = 300, loopCount = 1,onComplete=function() display.getCurrentStage():setFocus( nil ) end} )
		display.getCurrentStage():setFocus( cursprite )	
	curspritescale = (obj.contentWidth-10)/cursprite.contentWidth/2
	cursprite:scale(curspritescale,curspritescale)
	cursprite.x = obj.x
	cursprite.y = obj.y
	cursprite.orig = obj
	group:insert(cursprite)
	cursprite:toFront()
	cursprite:play()
	
	remme[#remme+1] = cursprite
	removeWrong()
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

function AddShapes()
	if numb == 1 then
		-- local l = display.newImage(questions[1])
		-- l:scale(0.25,0.25)
		-- l.x = display.actualContentWidth - drag.x -- - drag.contentWidth -  )/2--display.contentWidth/2 - display.actualContentWidth*0.1
		-- l.y = display.contentHeight/2
		-- sceneGroup:insert(l)
	
		-- local t = display.newImage("triangle1.png")
		-- t:scale(l.contentWidth/2/t.contentWidth,l.contentWidth/2/t.contentWidth)
		-- t.x = l.x - l.contentWidth/2 + t.contentWidth/2
		-- t.y = l.y + l.contentHeight/2 - t.contentHeight/2
		-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)
	
		-- local t = display.newImage("triangle1.png")
		-- t:scale(l.contentWidth/2/t.contentWidth,l.contentWidth/2/t.contentWidth)
		-- t.x = l.x + l.contentWidth/2 - t.contentWidth/2
		-- t.y = l.y + l.contentHeight/2 - t.contentHeight/2
		-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)
	
		-- local t = display.newImage("triangle1.png")
		-- t:scale(l.contentWidth/2/t.contentWidth,l.contentWidth/2/t.contentWidth)
		-- t.x = l.x 
		-- t.y = l.y - l.contentHeight/2 + t.contentHeight/2
		-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)
	
		-- local t = display.newImage("triangle2.png")
		-- t:scale(l.contentWidth/2/t.contentWidth,l.contentWidth/2/t.contentWidth)
		-- t.x = l.x
		-- t.y = l.y + l.contentHeight/2 - t.contentHeight/2
		-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)
		local t = display.newImage("triangle1M.png")
		t:scale(0.4,0.4)
		t.x = t.x + xInset*7
		t.y = t.y + yInset*6
		t.alpha = 1
		--collide[#collide+1] = t
		sceneGroup:insert(t)
		local t2 = display.newImage("triangle2M.png")
		t2:scale(0.4,0.4)
		t2.x = t2.x + xInset*7
		t2.y = t.y + t.contentHeight
		t2.alpha = 1
		--collide[#collide+1] = t2
		sceneGroup:insert(t2)
		local t3 = display.newImage("triangle1M.png")
		t3:scale(0.4,0.4)
		t3.x = t2.x - t2.contentWidth/2
		t3.y =  t.y + t.contentHeight
		t3.alpha = 1
		--collide[#collide+1] = t3
		sceneGroup:insert(t3)
		local t4 = display.newImage("triangle1M.png")
		t4:scale(0.4,0.4)
		t4.x = t2.x + t2.contentWidth/2
		t4.y =  t.y + t.contentHeight
		t4.alpha = 1
		--collide[#collide+1] = t4
		sceneGroup:insert(t4)
		
		local t = display.newImage("triangle1.png")
		t:scale(0.4,0.4)
		t.x = t.x + xInset*7
		t.y = t.y + yInset*6
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)
		local t2 = display.newImage("triangle2.png")
		t2:scale(0.4,0.4)
		t2.x = t2.x + xInset*7
		t2.y = t.y + t.contentHeight
		t2.alpha = 0
		collide[#collide+1] = t2
		sceneGroup:insert(t2)
		local t3 = display.newImage("triangle1.png")
		t3:scale(0.4,0.4)
		t3.x = t2.x - t2.contentWidth/2
		t3.y =  t.y + t.contentHeight
		t3.alpha = 0
		collide[#collide+1] = t3
		sceneGroup:insert(t3)
		local t4 = display.newImage("triangle1.png")
		t4:scale(0.4,0.4)
		t4.x = t2.x + t2.contentWidth/2
		t4.y =  t.y + t.contentHeight
		t4.alpha = 0
		collide[#collide+1] = t4
		sceneGroup:insert(t4)
		
		amount = 4
		
		
	elseif numb == 2 then
	-- local l = display.newImage(questions[2])
	-- l:scale(0.25,0.25)
	-- l.x = display.contentWidth/2 - display.actualContentWidth*0.1
	-- l.y = display.contentHeight/2
	-- sceneGroup:insert(l)
	local t = display.newImage("rect1M.png")
	t:scale(0.3,0.3)
	t.x = xInset*7
	t.y = yInset*6
	t.alpha =1
	sceneGroup:insert(t)
	
	local t1 = display.newImage("rect1M.png")
	t1:scale(0.3,0.3)
	t1.x = t1.x + xInset*7
	t1.y = t.y + t.contentHeight
	t1.alpha=1
	sceneGroup:insert(t1)
	
	local t2 = display.newImage("rect1.png")
	t2:scale(0.3,0.3)
	t2.x = xInset*7 
	t2.y = yInset*6
	t2.alpha =0
	collide[#collide+1] = t2
	sceneGroup:insert(t2)
	
	local t3 = display.newImage("rect2.png")
	t3:scale(0.3,0.3)
	t3.x = t3.x + xInset*7
	t3.y = t2.y + t2.contentHeight
	t3.alpha =0
	collide[#collide+1] = t3
	sceneGroup:insert(t3)
	
	amount = 2
	elseif numb == 3 then
	-- local l = display.newImage(questions[3])
	-- l:scale(0.25,0.25)
	-- l.x = display.contentWidth/2 - display.actualContentWidth*0.1
	-- l.y = display.contentHeight/2
	-- sceneGroup:insert(l)
	
	-- local t = display.newImage("square.png")
	-- t:scale(l.contentHeight/2/t.contentHeight,l.contentHeight/2/t.contentHeight)
	-- t.x = l.x + l.contentWidth/2 - t.contentWidth/2-1
	-- t.y = l.y - l.contentHeight/2 + t.contentHeight/2+1
	-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)
	
	-- local t = display.newImage("squareg.png")
	-- t:scale(l.contentHeight/2/t.contentHeight,l.contentHeight/2/t.contentHeight)
	-- t.x = l.x + l.contentWidth/2 - t.contentWidth/2-1
	-- t.y = l.y + l.contentHeight/2 - t.contentHeight/2
	-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)
	
	-- local t = display.newImage("squareb.png")
	-- t:scale(l.contentHeight/2/t.contentHeight,l.contentHeight/2/t.contentHeight)
	-- t.x = l.x - l.contentWidth/2 + t.contentWidth/2+1
	-- t.y = l.y - l.contentHeight/2 + t.contentHeight/2+1
	-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)
	
	-- local t = display.newImage("squarey.png")
	-- t:scale(l.contentHeight/2/t.contentHeight,l.contentHeight/2/t.contentHeight)
	-- t.x = l.x - l.contentWidth/2 + t.contentWidth/2+1
	-- t.y = l.y + l.contentHeight/2 - t.contentHeight/2
	-- t.alpha = 0
	-- collide[#collide+1] = t
	-- sceneGroup:insert(t)
	
	local t = display.newImage("squareM.png")
	t:scale(0.4,0.4)
	t.x = t.x + xInset*9
	t.y = t.y + yInset*8
	t.alpha = 1
	sceneGroup:insert(t)
	local t1 = display.newImage("squareM.png")
	t1:scale(0.4,0.4)
	t1.x = t1.x + xInset*9
	t1.y = t.y + t.contentHeight
	t1.alpha = 1
	sceneGroup:insert(t1)
	local t2 = display.newImage("squareM.png")
	t2:scale(0.4,0.4)
	t2.x = t.x - t.contentWidth
	t2.y = t2.y + yInset*8
	t2.alpha = 1
	sceneGroup:insert(t2)
	local t3 = display.newImage("squareM.png")
	t3:scale(0.4,0.4)
	t3.x = t.x - t.contentWidth
	t3.y = t.y + t.contentHeight
	t3.alpha = 1
	sceneGroup:insert(t3)
	
	local t = display.newImage("square.png")
	t:scale(0.4,0.4)
	t.x = t.x + xInset*9
	t.y = t.y + yInset*8
	t.alpha = 0
	collide[#collide+1] = t
	sceneGroup:insert(t)
	local t1 = display.newImage("squareg.png")
	t1:scale(0.4,0.4)
	t1.x = t1.x + xInset*9
	t1.y = t.y + t.contentHeight
	t1.alpha = 0
	collide[#collide+1] = t1
	sceneGroup:insert(t1)
	local t2 = display.newImage("squareb.png")
	t2:scale(0.4,0.4)
	t2.x = t.x - t.contentWidth
	t2.y = t2.y + yInset*8
	t2.alpha = 0
	collide[#collide+1] = t2
	sceneGroup:insert(t2)
	local t3 = display.newImage("squarey.png")
	t3:scale(0.4,0.4)
	t3.x = t.x - t.contentWidth
	t3.y = t.y + t.contentHeight
	t3.alpha = 0
	collide[#collide+1] = t3
	sceneGroup:insert(t3)
	
	amount = 4
		
		
	elseif numb == 4 then	
	-- local l = display.newImage(questions[4])
	-- l:scale(0.25,0.25)
	-- l.x = display.contentWidth/2 - display.actualContentWidth*0.1
	-- l.y = display.contentHeight/2
	-- sceneGroup:insert(l)
	
	-- local t = display.newImage("circle2.png")
	-- t:scale(l.contentWidth/2/t.contentWidth,l.contentWidth/2/t.contentWidth)
	-- t.x = l.x - l.contentWidth/2 + t.contentWidth/2
	-- t.y = l.y - l.contentHeight/2 + t.contentHeight/2
	-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)
	
	-- local t = display.newImage("circle3.png")
	-- t:scale(l.contentHeight/2/t.contentHeight,l.contentHeight/2/t.contentHeight)
	-- t.x = l.x
	-- t.y = l.y + l.contentHeight/2 - t.contentHeight/2
	-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)
	
	-- local t = display.newImage("circle4.png")
	-- t:scale(l.contentWidth/2/t.contentWidth,l.contentWidth/2/t.contentWidth)
	-- t.x = l.x + l.contentWidth/2 - t.contentWidth/2
	-- t.y = l.y - l.contentHeight/2 + t.contentHeight/2+1
	-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)
		local c = display.newImage("circle2M.png")
		c:scale(0.4,0.4)
		c.x = c.x + xInset*6
		c.y = c.y + yInset*8
		c.alpha = 1
		sceneGroup:insert(c)
		local c2 = display.newImage("circle3M.png")
		c2:scale(0.4,0.4)
		c2.x = c.x + c.contentWidth/2
		c2.y = c.y + c.contentHeight/2
		c2.alpha = 1
		sceneGroup:insert(c2)
		local c3 = display.newImage("circle4M.png")
		c3:scale(0.4,0.4)
		c3.x = c.x + c.contentWidth
		c3.y = c3.y + yInset*8
		c3.alpha = 1
		sceneGroup:insert(c3)
		local c = display.newImage("circle2.png")
		c:scale(0.4,0.4)
		c.x = c.x + xInset*6
		c.y = c.y + yInset*8
		c.alpha = 0
		collide[#collide+1] = c
		sceneGroup:insert(c)
		local c2 = display.newImage("circle3.png")
		c2:scale(0.4,0.4)
		c2.x = c.x + c.contentWidth/2
		c2.y = c.y + c.contentHeight/2
		c2.alpha = 0
		collide[#collide+1] = c2
		sceneGroup:insert(c2)
		local c3 = display.newImage("circle4.png")
		c3:scale(0.4,0.4)
		c3.x = c.x + c.contentWidth
		c3.y = c3.y + yInset*8
		c3.alpha = 0
		collide[#collide+1] = c3
		sceneGroup:insert(c3)
		amount = 3
	elseif numb == 5 then
	local l = display.newImage(questions[5])
	l:scale(0.25,0.25)
	l.x = display.contentWidth/2
	l.y = display.contentHeight/2
	sceneGroup:insert(l)
	
	local t = display.newImage("circle6.png")
	t:scale(l.contentHeight/2/t.contentHeight,l.contentHeight/2/t.contentHeight)
	t.x = l.x + l.contentWidth/2 - t.contentWidth/2
	t.y = l.y - l.contentHeight/2 + t.contentHeight/2
	t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)
	
	local t = display.newImage("circle6.png")
	t:scale(l.contentHeight/2/t.contentHeight,-l.contentHeight/2/t.contentHeight)
	t.x = l.x + l.contentWidth/2 - t.contentWidth/2
	t.y = l.y + l.contentHeight/2 - t.contentHeight/2
	t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)
	
	local t = display.newImage("circle5.png")
	t:scale(l.contentHeight/2/t.contentHeight,l.contentHeight/2/t.contentHeight)
	t.x = l.x - l.contentWidth/2 + t.contentWidth/2
	t.y = l.y - l.contentHeight/2 + t.contentHeight/2
	t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)
	
	local t = display.newImage("circle5.png")
	t:scale(l.contentHeight/2/t.contentHeight,-l.contentHeight/2/t.contentHeight)
	t.x = l.x - l.contentWidth/2 + t.contentWidth/2
	t.y = l.y + l.contentHeight/2 - t.contentHeight/2 
	t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)
		
		amount = 4
	else
		-- local l = display.newImage(questions[6])
		-- l:scale(0.25,0.25)
		-- l.x = display.contentWidth/2 - display.actualContentWidth*0.1
		-- l.y = display.contentHeight/2
		-- sceneGroup:insert(l)

		-- local t = display.newImage("triangle4.png")
		-- t:scale(l.contentWidth/2/t.contentWidth,l.contentWidth/2/t.contentWidth)
		-- t.x = l.x - l.contentWidth/2 + t.contentWidth/2
		-- t.y = l.y - l.contentHeight/2 + t.contentHeight/2
		-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)

		-- local t = display.newImage("triangle5.png")
		-- t:scale(l.contentWidth/t.contentWidth,l.contentWidth/t.contentWidth)
		-- t.x = l.x
		-- t.y = l.y + l.contentHeight/2 - t.contentHeight/2
		-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)

		-- local t = display.newImage("triangle3.png")
		-- t:scale(l.contentWidth/2/t.contentWidth,l.contentWidth/2/t.contentWidth)
		-- t.x = l.x + l.contentWidth/2 - t.contentWidth/2
		-- t.y = l.y - l.contentHeight/2 + t.contentHeight/2
		-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)
		
		local t = display.newImage("triangle4M.png")
		t:scale(0.5,0.5)
		t.x = t.x + xInset*6
		t.y = t.y + yInset*8
		t.alpha = 1
		sceneGroup:insert(t)
		
		local t2 = display.newImage("triangle3M.png")
		t2:scale(0.5,0.5)
		t2.x = t.x + t.contentWidth
		t2.y = t2.y + yInset*8
		t2.alpha = 1
		sceneGroup:insert(t2)
		local t1 = display.newImage("triangle5M.png")
		t1:scale(0.5,0.5)
		t1.x = t.x + t.contentWidth/2
		t1.y = t2.y+ t2.contentWidth/2
		t1.alpha = 1
		sceneGroup:insert(t1)
		
		local t = display.newImage("triangle4.png")
		t:scale(0.5,0.5)
		t.x = t.x + xInset*6
		t.y = t.y + yInset*8
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)
		local t1 = display.newImage("triangle5.png")
		t1:scale(0.5,0.5)
		t1.x = t.x + t.contentWidth/2
		t1.y = t.y+ t.contentWidth/2
		t1.alpha = 0
		collide[#collide+1] = t1
		sceneGroup:insert(t1)
		local t2 = display.newImage("triangle3.png")
		t2:scale(0.5,0.5)
		t2.x = t.x + t.contentWidth
		t2.y = t2.y + yInset*8
		t2.alpha = 0
		collide[#collide+1] = t2
		sceneGroup:insert(t2)
		
		amount = 3
	end
end

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	local sceneGroup = self.view
end


function scene:show( event )
	sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		
		complete = false
		
		local background = display.newImage("background.png")
		
		background.x = display.contentWidth/2
		background.y = display.contentHeight/2
		sceneGroup:insert(background)
		home = display.newImage("Home_button.png")
		home:scale(0.4,0.4)
		home.y = home.y + yInset*2
		home.x = home.x + xInset*1.5

		function goHome()
		
			composer.removeScene("voltooivorm")
			composer.gotoScene( "scene1" , "fade", 500)
			home.alpha = 0
			audio:pause(backgroundMusicChannelMenu)
			--audio.play( backgroundMusicMenu, { loops=1, fadein=3000 } )
			timer.performWithDelay( 1000, (function(e) home.alpha = 0 end))
			return true
		end
		home:addEventListener("tap",goHome)
		sceneGroup:insert(home)
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
		if(isPlayingVWP)then
		musicO:toFront()
		else
		music:toFront()
		end
		if(voltooivormvar == 1) then
		isPlayingVWP = true
		local backgroundMusicChannelMenu = audio.play( backgroundMusicMenu, { loops=1, fadein=3000,onComplete = function() isPlayingVWP = false 
		music:toFront()
		end } )
		end
		sceneGroup:insert(display.newRect(display.contentWidth-display.actualContentWidth*1/6,display.contentHeight/2,display.actualContentWidth*1/3,display.actualContentHeight))
		
		for i = -(#shapes/2), #shapes/2-1 do
		print(i)
			local l = display.newImage(shapes[#shapes/2+i+1])
			
			if i == #shapes/2-1 then
			l:scale(shapeHeight/l.contentWidth,shapeHeight/l.contentWidth)
			else
			l:scale(shapeHeight/l.contentHeight,shapeHeight/l.contentHeight)
			end
			-- if i == -4 then
				-- l:scale(shapeHeight/l.contentHeight,shapeHeight/l.contentHeight)
			-- end
			l.y = 2*margin*i+shapeHeight*(i-1) --+ l.contentHeight/2
			l.x = display.actualContentWidth*5/6
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
					if event.target.markY == nil or cursprite == nil then
						return
					end
					local y = (event.y - event.yStart) + event.target.markY
					local x = (event.x - event.xStart) + event.target.markX
					
					cursprite.x = event.target.x
					cursprite.y = event.target.y
		
					event.target.y = y    -- move object based on calculations above
					event.target.x = x
					else
						w = false
						if cursprite then
						cursprite:removeSelf()
             			cursprite = nil
             			end
             			
					if numb == 1 and l.tag == "triangle1.png" then
						if (hasCollided(collide[1],l) and collide[1].alpha == 0) then
							collide[1].alpha = 1
							showCorrect(collide[1])
						elseif (hasCollided(collide[4],l) and collide[4].alpha == 0) then
							collide[4].alpha = 1
							showCorrect(collide[4])
						elseif (hasCollided(collide[3],l) and collide[3].alpha == 0) then
							collide[3].alpha = 1
							showCorrect(collide[3])
						end
					elseif numb == 1 and l.tag == "triangle2.png" then
						if (hasCollided(collide[2],l) and collide[2].alpha == 0) then
							collide[2].alpha = 1
							showCorrect(collide[2])
						end
					elseif numb == 1 then
						showWrong(event.target)
						w = true
					end
					if numb == 2 and l.tag == "rectangle.png" then
						if (hasCollided(collide[1],l) and collide[1].alpha == 0) then
							collide[1].alpha = 1
							showCorrect(collide[1])
						elseif (hasCollided(collide[2],l) and collide[2].alpha == 0) then
							collide[2].alpha = 1
							showCorrect(collide[2])
						end
					elseif numb == 2 then
						showWrong(event.target)
						w = true
					end
					if numb == 3 and l.tag == "square.png" then
						if (hasCollided(collide[1],l) and collide[1].alpha == 0) then
						collide[1].alpha = 1
						showCorrect(collide[1])
						elseif (hasCollided(collide[2],l) and collide[2].alpha == 0) then
						collide[2].alpha = 1
						showCorrect(collide[2])
						elseif (hasCollided(collide[3],l) and collide[3].alpha == 0) then
						collide[3].alpha = 1
						showCorrect(collide[3])
						elseif (hasCollided(collide[4],l) and collide[4].alpha == 0) then
						collide[4].alpha = 1
						showCorrect(collide[4])
						end
					elseif numb == 3 then
						showWrong(event.target)
						w = true
					end
					
					if numb == 4 and l.tag == "circle2.png" then
						if (hasCollided(collide[1],l) and collide[1].alpha == 0) then
						collide[1].alpha = 1
						showCorrect(collide[1])
						end
					elseif numb == 4 and l.tag == "circle3.png" then
						if (hasCollided(collide[2],l) and collide[2].alpha == 0) then
						collide[2].alpha = 1
						showCorrect(collide[2])
						end
					elseif numb == 4 and l.tag == "circle4.png" then
						if (hasCollided(collide[3],l) and collide[3].alpha == 0) then
						collide[3].alpha = 1
						showCorrect(collide[3])
						end
					elseif numb == 4 then
						showWrong(event.target)
						w = true
					end
					
					if numb == 6 and l.tag == "triangle4.png" then
						if (hasCollided(collide[1],l) and collide[1].alpha == 0) then
						collide[1].alpha = 1
						showCorrect(collide[1])
						end
					elseif numb == 6 and l.tag == "triangle5.png" then
						if (hasCollided(collide[2],l) and collide[2].alpha == 0) then
						collide[2].alpha = 1
						showCorrect(collide[2])
						end
					elseif numb == 6 and l.tag == "triangle3.png" then
						if (hasCollided(collide[3],l) and collide[3].alpha == 0) then
						collide[3].alpha = 1
						showCorrect(collide[3])
						end
					elseif numb == 6 then
						showWrong(event.target)
						w = true
					end
					
					display.getCurrentStage():setFocus( nil, event.id )
					event.target.isFocus = false
					
					if w == false then
					event.target:scale(0.5,0.5)
					self.x = self.origx
					self.y = self.origy
					end
				end
	
				return true
			end	
	
			l:addEventListener( "touch", l )
	
		end

drag = display.newImage("drag.png")
		drag:scale(1/2,1/2)
		drag.y = display.contentHeight/2
		drag.x = display.contentWidth-display.actualContentWidth*1/3

		local y = drag.y 
	        group.y = (y-display.contentHeight/2)*2 + display.contentHeight/1.5 + 25
	    
-- touch listener function
	function drag:touch( event )
    if event.phase == "began" then
	
        self.markY = self.y    -- store y location of object
        
        display.getCurrentStage():setFocus( event.target, event.id )
		event.target.isFocus = true
	
    elseif event.phase == "moved" then
		if self.markY == nil then
						return
		end
        local y = (event.y - event.yStart) + self.markY
        
        if (y > 0 + event.target.contentHeight/2 and y < display.actualContentHeight - event.target.contentHeight/2) then
        self.y =  y    -- move object based on calculations above
        
        --Transform function
        group.y = (y-display.contentHeight/2)*2 + display.contentHeight/1.5 + 25
        end
        else
        event.target.isFocus = false
        display.getCurrentStage():setFocus( nil, event.id )
        
    end
    
    return true
	end

-- make 'myObject' listen for touch events
drag:addEventListener( "touch", drag )
		AddShapes()
		
		local line = display.newLine(drag.x,-100,drag.x,display.actualContentHeight+1000)
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

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene