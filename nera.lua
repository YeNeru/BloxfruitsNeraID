local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Menambahkan aura berwarna ungu tembus pandang
local aura = Instance.new("ParticleEmitter")
aura.Color = ColorSequence.new(Color3.fromRGB(128, 0, 128))
aura.Transparency = NumberSequence.new(0.5)
aura.LightEmission = 1
aura.Size = NumberSequence.new(2)
aura.Texture = "rbxassetid://123456789" -- Ganti dengan ID tekstur yang sesuai
aura.Parent = character:WaitForChild("HumanoidRootPart")

-- Menambahkan 2x jump
local canDoubleJump = true
humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
    if canDoubleJump then
        humanoid:Move(Vector3.new(0,10,0))
        canDoubleJump = false
    end
end)

-- Menambahkan kecepatan 1,5x
local baseWalkSpeed = humanoid.WalkSpeed
humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    humanoid.WalkSpeed = baseWalkSpeed * 1.5
end)

-- Membuat pemain bisa berjalan di atas air
local isWalkingOnWater = false
humanoid:GetPropertyChangedSignal("Health"):Connect(function()
    if humanoid.Health > 0 then
        humanoid:GetPropertyChangedSignal("Swimming"):Connect(function()
            humanoid.Swimming = isWalkingOnWater
        end)
    end
end)

-- Mendeteksi apakah pemain berada di atas air
local function checkWater()
    if humanoid:GetState() == Enum.HumanoidStateType.Swimming then
        isWalkingOnWater = true
    else
        isWalkingOnWater = false
    end
end

-- Memanggil checkWater secara berkala
while wait(1) do
    checkWater()
end