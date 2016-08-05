---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

local speech = {"Puik.", "Fantasties.", "Uitstekend."}
local dialog = {}
local speechtext = {}

local instructionsset = {"Rangskik die diere van groot na klein.","Rangskik die diere van klein na groot"}

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

local images = {}
local shadow = {}

local sceneGroup

local animals = {1,2,3,4,5}
local markX
local kleinnagroot =  (math.random(1, 10) > 5)
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20
local justmoved = {}

local sheetInfo = require("animations")
		local myImageSheet = graphics.newImageSheet( "animations.png", sheetInfo:getSheet() )
		local cursprite

local instruction = instructionsset[(kleinnagroot and 1 or 0)+1]

local levels = {"thisorthat","hoeveelvorms","vormwatpas","patrone"}

math.randomseed( os.time() )

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

---------------------------------------------------------------------------------

local nextSceneButton
function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

local function recalibrate()

local animaltemp = {}
local min = {}

--Find justmoved first
local justindex = {}
local justindex2 = {}
local justimgindex = {}

for i = 1, #animals, 1 do
	if (animals[i] == justmoved) then
		justindex = i
	end
end

for i = 1, #images, 1 do
	if (images[i].tag == justmoved) then
		justimgindex = i
	end
end

--Now we need to swap it with some image
	for ii=1,#animals,1 do
		for x=1,#animals,1 do
			if table.contains(animaltemp,images[x].tag) then
			else
				min = images[x]
				break
			end
		end

		for i=1,#animals,1 do
			if images[i].x < min.x then
				if table.contains(animaltemp,images[i].tag) then
				else
					min = images[i]
				end
			end
		end
		animaltemp[ii] = min.tag
	end
	
	--Set up table, now find the new position for the moved image
	for i = 1, #animals, 1 do
	if (animaltemp[i] == justmoved) then
		justindex2 = i
	end
end
	print(justindex)
	print(justindex2)
--Swap the values
local t = animals[justindex]
animals[justindex] = animals[justindex2]
animals[justindex2] = t
--animals = animaltemp

local margin = display.contentWidth*0.10
        local position = display.contentWidth*0.2
        print("----------")
        for i=1,#animals do
        	--We need to move 
        	for y=1,#animals do
        	if (images[y].tag == animals[i]) then
				transition.to( images[y], { time=500, x=margin + position*(i-1) } )
				end
			end
		end
		
		--Check tint
		for i=1,#animals do
			if shadow[i].tag == animals[i] then
				shadow[i]:setFillColor( 0, 0.8, 0,0.8 )
				images[i].check:scale(shadow[i].contentWidth*0.8/images[i].check.contentWidth,shadow[i].contentWidth*0.8/images[i].check.contentWidth)
				images[i].check.x = shadow[i].x
				images[i].check.y = images[i].y
				images[i].check.alpha = 1
				sceneGroup:insert(images[i].check)
				else
				images[i].check.alpha = 0
				shadow[i]:setFillColor( 1,1,1 )
				end
				
		end

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
 

composer.removeScene("rangskik")
-- composer.removeScene("thisorthat")
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



local function CheckComplete()
local correct = true
for i=2,#animals,1 do

if kleinnagroot == true then
	if animals[i-1] > animals[i] then
		correct = false
	end
	else
	if animals[i-1] < animals[i] then
		correct = false
	end
	end
end

if correct then
math.randomseed( os.time() )
					local n = math.random(#levels)
					
for i=1,#animals do
shadow[i]:removeSelf()
shadow[i] = nil
end
local Sound = audio.loadSound( "success.mp3" )
                    		audio.play( Sound )
--composer.removeScene("scene1")
	--composer.gotoScene( "scene1" , "fade", 500)
if counter%5 == 0 then
counter = counter + 1
timer.performWithDelay(1000,playX)
else
timer.performWithDelay(1000,NextLv)
end

end
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
                    recalibrate()
                    CheckComplete()
    	end
    end
    
    return true
end


function scene:show( event )
    sceneGroup = self.view
    local phase = event.phase
    print(counter)
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
			composer.removeScene("rangskik")
			composer.gotoScene( "scene1" )
			home.alpha = 0
			--audio.resume(backgroundMusicChannel)
			--timer.performWithDelay( 1000, (function(e) home.alpha = 0 end))
			return true
		end
		home:addEventListener("tap",goHome)
		sceneGroup:insert(home)
    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
        --local text = self:getObjectByTag("textPlace")
        counter = counter + 1
        --if kleinnagroot then
        --text.text = "klein na groot"
        --else
        --text.text = "groot na klein"
        --end
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
        if kleinnagroot then
        	local s = audio.loadSound( "kleinnagroot.mp3" )
			audio.play( s )
        else
        	local s = audio.loadSound( "grootnaklein.mp3" )
			audio.play( s )
        end
        
        home.alpha = 1
        
        shuffleTable(animals)
        
        local margin = display.contentWidth*0.10
        local position = display.contentWidth*0.2
        
        local rand = math.random(6)
        if rand == 5 then
            rand = 6
        end
        --rand = 1
        
        for i=1,#animals do
        shadow[i] = display.newImage("shadow.png")
        if kleinnagroot == false then
        x = #animals+1 - i
        else
        x = i
        end
        
        if string.sub(system.getInfo("model"),1,4) == "iPad" then
        shadow[i]:scale(x/25,x/25)
        else
        shadow[i]:scale(x/15/2,x/15/2)
        end
        shadow[i].x = margin + position*(i-1)
        shadow[i].y = display.contentHeight/2 + display.contentHeight/4
        shadow[i].tag = x
        sceneGroup:insert(shadow[i])
        end
        
        for i=1,#animals do
        images[i] = display.newImage(rand .. ".png")
        if string.sub(system.getInfo("model"),1,4) == "iPad" then
        	--if (i == 1) then
        	--images[i]:scale(animals[i]/100*1.8*4/1.5*2,animals[i]/100*1.8*4/1.5*2)
        	--else


            --images[i].xScale
        		images[i]:scale(animals[i]/100*1.8*4/1.5*1.3,animals[i]/100*1.8*4/1.5*1.3)
        	--end
        else
        	--if (i == 1) then
        	--	images[i]:scale(animals[i]/100*1.2*8/1.5*2,animals[i]/100*1.2*8/1.5*2)
        	--else
            local maxsize = display.contentWidth/7

            images[i].xScale = animals[i]/maxsize*5
            images[i].yScale = animals[i]/maxsize*5
        		--images[i]:scale(animals[i]/100*1.2*8/1.5*1.3,animals[i]/100*1.2*8/1.5*1.3)
        	--end
        end
        
        images[i].x = margin + position*(i-1)
        
        images[i].y = display.contentHeight/2
        images[i].tag = animals[i]
        images[i].check = display.newImage("Correct_Done.png")
        sceneGroup:insert(images[i].check)
        images[i].check.alpha = 0
        images[i]:addEventListener( "touch", move )
        sceneGroup:insert(images[i])
        end       
        
        for i=1,#animals do
			if shadow[i].tag == animals[i] then
				shadow[i]:setFillColor( 0, 0.8, 0,0.8 )
				images[i].check:scale(images[i].contentWidth*0.8/images[i].check.contentWidth,images[i].contentWidth*0.8/images[i].check.contentWidth)
				images[i].check.x = images[i].x
				images[i].check.y = images[i].y
				images[i].check.alpha = 1
				sceneGroup:insert(images[i].check)
				else
				images[i].check.alpha = 0
				shadow[i]:setFillColor( 1,1,1 )
				end
				
		end
		
		--home = display.newImage("home.png")
        --home:scale(0.4,0.4)
        --home.x = -((display.actualContentWidth-display.contentWidth)/2-home.contentWidth/2)
        --home.y = home.y + home.contentHeight/2
		--home:addEventListener( "touch", tohome )
        
        
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
        
    for i=1,#images,1 do
    images[i]:removeSelf()
    end
        
		if nextSceneButton then
			nextSceneButton:removeEventListener( "touch", nextSceneButton )
		end
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
    
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------


return scene
