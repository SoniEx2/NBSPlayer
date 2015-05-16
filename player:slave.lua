local playerslave = {}

playerslave.new = function(side, id)
  return function()
    local modem = peripheral.wrap(side)

    local peripherals = modem.getNamesRemote()
    local nperipherals = #peripherals
    local idx = 1

    while true do
      local evt, p1_id, p2_inst, p3_note, p4_volume = os.pullEvent("player:slave")
      if id == p1_id then
        modem.call(peripherals[idx], "playNote", p2_inst, p3_note, p4_volume)
        idx = (idx % nperipherals) + 1
      end
    end
  end
end

return playerslave