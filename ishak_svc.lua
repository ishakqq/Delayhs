--[[
    ⚡ ISHAK SCRIPT v3.1 — Pet Sim 99 (Delta uyumlu)
    GitHub: https://raw.githubusercontent.com/KULLANICI/REPO/main/ishak_svc.lua
    Kullanım: loadstring(game:HttpGet("...url..."))()
]]

--═══ GÜVENLİ SERVİS ALMA ═══
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- PlayerGui bekle (timeout'lu — sonsuz döngü yok)
local PlayerGui
local t0 = tick()
repeat
    PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    task.wait(0.1)
until PlayerGui or (tick() - t0 > 10)

if not PlayerGui then
    warn("[ISHAK] PlayerGui bulunamadı!")
    return
end

-- Eski GUI temizle
local old = PlayerGui:FindFirstChild("IshakScriptGUI")
if old then old:Destroy() end

--═══ GUI ═══
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "IshakScriptGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 400, 0, 560)
Main.Position = UDim2.new(0.5, -200, 0.5, -280)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 0, 100)
Stroke.Thickness = 2

local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 64)
Header.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, 0, 1, -20)
Title.BackgroundTransparency = 1
Title.Text = "⚡ ISHAK SCRIPT ⚡"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true

local Sub = Instance.new("TextLabel", Header)
Sub.Size = UDim2.new(1, 0, 0, 20)
Sub.Position = UDim2.new(0, 0, 1, -20)
Sub.BackgroundTransparency = 1
Sub.Text = "Pet Sim 99 • v3.1 (Delta)"
Sub.TextColor3 = Color3.fromRGB(255, 220, 240)
Sub.Font = Enum.Font.GothamBold
Sub.TextSize = 11

local Close = Instance.new("TextButton", Header)
Close.Size = UDim2.new(0, 28, 0, 28)
Close.Position = UDim2.new(1, -36, 0, 18)
Close.BackgroundColor3 = Color3.fromRGB(180, 0, 70)
Close.Text = "✕"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Font = Enum.Font.GothamBlack
Close.TextSize = 15
Close.BorderSizePixel = 0
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -16, 1, -80)
Scroll.Position = UDim2.new(0, 8, 0, 72)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 100)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0, 6)
List.SortOrder = Enum.SortOrder.LayoutOrder

--═══ YARDIMCILAR ═══
local function Btn(text, color)
    local b = Instance.new("TextButton", Scroll)
    b.Size = UDim2.new(1, 0, 0, 38)
    b.BackgroundColor3 = color or Color3.fromRGB(45, 45, 55)
    b.Text = text
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.BorderSizePixel = 0
    b.AutoButtonColor = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    return b
end

local function Lbl(text, color)
    local l = Instance.new("TextLabel", Scroll)
    l.Size = UDim2.new(1, 0, 0, 22)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or Color3.fromRGB(255, 120, 170)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    return l
end

--═══ MENÜ ═══
Lbl("🍀 ŞANS & PETLER")
local luckBtn = Btn("🍀 Şans Artır", Color3.fromRGB(60, 170, 100))
local hugeBtn = Btn("💎 Huge Pet Spawnla", Color3.fromRGB(190, 50, 150))

Lbl("💰 OTOMATİK FARM")
local farmBtn = Btn("💎 Auto Farm Gems: KAPALI", Color3.fromRGB(50, 120, 190))

Lbl("🥚 YUMURTA AÇMA")
local eggBox = Instance.new("TextBox", Scroll)
eggBox.Size = UDim2.new(1, 0, 0, 34)
eggBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
eggBox.Text = ""
eggBox.PlaceholderText = "Yumurta adı (boş = varsayılan)"
eggBox.TextColor3 = Color3.new(1, 1, 1)
eggBox.Font = Enum.Font.Gotham
eggBox.TextSize = 12
eggBox.BorderSizePixel = 0
Instance.new("UICorner", eggBox).CornerRadius = UDim.new(0, 6)

local b1000 = Btn("🥚 1000 Yumurta Aç", Color3.fromRGB(255, 140, 0))
local b5000 = Btn("💥 5000 Yumurta Aç", Color3.fromRGB(255, 60, 60))

Lbl("⚡ HAREKET")
local spd50 = Btn("🏃 Hız 50", Color3.fromRGB(70, 70, 90))
local spd100 = Btn("🏃 Hız 100", Color3.fromRGB(70, 70, 90))
local jmp = Btn("🦘 Zıplama 200", Color3.fromRGB(70, 70, 90))
local tp = Btn("📍 Spawn TP", Color3.fromRGB(120, 100, 60))

Lbl("📝 DURUM")
local Status = Instance.new("TextLabel", Scroll)
Status.Size = UDim2.new(1, 0, 0, 60)
Status.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Status.Text = "⏳ Remote'lar taranıyor..."
Status.TextColor3 = Color3.fromRGB(180, 180, 180)
Status.Font = Enum.Font.Gotham
Status.TextSize = 11
Status.TextWrapped = true
Status.BorderSizePixel = 0
Instance.new("UICorner", Status).CornerRadius = UDim.new(0, 6)

-- Açılış animasyonu
Main.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 400, 0, 560)}):Play()

--═══ REMOTE TARAYICI (güvenli) ═══
local RemoteCache = {}
task.spawn(function()
    local n = 0
    for _, d in ipairs(ReplicatedStorage:GetDescendants()) do
        if d:IsA("RemoteEvent") or d:IsA("RemoteFunction") or d:IsA("UnreliableRemoteEvent") then
            RemoteCache[d.Name:lower()] = d
            n = n + 1
        end
    end
    Status.Text = "✅ " .. n .. " remote bulundu.\nButonlar hazır."
    Status.TextColor3 = Color3.fromRGB(120, 255, 120)
end)

local function findR(keys)
    for _, k in ipairs(keys) do
        for name, r in pairs(RemoteCache) do
            if name:find(k, 1, true) then return r end
        end
    end
    return nil
end

local function fire(r, ...)
    if not r then return false end
    local args = {...}
    pcall(function()
        if r:IsA("RemoteFunction") then
            r:InvokeServer(table.unpack(args))
        else
            r:FireServer(table.unpack(args))
        end
    end)
    return true
end

--═══ HİLELER ═══
local function char()
    local c = LocalPlayer.Character
    if not c or not c:FindFirstChild("Humanoid") then
        LocalPlayer.CharacterAdded:Wait()
        c = LocalPlayer.Character
        task.wait(0.3)
    end
    return c
end

local function setSpeed(s)
    pcall(function() char().Humanoid.WalkSpeed = s end)
end

local function setJump(p)
    pcall(function() char().Humanoid.JumpPower = p end)
end

local function tpSpawn()
    pcall(function()
        char().HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
    end)
end

local function luckBoost()
    pcall(function()
        local bp = LocalPlayer:FindFirstChild("Backpack")
        if not bp then return end
        for _, t in ipairs(bp:GetChildren()) do
            local nm = t.Name:lower()
            if nm:find("lucky") or nm:find("clover") or nm:find("fortune")
               or nm:find("dice") or nm:find("boost") then
                t.Parent = char()
                task.wait(0.05)
                t.Parent = bp
            end
        end
    end)
end

local function spawnHuge()
    pcall(function()
        local hugeFolder = ReplicatedStorage:FindFirstChild("HugePets")
        if hugeFolder then
            for _, p in ipairs(hugeFolder:GetChildren()) do
                fire(findR({"huge"}), p.Name)
            end
        end
    end)
end

local AutoFarm = false
local function toggleFarm()
    AutoFarm = not AutoFarm
    farmBtn.Text = "💎 Auto Farm Gems: " .. (AutoFarm and "AÇIK" or "KAPALI")
    farmBtn.BackgroundColor3 = AutoFarm and Color3.fromRGB(60, 170, 100) or Color3.fromRGB(50, 120, 190)
    if not AutoFarm then return end
    task.spawn(function()
        while AutoFarm do
            pcall(function()
                local hrp = char():FindFirstChild("HumanoidRootPart")
                if hrp then
                    for _, v in ipairs(workspace:GetDescendants()) do
                        if v:IsA("BasePart") then
                            local nm = v.Name:lower()
                            if nm:find("gem") or nm:find("coin")
                               or nm:find("diamond") or nm:find("orb") then
                                hrp.CFrame = v.CFrame
                                break
                            end
                        end
                    end
                end
            end)
            task.wait(0.35)
        end
    end)
end

local function hatch(eggName, count)
    task.spawn(function()
        local r = findR({"hatch", "egg"})
        if not r then
            Status.Text = "⚠️ Yumurta remote bulunamadı!"
            return
        end
        for i = 1, count do
            fire(r, eggName or "Egg")
            if i % 50 == 0 then task.wait(0.1) end
        end
    end)
end

--═══ BAĞLA ═══
luckBtn.MouseButton1Click:Connect(luckBoost)
hugeBtn.MouseButton1Click:Connect(spawnHuge)
farmBtn.MouseButton1Click:Connect(toggleFarm)
b1000.MouseButton1Click:Connect(function()
    hatch(eggBox.Text ~= "" and eggBox.Text or nil, 1000)
end)
b5000.MouseButton1Click:Connect(function()
    hatch(eggBox.Text ~= "" and eggBox.Text or nil, 5000)
end)
spd50.MouseButton1Click:Connect(function() setSpeed(50) end)
spd100.MouseButton1Click:Connect(function() setSpeed(100) end)
jmp.MouseButton1Click:Connect(function() setJump(200) end)
tp.MouseButton1Click:Connect(tpSpawn)

print("[ISHAK v3.1] Hazır ✅")
