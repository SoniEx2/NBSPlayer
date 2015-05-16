local playermonitor = {}

local noteinfo = dofile("noteinfo.lua")

playermonitor.new = function(side, id, settings)
  return function()
    local monitor = peripheral.wrap(side)
    
    local hasColor, fgColor, bgColor = settings.hasColor, colors.white, colors.black
    
    while true do
      local evt, p1_id, p2_inst, p3_note, p4_volume = os.pullEvent()
      if id == p1_id then
        if evt == "player:slave" then
          -- note
        elseif evt == "player:monitor" then
          -- update monitor settings (done each tick)
        end
      end
    end
  end
end

return playermonitor