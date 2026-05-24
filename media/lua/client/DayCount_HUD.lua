DayCount_HUD = ISPanel:derive("DayCount_HUD")

local W      = 110
local H      = 62
local POS_FILE = "DayCount_pos.txt"

local function loadPos()
    local r = getFileReader(POS_FILE, true)
    if not r then return nil, nil end
    local line = r:readLine()
    r:close()
    if not line then return nil, nil end
    local x, y = line:match("^(-?%d+),(-?%d+)$")
    if x and y then return tonumber(x), tonumber(y) end
    return nil, nil
end

local function savePos(x, y)
    local w = getFileWriter(POS_FILE, true, false)
    if not w then return end
    w:write(math.floor(x) .. "," .. math.floor(y))
    w:close()
end

function DayCount_HUD:new()
    local sx = getCore():getScreenWidth()
    local px, py = loadPos()
    px = px or (sx - W - 12)
    py = py or 12
    local o = ISPanel.new(self, px, py, W, H)
    o.backgroundColor = { r=0, g=0, b=0, a=0 }
    o.borderColor     = { r=0, g=0, b=0, a=0 }
    o.movable         = true
    o.moveWithMouse   = true
    return o
end

function DayCount_HUD:onMouseUp(x, y)
    savePos(self:getAbsoluteX(), self:getAbsoluteY())
    ISPanel.onMouseUp(self, x, y)
end

function DayCount_HUD:render()
    local day = (getGameTime():getNightsSurvived() or 0) + 1
    self:drawRect(0, 0, self.width, self.height, 0.78, 0.04, 0.04, 0.04)
    self:drawRectBorder(0, 0, self.width, self.height, 1, 1, 0.82, 0.1)
    self:drawTextCentre("DAY", self.width / 2, 6, 1, 0.75, 0.1, 0.9, UIFont.Small)
    self:drawTextCentre(tostring(day), self.width / 2, 20, 1, 1, 0.9, 1, UIFont.Large)
end

local _instance = nil

local function onShow()
    if _instance then return end
    _instance = DayCount_HUD:new()
    _instance:initialise()
    _instance:addToUIManager()
end

Events.OnGameStart.Remove(onShow)
Events.OnGameStart.Add(onShow)
Events.OnLoad.Remove(onShow)
Events.OnLoad.Add(onShow)
