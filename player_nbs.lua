local playernbs = {}

local loadAsModule = dofile("loadasmodule.lua").loadAsModule
local nbs = loadAsModule("nbs.lua")
local ats = loadAsModule("ats.lua")

local NBS_MC_inst = {
  [1] = 0,
  [2] = 4,
  [3] = 1,
  [4] = 2,
  [5] = 3,
  [6] = 5,
  [7] = 6
}

local playNBSNote = function(id, subid, inst, note, volume)
  local mcinst = NBS_MC_inst[inst + 1]
  local mcnote = note - 33
  local mcvolume = volume / 100
  os.queueEvent("player:slave", id, subid, mcinst, mcnote, mcvolume)
end

local playNBSNotes = function(id, subid, inst, noteTable, tSong)

  local i = 0
  local layers = tSong.layers
  -- TODO figure out why ipairs() doesn't work
  for layer,note in pairs(noteTable) do
    i = i + 1
    playNBSNote(id, subid, inst, note + 33, layers[layer].volume)
  end
  for i=1,i do
    repeat
      local e, i, s = os.pullEvent("player:slave") -- wait for slaves
    until i == id and s == subid -- our slaves
  end
end

local playNBSInstruments = function(id, subid, instTable, tSong)

  os.queueEvent("player:monitor", id, subid, "pre")
  os.pullEvent("player:monitor") -- wait for monitor

  -- TODO figure out why ipairs() doesn't work
  for inst, notes in pairs(instTable) do
    playNBSNotes(id, subid, inst - 1, notes, tSong)
  end

  os.queueEvent("player:monitor", id, subid, "post")
  os.pullEvent("player:monitor") -- wait for monitor
  
end

playernbs.new = function(id, subid, filename, monitorSettings)
  return function()
    local tSong = assert(nbs.load(filename))

    local delay = tSong.delay
    local lenght = tSong.lenght
    local tps = 1/delay

    monitorSettings.length = lenght / delay
    monitorSettings.footerRight = tps .. " TPS"

    local row = 0

    local wait = ats.makesleeper()

    local startTime = os.clock()
    for _,tick in ipairs(tSong) do
      playNBSInstruments(id, subid, tick, tSong)
      row = row + 1
      wait(delay)
      if rs.getInput("front") then
        return
      end
    end
    local x = os.clock() - startTime
    print("Total time: ", x)
    local avgtps = row / x
    print("Average TPS: ", avgtps)
    local diff = avgtps - tps
    if diff >= 0.05 or diff <= -0.05 then
      print("WARNING")
      print("Song was expected to play at an average TPS of ", tps)
      print("Unless you've changed game tick rate, THIS IS A BUG!")
      print("Report it at https://github.com/SoniEx2/NBSPlayer")
    end
  end
end

return playernbs