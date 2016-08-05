
local composer = require( "composer" )
local scene = composer.newScene( sceneName )
local xInset = display.contentWidth/20
local yInset = display.contentHeight/20


function scene:create( event )
    local sceneGroup = self.view
	local phase = event.phase
	
end

local levels = {"rangskik","thisorthat","hoeveelvorms","vormwatpas","patrone"}


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

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
	
	
	local background = display.newImage("background.png")
		
		background.x = display.contentWidth/2
		background.y = display.contentHeight/2
		sceneGroup:insert(background)
	
    if phase == "will" then
		local backgroundMusicMenu = audio.loadStream( "music.mp3" )
		local backgroundMusicChannelMenu = audio.play( backgroundMusicMenu, { loops=1, fadein=3000 } )
    elseif phase == "did" then
    
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
    local options = 
	{
		--parent = textGroup,
		text = "Hello Slimkop.\nKies 'n speletjie.",     
		x = xInset*9,
		y = yInset*18,
		width = 328,     --required for multi-line and alignment
		font = "TeachersPet",   
		fontSize = 22,
		align = "center"  --new alignment parameter
	}

local myText = display.newText( options )
myText.alpha =0
myText:setFillColor( 0, 0, 0 )


local shadow = display.newImage("speech.png")
shadow.x = myText.x
shadow.y = myText.y+2
shadow:setFillColor( 0.8 )
shadow.alpha = 0
shadow:scale(myText.contentWidth*1.2/shadow.contentWidth/2.4,myText.contentHeight*1.2/shadow.contentHeight)

local speech = display.newImage("speech.png")
speech.x = myText.x
speech.y = myText.y
speech.alpha = 0
speech:scale(myText.contentWidth*1.2/speech.contentWidth/2.4,myText.contentHeight*1.2/speech.contentHeight)

local xander = display.newImage("X3.png")
xander:scale(-speech.contentHeight/xander.contentHeight*2,speech.contentHeight/xander.contentHeight*2)
xander.x = speech.x + speech.contentWidth/1.3
xander.y = speech.y
xander.alpha = 0
sceneGroup:insert(xander)

transition.to(xander,{alpha=1,delay=1000})
transition.to(speech,{alpha=1,delay=1000})
--transition.to(shadow,{alpha=0,delay=3000})
transition.to(myText,{alpha=1,delay=1000})

sceneGroup:insert(shadow)
sceneGroup:insert(speech)
--sceneGroup:insert(spoly)
sceneGroup:insert(myText)
        
        bouVorm = display.newImage("Menu_vind_wat_pas.png")
		bouVorm.x =display.contentCenterX - xInset * 5.5
		bouVorm.y =display.contentCenterY - yInset * 6
		bouVorm.xScale = 0.3
		bouVorm.yScale = 0.3
		sceneGroup:insert(bouVorm)
        bouVoorwerp = display.newImage("Menu_bou_voorwerp.png")
		bouVoorwerp.x =display.contentCenterX + xInset * 0.5
		bouVoorwerp.y =display.contentCenterY - yInset * 6
		bouVoorwerp.xScale = 0.3
		bouVoorwerp.yScale = 0.3
		sceneGroup:insert(bouVoorwerp)
        tekenSpeelbeeld = display.newImage("Menu_teken_spieelbeeld.png")
		tekenSpeelbeeld.x =display.contentCenterX + xInset * 6.5
		tekenSpeelbeeld.y =display.contentCenterY - yInset * 6
		tekenSpeelbeeld.xScale = 0.3
		tekenSpeelbeeld.yScale = 0.3
		sceneGroup:insert(tekenSpeelbeeld)
        tekenSelf = display.newImage("Menu_teken_self.png")
		tekenSelf.x =display.contentCenterX - xInset * 5.5
		tekenSelf.y =display.contentCenterY + yInset * 2
		tekenSelf.xScale = 0.3
		tekenSelf.yScale = 0.3
		sceneGroup:insert(tekenSelf)
        games = display.newImage("Menu_Speletjies.png")
		games.x =display.contentCenterX + xInset * 0.5
		games.y =display.contentCenterY + yInset * 2
		games.xScale = 0.3
		games.yScale = 0.3
		sceneGroup:insert(games)
        bulldozer = display.newImage("Menu_breek.png")
        bulldozer.x =display.contentCenterX + xInset * 6.5
		bulldozer.y =display.contentCenterY + yInset * 2
		bulldozer.xScale = 0.3
		bulldozer.yScale = 0.3
		sceneGroup:insert(bulldozer)
		
        if bouVorm then
        	function bouVorm:tap ( event )
				audio:pause( backgroundMusicChannelMenu )
        	    composer.removeScene("scene1")
        		composer.gotoScene( "voltooivorm", { effect = "fade", time = 300 } )
				return true
        	end
        	bouVorm:addEventListener( "tap", bouVorm )
        end
		
        if bouVoorwerp then
            function bouVoorwerp:tap ( event )
			audio:pause(backgroundMusicChannelMenu)
				composer.removeScene("scene1")
				composer.gotoScene( "bouself", { effect = "fade", time = 300 } )
            end
            bouVoorwerp:addEventListener( "tap", bouVoorwerp )
        end
        
        if tekenSelf then
        	function tekenSelf:tap ( event )
			audio:pause(backgroundMusicChannelMenu)
        		composer.removeScene("scene1")
        		composer.gotoScene( "drawself", { effect = "fade", time = 300 } )
        	end
        	tekenSelf:addEventListener( "tap", tekenSelf )
        end
        
        if tekenSpeelbeeld then
        	function tekenSpeelbeeld:tap ( event )
			audio:pause(backgroundMusicChannelMenu)
        	composer.removeScene("scene1")
        		composer.gotoScene( "drawspeel", { effect = "fade", time = 300 } )
        	end
        	tekenSpeelbeeld:addEventListener( "tap", tekenSpeelbeeld )
        end
        
        if bulldozer then
        	function bulldozer:tap ( event )
				audio:pause(backgroundMusicChannelMenu)
        		composer.removeScene("scene1")
        		composer.gotoScene( "physicsgame", { effect = "fade", time = 300 } )
        	end
        	bulldozer:addEventListener( "tap", bulldozer )
        end
        
        if games then
        	function games:tap ( event )
				--composer.removeScene("vormwatpas")
        		--composer.gotoScene( "vormwatpas", { effect = "fade", time = 300 } )
        		
        		composer.removeScene("scene1")
        		composer.gotoScene( "patrone", { effect = "fade", time = 300 } )
        		audio:pause(backgroundMusicChannelMenu)
        		-- composer.removeScene("scene1")
        		-- composer.gotoScene( levels[math.random(#levels)], { effect = "fade", time = 300 } )
        	end
        	games:addEventListener( "tap", games )
        end
        
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
    elseif phase == "did" then
	
	
    end 
end

function scene:destroy( event )
    local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene