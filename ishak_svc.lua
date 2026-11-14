--[[
    ⚡ ISHAK SCRIPT v6.1
    RED / BLACK EDITION
    Delta Mobile UI — FIXED + UPGRADED
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

local OLD = PG:FindFirstChild("IshakScriptGUI")
if OLD then OLD:Destroy() end

-- RENKLER
local RED   = Color3.fromRGB(230,25,45)
local GREEN = Color3.fromRGB(50,200,90)
local DARK  = Color3.fromRGB(12,12,16)
local PANEL = Color3.fromRGB(24,24,30)
local WHITE = Color3.fromRGB(245,245,245)
local GRAY  = Color3.fromRGB(155,155,165)

-- GUI
local GUI = Instance.new("ScreenGui")
GUI.Name = "IshakScriptGUI"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.Parent = PG

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(640,420)
Main.Position = UDim2.new(.5,-320,.5,-210)
Main.BackgroundColor3 = DARK
Main.BorderSizePixel = 0
Main.Parent = GUI
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,12)

local Border = Instance.new("UIStroke",Main)
Border.Color = RED
Border.Thickness = 2

local function corner(o,r)
    local c=Instance.new("UICorner")
    c.CornerRadius=UDim.new(0,r or 8)
    c.Parent=o
end

local function label(parent,text,size,color)
    local l=Instance.new("TextLabel")
    l.BackgroundTransparency=1
    l.Text=text
    l.TextSize=size or 13
    l.TextColor3=color or WHITE
    l.Font=Enum.Font.GothamBold
    l.Parent=parent
    return l
end

-- HEADER
local Header=Instance.new("Frame")
Header.Size=UDim2.new(1,0,0,45)
Header.BackgroundColor3=Color3.fromRGB(105,8,20)
Header.BorderSizePixel=0
Header.Parent=Main
corner(Header,10)

local Title=label(Header,"⚡ ISHAK SCRIPT v6.1",18,WHITE)
Title.Size=UDim2.new(1,-100,1,0)
Title.Position=UDim2.fromOffset(14,0)
Title.TextXAlignment=Enum.TextXAlignment.Left

local Close=Instance.new("TextButton")
Close.Size=UDim2.fromOffset(30,29)
Close.Position=UDim2.new(1,-37,0,8)
Close.BackgroundColor3=RED
Close.Text="✕"
Close.TextColor3=WHITE
Close.Font=Enum.Font.GothamBlack
Close.TextSize=16
Close.Parent=Header
corner(Close,6)

-- STATUS BAR (önce tanımla!)
local Status=label(Main,"● ISHAK v6.1 | READY",10,RED)
Status.Position=UDim2.new(0,155,1,-18)
Status.Size=UDim2.new(1,-165,0,15)
Status.TextXAlignment=Enum.TextXAlignment.Left
Status.TextTruncate = Enum.TextTruncate.AtEnd

local function setStatus(s, ok)
    print("[ISHAK] "..s)
    Status.Text = (ok and "✓ " or "● ")..s
    Status.TextColor3 = ok and GREEN or RED
end

-- DRAG
local dragging=false
local dragStart,startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Touch
    or input.UserInputType==Enum.UserInputType.MouseButton1 then
        dragging=true
        dragStart=input.Position
        startPos=Main.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType==Enum.UserInputType.Touch
    or input.UserInputType==Enum.UserInputType.MouseMovement) then
        local d=input.Position-dragStart
        Main.Position=UDim2.new(
            startPos.X.Scale,startPos.X.Offset+d.X,
            startPos.Y.Scale,startPos.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Touch
    or input.UserInputType==Enum.UserInputType.MouseButton1 then
        dragging=false
    end
end)

-- SIDEBAR
local Side=Instance.new("Frame")
Side.Position=UDim2.fromOffset(8,53)
Side.Size=UDim2.new(0,135,1,-61)
Side.BackgroundColor3=PANEL
Side.BorderSizePixel=0
Side.Parent=Main
corner(Side,8)

local SideLayout=Instance.new("UIListLayout")
SideLayout.Padding=UDim.new(0,6)
SideLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
SideLayout.SortOrder=Enum.SortOrder.LayoutOrder
SideLayout.Parent=Side

local Pad=Instance.new("UIPadding")
Pad.PaddingTop=UDim.new(0,9)
Pad.Parent=Side

-- CONTENT
local Content=Instance.new("Frame")
Content.Position=UDim2.fromOffset(151,53)
Content.Size=UDim2.new(1,-159,1,-61)
Content.BackgroundColor3=PANEL
Content.BorderSizePixel=0
Content.Parent=Main
corner(Content,8)

local Pages={}
local Tabs={}

local function newLbl(parent,text)
    local l=label(parent,text,12,RED)
    l.Size=UDim2.new(1,-10,0,25)
    l.TextXAlignment=Enum.TextXAlignment.Left
    return l
end

local function newBtn(parent,text,color)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(1,-10,0,36)
    b.BackgroundColor3=color or Color3.fromRGB(42,42,50)
    b.Text=text
    b.TextColor3=WHITE
    b.Font=Enum.Font.GothamBold
    b.TextSize=12
    b.BorderSizePixel=0
    b.Parent=parent
    corner(b,7)
    return b
end

local function makeTab(name,emoji)
    local b=newBtn(Side,emoji.." "..name,DARK)
    local p=Instance.new("ScrollingFrame")
    p.Size=UDim2.new(1,-16,1,-16)
    p.Position=UDim2.fromOffset(8,8)
    p.BackgroundTransparency=1
    p.BorderSizePixel=0
    p.ScrollBarThickness=3
    p.ScrollBarImageColor3=RED
    p.AutomaticCanvasSize=Enum.AutomaticSize.Y
    p.CanvasSize=UDim2.new()
    p.Visible=false
    p.Parent=Content

    local layout=Instance.new("UIListLayout")
    layout.Padding=UDim.new(0,7)
    layout.Parent=p

    b.MouseButton1Click:Connect(function()
        for n,page in pairs(Pages) do
            page.Visible=false
            Tabs[n].BackgroundColor3=DARK
        end
        p.Visible=true
        b.BackgroundColor3=RED
    end)

    Pages[name]=p
    Tabs[name]=b
    return p
end

-- ================= FARM =================
local Farm=makeTab("FARM","💎")
newLbl(Farm,"FARM CENTER")

local farmInfo=label(Farm,"Pet Sim 99 yardımcı paneli",12,GRAY)
farmInfo.Size=UDim2.new(1,-10,0,25)
farmInfo.TextXAlignment=Enum.TextXAlignment.Left

-- AUTO CLICKER
local autoClickOn = false
local autoClickBtn = newBtn(Farm,"🖱️ Auto-Clicker: KAPALI")
autoClickBtn.MouseButton1Click:Connect(function()
    autoClickOn = not autoClickOn
    autoClickBtn.Text = "🖱️ Auto-Clicker: "..(autoClickOn and "AÇIK" or "KAPALI")
    autoClickBtn.BackgroundColor3 = autoClickOn and GREEN or Color3.fromRGB(42,42,50)
    setStatus("Auto-Clicker "..(autoClickOn and "açıldı" or "kapatıldı"), autoClickOn)
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        if autoClickOn then
            VIM:SendMouseButtonEvent(0,0,0,true,game,1)
            VIM:SendMouseButtonEvent(0,0,0,false,game,1)
        end
    end
end)

newBtn(Farm,"💎 Farm rehberi",RED).MouseButton1Click:Connect(function()
    setStatus("Farm rehberi seçildi", true)
end)
newBtn(Farm,"📦 Chest rehberi").MouseButton1Click:Connect(function()
    setStatus("Chest rehberi seçildi", true)
end)
newBtn(Farm,"🪙 Coin rehberi").MouseButton1Click:Connect(function()
    setStatus("Coin rehberi seçildi", true)
end)

-- ================= HATCH =================
local Hatch=makeTab("HATCH","🥚")
newLbl(Hatch,"HATCH CENTER")

local EggBox=Instance.new("TextBox")
EggBox.Size=UDim2.new(1,-10,0,36)
EggBox.BackgroundColor3=DARK
EggBox.TextColor3=WHITE
EggBox.PlaceholderText="Yumurta adı"
EggBox.Text="Cracked Egg"
EggBox.Font=Enum.Font.Gotham
EggBox.TextSize=12
EggBox.Parent=Hatch
corner(EggBox,7)

newBtn(Hatch,"🥚 Yumurta rehberi",RED).MouseButton1Click:Connect(function()
    setStatus("Yumurta: "..EggBox.Text, true)
end)

-- ================= FISH =================
local Fish=makeTab("FISH","🎣")
newLbl(Fish,"FISH CENTER")
newBtn(Fish,"🎣 Balık tutma rehberi",RED).MouseButton1Click:Connect(function()
    setStatus("Balık tutma rehberi açıldı", true)
end)

-- ================= PLAYER =================
local PlayerTab=makeTab("PLAYER","⚡")
newLbl(PlayerTab,"PLAYER SETTINGS")

local SpeedBox=Instance.new("TextBox")
SpeedBox.Size=UDim2.new(1,-10,0,35)
SpeedBox.BackgroundColor3=DARK
SpeedBox.Text="100"
SpeedBox.TextColor3=WHITE
SpeedBox.PlaceholderText="WalkSpeed (8-200)"
SpeedBox.Font=Enum.Font.Gotham
SpeedBox.TextSize=13
SpeedBox.Parent=PlayerTab
corner(SpeedBox,7)

newBtn(PlayerTab,"⚡ Hızı ayarla",RED).MouseButton1Click:Connect(function()
    local n=tonumber(SpeedBox.Text)
    local char=LP.Character
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    if n and hum then
        local v = math.clamp(n,8,200)   -- 🔥 sınır 200'e çıktı
        hum.WalkSpeed = v
        setStatus("WalkSpeed: "..v, true)
    else
        setStatus("Geçersiz hız", false)
    end
end)

newBtn(PlayerTab,"↩️ Hızı sıfırla").MouseButton1Click:Connect(function()
    local char=LP.Character
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = 16
        setStatus("WalkSpeed 16'ya sıfırlandı", true)
    end
end)

-- ANTI-AFK
local antiAFKOn = false
local antiAFKBtn = newBtn(PlayerTab,"🛡️ Anti-AFK: KAPALI")
antiAFKBtn.MouseButton1Click:Connect(function()
    antiAFKOn = not antiAFKOn
    antiAFKBtn.Text = "🛡️ Anti-AFK: "..(antiAFKOn and "AÇIK" or "KAPALI")
    antiAFKBtn.BackgroundColor3 = antiAFKOn and GREEN or Color3.fromRGB(42,42,50)
    setStatus("Anti-AFK "..(antiAFKOn and "açıldı" or "kapatıldı"), antiAFKOn)
end)

LP.Idled:Connect(function()
    if antiAFKOn then
        local VU = game:GetService("VirtualUser")
        VU:CaptureController()
        VU:ClickButton2(Vector2.new())
    end
end)

-- FLY
local flyOn = false
local flyConn
local flyBtn = newBtn(PlayerTab,"🕊️ Fly: KAPALI")
flyBtn.MouseButton1Click:Connect(function()
    flyOn = not flyOn
    flyBtn.Text = "🕊️ Fly: "..(flyOn and "AÇIK" or "KAPALI")
    flyBtn.BackgroundColor3 = flyOn and GREEN or Color3.fromRGB(42,42,50)

    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not (hum and hrp) then return end

    if flyOn then
        local BV = Instance.new("BodyVelocity", hrp)
        BV.Name = "IshakFlyVelocity"
        BV.MaxForce = Vector3.new(1e5,1e5,1e5)
        BV.Velocity = Vector3.new()

        local BG = Instance.new("BodyGyro", hrp)
        BG.Name = "IshakFlyGyro"
        BG.MaxTorque = Vector3.new(1e5,1e5,1e5)
        BG.P = 1e4
        BG.D = 1e2
        BG.CFrame = hrp.CFrame

        hum.PlatformStand = true

        local UIS2 = UIS
        flyConn = RunService.RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera
            local moveDir = Vector3.new()

            -- Tuş kontrolleri (PC)
            if UIS2:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
            if UIS2:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
            if UIS2:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
            if UIS2:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
            if UIS2:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
            if UIS2:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir -= Vector3.new(0,1,0) end

            -- Mobile joystick
            local humanoidMove = hum.MoveDirection
            if humanoidMove.Magnitude > 0 then
                local camCF = cam.CFrame
                local flatMove = Vector3.new(humanoidMove.X, 0, humanoidMove.Z)
                if flatMove.Magnitude > 0 then
                    moveDir += (camCF.LookVector * flatMove.Z + camCF.RightVector * flatMove.X)
                end
            end

            if moveDir.Magnitude > 0 then
                moveDir = moveDir.Unit * (hum.WalkSpeed * 2)
            end

            if BV and BV.Parent then
                BV.Velocity = moveDir
            end
            if BG and BG.Parent then
                BG.CFrame = cam.CFrame
            end
        end)
        setStatus("Fly açıldı", true)
    else
        if flyConn then flyConn:Disconnect() flyConn = nil end
        local bv = hrp:FindFirstChild("IshakFlyVelocity")
        local bg = hrp:FindFirstChild("IshakFlyGyro")
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
        hum.PlatformStand = false
        setStatus("Fly kapatıldı", false)
    end
end)

-- Character respawn olunca fly'ı temizle
LP.CharacterAdded:Connect(function()
    flyOn = false
    flyBtn.Text = "🕊️ Fly: KAPALI"
    flyBtn.BackgroundColor3 = Color3.fromRGB(42,42,50)
    if flyConn then flyConn:Disconnect() flyConn = nil end
end)

-- ================= CLOSE BUTTON =================
Close.MouseButton1Click:Connect(function()
    if flyConn then flyConn:Disconnect() flyConn = nil end
    GUI:Destroy()
end)

-- ================= INIT =================
Tabs["FARM"].BackgroundColor3 = RED
Pages["FARM"].Visible = true
setStatus("ISHAK v6.1 | READY", true)
