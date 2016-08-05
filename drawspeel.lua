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

local s = {"rainbow","fish","butterfly","car"}
local selected
function toggleMusic()
		if (isPlayingDS) then
		audio.pause(backgroundMusicChannel)
		isPlayingDS = false
		music:toFront()
		else
		 backgroundMusicMenu = audio.loadStream( "music.mp3" )
		 local backgroundMusicChannelMenu = audio.play( backgroundMusicMenu, { loops=1, fadein=3000,onComplete = function() isPlayingDS = false 
		music:toFront()
		end } )
		--audio.play( backgroundMusicMenu, { loops=1, fadein=3000 } )
		isPlayingDS = true
		musicO:toFront()
		end
		return true
end
local backgroundMusicMenu = audio.loadStream( "music.mp3" )
--local backgroundMusicChannelMenu = audio.play( backgroundMusicMenu, { loops=1, fadein=3000 } )
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
		img:scale(0.4,0.4)
		img.x = display.contentWidth/2 - img.contentWidth/2 +2
		img.y = display.contentHeight/2

		-- if selected == "car" then
			-- img.x = img.x - 7
		-- end


		
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
			return true
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
		if(isPlayingDS)then
		musicO:toFront()
		else
		music:toFront()
		end
		if(speelcounter == 1) then
		isPlayingDS = true
		local backgroundMusicChannelMenu = audio.play( backgroundMusicMenu, { loops=1, fadein=3000,onComplete = function() isPlayingDS = false 
			music:toFront()
		end } )
		end
		if selected == "rainbow" then
			for i =1,7 do
				masks[#masks+1] = display.newImage("rainbow"..i..".png")
				

				masks[#masks].alpha = 0.5

				local name = "rainbow"..i.."M.png"
				print(name)
				masks[#masks]:setMask( graphics.newMask( name ) )
				masks[#masks].isHitTestMasked = true
				--car.alpha = 1

				masks[#masks]:scale(0.4,0.4)
				masks[#masks].x = display.contentWidth/2+masks[#masks].contentWidth/2
				masks[#masks].y = display.contentHeight/2
				sceneGroup:insert(masks[#masks])
				local l = masks[#masks]
				if (i == 1) then
					l.color = "#7E44BC"
					elseif (i == 2) then
					l.color = "#2862B9"
					elseif i == 3 then
					l.color = "#09C5F4"
					elseif i == 4 then
					l.color = "#51C201"
					elseif i == 5 then
					l.color = "#F6EB20"
					elseif i == 6 then
					
					l.color = "#FF8000"
					elseif i == 7 then
					l.color = "#C91111"
					
				end
				
				local function ShowCorrect(obj)
					local d = display.newImage("Correct_Done.png")
					d.alpha = 1
					--d:scale(d.contentWidth/cursprite.contentWidth/8,d.contentWidth/cursprite.contentWidth/8)
					d.x = display.contentWidth/2
					d.y = display.contentHeight/2
					sceneGroup:insert(d)

					--timer.performWithDelay( 600, removeCorrect)
				end
				function l:tap( event )
					if (curcol == l.color and event.target.alpha ~= 1 ) then
					event.target.alpha = 1
					count = count + 1
					
					if count == 7 then
						picker.alpha = 0

						local Sound = audio.loadSound( "success.mp3" )
								audio.play( Sound )

						timer.performWithDelay( 500, (function()
							local imgtemp = display.newImage( "Rainbow.png")
							imgtemp:scale(img.xScale,img.yScale)
							imgtemp.x = display.contentWidth/2
							imgtemp.y = display.contentHeight/2
							sceneGroup:insert(imgtemp)
							img.alpha = 0

							for i = 1,#masks do
								masks[i].alpha = 0
							end
							if(car~=nil)then
							car.alpha = 0
							end
							-- transition.scaleBy( imgtemp, { xScale=0.1, yScale=0.1} )
							-- transition.to( imgtemp, {delay = 1000, alpha = 0} )
							ShowCorrect()

								--Temp
								if speelcounter <= #s-1 then
									speelcounter = speelcounter+1
									timer.performWithDelay( 500, (function()
								composer.removeScene("drawspeel")
								composer.gotoScene( "drawspeel" , "fade", 500)
									end))
								else
									speelcounter = 1
								timer.performWithDelay( 500, (function()
								composer.removeScene("drawspeel")
								composer.gotoScene( "scene1" , "fade", 500) end))
							end
						end) )
						
					end
					return true
					end
				end	
		
				l:addEventListener( "tap", l )
			end
			local car = display.newImage("rainbowF.png")
			car:scale(0.4,0.4)
			car.x = display.contentWidth/2+car.contentWidth/2
			car.y = display.contentHeight/2
			sceneGroup:insert(car)
		end
		if selected == "car" then
			for i =1,8 do
				masks[#masks+1] = display.newImage("car"..i..".png")
				

				masks[#masks].alpha = 0.5

				local name = "car"..i.."M.png"
				print(name)
				masks[#masks]:setMask( graphics.newMask( name ) )
				masks[#masks].isHitTestMasked = true
				--car.alpha = 1

				masks[#masks]:scale(0.4,0.4)
				masks[#masks].x = display.contentWidth/2+masks[#masks].contentWidth/2
				masks[#masks].y = display.contentHeight/2
				sceneGroup:insert(masks[#masks])
				local l = masks[#masks]
				if (i == 1) then
					l.color = "#F6EB20"
					elseif (i == 5) then
					l.color = "#09C5F4"
					elseif i == 3 or i==2 or i == 7 then
					l.color = "#C91111"
					elseif i == 4 then
					-- light gray vendor
					l.color = "#CCCCCC"
					elseif i == 6 or i == 8 then
					
					l.color = "#4C4646"
				end
				
				local function ShowCorrect(obj)
					local d = display.newImage("Correct_Done.png")
					d.alpha = 1
					--d:scale(d.contentWidth/cursprite.contentWidth/8,d.contentWidth/cursprite.contentWidth/8)
					d.x = display.contentWidth/2
					d.y = display.contentHeight/2
					sceneGroup:insert(d)

					--timer.performWithDelay( 600, removeCorrect)
				end
				function l:tap( event )
					if (curcol == l.color and event.target.alpha ~= 1 ) then
					event.target.alpha = 1
					count = count + 1
					
					if count == 8 then
						picker.alpha = 0

						local Sound = audio.loadSound( "success.mp3" )
								audio.play( Sound )

						timer.performWithDelay( 500, (function()
							local imgtemp = display.newImage( "car.png")
							imgtemp:scale(img.xScale,img.yScale)
							imgtemp.x = display.contentWidth/2
							imgtemp.y = display.contentHeight/2
							sceneGroup:insert(imgtemp)
							img.alpha = 0

							for i = 1,#masks do
								masks[i].alpha = 0
							end
							if(car~=nil)then
							car.alpha = 0
							end
							-- transition.scaleBy( imgtemp, { xScale=0.1, yScale=0.1} )
							-- transition.to( imgtemp, {delay = 1000, alpha = 0} )
							ShowCorrect()

								--Temp
								if speelcounter <= #s-1 then
									speelcounter = speelcounter+1
									timer.performWithDelay( 500, (function()
								composer.removeScene("drawspeel")
								composer.gotoScene( "drawspeel" , "fade", 500)
									end))
								else
									speelcounter = 1
								timer.performWithDelay( 500, (function()
								composer.removeScene("drawspeel")
								composer.gotoScene( "scene1" , "fade", 500) end))
							end
						end) )
						
					end
					return true
					end
				end	
		
				l:addEventListener( "tap", l )
			end
			local car = display.newImage("carF.png")
			car:scale(0.4,0.4)
			car.x = display.contentWidth/2+car.contentWidth/2
			car.y = display.contentHeight/2
			sceneGroup:insert(car)
		end
		if selected == "butterfly" then
			for i =1,5 do
				masks[#masks+1] = display.newImage("butterfly"..i..".png")
				

				masks[#masks].alpha = 0.5

				local name = "butterfly"..i.."M.png"
				print(name)
				masks[#masks]:setMask( graphics.newMask( name ) )
				masks[#masks].isHitTestMasked = true
				--car.alpha = 1

				masks[#masks]:scale(0.4,0.4)
				masks[#masks].x = display.contentWidth/2+masks[#masks].contentWidth/2
				masks[#masks].y = display.contentHeight/2
				sceneGroup:insert(masks[#masks])
				local l = masks[#masks]
				if (i == 3 or i == 5) then
					l.color = "#F6EB20"
				elseif (i == 4) then
					l.color = "#7E44BC"
				elseif (i == 2) then
					l.color = "#BC6EC7"
				elseif i == 1 then
					l.color = "#4C4646"
				end
				
				local function ShowCorrect(obj)
					local d = display.newImage("Correct_Done.png")
					d.alpha = 1
					--d:scale(d.contentWidth/cursprite.contentWidth/8,d.contentWidth/cursprite.contentWidth/8)
					d.x = display.contentWidth/2
					d.y = display.contentHeight/2
					sceneGroup:insert(d)

					--timer.performWithDelay( 600, removeCorrect)
				end
				function l:tap( event )
					if (curcol == l.color and event.target.alpha ~= 1 ) then
					event.target.alpha = 1
					count = count + 1
					
					if count == 5 then
						picker.alpha = 0

						local Sound = audio.loadSound( "success.mp3" )
								audio.play( Sound )

						timer.performWithDelay( 500, (function()
							local imgtemp = display.newImage( "butterfly.png")
							imgtemp:scale(img.xScale,img.yScale)
							imgtemp.x = display.contentWidth/2
							imgtemp.y = display.contentHeight/2
							sceneGroup:insert(imgtemp)
							img.alpha = 0

							for i = 1,#masks do
								masks[i].alpha = 0
							end
							if(but~=nil)then
							but.alpha = 0
							end
							-- transition.scaleBy( imgtemp, { xScale=0.1, yScale=0.1} )
							-- transition.to( imgtemp, {delay = 1000, alpha = 0} )
							ShowCorrect()

								--Temp
								if speelcounter <= #s-1 then
									speelcounter = speelcounter+1
									timer.performWithDelay( 500, (function()
								composer.removeScene("drawspeel")
								composer.gotoScene( "drawspeel" , "fade", 500)
									end))
								else
									speelcounter = 1
								timer.performWithDelay( 500, (function()
								composer.removeScene("drawspeel")
								composer.gotoScene( "scene1" , "fade", 500) end))
							end
						end) )
						
					end
					return true
					end
				end	
		
				l:addEventListener( "tap", l )
			end
			local but = display.newImage("butterflyF.png")
			but:scale(0.4,0.4)
			but.x = display.contentWidth/2+but.contentWidth/2
			but.y = display.contentHeight/2
			sceneGroup:insert(but)
		end
		if selected == "fish" then
			for i =1,6 do
				masks[#masks+1] = display.newImage("fish"..i..".png")
				

				masks[#masks].alpha = 0.5

				local name = "fish"..i.."M.png"
				print(name)
				masks[#masks]:setMask( graphics.newMask( name ) )
				masks[#masks].isHitTestMasked = true
				--car.alpha = 1

				masks[#masks]:scale(0.4,0.4)
				masks[#masks].x = display.contentWidth/2+masks[#masks].contentWidth/2
				masks[#masks].y = display.contentHeight/2
				sceneGroup:insert(masks[#masks])
				local l = masks[#masks]
				if (i == 1) then
					l.color = "#09C5F4"
				elseif (i == 5) then
					l.color = "#FF8000"
				elseif i == 2 or i == 3 or i == 4 then
					l.color = "#4C4646"
				elseif i == 6 then
					l.color = "#FF8000"
				end
				
				local function ShowCorrect(obj)
					local d = display.newImage("Correct_Done.png")
					d.alpha = 1
					--d:scale(d.contentWidth/cursprite.contentWidth/8,d.contentWidth/cursprite.contentWidth/8)
					d.x = display.contentWidth/2
					d.y = display.contentHeight/2
					sceneGroup:insert(d)

					--timer.performWithDelay( 600, removeCorrect)
				end
				function l:tap( event )
					if (curcol == l.color and event.target.alpha ~= 1 ) then
					event.target.alpha = 1
					count = count + 1
					
					if count == 6 then
						picker.alpha = 0

						local Sound = audio.loadSound( "success.mp3" )
								audio.play( Sound )

						timer.performWithDelay( 500, (function()
							local imgtemp = display.newImage( "fish.png")
							imgtemp:scale(img.xScale,img.yScale)
							imgtemp.x = display.contentWidth/2
							imgtemp.y = display.contentHeight/2
							sceneGroup:insert(imgtemp)
							img.alpha = 0

							for i = 1,#masks do
								masks[i].alpha = 0
							end
							if(fish~=nil)then
							fish.alpha = 0
							end
							-- transition.scaleBy( imgtemp, { xScale=0.1, yScale=0.1} )
							-- transition.to( imgtemp, {delay = 1000, alpha = 0} )
							ShowCorrect()

								--Temp
								if speelcounter <= #s-1 then
									speelcounter = speelcounter+1
									timer.performWithDelay( 500, (function()
								composer.removeScene("drawspeel")
								composer.gotoScene( "drawspeel" , "fade", 500)
									end))
								else
									speelcounter = 1
								timer.performWithDelay( 500, (function()
								composer.removeScene("drawspeel")
								composer.gotoScene( "scene1" , "fade", 500) end))
							end
						end) )
						
					end
					return true
					end
				end	
		
				l:addEventListener( "tap", l )
			end
			local fish = display.newImage("fishF.png")
			fish:scale(0.4,0.4)
			fish.x = display.contentWidth/2+fish.contentWidth/2
			fish.y = display.contentHeight/2
			sceneGroup:insert(fish)
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