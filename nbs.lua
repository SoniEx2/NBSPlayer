--[[
  NoteBlock Song API
  by MysticT
--]]

-- yield to avoid error
local function yield()
  os.queueEvent("fake")
  os.pullEvent("fake")
end

-- read short integer (16-bit) from file
local function readShort(file)
  return file.read() + file.read() * 256
end

-- read integer (32-bit) from file
local function readInt(file)
  return file.read() + file.read() * 256 + file.read() * 65536 + file.read() * 16777216
end

-- read string from file
local function readString(file)
  local s = ""
  local len = readInt(file)
  for i = 1, len do
    local c = file.read()
    if not c then
      break
    end
    s = s..string.char(c)
  end
  return s
end

-- read nbs file header
local function readNBSHeader(file)
  local header = {}
  header.lenght = readShort(file)
  header.height = readShort(file)
  header.name = readString(file)
  if header.name == "" then
    header.name = "Untitled"
  end
  header.author = readString(file)
  if header.author == "" then
    header.author = "Unknown"
  end
  header.original_author = readString(file)
  if header.original_author == "" then
    header.original_author = "Unknown"
  end
  header.description = readString(file)
  header.tempo = readShort(file) / 100
  header.autosave = file.read()
  header.autosave_duration = file.read()
  header.time_signature = file.read()
  header.minutes_spent = readInt(file)
  header.left_clicks = readInt(file)
  header.right_clicks = readInt(file)
  header.blocks_added = readInt(file)
  header.blocks_removed = readInt(file)
  header.filename = readString(file)
  return header
end

-- jump to the next tick in the file
local function nextTick(file, tSong)
  local jump = readShort(file)
  for i = 1, jump - 1 do
    table.insert(tSong, {})
  end
  return jump > 0
end

-- read the notes in a tick
local function readTick(file)
  local t = {}
  local jump = readShort(file)
  while jump > 0 do
    local instrument = file.read() + 1
    if instrument > 5 then
      return nil, "Can't convert custom instruments"
    end
    local note = file.read() - 33
    if note < 0 or note > 24 then
      return nil, "Notes must be in Minecraft's 2 octaves"
    end
    if not t[instrument] then
      t[instrument] = {}
    end
    table.insert(t[instrument], note)
    jump = readShort(file)
  end
  return t
end

-- API functions

-- save a converted song to a file
function saveSong(tSong, sPath)
  local file = fs.open(sPath, "w")
  if file then
    file.write(textutils.serialize(tSong))
    file.close()
    return true
  end
  return false, "Error opening file "..sPath
end

-- load and convert an .nbs file and save it
function load(sPath, bVerbose)
  local file = fs.open(sPath, "rb")
  if file then
    if bVerbose then
      print("Reading header...")
    end
    local tSong = {}
    local header = readNBSHeader(file)
    tSong.name = header.name
    tSong.author = header.author
    tSong.original_author = header.original_author
    tSong.lenght = header.lenght / header.tempo
    tSong.delay = 1 / header.tempo
    if bVerbose then
      print("Reading ticks...")
    end
    while nextTick(file, tSong) do
      local tick, err = readTick(file, tSong)
      if tick then
        table.insert(tSong, tick)
      else
        file.close()
        return nil, err
      end
      yield()
    end
    file.close()
    return tSong
  end
  return nil, "Error opening file "..sPath
end
