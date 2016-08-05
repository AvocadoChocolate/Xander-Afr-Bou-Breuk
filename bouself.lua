local composer = require( "composer" )
local scene = composer.newScene()

local group = display.newGroup()
--5 should fit on the scene, with a margin equivalent of 1 of the vorms

--b.mask={{88,140},{88,372},{43,70},{89,70},{137,69},{43,117},{90,117},{136,118},{43,166},{90,166},{136,166},{269,109},{90,215},{135,214},{42,302},{88,302},{136,302},{42,350},{88,349},{136,350},{42,398},{89,396},{136,396},{90,460}}
--h.mask={{100,316},{99,215},{101,106},{102,316},{57,213},{143,214},{158,96}}
--l.mask={{323,253},{323,569},{330,889},{468,1117},{200,1115},{330,575},{426,581},{228,579},{431,897},{330,895},{228,897},{268,251},{387,257},{330,55},{596,253},{41,253}}
--rock.mask={{542,622},{549,420},{542,1104},{446,877},{463,869},{549,204},{839,913},{231,915},{547,517}}
--s.mask={{186,150},{640,158},{194,404},{636,405},{414,475},{643,249},{198,250},{791,57},{644,58},{496,55},{355,56},{206,57},{417,540},{50,57},{399,460},{441,463}}
--t.mask={{244,616},{426,617},{616,608},{807,610},{657,616},{783,160},{910,159},{288,80},{98,577}}

local background
local isTransition = false
local shapeHeight = display.contentHeight/6
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20
local margin = shapeHeight/6
local backgroundMusicMenu = audio.loadStream( "music.mp3" )
local sceneGroup
local drag
local curShape
local addme = {}
local remme = {}
local listeners ={}
local sheetInfo = require("animations")
		local myImageSheet = graphics.newImageSheet( "animations.png", sheetInfo:getSheet() )
		local cursprite

local shapes = {"f1.png","f2.png","f3.png",
"f4.png","f5.png","r1.png",
"h3.png","h4.png","r2.png","r3.png","r4.png","c1.png","c2.png","c3.png","i1.png"}

local questions = {"flower_lines.png","house_lines.png","rocket_lines.png","castle_lines.png"}
function toggleMusic()
		if (isPlayingBS) then
		audio.pause(backgroundMusicChannel)
		isPlayingBS = false
		music:toFront()
		else
		 backgroundMusicMenu = audio.loadStream( "music.mp3" )
		 local backgroundMusicChannelMenu = audio.play( backgroundMusicMenu, { loops=1, fadein=3000,onComplete = function() isPlayingBS = false 
		music:toFront()
		end } )
		--audio.play( backgroundMusicMenu, { loops=1, fadein=3000 } )
		isPlayingBS = true
		musicO:toFront()
		end
		return true
end
local n = {1,2,3,4,5,6,7}
local answ = 0
local amount = 0
local scaleS
local numb = n[voltooivormbouvar]

local collide = {}
local mask={}
local whites = {}

local function removeCorrect()
	for i=1,#remme do
		isTransition = true
		transition.to(remme[i],{alpha = 0,onComplete = function() isTransition = false end})
	end

	for i=1,#addme do
		isTransition = true
		transition.to(addme[i],{alpha = 1,onComplete = function() isTransition = false end})
	end

	if answ == amount then
		voltooivormbouvar = voltooivormbouvar + 1

		if voltooivormbouvar <= #n then
		--audio:pause(backgroundMusicChannelMenu)
		 timer.performWithDelay( 1000, (function(e) composer.removeScene("bouself")
		 
			composer.gotoScene( "bouself" , "fade", 500) end) )
			else
			audio:pause(backgroundMusicChannelMenu)
		composer.removeScene("bouself")
			composer.gotoScene( "scene1" , "fade", 500) 
		voltooivormbouvar = 1
		end
	end
end

local function removeWrong(obj)
	for i=1,#remme do
	isTransition = true
	transition.to(remme[i],{alpha = 0,onComplete = function() isTransition = false end})
	end

	for i=1,#addme do
	isTransition = true
	transition.to(addme[i],{alpha = 1,onComplete = function() isTransition = false end})
	end

	if answ == amount then
	voltooivormbouvar = voltooivormbouvar + 1

	if voltooivormbouvar <= #n then
	--audio:pause(backgroundMusicChannelMenu)
		timer.performWithDelay( 1000, (function(e) composer.removeScene("bouself")
			composer.gotoScene( "bouself" , "fade", 500) end) )
			else
			audio:pause(backgroundMusicChannelMenu)
		composer.removeScene("bouself")
			composer.gotoScene( "scene1" , "fade", 500) 
		voltooivormbouvar = 1
		end
	end
	isTransition = true
	transition.to(cursprite.orig,{x = cursprite.orig.origx,y = cursprite.orig.origy, xScale = cursprite.orig.origScaleF, yScale = cursprite.orig.origScaleF,onComplete = function() isTransition = false end})
end

local function showCorrect(obj)
	
	--isTransition = true
	cursprite = display.newSprite( myImageSheet , {frames={1,2,3,4,5,6,7},loopDirection = "bounce", time = 300, loopCount = 1,onComplete=function() display.getCurrentStage():setFocus( nil ) end} )
	display.getCurrentStage():setFocus( cursprite )	
	--curspritescale = (obj.contentWidth-10)/cursprite.contentWidth/2
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
	
	timer.performWithDelay( 300, removeCorrect)
	
	answ = answ + 1
	
end

local function showWrong(obj)
	--isTransition = true
	
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
	--timer.performWithDelay( 300, removeWrong)
	
end

function AddShapes()
	if numb == 1 then
	local t = display.newImage("flower/f1.png")
	t.alpha = 0
	scaleS = (display.contentHeight - xInset)/t.contentHeight
	t:removeSelf()
	for i =1,14 do
			print("flower/f"..i..".png")
			local t = display.newImage("flower/f"..i..".png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*4
			t.y = yInset
			t:scale(scaleS,scaleS)
			t.alpha = 0
			collide[#collide+1] = t
			sceneGroup:insert(t)
		end
		for i =1,14 do
			local t = display.newImage("flower/f"..i.."M.png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*4
			t.y = yInset
			t:scale(scaleS,scaleS)
			t.alpha = 1
			t.pos = i
			whites[#whites+1] = t
			sceneGroup:insert(t)
		
		end
		mask = {{288,566},{288,714},{288,884},{210,421},{109,263},{396,425},{498,275},{398,105},{211,105},{131,661},{456,621},{301,279},{403,960},{182,959}}
		amount = 14
	elseif numb == 2 then
		local t = display.newImage("house/h1.png")
		t.alpha = 0
		scaleS = (display.contentHeight - xInset)/t.contentHeight
		t:removeSelf()
		for i =1,7 do
			
			local t = display.newImage("house/h"..i..".png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*4
			t.y = yInset
			t:scale(scaleS,scaleS)
			t.alpha = 0
			
			collide[#collide+1] = t
			sceneGroup:insert(t)
		end
		
		for i =1,7 do
			local t = display.newImage("house/h"..i.."M.png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*4
			t.y = yInset
			t:scale(scaleS,scaleS)
			t.alpha = 1
			t.pos = i
			whites[#whites+1] = t
			sceneGroup:insert(t)
		
		end
		mask={{100,316},{99,215},{101,106},{102,316},{57,213},{143,214},{158,96}}
		amount = 7
	
	elseif numb == 3 then
		local t = display.newImage("rocket/r1.png")
		t.alpha = 0
		scaleS = (display.contentWidth/2 - xInset)/t.contentWidth
		t:removeSelf()
		for i =1,9 do
			local t = display.newImage("rocket/r"..i..".png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*2
			t.y = yInset
			t:scale(scaleS,scaleS)
			t.alpha = 0
			
			collide[#collide+1] = t
			sceneGroup:insert(t)
		end
		
		for i =1,9 do
			local t = display.newImage("rocket/r"..i.."M.png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*2
			t.y = yInset
			t:scale(scaleS,scaleS)
			t.alpha = 1
			t.pos = i
			whites[#whites+1] = t
			sceneGroup:insert(t)
		
		end
		
		mask={{271,311},{274,210},{271,552},{223,438},{324,428},{274,102},{419,456},{115,457},{273,258}}
		amount = 9
	elseif numb == 4 then	
		local t = display.newImage("sandcastle/s1.png")
		t.alpha = 0
		scaleS = (display.contentWidth/2)/t.contentWidth
		t:removeSelf()
		for i =1,16 do
			
			local t = display.newImage("sandcastle/s"..i..".png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*2
			t.y = yInset*3
			t:scale(scaleS,scaleS)
			t.alpha = 0
			
			collide[#collide+1] = t
			sceneGroup:insert(t)
		end
		
		for i =1,16 do
			local t = display.newImage("sandcastle/s"..i.."M.png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*2
			t.y = yInset*3
			t:scale(scaleS,scaleS)
			t.alpha = 1
			t.pos = i
			whites[#whites+1] = t
			sceneGroup:insert(t)
		
		end
		mask={{186,150},{640,158},{194,404},{636,405},{414,475},{643,249},{198,250},{791,57},{644,58},{496,55},{355,56},{206,57},{417,540},{50,57},{399,460},{441,463}}
	amount = 16
	elseif numb == 5 then	
		local t = display.newImage("train/t1.png")
		t.alpha = 0
		scaleS = (display.contentWidth/2)/t.contentWidth
		t:removeSelf()
		for i =1,14 do
			
			local t = display.newImage("train/t"..i..".png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset
			t.y = yInset*3
			t:scale(scaleS,scaleS)
			t.alpha = 0
			
			collide[#collide+1] = t
			sceneGroup:insert(t)
		end
		
		for i =1,14 do
			local t = display.newImage("train/t"..i.."M.png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset
			t.y = yInset*3
			t:scale(scaleS,scaleS)
			t.alpha = 1
			t.pos = i
			whites[#whites+1] = t
			sceneGroup:insert(t)
		
		end
		
		mask={{800,420},{382,497},{856,288},{735,288},{657,116},{783,160},{910,159},{288,80},{98,577},{288,245},{244,616},{426,617},{616,608},{807,610}}
		amount = 14
	elseif numb == 6 then	
		local t = display.newImage("building/b1.png")
		t.alpha = 0
		scaleS = (display.contentHeight - xInset)/t.contentHeight
		t:removeSelf()
		for i =1,24 do
			
			local t = display.newImage("building/b"..i..".png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*4
			t.y = yInset
			t:scale(scaleS,scaleS)
			t.alpha = 0
			
			collide[#collide+1] = t
			sceneGroup:insert(t)
		end
		for i =1,24 do
			local t = display.newImage("building/b"..i.."M.png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*4
			t.y = yInset
			t:scale(scaleS,scaleS)
			t.alpha = 1
			t.pos = i
			whites[#whites+1] = t
			sceneGroup:insert(t)
		
		end
		mask={{88,140},{88,372},{43,70},{89,70},{137,69},{43,117},{90,117},{136,118},{43,166},{90,166},{136,166},{40,215},{90,215},{135,214},{42,302},{88,302},{136,302},{42,350},{88,349},{136,350},{42,398},{89,396},{136,396},{90,460}}
		amount = 24
	elseif numb == 7 then	
		local t = display.newImage("lighthouse/L1.png")
		t.alpha = 0
		scaleS = (display.contentHeight - xInset)/t.contentHeight
		t:removeSelf()
		for i =1,16 do
			
			local t = display.newImage("lighthouse/L"..i..".png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*4
			t.y = yInset
			t:scale(scaleS,scaleS)
			t.alpha = 0
			
			collide[#collide+1] = t
			sceneGroup:insert(t)
		end
		
		for i =1,16 do
			local t = display.newImage("lighthouse/L"..i.."M.png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*4
			t.y = yInset
			t:scale(scaleS,scaleS)
			t.alpha = 1
			t.pos = i
			whites[#whites+1] = t
			sceneGroup:insert(t)
		
		end
		mask={{323,253},{323,569},{330,889},{468,1117},{200,1115},{330,575},{426,581},{228,579},{431,897},{330,895},{228,897},{268,251},{387,257},{330,55},{596,253},{41,253}}
		amount = 16
	elseif numb == 8 then	
		scaleS = 0.3
		for i =1,26 do
			
			local t = display.newImage("robot/r"..i..".png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*4
			t.y = yInset
			t:scale(0.3,0.3)
			t.alpha = 0
			
			collide[#collide+1] = t
			sceneGroup:insert(t)
		end
		
		for i =1,26 do
			local t = display.newImage("robot/r"..i.."M.png")
			t.anchorX = 0
			t.anchorY = 0
			t.x = xInset*4
			t.y = yInset
			t:scale(0.3,0.3)
			t.alpha = 1
			t.pos = i
			whites[#whites+1] = t
			sceneGroup:insert(t)
		
		end
		amount = 26
	end
end
function findShape(startpos,endpos,x,y,tolerance)
	for i=startpos,endpos do
		if(x < collide[i].x + mask[i][1]*scaleS + tolerance and x > collide[i].x + mask[i][1]*scaleS - tolerance and y < collide[i].y + mask[i][2]*scaleS + tolerance and y > collide[i].y + mask[i][2]*scaleS - tolerance ) then
			whites[i].alpha = 0
			collide[i].alpha = 1
			mask[i][1] = -xInset*2
			mask[i][2] = -xInset*2
			return true
		end
	end
	return false
end
function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view
	
end
--local backgroundMusicMenu = audio.loadStream( "music.mp3" )
--local backgroundMusicChannelMenu = audio.play( backgroundMusicMenu, { loops=1, fadein=3000 } )

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
			shapes = {"flower/hexagon.png","flower/the circle.png","flower/oval.png",
		"flower/Parellelogram.png","flower/square.png","train/EvenTriangle.png","train/VRectangle.png"}
		elseif voltooivormbouvar == 2 then
			shapes = {"house/rectangle.png","house/square.png","house/triangle.png",
		"house/upright rectangle.png","train/RIghtTraingle.png","train/parallelogram.png","train/VRectangle.png"}
		elseif voltooivormbouvar == 3 then
			shapes = {"rocket/circle.png","rocket/rectangle.png","rocket/rectangle2.png",
		"rocket/triangle.png","rocket/triangle1.png","rocket/triangle2.png","train/parallelogram.png"}
		elseif voltooivormbouvar == 4 then
			shapes = {"sandcastle/halfmoon.png","sandcastle/hrectangle.png","sandcastle/quarter1.png",
		"sandcastle/quarter2.png","sandcastle/square1.png","sandcastle/uprightRectangle.png","train/parallelogram.png"}
		elseif voltooivormbouvar == 5 then
			shapes = {"train/1.png","train/EvenTriangle.png","train/HRectangle.png",
		"train/parallelogram.png","train/RIghtTraingle.png","train/square.png","train/VRectangle.png"}
		elseif voltooivormbouvar == 6 then
			shapes = {"building/rectangle.png","building/smaller rectangle.png","building/square.png",
		"train/parallelogram.png","train/RIghtTraingle.png"}
		elseif voltooivormbouvar == 7 then
			shapes = {"lighthouse/square1.png","lighthouse/square.png","lighthouse/rectangle.png","lighthouse/triangle.png",
		"lighthouse/semicircle1.png","lighthouse/semicircle2.png","lighthouse/semicircle3.png","lighthouse/arrow1.png","lighthouse/arrow2.png"}
		elseif voltooivormbouvar == 8 then
			shapes = {"robot/parrallel.png","sandcastle/hrectangle.png","robot/square.png","robot/halfcircle.png",
		"robot/diamond.png","robot/the circle.png","robot/circle_black.png","robot/triangle.png","robot/halfcircle_2.png","robot/halfcircle_2.png"}
		end

		
	    background = display.newImage("background.png")
		
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
		if(isPlayingBS)then
		musicO:toFront()
		else
		music:toFront()
		end
		if(voltooivormbouvar == 1) then
		isPlayingBS = true
		local backgroundMusicChannelMenu = audio.play( backgroundMusicMenu, { loops=1, fadein=3000,onComplete = function() isPlayingBS = false 
		music:toFront()
		end } )
		end
		sceneGroup:insert(display.newRect(display.contentWidth-display.actualContentWidth*1/6,display.contentHeight/2,display.actualContentWidth*1/3,display.actualContentHeight))
		
		for i = -(#shapes/2), #shapes/2-1 do
			print(shapes[#shapes/2+i+1])
			local l = display.newImage(shapes[#shapes/2+i+1])
			
			local scaleF 
			if voltooivormbouvar == 5 then
				scaleF = shapeHeight/l.contentWidth
				l:scale(scaleF,scaleF)
			else
				if i == #shapes/2-1 then
					scaleF = shapeHeight/l.contentWidth
					l:scale(scaleF,scaleF)
				else
					scaleF = shapeHeight/l.contentHeight
					l:scale(scaleF,scaleF)
				end
				if i==-(#shapes/2) and voltooivormbouvar==4 then
					scaleF =0.5
					l:scale(scaleF,scaleF)
				end
			end
			l.y = 2*margin*i+shapeHeight*(i-1) --+ l.contentHeight/2
			l.x = display.actualContentWidth*5/6
			l.tag = shapes[#shapes/2+i+1]
			l.origx = l.x
			l.origy = l.y
			l.origScaleF = scaleF
			
			group:insert(l)
			
			function listen( event )
			 --if(isTransition==false)then
					if event.phase == "began" then
						w = true
						event.target.markY = event.target.y    -- store y location of object
						event.target.markX = event.target.x
						display.getCurrentStage():setFocus( event.target )
						--event.target.isFocus = true
						--display.getCurrentStage():setFocus( event.target )
						local chosen = math.random(1,3)
						target = event.target
						curShape = event.target.tag
						print(curShape)
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
						group:insert(cursprite)
						cursprite:play()
						
						
					elseif event.phase == "moved" then
						-- if event.target == target then
						
						if target==nil or event.target == nil or cursprite == nil then	
							--print("maybe")
							return
						end
						local y = (event.y - event.yStart) + target.markY
						local x = (event.x - event.xStart) + target.markX
						--print("event.x = "..event.x)
						--print("target.x - target.width = "..(target.x -20))
						
						target.y = y    -- move object based on calculations above
						target.x = x
						if(cursprite~= nil)then
						cursprite.x = target.x
						cursprite.y = target.y
						end
						
						
						
					elseif event.phase == "ended"  then
							print("ended")
							
								--removeListeners()
								if cursprite then
								cursprite:removeSelf()
								cursprite = nil
								end
							if(numb == 1 and curShape == "flower/Parellelogram.png") then
								if(findShape(1,3,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
								
							elseif(numb == 1 and curShape == "flower/the circle.png") then
								if(findShape(4,9,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
								
							elseif(numb == 1 and curShape == "flower/oval.png")then
								if(findShape(10,11,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 1 and curShape == "flower/hexagon.png")then
								if(findShape(12,12,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 1 and curShape == "flower/square.png")then
								if(findShape(13,14,event.x,event.y,xInset*2)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 1)  then
									showWrong(event.target)
							end
							
							if(numb == 2 and curShape == "house/rectangle.png") then
								if(findShape(1,2,event.x,event.y,xInset*3)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 2 and curShape == "house/triangle.png")then
								if(findShape(3,3,event.x,event.y,xInset*3)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 2 and curShape == "house/upright rectangle.png")then
								if(findShape(4,4,event.x,event.y,xInset)) then
								showCorrect(event)
								whites[1]:toBack()
								background:toBack()
								w = false
								elseif(findShape(7,7,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							
							elseif(numb == 2 and curShape == "house/square.png")then
								--print("touched")
								if(findShape(5,6,event.x,event.y,xInset)) then
								showCorrect(event)
								whites[2]:toBack()
								background:toBack()
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 2)  then
								showWrong(event.target)
							end
							if(numb == 3 and curShape == "rocket/rectangle.png") then
								if(findShape(1,3,event.x,event.y,xInset*2)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 3 and curShape == "rocket/rectangle2.png")then
								if(findShape(4,5,event.x,event.y,xInset*2)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 3 and curShape == "rocket/triangle.png")then
								if(findShape(6,6,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 3 and curShape == "rocket/triangle1.png")then
								if(findShape(7,7,event.x,event.y,xInset*2)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 3 and curShape == "rocket/triangle2.png")then
								if(findShape(8,8,event.x,event.y,xInset*2)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 3 and curShape == "rocket/circle.png")then
								if(findShape(9,9,event.x,event.y,xInset)) then
								whites[1]:toBack()
								whites[2]:toBack()
								background:toBack()
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb ==3)  then
								showWrong(event.target)
							end
							if(numb == 4 and curShape == "sandcastle/hrectangle.png") then
								if(findShape(1,2,event.x,event.y,xInset*2)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 4 and curShape == "sandcastle/uprightRectangle.png")then
								if(findShape(3,5,event.x,event.y,xInset*2)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 4 and curShape == "sandcastle/square1.png")then
								if(findShape(8,14,event.x,event.y,xInset)) then
								showCorrect(event)
								whites[5]:toBack()
								background:toBack()
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 4 and curShape == "sandcastle/quarter2.png")then
								if(findShape(15,15,event.x,event.y,xInset)) then
								showCorrect(event)
								whites[5]:toBack()
								background:toBack()
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 4 and curShape == "sandcastle/quarter1.png")then
								if(findShape(16,16,event.x,event.y,xInset)) then
								showCorrect(event)
								whites[5]:toBack()
								background:toBack()
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 4 and curShape == "sandcastle/halfmoon.png")then
								if(findShape(6,7,event.x,event.y,xInset)) then
								showCorrect(event)
								whites[3]:toBack()
								whites[4]:toBack()
								whites[1]:toBack()
								whites[2]:toBack()
								background:toBack()
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 4)  then
								showWrong(event.target)
							end
							if(numb == 5 and curShape == "train/1.png") then
								if(findShape(11,14,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 5 and curShape == "train/parallelogram.png") then
								if(findShape(5,7,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 5 and curShape == "train/EvenTriangle.png") then
								if(findShape(8,8,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 5 and curShape == "train/RIghtTraingle.png") then
								if(findShape(9,9,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 5 and curShape == "train/VRectangle.png") then
								if(findShape(10,10,event.x,event.y,xInset*2)) then
								showCorrect(event)
								w = false
								elseif(findShape(1,1,event.x,event.y,xInset*2)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 5 and curShape == "train/square.png") then
								if(findShape(3,4,event.x,event.y,xInset)) then
								showCorrect(event)
								whites[1]:toBack()
								background:toBack()
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 5 and curShape == "train/HRectangle.png") then
								if(findShape(2,2,event.x,event.y,xInset*2)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 5)  then
								showWrong(event.target)
							end
							if(numb == 6 and curShape == "building/rectangle.png") then
								if(findShape(1,2,event.x,event.y,xInset*2)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 6 and curShape == "building/smaller rectangle.png")then
								if(findShape(24,24,event.x,event.y,xInset)) then
								showCorrect(event)
								whites[2]:toBack()
								background:toBack()
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 6 and curShape == "building/square.png")then
								if(findShape(3,23,event.x,event.y,xInset)) then
								whites[1]:toBack()
								whites[2]:toBack()
								background:toBack()
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 6)  then
								showWrong(event.target)
							end
							if(numb == 7 and curShape == "lighthouse/square1.png") then
								if(findShape(2,3,event.x,event.y,xInset*2)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 7 and curShape == "lighthouse/square.png")then
								if(findShape(1,1,event.x,event.y,xInset*2)) then
								showCorrect(event)
								-- whites[13]:toBack()
								-- background:toBack()
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 7 and curShape == "lighthouse/triangle.png")then
								if(findShape(6,11,event.x,event.y,xInset)) then
								showCorrect(event)
								whites[2]:toBack()
								whites[3]:toBack()
								background:toBack()
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 7 and curShape == "lighthouse/rectangle.png")then
								if(findShape(4,5,event.x,event.y,xInset*2)) then
								showCorrect(event)
								
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 7 and curShape == "lighthouse/semicircle1.png")then
								if(findShape(13,13,event.x,event.y,xInset)) then
								showCorrect(event)
								whites[1]:toBack()
								background:toBack()
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 7 and curShape == "lighthouse/semicircle2.png")then
								if(findShape(12,12,event.x,event.y,xInset)) then
								showCorrect(event)
								whites[1]:toBack()
								background:toBack()
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 7 and curShape == "lighthouse/semicircle3.png")then
								if(findShape(14,14,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 7 and curShape == "lighthouse/arrow1.png")then
								if(findShape(15,15,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 7 and curShape == "lighthouse/arrow2.png")then
								if(findShape(16,16,event.x,event.y,xInset)) then
								showCorrect(event)
								w = false
								else
								showWrong(event.target)
								end
							elseif(numb == 7) then
								showWrong(event.target)
							end
							
							if w == false then
							event.target.y = event.target.markY      -- store y location of object
							event.target.x = event.target.markX
							end
							curShape = nil
							target = nil
							display.getCurrentStage():setFocus( nil )
							self.isFocus = false
							--addListeners()
					end
				--end
				--return true
				
			end	
			
			l:addEventListener( "touch", listen )
			listeners[#listeners+1] = l
	
		end

		drag = display.newImage("drag.png")
		drag:scale(1/2,1/2)
		drag.y = display.contentHeight/2
		drag.x = display.contentWidth-display.actualContentWidth*1/3
		drag.name = "drag"
		local y = drag.y 
	        group.y = (y-display.contentHeight/2)*2 + display.contentHeight/1.5 + 25
	    
-- touch listener function
	function drag:touch( event )
	---if(isTransition == false)then
		if event.phase == "began" then
			
			if(event.target.name == "drag") then
			self.markY = self.y    -- store y location of object
			dragTarget = event.target.name
			display.getCurrentStage():setFocus( event.target, event.id )
			event.target.isFocus = true
			end
		elseif event.phase == "moved" then
			if self.markY==nil or event.target == nil then	
							--print("maybe")
							return
			end
		   local y = (event.y - event.yStart) + self.markY
			
			if (y > 0 + event.target.contentHeight/2 and y < display.actualContentHeight - event.target.contentHeight/2) then
			self.y =  y    -- move object based on calculations above
			
			--Transform function
			group.y = (y-display.contentHeight/2)*3.1 + display.contentHeight/1.5 + 35
			
			end
		end
	--end
    display.getCurrentStage():setFocus( nil )
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
		audio.dispose( backgroundMusicMenu )
		
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