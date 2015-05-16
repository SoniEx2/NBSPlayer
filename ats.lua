--[[
  ATS - Advanced Timing System
  by SoniEx2
--]]
local function _round(_i)
  _i = _i * 20;
  if _i >= 0 then
    local x = math.floor(_i+.5)
    return x / 20, x
  else
    local x = math.ceil(_i-.5)
    return x / 20, x
  end
end

-- custom "working" sleep (can sleep 4-12 ticks without sleeping an extra tick)
local function sleepspecial(i)
  for _=1, i do
    sleep(0.05)
  end
end

function makesleeper()
  local total = 0
  local slept = 0
  local function wait(_sleep)
    if _sleep <= 0 then return end
    total = total + _sleep
    local f, i = _round(total - slept)
    slept = slept + f
    sleepspecial(i)
  end
  return wait
end
