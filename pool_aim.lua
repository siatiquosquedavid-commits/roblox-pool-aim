-- AUTO AIM SINUCA (LEGIT)
-- Uso educacional

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LP = Players.LocalPlayer

local SMOOTHNESS = 0.12

local function getWhiteBall()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Shape == Enum.PartType.Ball then
            if v.Name:lower():find("white") then
                return v
            end
        end
    end
end

local function getTargetBall(origin)
    local closest, shortest = nil, math.huge
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Shape == Enum.PartType.Ball then
            local d = (v.Position - origin).Magnitude
            if d < shortest and d > 3 then
                shortest = d
                closest = v
            end
        end
    end
    return closest
end

local function getClosestPocket(pos)
    local pocket, shortest = nil, math.huge
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name:lower():find("pocket") then
            local d = (v.Position - pos).Magnitude
            if d < shortest then
                shortest = d
                pocket = v
            end
        end
    end
    return pocket
end

RunService.RenderStepped:Connect(function()
    local white = getWhiteBall()
    if not white then return end

    local target = getTargetBall(white.Position)
    if not target then return end

    local pocket = getClosestPocket(target.Position)
    if not pocket then return end

    local dir = (target.Position - pocket.Position).Unit
    local aimPoint = target.Position + dir * 3

    Camera.CFrame = Camera.CFrame:Lerp(
        CFrame.new(Camera.CFrame.Position, aimPoint),
        SMOOTHNESS
    )
end)
