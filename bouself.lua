local composer = require( "composer" )
local scene = composer.newScene()

local group = display.newGroup()
--5 should fit on the scene, with a margin equivalent of 1 of the vorms

local shapeHeight = display.contentHeight/6
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20
local margin = shapeHeight/6

local sceneGroup
local drag

local addme = {}
local remme = {}

local sheetInfo = require("animations")
		local myImageSheet = graphics.newImageSheet( "animations.png", sheetInfo:getSheet() )
		local cursprite

local shapes = {"f1.png","f2.png","f3.png",
"f4.png","f5.png","r1.png",
"h3.png","h4.png","r2.png","r3.png","r4.png","c1.png","c2.png","c3.png","i1.png"}

local questions = {"flower_lines.png","house_lines.png","rocket_lines.png","castle_lines.png"}
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
local n = {1,2,3,4}
local answ = 0
local amount = 0

local numb = n[voltooivormbouvar]

local collide = {}
local mask={}

local function removeCorrect()
	for i=1,#remme do
		transition.to(remme[i],{alpha = 0})
	end

	for i=1,#addme do
		transition.to(addme[i],{alpha = 1})
	end

	if answ == amount then
		voltooivormbouvar = voltooivormbouvar + 1

		if voltooivormbouvar <= #n then
		audio:pause(backgroundMusicChannelMenu)
		 timer.performWithDelay( 1000, (function(e) composer.removeScene("bouself")
			composer.gotoScene( "bouself" , "fade", 500) end) )
			else
			audio:pause(backgroundMusicChannelMenu)
		composer.removeScene("scene1")
			composer.gotoScene( "scene1" , "fade", 500) 
		voltooivormbouvar = 1
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
		timer.performWithDelay( 1000, (function(e) composer.removeScene("voltooivorm")
			composer.gotoScene( "voltooivorm" , "fade", 500) end) )
			else
			audio:pause(backgroundMusicChannelMenu)
		composer.removeScene("scene1")
			composer.gotoScene( "scene1" , "fade", 500) 
		voltooivormvar = 1
		end
	end
	
	transition.to(cursprite.orig,{x = cursprite.orig.origx,y = cursprite.orig.origy, xScale = 0.25, yScale = 0.25})
end

local function showCorrect(obj)
	cursprite = display.newSprite( myImageSheet , {frames={1,2,3,4,5,6,7},loopDirection = "bounce", time = 600, loopCount = 1} )
		
	curspritescale = (obj.contentWidth-10)/cursprite.contentWidth/2
	cursprite:scale(curspritescale,curspritescale)
	cursprite.x = obj.x
	cursprite.y = obj.y
	--group:insert(cursprite)
	cursprite:play()
	
	remme[#remme+1] = cursprite
	
	local d = display.newImage("Correct_Done.png")
d.alpha = 0
d:scale(curspritescale,curspritescale)
d.x = cursprite.x
d.y = cursprite.y
sceneGroup:insert(d)
addme[#addme+1] = d
	
	timer.performWithDelay( 600, removeCorrect)
	
	answ = answ + 1
end

local function showWrong(obj)
	cursprite = display.newSprite( myImageSheet , {frames={8,9,10,11,12,13,14},loopDirection = "bounce", time = 600, loopCount = 1} )
		
	curspritescale = (obj.contentWidth-10)/cursprite.contentWidth/2
	cursprite:scale(curspritescale,curspritescale)
	cursprite.x = obj.x
	cursprite.y = obj.y
	cursprite.orig = obj
	group:insert(cursprite)
	cursprite:toFront()
	cursprite:play()
	
	remme[#remme+1] = cursprite
	timer.performWithDelay( 600, removeWrong)
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
		local l = display.newImage(questions[1])
		l:scale(0.25,0.25)
		l.x = display.actualContentWidth - drag.x -- - drag.contentWidth -  )/2--display.contentWidth/2 - display.actualContentWidth*0.1
		l.y = display.contentHeight/2
		l.alpha = 0
		sceneGroup:insert(l)

		--Stem1
		local t = display.newImage("f3M.png")
		t:scale(l.contentWidth/4.6/t.contentWidth,l.contentWidth/4.6/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 294*l.xScale
		t.y = l.y - t.contentHeight/2 + 31
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--Stem2
		local t = display.newImage("f3M.png")
		t:scale(l.contentWidth/4.6/t.contentWidth,l.contentWidth/4.6/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 294*l.xScale
		t.y = l.y - t.contentHeight/2 + 74
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--Stem3
		local t = display.newImage("f3M.png")
		t:scale(l.contentWidth/4.6/t.contentWidth,l.contentWidth/4.6/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 294*l.xScale
		t.y = l.y - t.contentHeight/2 + 74+43
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

--Petal
		local t = display.newImage("f5M.png")
		t:scale(l.contentWidth/2.75/t.contentWidth,l.contentWidth/2.75/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 300*l.xScale
		t.y = l.y - t.contentHeight/2 - 35
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)
	
	--Bottom left
		local t = display.newImage("f1M.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 209*l.xScale
		t.y = l.y - t.contentHeight/2 - 3
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

--Bottom right
		local t = display.newImage("f1M.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 397*l.xScale
		t.y = l.y - t.contentHeight/2 - 1
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

--Middel right
		local t = display.newImage("f1M.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 495*l.xScale
		t.y = l.y - t.contentHeight/2 - 41
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--Top right
		local t = display.newImage("f1M.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 396*l.xScale
		t.y = l.y - t.contentHeight/2 - 82
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--Top left
		local t = display.newImage("f1M.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 209*l.xScale
		t.y = l.y - t.contentHeight/2 - 82
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--Middel left
		local t = display.newImage("f1M.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 105*l.xScale
		t.y = l.y - t.contentHeight/2 - 43
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

--leaf1
		local t = display.newImage("f2M.png")
		t:scale(l.contentWidth/3/t.contentWidth,l.contentWidth/3/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 450*l.xScale
		t.y = l.y - t.contentHeight/2 + 40
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--leaf2
		local t = display.newImage("f2M.png")
		t:scale(l.contentWidth/3/t.contentWidth,l.contentWidth/3/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 131*l.xScale
		t.y = l.y - t.contentHeight/2 + 51
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--pot1
		local t = display.newImage("f4M.png")
		t:scale(l.contentWidth/2.7/t.contentWidth,l.contentWidth/2.7/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 181*l.xScale
		t.y = l.y - t.contentHeight/2 + 133
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--pot2
		local t = display.newImage("f4M.png")
		t:scale(l.contentWidth/2.7/t.contentWidth,l.contentWidth/2.7/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 403*l.xScale
		t.y = l.y - t.contentHeight/2 + 133
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)
		mask[4]:toFront()
--Stem1
		local t = display.newImage("f3.png")
		t:scale(l.contentWidth/4.6/t.contentWidth,l.contentWidth/4.6/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 294*l.xScale
		t.y = l.y - t.contentHeight/2 + 31
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Stem2
		local t = display.newImage("f3.png")
		t:scale(l.contentWidth/4.6/t.contentWidth,l.contentWidth/4.6/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 294*l.xScale
		t.y = l.y - t.contentHeight/2 + 74
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Stem3
		local t = display.newImage("f3.png")
		t:scale(l.contentWidth/4.6/t.contentWidth,l.contentWidth/4.6/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 294*l.xScale
		t.y = l.y - t.contentHeight/2 + 74+43
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

--Petal
		local t = display.newImage("f5.png")
		t:scale(l.contentWidth/2.75/t.contentWidth,l.contentWidth/2.75/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 300*l.xScale
		t.y = l.y - t.contentHeight/2 - 35
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)
	
	--Bottom left
		local t = display.newImage("f1.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 209*l.xScale
		t.y = l.y - t.contentHeight/2 - 3
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

--Bottom right
		local t = display.newImage("f1.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 397*l.xScale
		t.y = l.y - t.contentHeight/2 - 1
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

--Middel right
		local t = display.newImage("f1.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 495*l.xScale
		t.y = l.y - t.contentHeight/2 - 41
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Top right
		local t = display.newImage("f1.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 396*l.xScale
		t.y = l.y - t.contentHeight/2 - 82
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Top left
		local t = display.newImage("f1.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 209*l.xScale
		t.y = l.y - t.contentHeight/2 - 82
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Middel left
		local t = display.newImage("f1.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 105*l.xScale
		t.y = l.y - t.contentHeight/2 - 43
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

--leaf1
		local t = display.newImage("f2.png")
		t:scale(l.contentWidth/3/t.contentWidth,l.contentWidth/3/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 450*l.xScale
		t.y = l.y - t.contentHeight/2 + 40
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--leaf2
		local t = display.newImage("f2.png")
		t:scale(l.contentWidth/3/t.contentWidth,l.contentWidth/3/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 131*l.xScale
		t.y = l.y - t.contentHeight/2 + 51
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--pot1
		local t = display.newImage("f4.png")
		t:scale(l.contentWidth/2.7/t.contentWidth,l.contentWidth/2.7/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 181*l.xScale
		t.y = l.y - t.contentHeight/2 + 133
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--pot2
		local t = display.newImage("f4.png")
		t:scale(l.contentWidth/2.7/t.contentWidth,l.contentWidth/2.7/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 403*l.xScale
		t.y = l.y - t.contentHeight/2 + 133
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)
		
		--collide[4]:toFront()
		amount = 14
	elseif numb == 2 then
	local l = display.newImage(questions[2])
	l:scale(0.4,0.4)
	l.x = display.contentWidth/2 - display.actualContentWidth*0.1
	l.y = display.contentHeight/2
	l.alpha =0;
	sceneGroup:insert(l)
	local t = display.newImage("i1M.png")
		t:scale(l.contentWidth/1/t.contentWidth,l.contentWidth/1/t.contentWidth)
		t.x = l.x
		t.y = l.y + 22.5
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		local t = display.newImage("i1M.png")
		t:scale(l.contentWidth/1/t.contentWidth,l.contentWidth/1/t.contentWidth)
		t.x = l.x
		t.y = l.y + 22.5+81
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--chimney
	local t = display.newImage("r3M.png")
		t:scale(l.contentWidth/4.5/t.contentWidth,l.contentWidth/4.5/t.contentWidth)
		t.x = l.x + l.contentWidth/2 - 35
		t.y = l.y - t.contentHeight/2 - 45
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

--Roof
	local t = display.newImage("h3M.png")
		t:scale(l.contentWidth/1/t.contentWidth,l.contentWidth/1/t.contentWidth)
		t.x = l.x -- l.contentWidth/2 + 403*l.xScale
		t.y = l.y - t.contentHeight/2 -17
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

--door
	local t = display.newImage("r3M.png")
		t:scale(l.contentWidth/3.35/t.contentWidth,l.contentWidth/3.35/t.contentWidth)
		t.x = l.x -- l.contentWidth/2 + 403*l.xScale
		t.y = l.y - t.contentHeight/2 + 137
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--window1
	local t = display.newImage("h4M.png")
		t:scale(l.contentWidth/3.5/t.contentWidth,l.contentWidth/3.5/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 113
		t.y = l.y - t.contentHeight/2+46
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

			--window2
	local t = display.newImage("h4M.png")
		t:scale(l.contentWidth/3.5/t.contentWidth,l.contentWidth/3.5/t.contentWidth)
		t.x = l.x + l.contentWidth/2 - 114
		t.y = l.y - t.contentHeight/2+46
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

local t = display.newImage("i1.png")
		t:scale(l.contentWidth/1/t.contentWidth,l.contentWidth/1/t.contentWidth)
		t.x = l.x
		t.y = l.y + 22.5
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		local t = display.newImage("i1.png")
		t:scale(l.contentWidth/1/t.contentWidth,l.contentWidth/1/t.contentWidth)
		t.x = l.x
		t.y = l.y + 22.5+81
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--chimney
	local t = display.newImage("r3.png")
		t:scale(l.contentWidth/4.5/t.contentWidth,l.contentWidth/4.5/t.contentWidth)
		t.x = l.x + l.contentWidth/2 - 35
		t.y = l.y - t.contentHeight/2 - 45
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

--Roof
	local t = display.newImage("h3.png")
		t:scale(l.contentWidth/1/t.contentWidth,l.contentWidth/1/t.contentWidth)
		t.x = l.x -- l.contentWidth/2 + 403*l.xScale
		t.y = l.y - t.contentHeight/2 -17
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

--door
	local t = display.newImage("r3.png")
		t:scale(l.contentWidth/3.35/t.contentWidth,l.contentWidth/3.35/t.contentWidth)
		t.x = l.x -- l.contentWidth/2 + 403*l.xScale
		t.y = l.y - t.contentHeight/2 + 137
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--window1
	local t = display.newImage("h4.png")
		t:scale(l.contentWidth/3.5/t.contentWidth,l.contentWidth/3.5/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 113
		t.y = l.y - t.contentHeight/2+46
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

			--window2
	local t = display.newImage("h4.png")
		t:scale(l.contentWidth/3.5/t.contentWidth,l.contentWidth/3.5/t.contentWidth)
		t.x = l.x + l.contentWidth/2 - 114
		t.y = l.y - t.contentHeight/2+46
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)
	
	amount = 7
	elseif numb == 3 then
	local l = display.newImage(questions[3])
	l:scale(0.25,0.25)
	l.x = display.contentWidth/2 - xInset*3
	l.y = display.contentHeight/2
	l.alpha=0
	sceneGroup:insert(l)
	
local t = display.newImage("i1M.png")
		t:scale(l.contentWidth/2.77/t.contentWidth,l.contentWidth/2.8/t.contentWidth)
		t.x = l.x
		t.y = l.y - t.contentHeight*0.9
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		local t = display.newImage("i1M.png")
		t:scale(l.contentWidth/2.77/t.contentWidth,l.contentWidth/2.8/t.contentWidth)
		t.x = l.x
		t.y = l.y + 4
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		local t = display.newImage("i1M.png")
		t:scale(l.contentWidth/2.77/t.contentWidth,l.contentWidth/2.8/t.contentWidth)
		t.x = l.x
		t.y = l.y + t.contentHeight*2.5
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

--Window
	local t = display.newImage("r1M.png")
		t:scale(l.contentWidth/4.5/t.contentWidth,l.contentWidth/4.5/t.contentWidth)
		t.x = l.x
		t.y = l.y - t.contentHeight/2+8
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

--Wing1
		local t = display.newImage("r2M.png")
		t:scale(l.contentWidth/3.1/t.contentWidth,l.contentWidth/3.05/t.contentWidth)
		t.x = l.x + l.contentWidth/2.95
		t.y = l.y + t.contentHeight*0.9
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--Wing2
		local t = display.newImage("r5M.png")
		t:scale(l.contentWidth/3.1/t.contentWidth,l.contentWidth/3.05/t.contentWidth)
		t.x = l.x - l.contentWidth/2.95
		t.y = l.y + t.contentHeight*0.9
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--base1
		local t = display.newImage("r3M.png")
		t:scale(l.contentWidth/5.5/t.contentWidth,l.contentWidth/5.5/t.contentWidth)
		t.x = l.x + t.contentWidth*0.5
		t.y = l.y + t.contentHeight/1.1
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--base2
		local t = display.newImage("r3M.png")
		t:scale(l.contentWidth/5.5/t.contentWidth,l.contentWidth/5.5/t.contentWidth)
		t.x = l.x - t.contentWidth*0.5
		t.y = l.y + t.contentHeight/1.1
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--base2
		local t = display.newImage("r4M.png")
		t:scale(l.contentWidth/2.75/t.contentWidth,l.contentWidth/2.75/t.contentWidth)
		t.x = l.x 
		t.y = l.y - t.contentHeight*1.375
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)
local t = display.newImage("i1.png")
		t:scale(l.contentWidth/2.77/t.contentWidth,l.contentWidth/2.8/t.contentWidth)
		t.x = l.x
		t.y = l.y - t.contentHeight*0.9
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		local t = display.newImage("i1.png")
		t:scale(l.contentWidth/2.77/t.contentWidth,l.contentWidth/2.8/t.contentWidth)
		t.x = l.x
		t.y = l.y + 4
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		local t = display.newImage("i1.png")
		t:scale(l.contentWidth/2.77/t.contentWidth,l.contentWidth/2.8/t.contentWidth)
		t.x = l.x
		t.y = l.y + t.contentHeight*2.5
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

--Window
	local t = display.newImage("r1.png")
		t:scale(l.contentWidth/4.5/t.contentWidth,l.contentWidth/4.5/t.contentWidth)
		t.x = l.x
		t.y = l.y - t.contentHeight/2+8
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

--Wing1
		local t = display.newImage("r2.png")
		t:scale(l.contentWidth/3.1/t.contentWidth,l.contentWidth/3.05/t.contentWidth)
		t.x = l.x + l.contentWidth/2.95
		t.y = l.y + t.contentHeight*0.9
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Wing2
		local t = display.newImage("r5.png")
		t:scale(l.contentWidth/3.1/t.contentWidth,l.contentWidth/3.05/t.contentWidth)
		t.x = l.x - l.contentWidth/2.95
		t.y = l.y + t.contentHeight*0.9
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--base1
		local t = display.newImage("r3.png")
		t:scale(l.contentWidth/5.5/t.contentWidth,l.contentWidth/5.5/t.contentWidth)
		t.x = l.x + t.contentWidth*0.5
		t.y = l.y + t.contentHeight/1.1
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--base2
		local t = display.newImage("r3.png")
		t:scale(l.contentWidth/5.5/t.contentWidth,l.contentWidth/5.5/t.contentWidth)
		t.x = l.x - t.contentWidth*0.5
		t.y = l.y + t.contentHeight/1.1
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--base2
		local t = display.newImage("r4.png")
		t:scale(l.contentWidth/2.75/t.contentWidth,l.contentWidth/2.75/t.contentWidth)
		t.x = l.x 
		t.y = l.y - t.contentHeight*1.375
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)
	
	
		amount = 9
	elseif numb == 4 then	
	local l = display.newImage(questions[4])
	l:scale(0.35,0.35)
	l.x = display.contentWidth/2 - xInset*3
	l.y = display.contentHeight/2
	l.alpha = 0
	sceneGroup:insert(l)
	local t = display.newImage("i1M.png")
		t:scale(l.contentWidth/2.35/t.contentWidth,l.contentWidth/2.35/t.contentWidth)
		t.x = l.x - 77.5
		t.y = l.y - l.contentHeight/2 + 56
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		local t = display.newImage("i1M.png")
		t:scale(l.contentWidth/2.35/t.contentWidth,l.contentWidth/2.35/t.contentWidth)
		t.x = l.x + 75
		t.y = l.y - l.contentHeight/2 + 56
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

	--Wall1
	local t = display.newImage("r3M.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - 80+1
		t.y = l.y + l.contentHeight/2 - 71
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--Wall2
	local t = display.newImage("r3M.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x +75
		t.y = l.y + l.contentHeight/2 - 71
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

			--Wall3
	local t = display.newImage("r3M.png")
		t:scale(l.contentWidth/5/t.contentWidth,l.contentWidth/5/t.contentWidth)
		t.x = l.x-2
		t.y = l.y + l.contentHeight/2 - 40
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

--window1
	local t = display.newImage("c1M.png")
		t:scale(-l.contentWidth/5.5/t.contentWidth,l.contentWidth/5.5/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 68.5
		t.y = l.y - t.contentHeight/2-6
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

--Window2
		local t = display.newImage("c1M.png")
		t:scale(-l.contentWidth/5.5/t.contentWidth,l.contentWidth/5.5/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 68.5+155.5
		t.y = l.y - t.contentHeight/2-6
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		

		--Door2
		-- local t = display.newImage("c1M.png")
		-- t:scale(l.contentWidth/14/t.contentWidth,l.contentWidth/14/t.contentWidth)
		-- t.x = l.x+7
		-- t.y = l.y + t.contentHeight/2+45
		-- t.alpha = 1
		-- mask[#mask+1] = t
		-- sceneGroup:insert(t)

		--Door3
		local t = display.newImage("c3M.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 2
		t.y = l.y + t.contentHeight/2+65
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)
--Door1
		local t = display.newImage("c1M.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x -1.9
		t.y = l.y + t.contentHeight/2+46
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)
		--Roof1
		local t = display.newImage("c3M.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 128.5
		t.y = l.y - l.contentHeight/2 + 19
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--Roof2
		local t = display.newImage("c3M.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 128.5 + 52
		t.y = l.y - l.contentHeight/2 + 19
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--Roof3
		local t = display.newImage("c3M.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 128.5 + 52*2
		t.y = l.y - l.contentHeight/2 + 19
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--Roof4
		local t = display.newImage("c3M.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 128.5 + 52*3-3
		t.y = l.y - l.contentHeight/2 + 19
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--Roof5
		local t = display.newImage("c3M.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 128.5 + 52*4-3
		t.y = l.y - l.contentHeight/2 + 19
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

		--Roof6
		local t = display.newImage("c3M.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 128.5 + 52*5-3
		t.y = l.y - l.contentHeight/2 + 19
		t.alpha = 1
		mask[#mask+1] = t
		sceneGroup:insert(t)

	local t = display.newImage("i1.png")
		t:scale(l.contentWidth/2.35/t.contentWidth,l.contentWidth/2.35/t.contentWidth)
		t.x = l.x - 77.5
		t.y = l.y - l.contentHeight/2 + 56
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		local t = display.newImage("i1.png")
		t:scale(l.contentWidth/2.35/t.contentWidth,l.contentWidth/2.35/t.contentWidth)
		t.x = l.x + 75
		t.y = l.y - l.contentHeight/2 + 56
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

	--Wall1
	local t = display.newImage("r3.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x - 80+1
		t.y = l.y + l.contentHeight/2 - 71
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Wall2
	local t = display.newImage("r3.png")
		t:scale(l.contentWidth/2.9/t.contentWidth,l.contentWidth/2.9/t.contentWidth)
		t.x = l.x +75
		t.y = l.y + l.contentHeight/2 - 71
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

			--Wall3
	local t = display.newImage("r3.png")
		t:scale(l.contentWidth/5/t.contentWidth,l.contentWidth/5/t.contentWidth)
		t.x = l.x-2
		t.y = l.y + l.contentHeight/2 - 40
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

--window1
	local t = display.newImage("c1.png")
		t:scale(-l.contentWidth/5.5/t.contentWidth,l.contentWidth/5.5/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 68.5
		t.y = l.y - t.contentHeight/2-6
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

--Window2
		local t = display.newImage("c1.png")
		t:scale(-l.contentWidth/5.5/t.contentWidth,l.contentWidth/5.5/t.contentWidth)
		t.x = l.x - l.contentWidth/2 + 68.5+155.5
		t.y = l.y - t.contentHeight/2-6
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Door1
		-- local t = display.newImage("c1.png")
		-- t:scale(l.contentWidth/14/t.contentWidth,l.contentWidth/14/t.contentWidth)
		-- t.x = l.x-11
		-- t.y = l.y + t.contentHeight/2+45
		-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)
		
		--Door2
		-- local t = display.newImage("c2.png")
		-- t:scale(l.contentWidth/14/t.contentWidth,l.contentWidth/14/t.contentWidth)
		-- t.x = l.x+7
		-- t.y = l.y + t.contentHeight/2+45
		-- t.alpha = 0
		-- collide[#collide+1] = t
		-- sceneGroup:insert(t)

		--Door3
		local t = display.newImage("c3.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 2
		t.y = l.y + t.contentHeight/2+65
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)
		
		local t = display.newImage("c1.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x -1.9
		t.y = l.y + t.contentHeight/2+46
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Roof1
		local t = display.newImage("c3.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 128.5
		t.y = l.y - l.contentHeight/2 + 19
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Roof2
		local t = display.newImage("c3.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 128.5 + 52
		t.y = l.y - l.contentHeight/2 + 19
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Roof3
		local t = display.newImage("c3.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 128.5 + 52*2
		t.y = l.y - l.contentHeight/2 + 19
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Roof4
		local t = display.newImage("c3.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 128.5 + 52*3-3
		t.y = l.y - l.contentHeight/2 + 19
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Roof5
		local t = display.newImage("c3.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 128.5 + 52*4-3
		t.y = l.y - l.contentHeight/2 + 19
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

		--Roof6
		local t = display.newImage("c3.png")
		t:scale(l.contentWidth/7.6/t.contentWidth,l.contentWidth/7.6/t.contentWidth)
		t.x = l.x - 128.5 + 52*5-3
		t.y = l.y - l.contentHeight/2 + 19
		t.alpha = 0
		collide[#collide+1] = t
		sceneGroup:insert(t)

	amount = 15
	end
end

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view
	
end
local backgroundMusicMenu = audio.loadStream( "music.mp3" )
local backgroundMusicChannelMenu = audio.play( backgroundMusicMenu, { loops=1, fadein=3000 } )
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
		
		if voltooivormbouvar == 1 then
			shapes = {"f1.png","f2.png","f3.png",
		"f4.png","f5.png"
		,"r5.png","r2.png","r3.png","h3.png","triangle3.png","i1.png"}
		elseif voltooivormbouvar == 2 then
			shapes = {"f2.png","f3.png",
		"r5.png","f5.png","r1.png",
		"h3.png","h4.png","r2.png","r3.png","triangle3.png","i1.png"}
		elseif voltooivormbouvar == 3 then
			shapes = {"f2.png","f3.png",
		"r5.png","f5.png","r1.png",
		"triangle3.png","h4.png","r2.png","r3.png","r4.png","i1.png"}
		else 
			shapes = {"c1.png","f2.png","f3.png",
		"r5.png","f5.png","r1.png",
		"h3.png","h3.png","r2.png","r3.png","r4.png","c3.png","i1.png"}
		end

		
		local background = display.newImage("background.png")
		
		background.x = display.contentWidth/2
		background.y = display.contentHeight/2
		sceneGroup:insert(background)
		home = display.newImage("Home_button.png")
		home:scale(0.4,0.4)
		home.y = home.y + yInset*2
		home.x = home.x + xInset*1.5

		function goHome()
			composer.removeScene("bouself")
			composer.gotoScene( "scene1" , "fade", 500)
			home.alpha = 0
			audio:pause(backgroundMusicChannelMenu)
			timer.performWithDelay( 1000, (function(e) home.alpha = 0 end))
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
		isPlaying=true
		sceneGroup:insert(display.newRect(display.contentWidth-display.actualContentWidth*1/6,display.contentHeight/2,display.actualContentWidth*1/3,display.actualContentHeight))
		
		for i = -(#shapes/2), #shapes/2-1 do
		
			local l = display.newImage(shapes[#shapes/2+i+1])
			
			if i == #shapes/2-1 then
			l:scale(shapeHeight/l.contentWidth,shapeHeight/l.contentWidth)
			else
			l:scale(shapeHeight/l.contentHeight,shapeHeight/l.contentHeight)
			end
			if i==-(#shapes/2) and voltooivormbouvar==4 then
				l:scale(0.5,0.5)
			end
			l.y = 2*margin*i+shapeHeight*(i-1) --+ l.contentHeight/2
			l.x = display.actualContentWidth*5/6
			l.tag = shapes[#shapes/2+i+1]
			l.origx = l.x
			l.origy = l.y
			group:insert(l)
			
			function l:touch( event )
				if event.phase == "began" then
					w = false
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
			if i==-(#shapes/2) and voltooivormbouvar==4 then
				event.target:scale(0.5,0.5)
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
						if cursprite then
						cursprite:removeSelf()
             			cursprite = nil
             			end

					if numb == 1 and l.tag == "f3.png" then
						if (hasCollided(collide[1],l) and collide[1].alpha == 0) then
						collide[1].alpha = 1
						showCorrect(collide[1])
						collide[1]:toBack()
						mask[1]:toBack()
						background:toBack()
						elseif (hasCollided(collide[2],l) and collide[2].alpha == 0) then
						collide[2].alpha = 1
						showCorrect(collide[2])
						elseif (hasCollided(collide[3],l) and collide[3].alpha == 0) then
						collide[3].alpha = 1
						showCorrect(collide[3])
						end
					elseif numb == 1 and l.tag == "f5.png" then
						if (hasCollided(collide[4],l) and collide[4].alpha == 0) then
						collide[4].alpha = 1
						mask[4]:toBack()
						background:toBack()
						showCorrect(collide[4])
						end
					elseif numb == 1 and l.tag == "f1.png" then
						if (hasCollided(collide[5],l) and collide[5].alpha == 0) then
						collide[5].alpha = 1
						showCorrect(collide[5])
						collide[5]:toBack()
						mask[5]:toBack()
						background:toBack()
						elseif (hasCollided(collide[6],l) and collide[6].alpha == 0) then
						collide[6].alpha = 1
						showCorrect(collide[6])
						collide[6]:toBack()
						mask[6]:toBack()
						background:toBack()
						elseif (hasCollided(collide[7],l) and collide[7].alpha == 0) then
						collide[7].alpha = 1
						showCorrect(collide[7])
						collide[7]:toBack()
						mask[7]:toBack()
						background:toBack()
						elseif (hasCollided(collide[8],l) and collide[8].alpha == 0) then
						collide[8].alpha = 1
						showCorrect(collide[8])
						collide[8]:toBack()
						mask[8]:toBack()
						background:toBack()
						elseif (hasCollided(collide[9],l) and collide[9].alpha == 0) then
						collide[9].alpha = 1
						showCorrect(collide[9])
						collide[9]:toBack()
						mask[9]:toBack()
						background:toBack()
						elseif (hasCollided(collide[10],l) and collide[10].alpha == 0) then
						collide[10].alpha = 1
						showCorrect(collide[10])
						collide[10]:toBack()
						mask[10]:toBack()
						background:toBack()
						end
					elseif numb == 1 and l.tag == "f2.png" then
						if (hasCollided(collide[12],l) and collide[12].alpha == 0) then
						collide[12].alpha = 1
						showCorrect(collide[12])
						elseif (hasCollided(collide[11],l) and collide[11].alpha == 0) then
						collide[11].alpha = 1
						showCorrect(collide[11])
						end
					elseif numb == 1 and l.tag == "f4.png" then
						if (hasCollided(collide[14],l) and collide[14].alpha == 0) then
						collide[14].alpha = 1
						showCorrect(collide[14])
						elseif (hasCollided(collide[13],l) and collide[13].alpha == 0) then
						collide[13].alpha = 1
						showCorrect(collide[13])
						end
					elseif numb == 1 then
						showWrong(event.target)
						w = true
					end
					
					if numb == 2 and l.tag == "i1.png" then
						if (hasCollided(collide[1],l) and collide[1].alpha == 0) then
						collide[1].alpha = 1
						collide[1]:toBack()
						background:toBack()
						mask[1].alpha=0
						showCorrect(collide[1])
						elseif (hasCollided(collide[2],l) and collide[2].alpha == 0) then
						collide[2].alpha = 1
						collide[2]:toBack()
						mask[2].alpha=0
						background:toBack()
						showCorrect(collide[2])
						end
					elseif numb == 2 and l.tag == "r3.png" then
						if (hasCollided(collide[3],l) and collide[3].alpha == 0) then
						collide[3].alpha = 1
						showCorrect(collide[3])
						elseif (hasCollided(collide[5],l) and collide[5].alpha == 0) then
						collide[5].alpha = 1
						showCorrect(collide[5])
						end
					elseif numb == 2 and l.tag == "h3.png" then
						if (hasCollided(collide[4],l) and collide[4].alpha == 0) then
						collide[4].alpha = 1
						showCorrect(collide[4])
						end
					elseif numb == 2 and l.tag == "h4.png" then
						if (hasCollided(collide[6],l) and collide[6].alpha == 0) then
						collide[6].alpha = 1
						showCorrect(collide[6])
						elseif (hasCollided(collide[7],l) and collide[7].alpha == 0) then
						collide[7].alpha = 1
						showCorrect(collide[7])
						end
					elseif numb == 2 then
						showWrong(event.target)
						w = true
					end
					
					if numb == 3 and l.tag == "i1.png" then
						if (hasCollided(collide[1],l) and collide[1].alpha == 0) then
						collide[1].alpha = 1
						showCorrect(collide[1])
						collide[1]:toBack()
						background:toBack()
						mask[1].alpha=0
						elseif (hasCollided(collide[2],l) and collide[2].alpha == 0) then
						collide[2].alpha = 1
						showCorrect(collide[2])
						collide[2]:toBack()
						background:toBack()
						mask[2].alpha=0
						elseif (hasCollided(collide[3],l) and collide[3].alpha == 0) then
						collide[3].alpha = 1
						showCorrect(collide[3])
						collide[3]:toBack()
						background:toBack()
						mask[3].alpha=0
						end
					elseif numb == 3 and l.tag == "r1.png" then
						if (hasCollided(collide[4],l) and collide[4].alpha == 0) then
						collide[4].alpha = 1
						showCorrect(collide[4])
						end
					elseif numb == 3 and l.tag == "r2.png" then
						if (hasCollided(collide[5],l) and collide[5].alpha == 0) then
						collide[5].alpha = 1
						showCorrect(collide[5])
						end
					elseif numb == 3 and l.tag == "r5.png" then
						if (hasCollided(collide[6],l) and collide[6].alpha == 0) then
						collide[6].alpha = 1
						showCorrect(collide[6])
					end
					elseif numb == 3 and l.tag == "r3.png" then
						if (hasCollided(collide[7],l) and collide[7].alpha == 0) then
						collide[7].alpha = 1
						showCorrect(collide[7])
						elseif (hasCollided(collide[8],l) and collide[8].alpha == 0) then
						collide[8].alpha = 1
						showCorrect(collide[8])
						end
					elseif numb == 3 and l.tag == "r4.png" then
						if (hasCollided(collide[9],l) and collide[9].alpha == 0) then
						collide[9].alpha = 1
						showCorrect(collide[9])
						end
					elseif numb == 3 then
						showWrong(event.target)
						w = true
					end

					
					if numb == 4 and l.tag == "i1.png" then
						if (hasCollided(collide[1],l) and collide[1].alpha == 0) then
						collide[1].alpha = 1
						collide[1]:toBack()
						background:toBack()
						mask[1].alpha=0
						showCorrect(collide[1])
						elseif (hasCollided(collide[2],l) and collide[2].alpha == 0) then
						collide[2].alpha = 1
						collide[2]:toBack()
						background:toBack()
						mask[2].alpha=0
						showCorrect(collide[2])
						end
					elseif numb == 4 and l.tag == "r3.png" then
						if (hasCollided(collide[3],l) and collide[3].alpha == 0) then
						collide[3].alpha = 1
						collide[3]:toBack()
						background:toBack()
						mask[3].alpha=0
						showCorrect(collide[3])
						elseif (hasCollided(collide[4],l) and collide[4].alpha == 0) then
						collide[4].alpha = 1
						collide[4]:toBack()
						background:toBack()
						mask[4].alpha=0
						showCorrect(collide[4])
						elseif (hasCollided(collide[5],l) and collide[5].alpha == 0) then
						collide[5].alpha = 1
						collide[5]:toBack()
						background:toBack()
						mask[5].alpha=0
						showCorrect(collide[5])
						end
					elseif numb == 4 and l.tag == "c1.png" then
						if (hasCollided(collide[6],l) and collide[6].alpha == 0) then
						collide[6].alpha = 1
						showCorrect(collide[6])
						elseif (hasCollided(collide[7],l) and collide[7].alpha == 0) then
						collide[7].alpha = 1
						showCorrect(collide[7])
						elseif (hasCollided(collide[9],l) and collide[9].alpha == 0) then
						collide[9].alpha = 1
						showCorrect(collide[9])
						end
					-- elseif numb == 4 and l.tag == "c2.png" then
						-- if (hasCollided(collide[8],l) and collide[8].alpha == 0) then
						-- collide[8].alpha = 1
						-- showCorrect(collide[8])
						-- elseif (hasCollided(collide[9],l) and collide[9].alpha == 0) then
						-- collide[9].alpha = 1
						-- showCorrect(collide[9])
						-- end
					elseif numb == 4 and l.tag == "c3.png" then
						if (hasCollided(collide[8],l) and collide[8].alpha == 0) then
						collide[8].alpha = 1
						showCorrect(collide[8])
						elseif (hasCollided(collide[10],l) and collide[10].alpha == 0) then
						collide[10].alpha = 1
						showCorrect(collide[10])
						elseif (hasCollided(collide[11],l) and collide[11].alpha == 0) then
						collide[11].alpha = 1
						showCorrect(collide[11])
						elseif (hasCollided(collide[12],l) and collide[12].alpha == 0) then
						collide[12].alpha = 1
						showCorrect(collide[12])
						elseif (hasCollided(collide[13],l) and collide[13].alpha == 0) then
						collide[13].alpha = 1
						showCorrect(collide[13])
						elseif (hasCollided(collide[14],l) and collide[14].alpha == 0) then
						collide[14].alpha = 1
						showCorrect(collide[14])
						elseif (hasCollided(collide[15],l) and collide[15].alpha == 0) then
						collide[15].alpha = 1
						showCorrect(collide[15])
						-- elseif (hasCollided(collide[16],l) and collide[16].alpha == 0) then
						-- collide[16].alpha = 1
						-- showCorrect(collide[16])
						end
					elseif numb == 4 then
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
	
        local y = (event.y - event.yStart) + self.markY
        
        if (y > 0 + event.target.contentHeight/2 and y < display.actualContentHeight - event.target.contentHeight/2) then
        self.y =  y    -- move object based on calculations above
        
        --Transform function
        group.y = (y-display.contentHeight/2)*3.1 + display.contentHeight/1.5 + 35
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
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene