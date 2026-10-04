-- ═══════════════════════════════════════════════════════════════
--  NEXUSHUB – FOOTAGESUS WINDUI
-- ═══════════════════════════════════════════════════════════════
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- ═══════════════════════════════════════════════════════════════
--  THEMES
-- ═══════════════════════════════════════════════════════════════
local function createTheme(name, colors)
    local theme = {}
    for key, value in pairs(WindUI:GetThemes().Dark) do
        theme[key] = value
    end
    theme.Name = name
    for key, value in pairs(colors) do
        theme[key] = value
    end
    WindUI:AddTheme(theme)
end

createTheme("Graphite", {
    Accent = Color3.fromRGB(58, 58, 62),
    Dialog = Color3.fromRGB(22, 22, 24),
    Outline = Color3.fromRGB(145, 145, 150),
    Text = Color3.fromRGB(232, 232, 235),
    Placeholder = Color3.fromRGB(118, 118, 124),
    Background = Color3.fromRGB(15, 15, 17),
    Button = Color3.fromRGB(82, 82, 88),
    Icon = Color3.fromRGB(174, 174, 180),
    Toggle = Color3.fromRGB(150, 150, 156),
    Slider = Color3.fromRGB(132, 132, 140),
    Checkbox = Color3.fromRGB(150, 150, 156),
    PanelBackground = Color3.fromRGB(22, 22, 25),
    PanelBackgroundTransparency = 0.56,
    TabBackground = Color3.fromRGB(38, 38, 42),
    TabBackgroundHover = Color3.fromRGB(72, 72, 78),
    TabBackgroundHoverTransparency = 0.72,
    TabBackgroundActive = Color3.fromRGB(92, 92, 100),
    TabBackgroundActiveTransparency = 0.52,
    TabTextTransparency = 0.05,
    TabTextTransparencyActive = 0,
    TabIconTransparency = 0.12,
    TabIconTransparencyActive = 0,
    TabBorderTransparency = 0.72,
    TabBorderTransparencyActive = 0.35,
    Primary = Color3.fromRGB(145, 145, 152)
})

createTheme("Deep Blue", {
    Accent = Color3.fromRGB(25, 42, 68),
    Dialog = Color3.fromRGB(10, 18, 31),
    Outline = Color3.fromRGB(75, 105, 145),
    Text = Color3.fromRGB(220, 231, 245),
    Placeholder = Color3.fromRGB(99, 119, 146),
    Background = Color3.fromRGB(6, 12, 22),
    Button = Color3.fromRGB(45, 69, 101),
    Icon = Color3.fromRGB(132, 158, 193),
    Toggle = Color3.fromRGB(69, 112, 168),
    Slider = Color3.fromRGB(62, 101, 154),
    Checkbox = Color3.fromRGB(69, 112, 168),
    PanelBackground = Color3.fromRGB(8, 16, 28),
    PanelBackgroundTransparency = 0.54,
    TabBackground = Color3.fromRGB(18, 34, 56),
    TabBackgroundHover = Color3.fromRGB(43, 72, 108),
    TabBackgroundHoverTransparency = 0.7,
    TabBackgroundActive = Color3.fromRGB(55, 91, 136),
    TabBackgroundActiveTransparency = 0.48,
    TabTextTransparency = 0.04,
    TabTextTransparencyActive = 0,
    TabIconTransparency = 0.1,
    TabIconTransparencyActive = 0,
    TabBorderTransparency = 0.68,
    TabBorderTransparencyActive = 0.3,
    Primary = Color3.fromRGB(69, 112, 168)
})

createTheme("Rose Gray", {
    Accent = Color3.fromRGB(111, 72, 88),
    Dialog = Color3.fromRGB(35, 24, 30),
    Outline = Color3.fromRGB(178, 137, 154),
    Text = Color3.fromRGB(242, 228, 234),
    Placeholder = Color3.fromRGB(151, 119, 132),
    Background = Color3.fromRGB(24, 16, 21),
    Button = Color3.fromRGB(126, 91, 106),
    Icon = Color3.fromRGB(202, 168, 182),
    Toggle = Color3.fromRGB(174, 119, 143),
    Slider = Color3.fromRGB(158, 108, 130),
    Checkbox = Color3.fromRGB(174, 119, 143),
    PanelBackground = Color3.fromRGB(32, 20, 27),
    PanelBackgroundTransparency = 0.52,
    TabBackground = Color3.fromRGB(58, 37, 47),
    TabBackgroundHover = Color3.fromRGB(105, 70, 84),
    TabBackgroundHoverTransparency = 0.68,
    TabBackgroundActive = Color3.fromRGB(132, 87, 106),
    TabBackgroundActiveTransparency = 0.46,
    TabTextTransparency = 0.03,
    TabTextTransparencyActive = 0,
    TabIconTransparency = 0.08,
    TabIconTransparencyActive = 0,
    TabBorderTransparency = 0.65,
    TabBorderTransparencyActive = 0.28,
    Primary = Color3.fromRGB(174, 119, 143)
})

WindUI:SetTheme("Graphite")

-- ═══════════════════════════════════════════════════════════════
--  HELPERS
-- ═══════════════════════════════════════════════════════════════
local function detectExecutorName()
    if type(getexecutorname) == "function" then
        local success, name = pcall(getexecutorname)
        if success and name ~= nil and tostring(name) ~= "" then
            return tostring(name)
        end
    end
    if type(identifyexecutor) == "function" then
        local success, name = pcall(identifyexecutor)
        if success and name ~= nil and tostring(name) ~= "" then
            return tostring(name)
        end
    end
    return "Unknown"
end

local executorName = detectExecutorName()

local notificationIcons = {
    done = "circle-check",
    warning = "triangle-alert",
    error = "circle-x",
    info = "info"
}

local function notify(config)
    config = config or {}
    return WindUI:Notify({
        Title = config.Title or "NexusHub",
        Content = config.Message or config.Content or "",
        Icon = notificationIcons[config.Type] or config.Icon or "bell",
        Duration = config.Duration or 4
    })
end

-- ═══════════════════════════════════════════════════════════════
--  SERVICES & STATE
-- ═══════════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local function isTargetEnemy(targetPlayer, mode, localPlayer)
    if mode == "FFA" then return true
    elseif mode == "Everyone" then return targetPlayer ~= localPlayer
    elseif mode == "Team-Based" then
        if localPlayer.Team and targetPlayer.Team then
            return localPlayer.Team ~= targetPlayer.Team
        end
        return false
    end
    return false
end

local aimbotState = {
    enabled = false, fovType = "Limited FOV", fovSize = 100,
    fovColor = Color3.fromRGB(128, 0, 128), smoothness = 1,
    targetPart = "Head", showFOV = false, visibilityCheck = false,
    teamCheckMode = "Team-Based"
}

local function safeCreateCircle()
    if Drawing and typeof(Drawing.new) == "function" then
        local ok, circle = pcall(function() return Drawing.new("Circle") end)
        if ok and circle then return circle end
    end
    return {Visible=false, Thickness=1, Color=Color3.fromRGB(255,255,255),
            Filled=false, Radius=0, Position=Vector2.new(0,0),
            Remove=function() end, Destroy=function() end}
end

local FOVring = safeCreateCircle()
FOVring.Visible = false
FOVring.Thickness = 2
FOVring.Color = aimbotState.fovColor
FOVring.Filled = false
FOVring.Radius = aimbotState.fovSize
FOVring.Position = workspace.CurrentCamera.ViewportSize / 2

local aimbotConnection

local function updateDrawings()
    local center = workspace.CurrentCamera.ViewportSize / 2
    if FOVring then
        FOVring.Position = center
        FOVring.Radius = aimbotState.fovSize
        FOVring.Color = aimbotState.fovColor
    end
end
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateDrawings)

local function CheckVisibility(part)
    local Cam = workspace.CurrentCamera
    local Params = RaycastParams.new()
    Params.FilterType = Enum.RaycastFilterType.Exclude
    Params.FilterDescendantsInstances = {LocalPlayer.Character}
    local Result = workspace:Raycast(Cam.CFrame.Position, part.Position - Cam.CFrame.Position, Params)
    if not Result then return true end
    return Result.Instance:IsDescendantOf(part.Parent)
end

local function getTargetPlayer(targetPart, fovSize, visibilityCheck, ignoreOnScreen)
    local camera = workspace.CurrentCamera
    local center = camera.ViewportSize / 2
    local closestDist = math.huge
    local closestPlayer = nil
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isTargetEnemy(player, aimbotState.teamCheckMode, LocalPlayer) then
            local char = player.Character
            if char then
                local part = char:FindFirstChild(targetPart)
                if part then
                    local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                    if ignoreOnScreen or onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                        if dist < fovSize and dist < closestDist then
                            if not visibilityCheck or CheckVisibility(part) then
                                closestDist = dist
                                closestPlayer = player
                            end
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

local function lookAt(targetPos, smoothness)
    local camera = workspace.CurrentCamera
    local direction = (targetPos - camera.CFrame.Position).Unit
    local targetCFrame = CFrame.lookAt(camera.CFrame.Position, camera.CFrame.Position + direction)
    camera.CFrame = camera.CFrame:Lerp(targetCFrame, smoothness)
end

aimbotConnection = RunService.RenderStepped:Connect(function()
    updateDrawings()
    if aimbotState.enabled then
        local fovSize = aimbotState.fovSize
        local ignoreOnScreen = false
        if aimbotState.fovType == "Full Screen" then
            fovSize = math.huge
        elseif aimbotState.fovType == "360 Degrees" then
            fovSize = math.huge
            ignoreOnScreen = true
        end
        FOVring.Visible = aimbotState.showFOV and aimbotState.enabled and aimbotState.fovType == "Limited FOV" or false
        local closest = getTargetPlayer(aimbotState.targetPart, fovSize, aimbotState.visibilityCheck, ignoreOnScreen)
        if closest and closest.Character and closest.Character:FindFirstChild(aimbotState.targetPart) then
            lookAt(closest.Character[aimbotState.targetPart].Position, aimbotState.smoothness)
        end
    else
        FOVring.Visible = false
    end
end)

-- ═══════════════════════════════════════════════════════════════
--  WINDOW
-- ═══════════════════════════════════════════════════════════════
local Window = WindUI:CreateWindow({
    Title = "NexusHub",
    Author = "Made by Unknown",
    Folder = "nexushub",
    ConfigName = "nexushub",
    Theme = "Graphite",
    ToggleKey = nil,
    HideOpenButtonOnClose = false,
    Size = UDim2.fromOffset(520, 405),
    MinSize = Vector2.new(440, 335),
    MaxSize = Vector2.new(650, 500),
    Icon = "rbxassetid://70486376205459",
    IconThemed = true,
    Background = "rbxassetid://104526290518522",
    BackgroundImageTransparency = 0.22,
    Transparent = false,
    Acrylic = false,
    SideBarWidth = 145,
    ElementsRadius = 12,
    ScrollBarEnabled = true,
    HideSearchBar = true,
    Resizable = true,
    ModernLayout = true,
    ModernLayoutMergeElements = false,
    HidePanelBackground = false,
    BottomDragBarEnabled = true,
    Topbar = { Height = 42, ButtonsType = "Default" },
    OpenButton = {
        Enabled = true,
        Title = "NexusHub",
        Icon = "rbxassetid://70486376205459",
        OnlyMobile = false,
        Draggable = true,
        Scale = 0.82,
        StrokeThickness = 1,
        Color = ColorSequence.new(Color3.fromRGB(118,118,124), Color3.fromRGB(164,164,170))
    }
})
Window:SetIconSize(30)
_G.SNG_SCRIPT_READY = true

local function syncLoadedControlEffects()
    if not Window.ConfigManager or type(Window.ConfigManager.GetAll) ~= "function" then return end
    local saved = Window.ConfigManager:GetAll() or {}
    if type(Window.ListFlags) ~= "function" then return end
    for _, flag in ipairs(Window:ListFlags()) do
        if saved[flag] ~= nil then
            local element = Window:GetFlagElement(flag)
            local elementType = element and element.__type
            local needsCallback = elementType == "Dropdown" or elementType == "Segmented"
                or elementType == "Colorpicker" or elementType == "Stats"
            if needsCallback and element and type(element.Callback) == "function" then
                local value = Window:GetFlag(flag)
                if value ~= nil then pcall(element.Callback, value) end
            end
        end
    end
end

-- ═══════════════════════════════════════════════════════════════
--  SECTION: MAIN
-- ═══════════════════════════════════════════════════════════════
local MainSection = Window:Section({ Title = "Main", })

-- ─── TAB: HOME  (vacío) ───
local HomeTab = MainSection:Tab({
    Title = "Home", Icon = "solar:home-2-bold",
    IconShape = "Square", Border = true,
})
-- (vacío por diseño)

-- ─── TAB: COMBAT ───
local CombatTab = MainSection:Tab({
    Title = "Combat", Icon = "solar:cursor-square-bold",
    IconShape = "Square", Border = true,
})

-- ▸ Aimbot
CombatTab:Space()
CombatTab:Divider({ Title = "Aimbot — Main Settings" })
CombatTab:Space()

CombatTab:Toggle({ Title = "Enable Aimbot", Flag = "AimSec1EnableAimbot1", Value = false,
    Callback = function(v) aimbotState.enabled = v end })
CombatTab:Space()
CombatTab:Toggle({ Title = "Wall Check", Flag = "AimSec1WallCheck1", Value = false,
    Callback = function(v) aimbotState.visibilityCheck = v end })
CombatTab:Space()
CombatTab:Dropdown({ Title = "Team Check Mode", Flag = "AimSec1TeamCheckMode2",
    Values = {"Team-Based","FFA","Everyone"}, Value = "Team-Based",
    Callback = function(v) aimbotState.teamCheckMode = v end })
CombatTab:Space()
CombatTab:Dropdown({ Title = "Target Part", Flag = "AimSec1TargetPart1",
    Values = {"Head","HumanoidRootPart","UpperTorso","LowerTorso"}, Value = "Head",
    Callback = function(v) aimbotState.targetPart = v end })
CombatTab:Space()
CombatTab:Slider({ Title = "Smoothness", Flag = "AimSec1Smoothness1",
    Value = {Min = 0.1, Max = 1, Default = 1}, Step = 0.01,
    Callback = function(v) aimbotState.smoothness = v end })

CombatTab:Space()
CombatTab:Divider({ Title = "Aimbot — FOV Settings" })
CombatTab:Space()

CombatTab:Toggle({ Title = "Show FOV", Flag = "AimSec2ShowFOV1", Value = false,
    Callback = function(v) aimbotState.showFOV = v end })
CombatTab:Space()
CombatTab:Dropdown({ Title = "FOV Mode", Flag = "AimSec2FOVMode1",
    Values = {"Limited FOV","Full Screen","360 Degrees"}, Value = "Limited FOV",
    Callback = function(v) aimbotState.fovType = v end })
CombatTab:Space()
CombatTab:Slider({ Title = "FOV Size", Flag = "AimSec2FOVSize1",
    Value = {Min = 20, Max = 500, Default = 100}, Step = 1,
    Callback = function(v)
        aimbotState.fovSize = v
        if FOVring then FOVring.Radius = v end
    end })
CombatTab:Space()
CombatTab:Colorpicker({ Title = "FOV Color", Flag = "AimSec2FOVColor1",
    Default = Color3.fromRGB(128, 0, 128),
    Callback = function(v)
        aimbotState.fovColor = v
        if FOVring then FOVring.Color = v end
    end })

-- ▸ Triggerbot
local triggerbotState = {
    enabled = false,
    teamCheck = "Team-Based",
    shotDelay = 0.2,
    isAlive = true
}

local function triggerbotIsEnemy(targetPlayer)
    if triggerbotState.teamCheck == "FFA" then return true
    elseif triggerbotState.teamCheck == "Everyone" then return targetPlayer ~= LocalPlayer
    elseif triggerbotState.teamCheck == "Team-Based" then
        return targetPlayer.Team ~= LocalPlayer.Team
    end
    return false
end

local function checkTriggerbotHealth()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.HealthChanged:Connect(function(health)
            triggerbotState.isAlive = health > 0
        end)
    end
end
LocalPlayer.CharacterAdded:Connect(checkTriggerbotHealth)
checkTriggerbotHealth()

RunService.RenderStepped:Connect(function()
    if triggerbotState.enabled and triggerbotState.isAlive then
        local mouse = LocalPlayer:GetMouse()
        local target = mouse.Target
        if target and target.Parent:FindFirstChild("Humanoid") and target.Parent.Name ~= LocalPlayer.Name then
            local targetPlayer = Players:FindFirstChild(target.Parent.Name)
            if targetPlayer and triggerbotIsEnemy(targetPlayer) then
                mouse1press()
                task.wait(triggerbotState.shotDelay)
                mouse1release()
            end
        end
    end
end)

CombatTab:Space()
CombatTab:Divider({ Title = "Triggerbot" })
CombatTab:Space()

CombatTab:Toggle({ Title = "Enable Triggerbot", Flag = "TrigSecEnableTriggerbot1", Value = false,
    Callback = function(v) triggerbotState.enabled = v end })
CombatTab:Space()
CombatTab:Dropdown({ Title = "Team Check Mode", Flag = "TrigSecTeamCheckMode3",
    Values = {"Team-Based","FFA","Everyone"}, Value = "Team-Based",
    Callback = function(v) triggerbotState.teamCheck = v end })
CombatTab:Space()
CombatTab:Slider({ Title = "Shot Delay (seconds * 10)", Flag = "TrigSecShotDelayseconds101",
    Value = {Min = 1, Max = 10, Default = 2}, Step = 1,
    Callback = function(v) triggerbotState.shotDelay = v / 10 end })

-- ▸ Visual / ESP
local ESPSettings = {
    Box = false,
    Names = false,
    TeamCheckMode = "Team-Based",
    Highlights = {
        Enabled = false,
        Color = Color3.fromRGB(255, 0, 0),
        Transparency = 0.5,
        TeamCheckMode = "Team-Based"
    }
}

local nameTagContainer = Instance.new("BillboardGui")
local playerNameLabel = Instance.new("TextLabel")
local boxContainer = Instance.new("BillboardGui")
local torsoHighlight = Instance.new("Frame")

nameTagContainer.Name = "NameTagESP"
nameTagContainer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
nameTagContainer.Active = true
nameTagContainer.AlwaysOnTop = true
nameTagContainer.LightInfluence = 1.000
nameTagContainer.Size = UDim2.new(0, 200, 0, 30)
nameTagContainer.StudsOffset = Vector3.new(0, 3, 0)
playerNameLabel.Name = "NameLabel"
playerNameLabel.Parent = nameTagContainer
playerNameLabel.BackgroundTransparency = 1
playerNameLabel.BorderSizePixel = 0
playerNameLabel.Size = UDim2.new(1, 0, 1, 0)
playerNameLabel.Font = Enum.Font.GothamBold
playerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
playerNameLabel.TextSize = 14
playerNameLabel.TextStrokeTransparency = 0.5
playerNameLabel.TextWrapped = true
playerNameLabel.TextTransparency = 1
boxContainer.Name = "BoxESP"
boxContainer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
boxContainer.Active = true
boxContainer.AlwaysOnTop = true
boxContainer.LightInfluence = 1.000
boxContainer.MaxDistance = 999999.000
boxContainer.Size = UDim2.new(4, 0, 6, 0)
torsoHighlight.Name = "TorsoHighlight"
torsoHighlight.Parent = boxContainer
torsoHighlight.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
torsoHighlight.BackgroundTransparency = 0.7
torsoHighlight.BorderSizePixel = 2
torsoHighlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
torsoHighlight.Size = UDim2.new(1, 0, 1, 0)

local function addESPToPlayer(targetPlayer)
    targetPlayer.CharacterAdded:Connect(function(character)
        task.wait(0.5)
        if character:FindFirstChild("Head") then
            local nameClone = nameTagContainer:Clone()
            nameClone.Parent = character:FindFirstChild("Head")
            nameClone:FindFirstChild("NameLabel").Text = targetPlayer.Name
        end
        if character:FindFirstChild("UpperTorso") then
            local boxClone = boxContainer:Clone()
            boxClone.Parent = character:FindFirstChild("UpperTorso")
        end
    end)
    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
        local nameClone = nameTagContainer:Clone()
        nameClone.Parent = targetPlayer.Character:FindFirstChild("Head")
        nameClone:FindFirstChild("NameLabel").Text = targetPlayer.Name
    end
    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("UpperTorso") then
        local boxClone = boxContainer:Clone()
        boxClone.Parent = targetPlayer.Character:FindFirstChild("UpperTorso")
    end
end

for _, targetPlayer in pairs(Players:GetPlayers()) do
    if targetPlayer ~= LocalPlayer then addESPToPlayer(targetPlayer) end
end

Players.PlayerAdded:Connect(function(newPlayer)
    if newPlayer ~= LocalPlayer then addESPToPlayer(newPlayer) end
end)

local highlights = {}

local function updateESP()
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= LocalPlayer and targetPlayer.Character then
            local shouldShow = isTargetEnemy(targetPlayer, ESPSettings.TeamCheckMode, LocalPlayer)
            local nameTag = targetPlayer.Character:FindFirstChild("Head") and targetPlayer.Character.Head:FindFirstChild("NameTagESP")
            if nameTag then
                nameTag.NameLabel.TextTransparency = ESPSettings.Names and (shouldShow and 0 or 1) or 1
            end
            local boxESP = targetPlayer.Character:FindFirstChild("UpperTorso") and targetPlayer.Character.UpperTorso:FindFirstChild("BoxESP")
            if boxESP then
                boxESP.TorsoHighlight.Visible = ESPSettings.Box and shouldShow
            end
            local shouldShowHighlights = ESPSettings.Highlights.Enabled and isTargetEnemy(targetPlayer, ESPSettings.Highlights.TeamCheckMode, LocalPlayer)
            if shouldShowHighlights then
                if not highlights[targetPlayer] then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP_Highlight"
                    highlight.Adornee = targetPlayer.Character
                    highlight.Enabled = true
                    highlight.FillColor = ESPSettings.Highlights.Color
                    highlight.FillTransparency = ESPSettings.Highlights.Transparency
                    highlight.OutlineColor = ESPSettings.Highlights.Color
                    highlight.OutlineTransparency = 0
                    highlight.Parent = targetPlayer.Character
                    highlights[targetPlayer] = highlight
                else
                    highlights[targetPlayer].Enabled = true
                    highlights[targetPlayer].FillColor = ESPSettings.Highlights.Color
                    highlights[targetPlayer].FillTransparency = ESPSettings.Highlights.Transparency
                    highlights[targetPlayer].OutlineColor = ESPSettings.Highlights.Color
                end
            elseif highlights[targetPlayer] then
                highlights[targetPlayer].Enabled = false
            end
        end
    end
end

Players.PlayerRemoving:Connect(function(p)
    if highlights[p] then highlights[p]:Destroy() highlights[p] = nil end
end)

local espUpdateInterval = 0.1
local lastUpdate = tick()
RunService.RenderStepped:Connect(function()
    local now = tick()
    if now - lastUpdate >= espUpdateInterval then
        updateESP()
        lastUpdate = now
    end
end)

CombatTab:Space()
CombatTab:Divider({ Title = "Visual — Basic ESP" })
CombatTab:Space()

CombatTab:Toggle({ Title = "Box ESP", Flag = "VisSec1BoxESP1", Value = false,
    Callback = function(v) ESPSettings.Box = v end })
CombatTab:Space()
CombatTab:Toggle({ Title = "Names ESP", Flag = "VisSec1NamesESP1", Value = false,
    Callback = function(v) ESPSettings.Names = v end })
CombatTab:Space()
CombatTab:Dropdown({ Title = "ESP Team Check Mode", Flag = "VisSec1ESPTeamCheckMode1",
    Values = {"Team-Based","FFA","Everyone"}, Value = "Team-Based",
    Callback = function(v) ESPSettings.TeamCheckMode = v end })

CombatTab:Space()
CombatTab:Divider({ Title = "Visual — Highlights" })
CombatTab:Space()

CombatTab:Toggle({ Title = "Highlights Enabled", Flag = "VisSec2HighlightsEnabled1", Value = false,
    Callback = function(v)
        ESPSettings.Highlights.Enabled = v
        if not v then
            for _, highlight in pairs(highlights) do
                if highlight then highlight:Destroy() end
            end
            highlights = {}
        end
    end })
CombatTab:Space()
CombatTab:Dropdown({ Title = "Highlights Team Check", Flag = "VisSec2HighlightsTeamCheck1",
    Values = {"Team-Based","FFA","Everyone"}, Value = "Team-Based",
    Callback = function(v) ESPSettings.Highlights.TeamCheckMode = v end })
CombatTab:Space()
CombatTab:Slider({ Title = "Transparency", Flag = "VisSec2Transparency1",
    Value = {Min = 0, Max = 1, Default = 0.5}, Step = 0.1,
    Callback = function(v) ESPSettings.Highlights.Transparency = v end })
CombatTab:Space()
CombatTab:Colorpicker({ Title = "Highlights Color", Flag = "VisSec2HighlightsColor1",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(v) ESPSettings.Highlights.Color = v end })

-- ▸ Hitbox
local HitboxSettings = {
    Enabled = false, Size = 12, Transparency = 1,
    Color = Color3.fromRGB(255, 0, 0), TeamCheckMode = "Team-Based"
}

local originalHitboxProperties = {}

local function restoreHitbox(targetPlayer)
    if targetPlayer.Character then
        local bodyParts = {"RightUpperLeg","LeftUpperLeg","HeadHB","HumanoidRootPart","LeftUpperArm","RightUpperArm","UpperTorso"}
        for _, partName in pairs(bodyParts) do
            local part = targetPlayer.Character:FindFirstChild(partName)
            if part and originalHitboxProperties[targetPlayer] and originalHitboxProperties[targetPlayer][partName] then
                local props = originalHitboxProperties[targetPlayer][partName]
                part.Size = props.Size
                part.Transparency = props.Transparency
                part.Color = props.Color
                part.CanCollide = props.CanCollide
            end
        end
    end
end

local function restoreAllHitboxes()
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        restoreHitbox(targetPlayer)
    end
    originalHitboxProperties = {}
end

local function toggleHitboxLoop()
    if HitboxSettings.Enabled then
        task.spawn(function()
            while HitboxSettings.Enabled do
                pcall(function()
                    for _, targetPlayer in pairs(Players:GetPlayers()) do
                        if targetPlayer.Name ~= LocalPlayer.Name then
                            local shouldExpand = isTargetEnemy(targetPlayer, HitboxSettings.TeamCheckMode, LocalPlayer)
                            if targetPlayer.Character then
                                local bodyParts = {"RightUpperLeg","LeftUpperLeg","HeadHB","HumanoidRootPart","LeftUpperArm","RightUpperArm","UpperTorso"}
                                for _, partName in pairs(bodyParts) do
                                    local part = targetPlayer.Character:FindFirstChild(partName)
                                    if part then
                                        if not originalHitboxProperties[targetPlayer] then
                                            originalHitboxProperties[targetPlayer] = {}
                                        end
                                        if not originalHitboxProperties[targetPlayer][partName] then
                                            originalHitboxProperties[targetPlayer][partName] = {
                                                Size = part.Size,
                                                Transparency = part.Transparency,
                                                Color = part.Color,
                                                CanCollide = part.CanCollide
                                            }
                                        end
                                        if shouldExpand then
                                            local newSize = Vector3.new(HitboxSettings.Size, HitboxSettings.Size, HitboxSettings.Size)
                                            if part.Size ~= newSize or part.Transparency ~= HitboxSettings.Transparency or part.Color ~= HitboxSettings.Color or part.CanCollide ~= false then
                                                part.CanCollide = false
                                                part.Transparency = HitboxSettings.Transparency
                                                part.Color = HitboxSettings.Color
                                                part.Size = newSize
                                            end
                                        else
                                            local props = originalHitboxProperties[targetPlayer][partName]
                                            if part.Size ~= props.Size or part.Transparency ~= props.Transparency or part.Color ~= props.Color or part.CanCollide ~= props.CanCollide then
                                                part.Size = props.Size
                                                part.Transparency = props.Transparency
                                                part.Color = props.Color
                                                part.CanCollide = props.CanCollide
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
    else
        restoreAllHitboxes()
    end
end

CombatTab:Space()
CombatTab:Divider({ Title = "Hitbox" })
CombatTab:Space()

CombatTab:Toggle({ Title = "Hitbox Enabled", Flag = "HBSecHitboxEnabled1", Value = false,
    Callback = function(v) HitboxSettings.Enabled = v; toggleHitboxLoop() end })
CombatTab:Space()
CombatTab:Dropdown({ Title = "Team Check Mode", Flag = "HBSecTeamCheckMode4",
    Values = {"Team-Based","FFA","Everyone"}, Value = "Team-Based",
    Callback = function(v) HitboxSettings.TeamCheckMode = v end })
CombatTab:Space()
CombatTab:Slider({ Title = "Hitbox Size", Flag = "HBSecHitboxSize1",
    Value = {Min = 1, Max = 25, Default = 12}, Step = 1,
    Callback = function(v) HitboxSettings.Size = v end })
CombatTab:Space()
CombatTab:Slider({ Title = "Hitbox Transparency", Flag = "HBSecHitboxTransparency1",
    Value = {Min = 0, Max = 1, Default = 1}, Step = 0.1,
    Callback = function(v) HitboxSettings.Transparency = v end })
CombatTab:Space()
CombatTab:Colorpicker({ Title = "Hitbox Color", Flag = "HBSecHitboxColor1",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(v) HitboxSettings.Color = v end })

-- ─── TAB: EXTRA ───
local ExtTab = MainSection:Tab({
    Title = "Extra", Icon = "solar:magic-stick-bold",
    IconShape = "Square", Border = true,
})

ExtTab:Space()
ExtTab:Divider({ Title = "Effects & Stats" })
ExtTab:Space()

local extraParticlesEnabled = false
local extraMaxStatsEnabled = false
local original_stats = { Score = nil, Kills = nil }

local function enableParticles()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            v.Parent = game.Players.LocalPlayer.Character["Particle Area"]
        end
    end
end

local function disableParticles()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            v.Parent = workspace
        end
    end
end

ExtTab:Toggle({ Title = "Screen Particle Mess", Flag = "ExtSec1ScreenParticleMess1", Value = false,
    Callback = function(state)
        extraParticlesEnabled = state
        if state then enableParticles() else disableParticles() end
    end })
ExtTab:Space()
ExtTab:Toggle({ Title = "Max Stats (Score & Kills)", Flag = "ExtSec1MaxStatsScoreKills1", Value = false,
    Callback = function(bool)
        extraMaxStatsEnabled = bool
        local stats = LocalPlayer.CareerStatsCache
        if bool then
            if not original_stats.Score then original_stats.Score = stats.Score.Value end
            if not original_stats.Kills then original_stats.Kills = stats.Kills.Value end
            stats.Score.Value = 1e18
            stats.Kills.Value = 1e14
        else
            if original_stats.Score and original_stats.Kills then
                stats.Score.Value = original_stats.Score
                stats.Kills.Value = original_stats.Kills
            end
        end
    end })

syncLoadedControlEffects()

-- ─── TAB: INFO  (vacío) ───
local InfoTab = MainSection:Tab({
    Title = "Info", Icon = "solar:info-square-bold",
    IconShape = "Square", Border = true,
})
-- (vacío por diseño)

-- ─── TAB: KEYBINDS ───
local KeybindTab = MainSection:Tab({
    Title = "Keybinds", Icon = "solar:keyboard-bold",
    IconShape = "Square", Border = true,
})

local uiToggleKey = Enum.KeyCode.RightShift
local aimbotKey, triggerbotKey, hitboxKey, highlightsKey

KeybindTab:Space()
KeybindTab:Divider({ Title = "Interface" })
KeybindTab:Space()

KeybindTab:Keybind({
    Title = "Toggle UI", Flag = "ToggleUIKB", Value = "RightShift",
    Callback = function(v)
        if v == "None" then
            uiToggleKey = nil
        else
            local key = typeof(v) == "EnumItem" and v or Enum.KeyCode[v]
            if key then uiToggleKey = key end
        end
    end
})

KeybindTab:Space()
KeybindTab:Divider({ Title = "Feature Keybinds" })
KeybindTab:Space()

KeybindTab:Keybind({
    Title = "Aimbot", Flag = "AimSec1ToggleAimbot1", Value = "None",
    Callback = function(v)
        if v == "None" then aimbotKey = nil
        else
            local key = typeof(v) == "EnumItem" and v or Enum.KeyCode[v]
            if key then aimbotKey = key end
        end
    end
})
KeybindTab:Space()
KeybindTab:Keybind({
    Title = "Triggerbot", Flag = "TrigSecToggleTriggerbot1", Value = "None",
    Callback = function(v)
        if v == "None" then triggerbotKey = nil
        else
            local key = typeof(v) == "EnumItem" and v or Enum.KeyCode[v]
            if key then triggerbotKey = key end
        end
    end
})
KeybindTab:Space()
KeybindTab:Keybind({
    Title = "Hitbox", Flag = "HBSecToggleHitbox1", Value = "None",
    Callback = function(v)
        if v == "None" then hitboxKey = nil
        else
            local key = typeof(v) == "EnumItem" and v or Enum.KeyCode[v]
            if key then hitboxKey = key end
        end
    end
})
KeybindTab:Space()
KeybindTab:Keybind({
    Title = "Highlights", Flag = "VisSec2ToggleHighlights1", Value = "None",
    Callback = function(v)
        if v == "None" then highlightsKey = nil
        else
            local key = typeof(v) == "EnumItem" and v or Enum.KeyCode[v]
            if key then highlightsKey = key end
        end
    end
})

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end

    if uiToggleKey and input.KeyCode == uiToggleKey then
        if Window.Closed then Window:Open() else Window:Close(true) end
    end

    if aimbotKey and input.KeyCode == aimbotKey then
        aimbotState.enabled = not aimbotState.enabled
        notify({ Message = "Aimbot: " .. (aimbotState.enabled and "Enabled" or "Disabled"), Type = "info" })
    end

    if triggerbotKey and input.KeyCode == triggerbotKey then
        triggerbotState.enabled = not triggerbotState.enabled
        notify({ Message = "Triggerbot: " .. (triggerbotState.enabled and "Enabled" or "Disabled"), Type = "info" })
    end

    if hitboxKey and input.KeyCode == hitboxKey then
        HitboxSettings.Enabled = not HitboxSettings.Enabled
        toggleHitboxLoop()
        notify({ Message = "Hitbox: " .. (HitboxSettings.Enabled and "Enabled" or "Disabled"), Type = "info" })
    end

    if highlightsKey and input.KeyCode == highlightsKey then
        ESPSettings.Highlights.Enabled = not ESPSettings.Highlights.Enabled
        if not ESPSettings.Highlights.Enabled then
            for _, highlight in pairs(highlights) do
                if highlight then highlight:Destroy() end
            end
            highlights = {}
        end
        notify({ Message = "Highlights: " .. (ESPSettings.Highlights.Enabled and "Enabled" or "Disabled"), Type = "info" })
    end
end)

-- ═══════════════════════════════════════════════════════════════
--  CLEANUP
-- ═══════════════════════════════════════════════════════════════
Window:OnDestroy(function()
    pcall(function()
        if aimbotConnection then aimbotConnection:Disconnect() end
        restoreAllHitboxes()
        if FOVring then FOVring:Remove() end
        for _, targetPlayer in ipairs(Players:GetPlayers()) do
            if targetPlayer.Character then
                for _, child in ipairs(targetPlayer.Character:GetDescendants()) do
                    if child.Name == "NameTagESP" or child.Name == "BoxESP" or child.Name == "ESP_Highlight" then
                        child:Destroy()
                    end
                end
            end
        end
    end)
end)
