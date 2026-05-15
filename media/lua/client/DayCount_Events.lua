local lastDay = 0

local function getInterval()
    local sv = SandboxVars and SandboxVars.DayCount
    if sv and sv.MilestoneInterval then
        return sv.MilestoneInterval
    end
    return 10
end

local function onEveryDay()
    if not getSpecificPlayer(0) then return end

    local day = (getGameTime():getNightsSurvived() or 0) + 1
    if day == lastDay then return end
    lastDay = day

    local interval = getInterval()
    if day > 1 and (day % interval) == 0 then
        DayCount_Popup.show(day)
    end
end

local function onInit()
    lastDay = (getGameTime():getNightsSurvived() or 0) + 1
end

Events.OnGameStart.Remove(onInit)
Events.OnGameStart.Add(onInit)
Events.OnLoad.Remove(onInit)
Events.OnLoad.Add(onInit)
Events.EveryDays.Remove(onEveryDay)
Events.EveryDays.Add(onEveryDay)
