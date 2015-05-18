--[[
  playMonitor
  By SoniEx2
--]]

local args = {...} -- args table
if not args[4] then
  print("Usage: newPlayMonitor.lua <hasColor> <NBS file> <monitor> <slave...>")
  print("(Example: newPlayMonitor.lua 1 whatislove.nbs top left right)")
  return
end

local monitorBaseSettings = {
  hasColor = (args[1] == "true" or args[1] == "on" or args[1] == "1"),
  title = args[2],
  -- avoid errors
  footerLeft = "",
  footerRight = "",
}

local playerslave = dofile("player_slave.lua")
local playermonitor = dofile("player_monitor.lua")
local playernbs = dofile("player_nbs.lua")

local function play(filename, monside, ...)
  local id = os.clock() -- heh
  local subid = 1
  local maxsubid = 1
  
  local threads = {}
  
  local monitor = peripheral.wrap(monside)
  if peripheral.getType(monside) == "modem" then
    print(monitor.getNamesRemote())
    for k,v in pairs(monitor.getNamesRemote()) do
      print(k,v)
      table.insert(threads, playermonitor.new(peripheral.wrap(v), id, subid, monitorBaseSettings))
    end
  else
    table.insert(threads, monitor)
  end

  for i, side in ipairs({...}) do
    table.insert(threads, playerslave.new(side, id, subid))
  end

  table.insert(threads, playernbs.new(id, maxsubid, filename, monitorBaseSettings))

  table.insert(threads, function()
    local count = 0
    while true do
      local evt, p1_id, p2_subid, p3_side, p4_count = os.pullEvent("player:slaveinfo")
      if p1_id == id and p2_subid == subid then
        count = count + p4_count
      end
      monitorBaseSettings.footerLeft = count .. " note blocks connected"
    end
  end)
  
  parallel.waitForAny(unpack(threads))

  while not rs.getInput("front") do
    os.pullEvent("redstone")
  end
end

play(select(2, ...))