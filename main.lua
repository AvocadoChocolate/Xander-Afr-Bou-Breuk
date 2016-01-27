-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--BUGS
--Music image off then on other scene on 
-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
composer.gotoScene( "scene1" )
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20

--if (string.sub(system.getInfo("model"),1,4) == "iPad") then
	--home.x = home.x + home.contentWidth/1.2
	--end
local background = display.newImage("background.png")
		
		background.x = display.contentWidth/2
		background.y = display.contentHeight/2
	background:toBack()
-- home = display.newImage("Home_button.png")
-- home:scale(0.4,0.4)
-- home.y = home.y + yInset*2
-- home.x = home.x + xInset*1.5

-- function goHome()
    -- composer.removeScene("scene1")
	-- composer.gotoScene( "scene1" , "fade", 500)
	-- home.alpha = 0
	-- audio.resume(backgroundMusicChannel)
	-- timer.performWithDelay( 1000, (function(e) home.alpha = 0 end))
-- end

voltooivormvar = 1
voltooivormbouvar = 1
speelcounter = 1
counter =1
-- home:addEventListener("tap",goHome)
local music = nil
local isPlaying = true
-- local music = nil
 -- function addOnMusic()
		-- if music ~= nil then
		-- music.alpha = 0
		-- music:removeSelf()
		-- music = nil
		-- end
		-- music = display.newImage("Music_on.png")
		-- music:scale(0.4,0.4)
		-- music.y = display.actualContentHeight - yInset*2
		-- music.x = music.x+ xInset*1.5
		-- music:addEventListener("tap",toggleMusic)
		
		-- end

		-- function addOffMusic()
		-- if music ~= nil then
		-- music.alpha = 0
		-- music:removeSelf()
		-- music = nil
		-- end
		-- music = display.newImage("Music_off.png")
		-- music:scale(0.4,0.4)
		-- music.y = display.actualContentHeight - yInset*2
		-- music.x = music.x+ xInset*1.5
		-- music:addEventListener("tap",toggleMusic)
		
		-- end

		-- function toggleMusic()
			-- if (isPlaying) then
			-- audio.pause(backgroundMusicChannel)
			-- isPlaying = false
			-- addOffMusic()
			-- else
			-- audio.resume(backgroundMusicChannel)
			-- isPlaying = true
			-- addOnMusic()
			-- end
		-- end
		
	

--addOnMusic()
