local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TouchFlingGui"
screenGui.Parent = game.CoreGui

-- Create the main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Active = true
mainFrame.Draggable = true

-- Create a UICorner for rounded corners
local uiCorner = Instance.new("UICorner")
uiCorner.Parent = mainFrame

-- Create a title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Parent = mainFrame
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.BackgroundTransparency = 0.5
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "Touch Fling GUI"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 20

-- Create the Touch Fling button
local touchFlingButton = Instance.new("TextButton")
touchFlingButton.Name = "TouchFlingButton"
touchFlingButton.Parent = mainFrame
touchFlingButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
touchFlingButton.Position = UDim2.new(0.5, -50, 0.5, -25)
touchFlingButton.Size = UDim2.new(0, 100, 0, 50)
touchFlingButton.Font = Enum.Font.SourceSansBold
touchFlingButton.Text = "Touch Fling"
touchFlingButton.TextColor3 = Color3.fromRGB(0, 0, 0)
touchFlingButton.TextSize = 18

-- Create a UICorner for the button
local buttonCorner = Instance.new("UICorner")
buttonCorner.Parent = touchFlingButton

-- State variable to track if fling is enabled
local flingEnabled = false

-- Function to execute Touch Fling
local function executeTouchFling(character)
    if not character then
        print("Character is nil, cannot execute Touch Fling.")
        return
    end

    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        print("HumanoidRootPart not found, unable to execute Touch Fling.")
        return
    end

    -- Apply a very large force
    local largeNumber = 1e6 -- A large number to simulate infinity
    local flingForce = Vector3.new(math.random(-largeNumber, largeNumber), 0, math.random(-largeNumber, largeNumber))

    -- Apply the fling force
    rootPart.Velocity = rootPart.Velocity + flingForce
    print("Touch Fling executed with force:", flingForce)
end

-- Connect the button to toggle the fling feature
touchFlingButton.MouseButton1Click:Connect(function()
    flingEnabled = not flingEnabled
end)

-- Use RunService to apply the fling force intermittently
RunService.Heartbeat:Connect(function()
    if flingEnabled then
        touchFlingButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Green when enabled
        local character = player.Character
        if character then
            -- Apply the fling force every few seconds
            if math.random() < 1e6 then -- Adjust the probability to control frequency
                executeTouchFling(character)
            end
        else
            print("Local player's character is not available.")
        end
    else
        touchFlingButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red when disabled
    end
end)