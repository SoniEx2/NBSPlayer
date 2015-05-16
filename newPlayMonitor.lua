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
}

-- os.loadAPI sucks >.>
local function loadAsModule(f)
  local x = assert(loadfile(f))
  local env = setmetatable({}, {__index = _G})
  setfenv(x, env)
  x()
  return setmetatable(env, nil)
end

local playerslave = dofile("player:slave.lua")
local playermonitor = dofile("player:monitor.lua")
local nbs = loadAsModule("nbs.lua")
local ats = loadAsModule("ats.lua")

local function play(filename)
  local id = {}
  -- nvm, os.queueEvent + os.pullEvent with `id` wouldn't work as CC makes copies of it instead of reusing...
  -- WHY CC, WHY? ;_;
  -- it also eats functions and has a 5 values limit because according to some ppl "dan was drunk when he wrote event stuff"
end