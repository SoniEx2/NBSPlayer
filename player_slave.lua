local playerslave = {}

playerslave.new = function(side, id, subid)
  return function()
    local modem = peripheral.wrap(side)

    local peripherals = modem.getNamesRemote()
    local nperipherals = #peripherals
    os.queueEvent("player:slaveinfo", id, subid, side, nperipherals)
    local idx = 1

    while true do

      local evt, p1_id, p2_subid, p3_inst, p4_note, p5_volume = os.pullEvent("player:slave")
      if id == p1_id and subid == p2_subid then

        modem.callRemote(peripherals[idx], "playNote", p3_inst, p4_note, p5_volume)
        idx = idx % nperipherals + 1

      end

    end
  end
end

return playerslave