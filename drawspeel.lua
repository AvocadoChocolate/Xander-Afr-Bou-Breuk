local composer = require( "composer" )
local scene = composer.newScene()
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20
function scene:create( event )
	local sceneGroup = self.view
end

local curcol = "#000000"
local masks = {}
local img
local count = 0

local s = {"butterfly","car","fish"}
local selected
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
		
		selected = s[speelcounter]
		
		img = display.newImage(selected .. "h.png")
		img:scale(display.contentHeight*0.8/img.contentHeight,display.contentHeight*0.8/img.contentHeight)
		img.x = display.contentWidth/2
		img.y = display.contentHeight/2

		if selected == "car" then
			img.x = img.x - 7
		end


		
		sceneGroup:insert(background)
		home = display.newImage("Home_button.png")
		home:scale(0.4,0.4)
		home.y = home.y + yInset*2
		home.x = home.x + xInset*1.5

		function goHome()
			composer.removeScene("drawspeel")
			composer.gotoScene( "scene1" , "fade", 500)
			home.alpha = 0
			audio.pause(backgroundMusicChannel)
			timer.performWithDelay( 1000, (function(e) home.alpha = 0 end))
		end
		home:addEventListener("tap",goHome)
		sceneGroup:insert(home)
		sceneGroup:insert(line)
		sceneGroup:insert(img)
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
		
		for i = 1, 5 do
			masks[#masks+1] = display.newImage(selected .. i .. ".png")
			masks[#masks]:scale(display.contentHeight*0.8/masks[#masks].contentHeight,display.contentHeight*0.8/masks[#masks].contentHeight)
			masks[#masks].x = display.contentWidth/2
			masks[#masks].y = display.contentHeight/2
			masks[#masks].alpha = 0.5

			if selected == "car" and (i == 3  or i == 1 or i == 4 or i == 5) then
			masks[#masks].x = masks[#masks].x - 7
		--else
		--	masks[#masks].alpha = 0
			end
			if selected == "butterfly" and i == 3 then
			masks[#masks].y = masks[#masks].y + 0.1
			end
			if selected == "fish" and (i == 1 or i == 4 or i == 5) then
				masks[#masks].x = masks[#masks].x - 1
			end
			
			local l = masks[#masks]
			l:setMask(graphics.newMask( selected .. "m" .. i .. ".png" ))
			l.isHitTestMasked = true
			
			sceneGroup:insert(l)
			
			----------For butterfly only
			if (selected == "butterfly") then
				if (i == 1 or i == 2) then
				l.color = "#F6EB20"
				elseif (i == 4) then
				l.color = "#7E44BC"
				elseif (i == 3) then
				l.color = "#BC6EC7"
				elseif i == 5 then
				l.color = "#000000"
				end
			elseif (selected == "car") then
			--------------For car only
				if (i == 1) then
				l.color = "#F6EB20"
				elseif (i == 2) then
				l.color = "#09C5F4"
				elseif i == 3 then
				l.color = "#C91111"
				elseif i == 4 then
				l.color = "#CCCCCC"
				elseif i == 5 then
				l.color = "#CCCCCC"
				end
			elseif (selected == "fish") then
			---------------------For car only
				if (i == 1) then
				l.color = "#09C5F4"
				elseif (i == 2) then
				l.color = "#FF8000"
				elseif i == 3 then
				l.color = "#CCCCCC"
				elseif i == 4 then
				l.color = "#CCCCCC"
				elseif i == 5 then
				l.color = "#FF8000"
				end
			end
			
			function l:tap( event )
				if (curcol == l.color and event.target.alpha ~= 1 ) then
				event.target.alpha = 1
				count = count + 1
				
				if count == 5 then
					picker.alpha = 0

					local Sound = audio.loadSound( "success.mp3" )
                    		audio.play( Sound )

					timer.performWithDelay( 2000, (function()
						local imgtemp = display.newImage( selected .. ".png")
						imgtemp:scale(img.xScale,img.yScale)
						imgtemp.x = img.x
						imgtemp.y = img.y
						img.alpha = 0

						for i = 1,#masks do
							masks[i].alpha = 0
						end

						transition.scaleBy( imgtemp, { xScale=0.1, yScale=0.1} )
						transition.to( imgtemp, {delay = 1000, alpha = 0} )


							--------------Temp
							if speelcounter <= #s-1 then
								speelcounter = speelcounter+1
								audio:pause(backgroundMusicChannelMenu)
								timer.performWithDelay( 2000, (function()
							composer.removeScene("drawspeel")
							composer.gotoScene( "drawspeel" , "fade", 500)
								end))
							else
							audio:pause(backgroundMusicChannelMenu)
								speelcounter = 1
							timer.performWithDelay( 2000, (function()
							composer.removeScene("scene1")
							composer.gotoScene( "scene1" , "fade", 500) end))
						end
					end) )
					
				end
				return true
				end
			end	
	
			l:addEventListener( "tap", l )
			
		end
		
		picker = display.newImage("Color_picker_button.png")
		picker:scale(0.4,0.4)
		picker.x = display.actualContentWidth - xInset*2
		picker.y = picker.y + yInset*2
		sceneGroup:insert(picker)

		

		picker:addEventListener("tap",ShowPicker)
		
		saveimg = display.newImage("save_btn.png")
		saveimg:scale(0.4,0.4)
		saveimg.x = picker.x
		saveimg.y = display.actualContentHeight - yInset*2
		sceneGroup:insert(saveimg)

		saveimg:addEventListener("tap",SavePic)
	end
end

function SavePic()
	media.save( selected .. ".png")
end

function ShowPicker()
	local tpicker = require("colorPicker")
	local p = {}

	if selected == "butterfly" then
		p = tpicker.showPicker(1)
	else
		p = tpicker.showPicker(2)
	end

	home.alpha = 0
	picker.alpha = 0

	function cc(event)
		curcol = event.color
		home.alpha = 1
	picker.alpha = 1
		print(curcol)
	end

	p:addEventListener("colorChange",cc)
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