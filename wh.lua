-- Roblox Key System UI Script
-- Place this in StarterGui or StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configuration
local VALID_KEY = "GAMESENSE2024" -- Change this to your desired key
local KEY_CHECK_URL = "https://your-key-server.com/check" -- Optional: external validation

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeySystemUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Background overlay
local overlay = Instance.new("Frame")
overlay.Name = "Overlay"
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.Position = UDim2.new(0, 0, 0, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.3
overlay.BorderSizePixel = 0
overlay.Parent = screenGui

-- Main container frame
local containerFrame = Instance.new("Frame")
containerFrame.Name = "Container"
containerFrame.Size = UDim2.new(0, 400, 0, 300)
containerFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
containerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
containerFrame.BorderSizePixel = 0
containerFrame.Parent = overlay

-- Border frames (same style as your info panel)
local borderFrame1 = Instance.new("Frame")
borderFrame1.Name = "BorderFrame1"
borderFrame1.Size = UDim2.new(1, -2, 1, -2)
borderFrame1.Position = UDim2.new(0, 1, 0, 1)
borderFrame1.BackgroundColor3 = Color3.fromRGB(52, 53, 52)
borderFrame1.BorderSizePixel = 0
borderFrame1.Parent = containerFrame

local borderFrame2 = Instance.new("Frame")
borderFrame2.Name = "BorderFrame2"
borderFrame2.Size = UDim2.new(1, -2, 1, -2)
borderFrame2.Position = UDim2.new(0, 1, 0, 1)
borderFrame2.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
borderFrame2.BorderSizePixel = 0
borderFrame2.Parent = borderFrame1

local borderFrame3 = Instance.new("Frame")
borderFrame3.Name = "BorderFrame3"
borderFrame3.Size = UDim2.new(1, -6, 1, -6)
borderFrame3.Position = UDim2.new(0, 3, 0, 3)
borderFrame3.BackgroundColor3 = Color3.fromRGB(52, 53, 52)
borderFrame3.BorderSizePixel = 0
borderFrame3.Parent = borderFrame2

-- Inner frame
local innerFrame = Instance.new("Frame")
innerFrame.Name = "InnerFrame"
innerFrame.Size = UDim2.new(1, -2, 1, -2)
innerFrame.Position = UDim2.new(0, 1, 0, 1)
innerFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 4)
innerFrame.BorderSizePixel = 0
innerFrame.Parent = borderFrame3

-- Top gradient accent
local gradientFrame = Instance.new("Frame")
gradientFrame.Name = "GradientFrame"
gradientFrame.Size = UDim2.new(1, 0, 0, 2)
gradientFrame.Position = UDim2.new(0, 0, 0, 0)
gradientFrame.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
gradientFrame.BorderSizePixel = 0
gradientFrame.Parent = innerFrame

-- Animated gradient
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 200)),
	ColorSequenceKeypoint.new(0.25, Color3.fromRGB(180, 100, 160)),
	ColorSequenceKeypoint.new(0.75, Color3.fromRGB(180, 230, 100)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 100, 160))
}
gradient.Parent = gradientFrame

-- Shadow line
local shadowLine = Instance.new("Frame")
shadowLine.Name = "ShadowLine"
shadowLine.Size = UDim2.new(1, 0, 0, 1)
shadowLine.Position = UDim2.new(0, 0, 0, 2)
shadowLine.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadowLine.BackgroundTransparency = 0.2
shadowLine.BorderSizePixel = 0
shadowLine.Parent = innerFrame

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, -20, 0, 40)
titleLabel.Position = UDim2.new(0, 10, 0, 20)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "GAME<font color='rgb(163, 200, 79)'>SENSE</font> KEY SYSTEM"
titleLabel.RichText = true
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.Code
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = innerFrame

-- Status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 70)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Enter your key to continue"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.Code
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = innerFrame

-- Key input frame
local inputFrame = Instance.new("Frame")
inputFrame.Name = "InputFrame"
inputFrame.Size = UDim2.new(1, -40, 0, 35)
inputFrame.Position = UDim2.new(0, 20, 0, 110)
inputFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
inputFrame.BorderSizePixel = 0
inputFrame.Parent = innerFrame

-- Input border
local inputBorder = Instance.new("UIStroke")
inputBorder.Color = Color3.fromRGB(52, 53, 52)
inputBorder.Thickness = 1
inputBorder.Parent = inputFrame

-- Key input box
local keyInput = Instance.new("TextBox")
keyInput.Name = "KeyInput"
keyInput.Size = UDim2.new(1, -16, 1, -8)
keyInput.Position = UDim2.new(0, 8, 0, 4)
keyInput.BackgroundTransparency = 1
keyInput.Text = ""
keyInput.PlaceholderText = "Enter key here..."
keyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextSize = 14
keyInput.Font = Enum.Font.Code
keyInput.TextXAlignment = Enum.TextXAlignment.Left
keyInput.ClearTextOnFocus = false
keyInput.Parent = inputFrame

-- Submit button container
local buttonFrame = Instance.new("Frame")
buttonFrame.Name = "ButtonFrame"
buttonFrame.Size = UDim2.new(0, 120, 0, 35)
buttonFrame.Position = UDim2.new(0.5, -60, 0, 160)
buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
buttonFrame.BorderSizePixel = 0
buttonFrame.Parent = innerFrame

-- Button borders (same style)
local buttonBorder1 = Instance.new("Frame")
buttonBorder1.Size = UDim2.new(1, -2, 1, -2)
buttonBorder1.Position = UDim2.new(0, 1, 0, 1)
buttonBorder1.BackgroundColor3 = Color3.fromRGB(52, 53, 52)
buttonBorder1.BorderSizePixel = 0
buttonBorder1.Parent = buttonFrame

local buttonBorder2 = Instance.new("Frame")
buttonBorder2.Size = UDim2.new(1, -2, 1, -2)
buttonBorder2.Position = UDim2.new(0, 1, 0, 1)
buttonBorder2.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
buttonBorder2.BorderSizePixel = 0
buttonBorder2.Parent = buttonBorder1

local buttonInner = Instance.new("Frame")
buttonInner.Size = UDim2.new(1, -6, 1, -6)
buttonInner.Position = UDim2.new(0, 3, 0, 3)
buttonInner.BackgroundColor3 = Color3.fromRGB(52, 53, 52)
buttonInner.BorderSizePixel = 0
buttonInner.Parent = buttonBorder2

local buttonBackground = Instance.new("Frame")
buttonBackground.Size = UDim2.new(1, -2, 1, -2)
buttonBackground.Position = UDim2.new(0, 1, 0, 1)
buttonBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
buttonBackground.BorderSizePixel = 0
buttonBackground.Parent = buttonInner

-- Button gradient accent
local buttonGradient = Instance.new("Frame")
buttonGradient.Size = UDim2.new(1, 0, 0, 1)
buttonGradient.Position = UDim2.new(0, 0, 0, 0)
buttonGradient.BackgroundColor3 = Color3.fromRGB(163, 200, 79)
buttonGradient.BorderSizePixel = 0
buttonGradient.Parent = buttonBackground

-- Submit button
local submitButton = Instance.new("TextButton")
submitButton.Name = "SubmitButton"
submitButton.Size = UDim2.new(1, 0, 1, 0)
submitButton.Position = UDim2.new(0, 0, 0, 0)
submitButton.BackgroundTransparency = 1
submitButton.Text = "SUBMIT"
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.TextSize = 14
submitButton.Font = Enum.Font.Code
submitButton.Parent = buttonBackground

-- Get Key button
local getKeyFrame = Instance.new("Frame")
getKeyFrame.Name = "GetKeyFrame"
getKeyFrame.Size = UDim2.new(0, 120, 0, 35)
getKeyFrame.Position = UDim2.new(0.5, -60, 0, 210)
getKeyFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
getKeyFrame.BorderSizePixel = 0
getKeyFrame.Parent = innerFrame

-- Get Key button borders
local getKeyBorder1 = Instance.new("Frame")
getKeyBorder1.Size = UDim2.new(1, -2, 1, -2)
getKeyBorder1.Position = UDim2.new(0, 1, 0, 1)
getKeyBorder1.BackgroundColor3 = Color3.fromRGB(52, 53, 52)
getKeyBorder1.BorderSizePixel = 0
getKeyBorder1.Parent = getKeyFrame

local getKeyBorder2 = Instance.new("Frame")
getKeyBorder2.Size = UDim2.new(1, -2, 1, -2)
getKeyBorder2.Position = UDim2.new(0, 1, 0, 1)
getKeyBorder2.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
getKeyBorder2.BorderSizePixel = 0
getKeyBorder2.Parent = getKeyBorder1

local getKeyInner = Instance.new("Frame")
getKeyInner.Size = UDim2.new(1, -6, 1, -6)
getKeyInner.Position = UDim2.new(0, 3, 0, 3)
getKeyInner.BackgroundColor3 = Color3.fromRGB(52, 53, 52)
getKeyInner.BorderSizePixel = 0
getKeyInner.Parent = getKeyBorder2

local getKeyBackground = Instance.new("Frame")
getKeyBackground.Size = UDim2.new(1, -2, 1, -2)
getKeyBackground.Position = UDim2.new(0, 1, 0, 1)
getKeyBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
getKeyBackground.BorderSizePixel = 0
getKeyBackground.Parent = getKeyInner

-- Get Key button gradient
local getKeyGradient = Instance.new("Frame")
getKeyGradient.Size = UDim2.new(1, 0, 0, 1)
getKeyGradient.Position = UDim2.new(0, 0, 0, 0)
getKeyGradient.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
getKeyGradient.BorderSizePixel = 0
getKeyGradient.Parent = getKeyBackground

local getKeyGradientUI = Instance.new("UIGradient")
getKeyGradientUI.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 200)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 100, 160))
}
getKeyGradientUI.Parent = getKeyGradient

-- Get Key button
local getKeyButton = Instance.new("TextButton")
getKeyButton.Name = "GetKeyButton"
getKeyButton.Size = UDim2.new(1, 0, 1, 0)
getKeyButton.Position = UDim2.new(0, 0, 0, 0)
getKeyButton.BackgroundTransparency = 1
getKeyButton.Text = "GET KEY"
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.TextSize = 14
getKeyButton.Font = Enum.Font.Code
getKeyButton.Parent = getKeyBackground

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundTransparency = 1
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
closeButton.TextSize = 20
closeButton.Font = Enum.Font.Code
closeButton.Parent = innerFrame

-- Loading indicator frame
local loadingFrame = Instance.new("Frame")
loadingFrame.Name = "LoadingFrame"
loadingFrame.Size = UDim2.new(1, -40, 0, 4)
loadingFrame.Position = UDim2.new(0, 20, 1, -30)
loadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
loadingFrame.BorderSizePixel = 0
loadingFrame.Visible = false
loadingFrame.Parent = innerFrame

-- Loading progress bar
local loadingBar = Instance.new("Frame")
loadingBar.Name = "LoadingBar"
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.Position = UDim2.new(0, 0, 0, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(163, 200, 79)
loadingBar.BorderSizePixel = 0
loadingBar.Parent = loadingFrame

-- Particle system for effects
local particlesFrame = Instance.new("Frame")
particlesFrame.Name = "Particles"
particlesFrame.Size = UDim2.new(1, 0, 1, 0)
particlesFrame.Position = UDim2.new(0, 0, 0, 0)
particlesFrame.BackgroundTransparency = 1
particlesFrame.ClipsDescendants = true
particlesFrame.Parent = innerFrame

-- Animation variables
local animationTime = 0
local particles = {}

-- Create particle effect
local function createParticle()
	local particle = Instance.new("Frame")
	particle.Size = UDim2.new(0, 2, 0, 2)
	particle.Position = UDim2.new(math.random(), 0, 0, -10)
	particle.BackgroundColor3 = Color3.fromRGB(163, 200, 79)
	particle.BorderSizePixel = 0
	particle.Parent = particlesFrame

	-- Fade effect
	local fade = Instance.new("UIGradient")
	fade.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(1, 1)
	}
	fade.Parent = particle

	table.insert(particles, {
		frame = particle,
		velocity = Vector2.new(math.random(-20, 20) * 0.01, math.random(30, 80) * 0.01),
		life = 0
	})
end

-- Update particles
local function updateParticles(deltaTime)
	for i = #particles, 1, -1 do
		local particle = particles[i]
		particle.life = particle.life + deltaTime

		if particle.life > 3 then
			particle.frame:Destroy()
			table.remove(particles, i)
		else
			local pos = particle.frame.Position
			particle.frame.Position = UDim2.new(
				pos.X.Scale + particle.velocity.X * deltaTime,
				pos.X.Offset,
				pos.Y.Scale + particle.velocity.Y * deltaTime,
				pos.Y.Offset
			)

			-- Fade out over time
			local alpha = 1 - (particle.life / 3)
			particle.frame.BackgroundTransparency = 1 - alpha
		end
	end
end

-- Focus effects for input
local function createInputEffect(entering)
	local targetColor = entering and Color3.fromRGB(163, 200, 79) or Color3.fromRGB(52, 53, 52)
	local tween = TweenService:Create(
		inputBorder,
		TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		{Color = targetColor}
	)
	tween:Play()
end

-- Button hover effects
local function createButtonHover(button, background, entering)
	local targetColor = entering and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(20, 20, 20)
	local tween = TweenService:Create(
		background,
		TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		{BackgroundColor3 = targetColor}
	)
	tween:Play()

	if entering then
		-- Create ripple effect
		for i = 1, 3 do
			createParticle()
		end
	end
end

-- Loading animation
local function showLoadingAnimation()
	loadingFrame.Visible = true
	statusLabel.Text = "Validating key..."
	statusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)

	local tween = TweenService:Create(
		loadingBar,
		TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		{Size = UDim2.new(1, 0, 1, 0)}
	)
	tween:Play()
end

-- Success animation
local function showSuccessAnimation()
	loadingFrame.Visible = false
	statusLabel.Text = "✓ Key accepted! Access granted"
	statusLabel.TextColor3 = Color3.fromRGB(163, 200, 79)

	-- Screen flash effect
	local flash = Instance.new("Frame")
	flash.Size = UDim2.new(1, 0, 1, 0)
	flash.Position = UDim2.new(0, 0, 0, 0)
	flash.BackgroundColor3 = Color3.fromRGB(163, 200, 79)
	flash.BackgroundTransparency = 0.7
	flash.BorderSizePixel = 0
	flash.Parent = innerFrame

	local flashTween = TweenService:Create(
		flash,
		TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		{BackgroundTransparency = 1}
	)
	flashTween:Play()

	flashTween.Completed:Connect(function()
		flash:Destroy()
		-- Close UI after success
		wait(1)
		local closeTween = TweenService:Create(
			containerFrame,
			TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
			{Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
		)
		closeTween:Play()
		closeTween.Completed:Connect(function()
			screenGui:Destroy()
		end)
	end)
end

-- Error animation
local function showErrorAnimation()
	loadingFrame.Visible = false
	loadingBar.Size = UDim2.new(0, 0, 1, 0)
	statusLabel.Text = "✗ Invalid key! Please try again"
	statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
	keyInput.Text = ""

	-- Shake animation
	local originalPos = containerFrame.Position
	for i = 1, 6 do
		wait(0.05)
		local offset = (i % 2 == 0) and 10 or -10
		containerFrame.Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset + offset, originalPos.Y.Scale, originalPos.Y.Offset)
	end
	containerFrame.Position = originalPos
end

-- Key validation function
local function validateKey(key)
	-- Simple validation - you can modify this for more complex systems
	return key == VALID_KEY
end

-- Submit key function
local function submitKey()
	local enteredKey = keyInput.Text
	if enteredKey == "" then
		statusLabel.Text = "Please enter a key"
		statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
		return
	end

	showLoadingAnimation()

	-- Simulate key checking delay
	wait(2)

	if validateKey(enteredKey) then
		showSuccessAnimation()
		-- Here you would typically enable your script's main functionality
		print("Key system passed! Script can now run.")
	else
		showErrorAnimation()
	end
end

-- Event connections
keyInput.Focused:Connect(function()
	createInputEffect(true)
end)

keyInput.FocusLost:Connect(function()
	createInputEffect(false)
end)

submitButton.MouseEnter:Connect(function()
	createButtonHover(submitButton, buttonBackground, true)
end)

submitButton.MouseLeave:Connect(function()
	createButtonHover(submitButton, buttonBackground, false)
end)

getKeyButton.MouseEnter:Connect(function()
	createButtonHover(getKeyButton, getKeyBackground, true)
end)

getKeyButton.MouseLeave:Connect(function()
	createButtonHover(getKeyButton, getKeyBackground, false)
end)

submitButton.MouseButton1Click:Connect(submitKey)

getKeyButton.MouseButton1Click:Connect(function()
	-- You can redirect to your key distribution page here
	statusLabel.Text = "Key link copied to clipboard!"
	statusLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
	-- In a real script, you'd use setclipboard("your-key-link-here")
end)

closeButton.MouseButton1Click:Connect(function()
	local tween = TweenService:Create(
		containerFrame,
		TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
		{Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
	)
	tween:Play()
	tween.Completed:Connect(function()
		screenGui:Destroy()
	end)
end)

-- Enter key to submit
keyInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		submitKey()
	end
end)

-- Main animation loop
RunService.Heartbeat:Connect(function(deltaTime)
	updateParticles(deltaTime)

	-- Randomly create particles
	if math.random() < 0.1 then
		createParticle()
	end
end)

-- Entrance animation
containerFrame.Size = UDim2.new(0, 0, 0, 0)
containerFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

local entranceTween = TweenService:Create(
	containerFrame,
	TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	{Size = UDim2.new(0, 400, 0, 300), Position = UDim2.new(0.5, -200, 0.5, -150)}
)
entranceTween:Play()

-- Initial status
statusLabel.Text = "Enter your key to continue"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
