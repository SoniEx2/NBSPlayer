-- os.loadAPI sucks >.>
local function loadAsModule(f)
  local x = assert(loadfile(f))
  local mt = {__index = getfenv()}
  local env = setmetatable({}, mt)
  setfenv(x, env)
  x()
  local ret = {}
  for k,v in pairs(env) do
    ret[k] = v
  end
  return ret
end

return {loadAsModule = loadAsModule}