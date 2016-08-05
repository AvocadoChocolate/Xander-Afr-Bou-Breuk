local composer = require( "composer" )
local scene = composer.newScene()
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20
function scene:create( event )
	local sceneGroup = self.view
end

local canvas
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
local backgroundMusicMenu = audio.loadStream( "music.mp3" )
local backgroundMusicChannelMenu = audio.play( backgroundMusicMenu, { loops=1, fadein=3000 } )
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	elseif phase == "did" then
		
		
		local background = display.newImage("background.png")
		
		local line = display.newImage("dashed_line.png")
		line:scale(display.actualContentHeight/line.contentHeight,display.actualContentHeight/line.contentHeight)
		line.x = display.contentWidth/2
		line.y = display.contentHeight/2
		
		background.x = display.contentWidth/2
		background.y = display.contentHeight/2
		
		sceneGroup:insert(background)
		sceneGroup:insert(line)
		local t = display.newImage("corner.png")
		t:scale(0.5,0.5)
		t.x = display.screenOriginX + display.actualContentWidth*0.05
		t.y = display.screenOriginY + display.actualContentHeight*0.2
		sceneGroup:insert(t)
		transition.to(t,{delay=3000,alpha=0})
		
		local t = display.newImage("corner.png")
		t:scale(-0.5,0.5)
		t.x = display.screenOriginX + display.actualContentWidth/2*0.9
		t.y = display.screenOriginY + display.actualContentHeight*0.2
		sceneGroup:insert(t)
		transition.to(t,{delay=3000,alpha=0})
		
		local t = display.newImage("corner.png")
		t:scale(0.5,-0.5)
		t.x = display.screenOriginX + display.actualContentWidth*0.05
		t.y = display.screenOriginY + display.actualContentHeight*0.8
		sceneGroup:insert(t)
		transition.to(t,{delay=3000,alpha=0})
		
		local t = display.newImage("corner.png")
		t:scale(-0.5,-0.5)
		t.x = display.screenOriginX + display.actualContentWidth/2*0.9
		t.y = display.screenOriginY + display.actualContentHeight*0.8
		sceneGroup:insert(t)
		transition.to(t,{delay=3000,alpha=0})
		
		local fingerPaint = require("fingerPaint")
		canvas = fingerPaint.newCanvas()
		sceneGroup:insert(canvas)
		
		picker = display.newImage("Color_picker_button.png")
		picker:scale(0.4,0.4)
		picker.x = display.actualContentWidth - xInset*2
		picker.y = picker.y + yInset*2
		sceneGroup:insert(picker)

		if (string.sub(system.getInfo("model"),1,4) == "iPad") then
	picker.x = display.actualContentWidth-picker.contentWidth
	end

		picker:addEventListener("tap",ShowPicker)

		restart = display.newImage("Restart_icon.png")
		restart:scale(0.4,0.4)
		restart.x = picker.x
		restart.y = display.actualContentHeight - yInset*2
		sceneGroup:insert(restart)

		restart:addEventListener("tap",(function(e) canvas:erase() end))
	end
	home = display.newImage("Home_button.png")
		home:scale(0.4,0.4)
		home.y = home.y + yInset*2
		home.x = home.x + xInset*1.5

		function goHome()
			composer.removeScene("drawself")
			composer.gotoScene( "scene1" , "fade", 500)
			home.alpha = 0
			audio.pause(backgroundMusicChannel)
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
		isPlaying=true
		
end

function ShowPicker()
	local tpicker = require("colorPicker")
	local p = tpicker.showPicker(2)
	
	home.alpha = 0
	picker.alpha = 0

	function cc(event)
		canvas:setPaintColor(convertHexToRGB(event.color))
		home.alpha = 1
	picker.alpha = 1
	end

	p:addEventListener("colorChange",cc)
end

function convertHexToRGB(hexCode)
print(hexCode)
   local hexCode = hexCode:gsub("#","")
   return tonumber("0x"..hexCode:sub(1,2))/255,tonumber("0x"..hexCode:sub(3,4))/255,tonumber("0x"..hexCode:sub(5,6))/255;
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