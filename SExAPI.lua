--[[
  SExAPI
  By SoniEx2
--]]

local SEx = {}

if getfenv() ~= getfenv(0) then
  _G.SEx = SEx
end

SEx._VERSION = "SExAPI v1.0"
SEx.math = {}

do -- Math/s API
 local t = SEx.math
 -- https://en.wikipedia.org/wiki/Greatest_common_divisor#Using_Euclid.27s_algorithm
 local function gcd(a,b)
  if b == 0 then return a end
  -- Lua requires "a % b" to be defined as "a - math.floor(a/b)*b"
  -- so "a % b" is faster than "a - math.floor(a/b)*b"
  -- http://www.lua.org/manual/5.1/manual.html#2.5.1
  return gcd(b, a % b)
 end
 t.gcd = gcd
 -- https://en.wikipedia.org/wiki/Least_common_multiple#Reduction_by_the_greatest_common_divisor
 local function lcm(a,b)
  return (math.abs(a) / gcd(a,b)) * math.abs(b)
 end
 t.lcm = lcm
end

do -- Advanced monitor API
 SEx.monitor = {}
 SEx.monitor.wrap = function(side)
  local monitor = peripheral.wrap(side)
  local tMonitorObj = {}
  for k,v in pairs(monitor) do
   tMonitorObj[k] = v
  end
  -- START write
  local function write( sText )
   local w,h = tMonitorObj.getSize()		
   local x,y = tMonitorObj.getCursorPos()
   local nLinesPrinted = 0
   local function newLine()
    if y + 1 <= h then
     tMonitorObj.setCursorPos(1, y + 1)
    else
     tMonitorObj.setCursorPos(1, h)
     tMonitorObj.scroll(1)
    end
    x, y = tMonitorObj.getCursorPos()
    nLinesPrinted = nLinesPrinted + 1
   end
   -- Print the line with proper word wrapping
   while string.len(sText) > 0 do
    local whitespace = string.match( sText, "^[ \t]+" )
    if whitespace then
     -- Print whitespace
     tMonitorObj.write( whitespace )
     x,y = tMonitorObj.getCursorPos()
     sText = string.sub( sText, string.len(whitespace) + 1 )
    end
    local newline = string.match( sText, "^\n" )
    if newline then
     -- Print newlines
     newLine()
     sText = string.sub( sText, 2 )
    end
    local text = string.match( sText, "^[^ \t\n]+" )
    if text then
     sText = string.sub( sText, string.len(text) + 1 )
     if string.len(text) > w then
      -- Print a multiline word				
      while string.len( text ) > 0 do
       if x > w then
        newLine()
       end
       tMonitorObj.write( text )
       text = string.sub( text, (w-x) + 2 )
       x,y = tMonitorObj.getCursorPos()
      end
     else
      -- Print a word normally
      if x + string.len(text) - 1 > w then
       newLine()
      end
      tMonitorObj.write( text )
      x,y = tMonitorObj.getCursorPos()
     end
    end
   end
   return nLinesPrinted
  end
  -- END write
  -- START print
  tMonitorObj.print = function( ... )
   local nLinesPrinted = 0
   for n,v in ipairs( { ... } ) do
    nLinesPrinted = nLinesPrinted + write( tostring( v ) )
   end
   nLinesPrinted = nLinesPrinted + write( "\n" )
   return nLinesPrinted
  end
  -- END print
  -- START Misc color stuff
  if monitor.isColor() then
   local nativeSetTextColor = tMonitorObj.setTextColor
   local nativeSetBackgroundColor = tMonitorObj.setBackgroundColor
   local textColor
   local bgColor
   -- Color setters
   tMonitorObj.setTextColor = function(color)
    nativeSetTextColor(color)
    textColor = color
   end
   tMonitorObj.setBackgroundColor = function(color)
    nativeSetBackgroundColor(color)
    bgColor = color
   end
   -- Color resetters
   tMonitorObj.resetTextColor = function()
    nativeSetTextColor(colors.white)
    textColor = colors.white
   end
   tMonitorObj.resetBackgroundColor = function()
    nativeSetBackgroundColor(colors.black)
    bgColor = colors.black
   end
   -- Color getters
   tMonitorObj.getTextColor = function()
    return textColor
   end
   tMonitorObj.getBackgroundColor = function()
    return bgColor
   end
   -- print() with colors
   -- You can pass "0" as a color and it'll use the current instead
   tMonitorObj.colorPrint = function(fg, bg, ...)
    local fgc, bgc = textColor, bgColor
    if fg ~= 0 then
     tMonitorObj.setTextColor(fg)
    end
    if bg ~= 0 then
     tMonitorObj.setBackgroundColor(bg)
    end
    tMonitorObj.print(...)
    tMonitorObj.setTextColor(fgc)
    tMonitorObj.setBackgroundColor(bgc)
   end
    -- Map Colour to Color...
    -- This is only following the core ComputerCraft
    -- decision of using both color and colour for
    -- function and variable names...
    tMonitorObj.setTextColour = tMonitorObj.setTextColor
    tMonitorObj.resetTextColour = tMonitorObj.resetTextColor
    tMonitorObj.setBackgroundColour = tMonitorObj.setBackgroundColor
    tMonitorObj.resetBackgroundColour = tMonitorObj.resetBackgroundColor
    tMonitorObj.getTextColour = tMonitorObj.getTextColor
    tMonitorObj.getBackgroundColour = tMonitorObj.getBackgroundColor
    tMonitorObj.colourPrint = tMonitorObj.colorPrint
  end
  -- END Misc color stuff
  return tMonitorObj
 end
end

return SEx
