-- Step One: put this lua file in your project's root directory
-- Step Two: require the module in your project as such:
	-- local fingerPaint = require("fingerPaint")
-- Step Three: create a finger painting "canvas" object as such:
	-- local canvas = fingerPaint.newCanvas()
	-- You can customize your canvas by including a single table as an argument when calling fingerPaint.newCanvas(). The table can include any of the following key/value pairs (but none are required):
		-- width: the width of your canvas. Defaults to the full screen width.
		-- height: the height of your canvas. Defaults to the full screen height.
		-- strokeWidth: the width of your fingerpainting "strokes," or the lines that the user draws. Defaults to 10 pixels.
		-- canvasColor: a table containing 4 numbers between 0 and 1, representing the RBGA values of your canvas' background color. Defaults to {1, 1, 1, 1} (white). TIP: Set the 4th value to 0 for a canvas with a transparent background.
		-- paintColor: a table containing 4 numbers between 0 and 1, representing the RBGA values of the "paint" color. Defaults to {0, 0, 0, 1} (black).
		-- segmented: a boolean (true/false) that, when set to true, results in paint strokes that are comprised of separate line object segments. USE WITH CAUTION: setting this value to true can substantially increase the memory usage of your app. Defaults to false.
		-- x: the x coordinate where you want your canvas to be placed. Defaults to the horizontal center of the screen.
		-- y: the y coordinate where you want your canvas to be placed. Defaults to the vertical center of the screen.
		-- isActive: a boolean (true/false) that disables painting when set to false, and enables painting when set to true. Defaults to true.
------------------------------------------------------------------------------------
-- CREATE TABLE TO HOLD MODULE
------------------------------------------------------------------------------------
local colorPicker = {}

------------------------------------------------------------------------------------
-- SCREEN POSITIONING VARIABLES
------------------------------------------------------------------------------------
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local screenTop = display.screenOriginY
local screenLeft = display.screenOriginX
local screenBottom = display.screenOriginY+display.actualContentHeight
local screenRight = display.screenOriginX+display.actualContentWidth
local screenWidth = screenRight - screenLeft
local screenHeight = screenBottom - screenTop

local colorsList = {"#51C201","#D84E09","#FF8000","#F6EB20",
"#C91111","#1C8E0D","#09C5F4","#2862B9","#7E44BC",
"#FFFFFF","#4C4646","#CCCCCC"}

local pickedColor = {}

function colorPicker.showPicker(col)

if col == nil then
elseif col == 1 then
colorsList = {"#FF8000","#D84E09","#C91111","#F6EB20",
"#51C201","#1C8E0D","#09C5F4","#BC6EC7","#7E44BC",
"#FFFFFF","#4C4646","#000000"}
elseif col == 2 then
	colorsList = {"#FF8000","#D84E09","#C91111","#F6EB20",
"#51C201","#1C8E0D","#09C5F4","#2862B9",
"#7E44BC","#FFFFFF","#CCCCCC","#4C4646"}
elseif col == 3 then
colorsList = {"#C91111","#D84E09","#FF8000","#F6EB20",
"#51C201","#1C8E0D","#09C5F4","#2862B9","#7E44BC",
"#FFFFFF","#4C4646","#000000"}
end

	local width = screenWidth
	local height = screenHeight

	local picker = display.newContainer(display.actualContentWidth*3, display.actualContentHeight*3)
	picker:translate( display.actualContentWidth*0.5, display.actualContentHeight*0.5 )
	
	local colors = display.newGroup()

	local background = display.newRect(picker, display.screenOriginX,display.screenOriginY,display.actualContentWidth, display.actualContentHeight)
	background:setFillColor(0.2,0.2,0.2,0.8)
	
	for i = 1, 4 do
		for ii = 1, 3 do
			local c = display.newCircle( display.actualContentWidth*0.18 + (display.contentWidth*0.75 - display.contentWidth*0.25)/2.5*(i-1) , display.actualContentHeight*0.25+(display.contentHeight*0.75 - display.contentHeight*0.25)/2*(ii-1), (display.contentWidth*0.75 - display.contentWidth*0.25)/7 )
			colors:insert(c)
			c.color = colorsList[3*(i-1)+ii]
			c:setFillColor(convertHexToRGB(colorsList[3*(i-1)+ii]))
			
			local function ctouch(event)
				pickedColor = c.color
				transition.to(colors,{alpha = 0})
				transition.to(picker,{alpha = 0})
				
				local event = { name="colorChange", color=c.color }
				picker:dispatchEvent( event )
				
				return true
			end
			
			c:addEventListener("tap",ctouch)
		end
	end
		
	local function touch(event)
		return true
	end
	picker:addEventListener("touch", touch)
	
	return picker
end


function convertHexToRGB(hexCode)
print(hexCode)
   local hexCode = hexCode:gsub("#","")
   return tonumber("0x"..hexCode:sub(1,2))/255,tonumber("0x"..hexCode:sub(3,4))/255,tonumber("0x"..hexCode:sub(5,6))/255;
end

return colorPicker