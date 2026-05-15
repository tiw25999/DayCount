DayCount_Popup = ISPanel:derive("DayCount_Popup")

local POP_W    = 230
local POP_H    = 54
local MARGIN_B = 62
local DURATION = 200

function DayCount_Popup:new(day)
    local sw = getCore():getScreenWidth()
    local sh = getCore():getScreenHeight()
    local x  = sw - POP_W - 10
    local y  = sh - POP_H - MARGIN_B
    local o  = ISPanel.new(self, x, y, POP_W, POP_H)
    o.day    = day
    o.timer  = DURATION
    o.backgroundColor = { r=0, g=0, b=0, a=0 }
    o.borderColor     = { r=0, g=0, b=0, a=0 }
    return o
end

function DayCount_Popup:render()
    self.timer = self.timer - 1
    local alpha = self.timer > 40 and 1.0 or (self.timer / 40)

    self:drawRect(0, 0, self.width, self.height, alpha * 0.78, 0.05, 0.05, 0.05)
    self:drawRectBorder(0, 0, self.width, self.height, alpha, 1, 0.82, 0.1)

    self:drawTextCentre(
        "Day " .. self.day .. "  —  Survived!",
        self.width / 2, 8,
        1, 0.85, 0.1, alpha, UIFont.Medium)

    self:drawTextCentre(
        "Milestone reached",
        self.width / 2, 30,
        0.75, 0.75, 0.75, alpha * 0.85, UIFont.Small)

    if self.timer <= 0 then
        self:removeFromUIManager()
    end
end

function DayCount_Popup.show(day)
    local sv = SandboxVars and SandboxVars.DayCount
    if sv and sv.EnableMilestonePopup == false then return end

    local pop = DayCount_Popup:new(day)
    pop:initialise()
    pop:addToUIManager()
end
