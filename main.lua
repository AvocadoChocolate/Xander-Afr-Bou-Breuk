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


local background = display.newImage("background.png")

background.x = display.contentWidth/2
background.y = display.contentHeight/2
background:toBack()

voltooivormvar = 1
voltooivormbouvar = 1
speelcounter = 1
counter =1

local music = nil
isPlayingVWP = true
isPlayingBS = true
isPlayingDS = true

