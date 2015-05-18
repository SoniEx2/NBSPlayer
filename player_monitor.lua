-- TODO much needed cleanup

local playermonitor = {}

local noteinfo = dofile("noteinfo.lua")

-- make it better
local indexedColors = {}
do
  local seen = {} -- treat colors.gray and colors.grey as the same
  local i = 0
  for k,v in pairs(colors) do
    if not seen[v] and type(v) == "number" then
      i = i + 1
      indexedColors[i] = v
      seen[v] = true
    end
  end
end
table.sort(indexedColors)
local maxColor = #indexedColors

local function monitor_print(monitor, str)
  local old = term.redirect(monitor) -- make print() use the monitor (monitors don't have a print())
  print(str .. "") -- do the print()
  term.redirect(old) -- restore
end

playermonitor.new = function(monitor, id, subid, settings)
  return function()
    local hasColor, title = settings.hasColor, settings.title

    if not hasColor then
      monitor.setTextColor(colors.white)
      monitor.setBackgroundColor(colors.black)
    end
    monitor.clear()
    monitor.setCursorPos(1,1)

    local fgColor, bgColor = 1, 2

    local notesPlayed, row = 0, 0

    local sizeX, sizeY = monitor.getSize()
    local halfSizeX = sizeX / 2

    local header = "Now playing: " .. title
    local headerXPos = halfSizeX - (#header / 2)

    local played, played2 = false, false

    while true do
      local evt, p1_id, p2_subid, p3_inst_or_state, p4_note, p5_volume = os.pullEvent()
      if id == p1_id and subid == p2_subid then
        if evt == "player:slave" then

          if played2 then
            played2 = false

            sizeX, sizeY = monitor.getSize()
            halfSizeX = sizeX / 2

            header = "Now playing: " .. title
            headerXPos = halfSizeX - (#header / 2)

            hasColor, title = settings.hasColor, settings.title

            if hasColor then
              bgColor = bgColor % maxColor + 1
              while bgColor == fgColor or indexedColors[bgColor] == colors.white do
                bgColor = bgColor % maxColor + 1
              end
              monitor.setBackgroundColor(indexedColors[bgColor])
            else
              monitor.setBackgroundColor(colors.black)
            end

            monitor.clear()
            monitor.setCursorPos(math.max(1, headerXPos), 1)
            monitor_print(monitor, header)
            local posX,posY = monitor.getCursorPos()
            monitor.setCursorPos(1, sizeY + 0)
            monitor.write(settings.footerLeft .. "")
            local str = settings.footerRight
            monitor.setCursorPos(sizeX - #str, sizeY + 0)
            monitor.write(str .. "")
            monitor.setCursorPos(posX, posY)
          end


          local inst, note = p3_inst_or_state, p4_note

          -- notes
          local str = noteinfo.instnames[inst+1] .. " " .. noteinfo.notenames[note+1]
          local _,pos = monitor.getCursorPos()
          monitor.setCursorPos(halfSizeX - string.len(str) / 2 + 0, pos + 0)

          if hasColor then
            fgColor = fgColor % maxColor + 1
            if fgColor == bgColor then fgColor = fgColor % maxColor + 1 end
            monitor.setTextColor(indexedColors[fgColor] + 0)
          end

          monitor_print(monitor, str)

          if hasColor then
            monitor.setTextColor(1)
          end

          notesPlayed = notesPlayed + 1

          played = true

        elseif evt == "player:monitor" and p3_inst_or_state == "pre" then
          if played then
            played = false
            played2 = true
          end
        elseif evt == "player:monitor" and p3_inst_or_state == "post" then

          -- done after playing (print notes played, etc)
          row = row + 1
          --local str = notesPlayed .. " notes played (" .. math.floor(row / settings.length * 1000) / 10 .."% completed)"
          local completed = math.floor(row / settings.length * 1000) / 10
          local str = string.format("%d notes played (%d%% completed)", notesPlayed, completed)
          local posX,posY = monitor.getCursorPos()
          monitor.setCursorPos(1,sizeY-1)
          monitor.clearLine()
          monitor.write(str .. "")
          monitor.setCursorPos(posX, posY)

        end
      end
    end
  end
end

return playermonitor