---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------
local speech = {"Puik.", "Fantasties.", "Uitstekend."}
local dialog = {}
local speechtext = {}

local sceneName = ...
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20
local sceneGroup
local shapeHeight = display.contentHeight/6
local margin2 = shapeHeight/6

local composer = require( "composer" )
local group = display.newGroup()

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

local sheetInfo = require("animations")
		local myImageSheet = graphics.newImageSheet( "animations.png", sheetInfo:getSheet() )
		local cursprite

local shapes = {"shapes/arrow2.png","shapes/circle.png","shapes/diamond.png","shapes/eye.png","shapes/halfmoon.png","shapes/hexagon.png","shapes/oval.png"
,"shapes/parellelogram.png","shapes/rectangle.png","shapes/square.png","shapes/triangle.png","shapes/uprightRectangle.png"}

local shapeHeight = display.contentHeight/6

local levels = {"thisorthat","hoeveelvorms","vormwatpas","rangskik"}

local images = {}
local top = {}
local bottom = {}
local line = {}
local img = {}

local animals = {1,2,3,4,5,6,7,8}
local markX
local pattern = {}
local n1 = {}
local n2 = {}
local n3 = {}
local done = false

--local levels = {"matchcol"}

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

local function choosePattern()
n1 = math.random(5)

repeat
n2 = math.random(5) 
until n1 ~= n2


n3 = math.random(5)

p1 = {n1, n2, n3, n1, n2, n3}
p2 = {n1, n2, n1, n2, n1, n2}
p3 = {n1, n2, n2, n1, n2, n2}
p4 = {n1, n2, n1, n1, n2, n1}
p5 = {n1, n1, n2, n1, n1, n2}
pp = {p1,p2,p3,p4,p5}

pattern = pp[math.random(5)]

--pattern[4] = pattern[1]
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
composer.removeScene("patrone")
-- composer.removeScene("hoeveelvorms")
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

local function CheckComplete(target)
local needed = pattern[6]

	local margin = display.contentWidth*0.10
        local position = display.contentWidth*0.2  

print(target.x .. "=" .. bottom[5].x)
if target.x > bottom[5].x and target.x < drag.x and needed == interpretTag(target.tag) then--and
  
  	local imgg = display.newImage(target.tag)
    imgg:scale(bottom[3].xScale/imgg.xScale,bottom[3].xScale/imgg.xScale)
    imgg.x = bottom[3].x
    imgg.y = bottom[4].y
    sceneGroup:insert(imgg)
                     
                     local Sound = audio.loadSound( "success.mp3" )
                    		audio.play( Sound )
                    		img.alpha = 0



local img = display.newImage("corners_vind_correct.png")
                        img.x = corner.x
                        img.y = corner.y
                        img:scale(0.26,0.3)
                        --sceneGroup:insert(img)
                        img:toFront()
                        transition.to(img,{delay = 500,alpha = 0})
                    		
                    		if counter%5 == 0 then
                    		counter = counter + 1
							timer.performWithDelay(1000,PlayX)
							else
							timer.performWithDelay(1000,NextLv)
							end
else

                    		local Sound = audio.loadSound( "fail.mp3" )
                    		audio.play( Sound )


                        local imgt = display.newImage("corners_vind_error.png")
                        imgt.x = corner.x
                        imgt.y = corner.y
                        imgt:scale(0.26,0.3)
                        sceneGroup:insert(imgt)
                        imgt:toFront()
                        transition.to(imgt,{delay = 500,alpha = 0})
                    		
                    		

for i=1,#images do
print("asdasdasd")
images[i].x = images[i].prevx
images[i].y = images[i].prevy
end
 end
end

local function move( event )
    if event.phase == "began" then
		
        event.target.markX = event.target.x    -- store x location of object
        event.target.markY = event.target.y
        
        display.getCurrentStage():setFocus( event.target, event.id )
		event.target.isFocus = true

	elseif event.target.isFocus then
	
    	if event.phase == "moved" then
	
        	local x = (event.x - event.xStart) + event.target.markX
        	local y = (event.y - event.yStart) + event.target.markY
        
        	event.target.x = x    -- move object based on calculations above
        	event.target.y = y 
    	elseif event.phase == "ended" or event.phase == "cancelled"  then
             
              -- here the focus is removed from the last position
                    display.getCurrentStage():setFocus( nil )
                    event.target.isFocus = false
                    CheckComplete()
    	end
    end
    
    return true
end

-- local function RemoveStuffies()
        -- home:removeSelf()
        -- home = nil
        
        -- media.stopSound()
-- end

-- local function tohome(event)
-- if ( event.phase == "began" ) then

        -- elseif ( event.phase == "moved" ) then
            -- print( "moved phase" )

        -- elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        -- RemoveStuffies()
            -- composer.gotoScene( "scene1", { effect = "fade", time = 300 } )
            
        -- end

    -- return true
-- end

function scene:show( event )
    sceneGroup = self.view
    local phase = event.phase
    print(counter)
    back = display.newImage("background.png")
    back.x = display.contentWidth/2
		back.y = display.contentHeight/2
		
    sceneGroup:insert(back)
	home = display.newImage("Home_button.png")
		home:scale(0.4,0.4)
		home.y = home.y + yInset*2
		home.x = home.x + xInset*1.5

		function goHome()
			composer.removeScene("patrone")
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
    elseif phase == "did" then
    
    counter = counter + 1
    choosePattern()
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc        
        local margin = display.contentWidth*0.2
        local position = display.contentWidth*0.2
        
        for i=1,#pattern do
        top[i] = display.newImage(shapes[pattern[i]])
        top[i].alpha = 0
        top[i]:scale(0.16/2,0.16/2)
        top[i].x = margin + position*(i-1)*5/3/2
        top[i].y = display.contentHeight/3-display.contentHeight/6
        top[i].tag = i
        sceneGroup:insert(top[i])
        end    
        
        for i=1,#pattern-1 do
        bottom[i] = display.newImage(shapes[pattern[i]])
        
        bottom[i]:scale(0.26*1.5/1.5,0.26*1.5/1.5)
       

        -- if (i <= 3) then
        -- bottom[i].y = display.contentHeight/4+20 +yInset
        -- bottom[i].x = 

        -- if (i <= 2) then
            -- bottom[i].x = bottom[i].x 
        -- end

        -- if (i == 1) then
            -- bottom[i].x = bottom[i].x 
        -- end

        -- else
         -- bottom[i].y = display.contentHeight/1.5+yInset
         -- bottom[i].x = display.contentWidth*(i-3)/5

         -- if (i == 4) then
            -- bottom[i].x = bottom[i].x 
        -- end

         -- end
		
		
		 if(i==1)then
			bottom[i].y = display.contentHeight/4+20 +yInset
			bottom[i].x = xInset*3
		 elseif(i==2)then
			bottom[i].y = display.contentHeight/4+20 +yInset
			bottom[i].x = xInset*3 + 110
		 elseif(i==3)then
			bottom[i].y = display.contentHeight/4+20 +yInset
		    bottom[i].x = xInset*3 + 220
		 elseif(i==4)then
		 bottom[i].y = display.contentHeight/1.5+yInset
		 bottom[i].x = xInset*3
		 else
		 bottom[i].y = display.contentHeight/1.5+yInset
		 bottom[i].x = xInset*3 + 110
		 end
        bottom[i].tag = animals[pattern[i]]
        local myRectangle = display.newRect( bottom[i].x, bottom[i].y, 100, 100)
		myRectangle.strokeWidth = 1
		myRectangle:setFillColor( 1 )
		myRectangle:setStrokeColor( 204/255, 204/255, 204/255 )
        sceneGroup:insert(myRectangle)
        
		
		sceneGroup:insert(bottom[i])
		
        end     
        
        img = display.newImage("q.png")
        img.x = xInset*3 + 220
        img:scale(0.3,0.3)
        --img:setFillColor(0,1,0)
        img.y = display.contentHeight/1.5+yInset
         
        
        local myRectangle = display.newRect( img.x, img.y, 100, 100)
		myRectangle.strokeWidth = 1
		myRectangle:setFillColor( 1 )
		myRectangle:setStrokeColor( 204/255, 204/255, 204/255 )
		sceneGroup:insert(myRectangle)     
        
        sceneGroup:insert(img)  

        corner = display.newImage("corners_vind.png")
            corner.x = img.x
            corner.y = img.y
            corner:scale(0.26,0.3)
            sceneGroup:insert(corner)
        
        
       sceneGroup:insert(display.newRect(display.contentWidth-display.actualContentWidth*1/8,display.contentHeight/2,display.actualContentWidth*1/4,display.actualContentHeight))
		
		
        for i = -(#shapes/2), #shapes/2-1 do
		print(#shapes/2+i+1)
			local l = display.newImage(shapes[#shapes/2+i+1])
			if i == #shapes/2-1 then
			l:scale(shapeHeight/l.contentWidth,shapeHeight/l.contentWidth)
			else
			l:scale(shapeHeight/l.contentHeight,shapeHeight/l.contentHeight)
			end

            

			l.y = margin2*i+shapeHeight*(i-1) + l.contentHeight/2
			l.x = display.contentWidth - display.actualContentWidth*1/8

           

			l.tag = shapes[#shapes/2+i+1]
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
		
					curspritescale = (event.target.contentWidth-10)/cursprite.contentWidth
					cursprite:scale(curspritescale,curspritescale)
					cursprite.x = event.target.x
					cursprite.y = event.target.y
					group:insert(cursprite)
					cursprite:play()
	
				elseif event.phase == "moved" then
					if(event.target.markY==nil)then
						return
					end
					local y = (event.y - event.yStart) + event.target.markY
					local x = (event.x - event.xStart) + event.target.markX
					
					cursprite.x = event.target.x
					cursprite.y = event.target.y
		
					event.target.y = y    -- move object based on calculations above
					event.target.x = x
				else
						cursprite:removeSelf()
             			cursprite = nil
					
					CheckComplete(event.target)
					display.getCurrentStage():setFocus( nil, event.id )
					event.target.isFocus = false
					self.x = self.markX
					self.y = self.markY
				end
	
				return true
			end	
	
			l:addEventListener( "touch", l )
	
		end
		
		drag = display.newImage("drag.png")
		drag:scale(1/2,1/2)
		drag.y = display.contentHeight/2
		drag.x = display.contentWidth-display.actualContentWidth*1/4

        
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

		local line = display.newLine(drag.x,-100,drag.x,display.actualContentHeight+1000)
		line:setStrokeColor(204/255,33/255,120/255)
		line.strokeWidth = 2
		sceneGroup:insert(line)

        sceneGroup:insert(drag)
		sceneGroup:insert(group)
        --line = display.newLine( -display.contentWidth, display.contentHeight-display.contentHeight/3, display.contentWidth*2, display.contentHeight-display.contentHeight/3 )
        --line.strokeWidth = 4
        --line.stroke.effect = "generator.marchingAnts"
        --line:setStrokeColor(0.81,0,0.435)
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
        
        if im then
        im:removeSelf()
        im = nil
        end
        
        for i=1,#pattern do
        top[i]:removeSelf()
        end    
        
        for i=1,#pattern-1 do
        bottom[i]:removeSelf()
        end  
        
        --line:removeSelf()
        --rect:removeSelf()
        
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

function interpretTag(name)
	if (name == "shapes/arrow2.png") then
	return 1
	elseif (name == "shapes/circle.png") then
	return 2
	elseif (name == "shapes/diamond.png") then
	return 3
	elseif (name == "shapes/eye.png") then
	return 4
	elseif (name == "shapes/halfmoon.png") then
	return 5
	elseif (name == "shapes/hexagon.png") then
	return 6
	elseif (name == "shapes/oval.png") then
	return 7
	elseif (name == "shapes/parellelogram.png") then
	return 8
	end
	return name
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------
--[[
Rectangle = {area = 0, length = 0, breadth = 0}

function Rectangle:new (o,length,breadth)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.length = length or 0
  self.breadth = breadth or 0
  self.area = length*breadth;
  return o
end

-- Derived class method printArea
function Rectangle:printArea ()
  print("The area of Rectangle is ",self.area)
end --]]


return scene
