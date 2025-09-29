local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TweenService=game:GetService("TweenService")
local Lighting=game:GetService("Lighting")
local RunService=game:GetService("RunService")
local SoundService=game:GetService("SoundService")

local LP=Players.LocalPlayer
local Camera=workspace.CurrentCamera

local DEF_BG=Color3.fromRGB(24,24,28)
local DEF_SIDE=Color3.fromRGB(35,35,42)
local DEF_CARD=Color3.fromRGB(40,40,48)
local DEF_TXT=Color3.fromRGB(235,235,240)
local C_BG=DEF_BG
local C_SIDE=DEF_SIDE
local C_CARD=DEF_CARD
local C_TXT=DEF_TXT
local C_MUT=Color3.fromRGB(170,170,178)
local C_STK=Color3.fromRGB(58,58,70)
local C_DIV=Color3.fromRGB(52,52,60)

local ACCENT=Color3.fromRGB(150,105,255)

local gui=Instance.new("ScreenGui")
gui.Name="AM_Menu"
gui.IgnoreGuiInset=true
gui.ResetOnSpawn=false
gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
gui.Parent=LP:WaitForChild("PlayerGui")

local overlay=Instance.new("ScreenGui")
overlay.Name="AM_Overlay"
overlay.IgnoreGuiInset=true
overlay.ResetOnSpawn=false
overlay.DisplayOrder=1000
overlay.Parent=LP.PlayerGui

-- Window
local win=Instance.new("Frame")
win.Size=UDim2.fromScale(0.54,0.58)
win.Position=UDim2.fromScale(0.23,0.21)
win.BackgroundColor3=C_BG
win.BorderSizePixel=0
win.ZIndex=10
win.ClipsDescendants=true
win.Parent=gui
Instance.new("UICorner",win).CornerRadius=UDim.new(0,14)
local ws=Instance.new("UIStroke",win); ws.Color=C_STK; ws.Transparency=0.35
local sh=Instance.new("ImageLabel",win)
sh.BackgroundTransparency=1
sh.Image="rbxassetid://5028857084"
sh.ScaleType=Enum.ScaleType.Slice
sh.SliceCenter=Rect.new(24,24,276,276)
sh.Size=UDim2.fromScale(1,1)
sh.Position=UDim2.fromOffset(-10,-10)
sh.ImageTransparency=0.35
sh.ZIndex=9

local top=Instance.new("Frame",win)
top.Size=UDim2.new(1,0,0,44)
top.BackgroundColor3=C_SIDE
top.BorderSizePixel=0
top.ZIndex=11
Instance.new("UICorner",top).CornerRadius=UDim.new(0,14)

local title=Instance.new("TextLabel",top)
title.BackgroundTransparency=1
title.Font=Enum.Font.GothamBold
title.Text="AimMany Menu by K3ngx1RIV"
title.TextSize=18
title.TextColor3=C_TXT
title.TextXAlignment=Enum.TextXAlignment.Left
title.Position=UDim2.fromOffset(16,0)
title.Size=UDim2.new(1,-120,1,0)
title.ZIndex=12

local function topBtn(off,sym,name)
	local b=Instance.new("TextButton",top)
	b.Name=name
	b.Text=sym
	b.Font=Enum.Font.GothamBold
	b.TextColor3=C_TXT
	b.TextScaled=true
	b.BackgroundColor3=C_SIDE
	b.BorderSizePixel=0
	b.AutoButtonColor=true
	b.Size=UDim2.fromOffset(24,24)
	b.AnchorPoint=Vector2.new(1,0.5)
	b.Position=UDim2.new(1,-off,0.5,0)
	b.ZIndex=12
	return b
end
local btnClose=topBtn(12,"×","Close")
local btnMin=topBtn(44,"–","Min")

local side=Instance.new("Frame",win)
side.BackgroundColor3=C_SIDE
side.BorderSizePixel=0
side.Position=UDim2.new(0,0,0,44)
side.Size=UDim2.new(0,210,1,-44)
side.ZIndex=10
Instance.new("UICorner",side).CornerRadius=UDim.new(0,14)
local spad=Instance.new("UIPadding",side)
spad.PaddingTop=UDim.new(0,12)
spad.PaddingLeft=UDim.new(0,12)
spad.PaddingRight=UDim.new(0,12)
local sl=Instance.new("UIListLayout",side)
sl.Padding=UDim.new(0,8)
sl.HorizontalAlignment=Enum.HorizontalAlignment.Center

local content=Instance.new("ScrollingFrame",win)
content.Name="Content"
content.BackgroundColor3=C_BG
content.BorderSizePixel=0
content.Position=UDim2.new(0,210,0,44)
content.Size=UDim2.new(1,-210,1,-44)
content.ZIndex=10
content.ScrollBarThickness=6
content.AutomaticCanvasSize=Enum.AutomaticSize.Y
content.CanvasSize=UDim2.fromOffset(0,0)
local cpad=Instance.new("UIPadding",content)
cpad.PaddingTop=UDim.new(0,14)
cpad.PaddingLeft=UDim.new(0,14)
cpad.PaddingRight=UDim.new(0,14)
cpad.PaddingBottom=UDim.new(0,14)

-- Helpers UI
local recolorLabels={}
local function trackLabel(x)table.insert(recolorLabels,x)end
local function vlist(p)local l=Instance.new("UIListLayout",p)l.Padding=UDim.new(0,10)l.SortOrder=Enum.SortOrder.LayoutOrder return l end
local function section(p,txt)
	local holder=Instance.new("Frame",p) holder.BackgroundTransparency=1 holder.Size=UDim2.new(1,0,0,24)
	local t=Instance.new("TextLabel",holder) t.BackgroundTransparency=1 t.Font=Enum.Font.GothamBold t.Text=txt t.TextSize=16 t.TextColor3=C_TXT trackLabel(t) t.TextXAlignment=Enum.TextXAlignment.Left t.Size=UDim2.new(1,0,1,0)
	local line=Instance.new("Frame",p) line.BackgroundColor3=C_DIV line.BorderSizePixel=0 line.Size=UDim2.new(1,0,0,2) line.Position=UDim2.new(0,0,1,-2)
end

local function makeDropdown(anchorAbs,options,onChoose)
	local dd=Instance.new("Frame",content)
	dd.BackgroundColor3=C_SIDE
	dd.BorderSizePixel=0
	dd.ZIndex=100
	Instance.new("UICorner",dd).CornerRadius=UDim.new(0,8)
	local h=(#options*36)+12
	dd.Size=UDim2.new(0,260,0,h)
	local y=6
	for _,opt in ipairs(options)do
		local b=Instance.new("TextButton",dd)
		b.Text=opt
		b.Font=Enum.Font.Gotham
		b.TextSize=16
		b.TextColor3=C_TXT
		trackLabel(b)
		b.BackgroundColor3=C_CARD
		b.BorderSizePixel=0
		b.Size=UDim2.new(1,-12,0,30)
		b.Position=UDim2.new(0,6,0,y)
		Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
		b.MouseButton1Click:Connect(function() dd:Destroy() pcall(onChoose,opt) end)
		y+=36
	end
	dd.Position=UDim2.new(0,anchorAbs.X,0,anchorAbs.Y+44+content.CanvasPosition.Y)
	return dd
end

local function cell(parent,text,rightText)
	local f=Instance.new("Frame",parent)
	f.BackgroundColor3=C_CARD
	f.BorderSizePixel=0
	f.Size=UDim2.new(1,0,0,40)
	f.ZIndex=10
	Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
	local st=Instance.new("UIStroke",f) st.Color=C_STK st.Transparency=0.45
	local lbl=Instance.new("TextLabel",f)
	lbl.BackgroundTransparency=1
	lbl.Font=Enum.Font.Gotham
	lbl.Text=text
	lbl.TextSize=16
	lbl.TextColor3=C_TXT
	trackLabel(lbl)
	lbl.TextXAlignment=Enum.TextXAlignment.Left
	lbl.Position=UDim2.fromOffset(12,0)
	lbl.Size=UDim2.new(0.6,0,1,0)
	if rightText then
		local r=Instance.new("TextLabel",f)
		r.Name="Right"
		r.BackgroundTransparency=1
		r.Font=Enum.Font.GothamBold
		r.Text=rightText
		r.TextSize=16
		r.TextColor3=C_TXT
		trackLabel(r)
		r.TextXAlignment=Enum.TextXAlignment.Right
		r.Position=UDim2.new(1,-220,0,0)
		r.Size=UDim2.new(0,210,1,0)
		r.TextTruncate=Enum.TextTruncate.AtEnd
	end
	local box=Instance.new("TextButton",f)
	box.Name="Toggle"
	box.Text=""
	box.AutoButtonColor=true
	box.BackgroundColor3=C_SIDE
	box.BorderSizePixel=0
	box.Size=UDim2.fromOffset(34,34)
	box.Position=UDim2.new(1,-70,0.5,-17)
	box.ZIndex=11
	Instance.new("UICorner",box).CornerRadius=UDim.new(0,8)
	local fill=Instance.new("Frame",box)
	fill.Name="Fill"
	fill.BackgroundColor3=ACCENT
	fill.BorderSizePixel=0
	fill.AnchorPoint=Vector2.new(0.5,0.5)
	fill.Position=UDim2.fromScale(0.5,0.5)
	fill.Size=UDim2.fromOffset(0,0)
	fill.Visible=false
	fill.ZIndex=12
	Instance.new("UICorner",fill).CornerRadius=UDim.new(0,8)
	return f
end

local function listCell(parent,labelText,initialRight)
	local f=Instance.new("TextButton",parent)
	f.BackgroundColor3=C_CARD
	f.BorderSizePixel=0
	f.AutoButtonColor=true
	f.Size=UDim2.new(1,0,0,44)
	f.ZIndex=10
	f.Text=""
	Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
	local st=Instance.new("UIStroke",f) st.Color=C_STK st.Transparency=0.45
	local lbl=Instance.new("TextLabel",f)
	lbl.BackgroundTransparency=1
	lbl.Font=Enum.Font.Gotham
	lbl.Text=labelText
	lbl.TextSize=18
	lbl.TextColor3=C_TXT
	trackLabel(lbl)
	lbl.TextXAlignment=Enum.TextXAlignment.Left
	lbl.Position=UDim2.fromOffset(12,0)
	lbl.Size=UDim2.new(0.6,0,1,0)
	local right=Instance.new("TextLabel",f)
	right.Name="Right"
	right.BackgroundTransparency=1
	right.Font=Enum.Font.GothamBold
	right.Text=initialRight or "Select"
	right.TextSize=16
	right.TextColor3=C_TXT
	trackLabel(right)
	right.TextXAlignment=Enum.TextXAlignment.Right
	right.Position=UDim2.new(1,-240,0,0)
	right.Size=UDim2.new(0,230,1,0)
	right.TextTruncate=Enum.TextTruncate.AtEnd
	return f,right
end

-- Tabs infra
local tabFrames,currentBtn={},nil
local function makeSideButton(text)
	local b=Instance.new("TextButton",side)
	b.Text=text
	b.AutoButtonColor=true
	b.Font=Enum.Font.GothamMedium
	b.TextSize=15
	b.TextColor3=C_MUT
	b.BackgroundColor3=C_SIDE
	b.BorderSizePixel=0
	b.Size=UDim2.new(1,0,0,36)
	b.ZIndex=11
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
	local st=Instance.new("UIStroke",b) st.Color=C_STK st.Transparency=0.5
	b.MouseEnter:Connect(function() if b~=currentBtn then b.BackgroundColor3=Color3.fromRGB(44,44,54) end end)
	b.MouseLeave:Connect(function() if b~=currentBtn then b.BackgroundColor3=C_SIDE end end)
	return b
end
local function makeTab(name)
	local fr=Instance.new("Frame",content)
	fr.Name=name
	fr.BackgroundTransparency=1
	fr.Visible=false
	fr.Size=UDim2.fromScale(1,1)
	fr.ZIndex=10
	vlist(fr)
	tabFrames[name]=fr
	return fr
end
local REDTXT=Color3.fromRGB(255,40,40)
local function selectTab(btn)
	if currentBtn then currentBtn.BackgroundColor3=C_SIDE currentBtn.TextColor3=C_MUT end
	currentBtn=btn
	btn.BackgroundColor3=C_BG
	btn.TextColor3=REDTXT
	for n,fr in pairs(tabFrames)do fr.Visible=(n==btn.Text) end
end

local buttons={}
for _,n in ipairs({"Credits","Main","ESP/Aim","Config"})do buttons[n]=makeSideButton(n) end

-- Credits (start open)
local frCredits=makeTab("Credits")
section(frCredits,"Info:")
local creditsLabel=Instance.new("TextLabel",frCredits)
creditsLabel.BackgroundTransparency=1
creditsLabel.Font=Enum.Font.Gotham
creditsLabel.TextSize=16
creditsLabel.TextColor3=C_TXT
trackLabel(creditsLabel)
creditsLabel.TextXAlignment=Enum.TextXAlignment.Left
creditsLabel.TextYAlignment=Enum.TextYAlignment.Top
creditsLabel.TextWrapped=true
creditsLabel.Size=UDim2.new(1,0,0,120)
creditsLabel.Text="AimMany Menu by K3ngx1RIV\nVersion: 1.7.4\nMore updates coming soon :3"

local frMain=makeTab("Main")
section(frMain,"Player")

local function hum()
	local ch=LP.Character or LP.CharacterAdded:Wait()
	return ch:FindFirstChildOfClass("Humanoid")
end
local function hrp()
	local ch=LP.Character or LP.CharacterAdded:Wait()
	return ch:FindFirstChild("HumanoidRootPart")
end

local speedCell=cell(frMain,"Walk Speed","16")
local speedIn=Instance.new("TextBox",frMain)
speedIn.BackgroundColor3=C_SIDE
speedIn.BorderSizePixel=0
speedIn.PlaceholderText="Value (e.g. 24)"
speedIn.PlaceholderColor3=C_MUT
speedIn.TextColor3=C_TXT
speedIn.Font=Enum.Font.Gotham
speedIn.TextSize=14
speedIn.Size=UDim2.new(1,0,0,30)
Instance.new("UICorner",speedIn).CornerRadius=UDim.new(0,8)

local speedLoop=nil
local onToggleMap=setmetatable({},{__mode="k"})
local function bindToggle(frame,fn)
	local btn=frame:FindFirstChild("Toggle")
	if not btn then return end
	onToggleMap[btn]=fn
	btn.MouseButton1Click:Connect(function()
		local fill=btn:FindFirstChild("Fill")
		local turnOn = not fill.Visible
		fill.Visible=true
		local goal= turnOn and UDim2.fromOffset(34,34) or UDim2.fromOffset(0,0)
		TweenService:Create(fill,TweenInfo.new(0.12,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=goal}):Play()
		if not turnOn then task.delay(0.13,function() if fill then fill.Visible=false end end) end
		local cb=onToggleMap[btn]
		if cb then cb(turnOn) end
	end)
end

bindToggle(speedCell,function(on)
	if speedLoop then speedLoop:Disconnect() speedLoop=nil end
	if on then
		speedLoop=RunService.Heartbeat:Connect(function()
			local h=hum()
			if h then
				local n=tonumber(speedIn.Text) or 16
				-- força em todo tick
				pcall(function() h.WalkSpeed=n end)
				-- fallback para jogos que mexem em controls: acelera root se a velocidade aparente cair
				local root=hrp()
				if root and (root.AssemblyLinearVelocity.Magnitude<0.1) and UIS:IsKeyDown(Enum.KeyCode.W) then
					root.AssemblyLinearVelocity = root.AssemblyLinearVelocity + Camera.CFrame.LookVector*(n*0.8)
				end
			end
		end)
	else
		local h=hum()
		if h then pcall(function() h.WalkSpeed=16 end) end
	end
end)
speedIn.FocusLost:Connect(function(e)
	if e and speedLoop then
		local h=hum()
		if h then pcall(function() h.WalkSpeed=tonumber(speedIn.Text) or 16 end) end
	end
end)

-- Jump Power
local jumpCell=cell(frMain,"Jump Power","50")
local jumpIn=Instance.new("TextBox",frMain)
jumpIn.BackgroundColor3=C_SIDE
jumpIn.BorderSizePixel=0
jumpIn.PlaceholderText="Value (e.g. 60)"
jumpIn.PlaceholderColor3=C_MUT
jumpIn.TextColor3=C_TXT
jumpIn.Font=Enum.Font.Gotham
jumpIn.TextSize=14
jumpIn.Size=UDim2.new(1,0,0,30)
Instance.new("UICorner",jumpIn).CornerRadius=UDim.new(0,8)
bindToggle(jumpCell,function(on)
	local h=hum() if not h then return end
	local n=tonumber(jumpIn.Text) or 50
	pcall(function() h.UseJumpPower=true end)
	h.JumpPower = on and n or 50
	pcall(function() h.JumpHeight = on and math.clamp(n/3,2,25) or 7.2 end)
end)
jumpIn.FocusLost:Connect(function(e)
	if not e then return end
	local h=hum()
	if not h then return end
	local n=tonumber(jumpIn.Text)
	if not n then return end
	pcall(function() h.UseJumpPower=true end)
	h.JumpPower=n
	pcall(function() h.JumpHeight=math.clamp(n/3,2,25) end)
end)

local flyCell=cell(frMain,"Fly (WASD/Space/Shift)","")
local flySpeedIn=Instance.new("TextBox",frMain)
flySpeedIn.BackgroundColor3=C_SIDE
flySpeedIn.BorderSizePixel=0
flySpeedIn.PlaceholderText="Fly speed (e.g. 4)"
flySpeedIn.PlaceholderColor3=C_MUT
flySpeedIn.TextColor3=C_TXT
flySpeedIn.Font=Enum.Font.Gotham
flySpeedIn.TextSize=14
flySpeedIn.Text="4"
flySpeedIn.Size=UDim2.new(1,0,0,30)
Instance.new("UICorner",flySpeedIn).CornerRadius=UDim.new(0,8)

local noclipCell=cell(frMain,"Noclip","")

local flyBG,flyBV,flyConn
local function stopFly()
	if flyConn then flyConn:Disconnect() flyConn=nil end
	if flyBG then flyBG:Destroy() flyBG=nil end
	if flyBV then flyBV:Destroy() flyBV=nil end
	local h=hum() if h then h.PlatformStand=false end
end
bindToggle(flyCell,function(on)
	stopFly()
	if not on then return end
	local root=hrp(); local h=hum()
	if not root or not h then return end
	h.PlatformStand=true
	flyBG=Instance.new("BodyGyro",root); flyBG.P=9e4; flyBG.MaxTorque=Vector3.new(9e9,9e9,9e9); flyBG.CFrame=Camera.CFrame
	flyBV=Instance.new("BodyVelocity",root); flyBV.P=9e4; flyBV.MaxForce=Vector3.new(9e9,9e9,9e9); flyBV.Velocity=Vector3.new()
	flyConn=RunService.RenderStepped:Connect(function()
		flyBG.CFrame=Camera.CFrame
		local spd=tonumber(flySpeedIn.Text) or 4
		local dir=Vector3.new()
		if UIS:IsKeyDown(Enum.KeyCode.W)then dir+=Camera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S)then dir-=Camera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A)then dir-=Camera.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D)then dir+=Camera.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space)then dir+=Vector3.new(0,1,0) end
		if UIS:IsKeyDown(Enum.KeyCode.LeftShift)then dir-=Vector3.new(0,1,0) end
		if dir.Magnitude>0 then dir=dir.Unit*spd*30 else dir=Vector3.new() end
		flyBV.Velocity=dir
	end)
end)

-- Noclip
local noclipConn
bindToggle(noclipCell,function(on)
	if noclipConn then noclipConn:Disconnect() noclipConn=nil end
	if on then
		noclipConn=RunService.Stepped:Connect(function()
			local ch=LP.Character
			if not ch then return end
			for _,p in ipairs(ch:GetDescendants())do
				if p:IsA("BasePart") then p.CanCollide=false end
			end
		end)
	else
		local ch=LP.Character
		if ch then
			for _,p in ipairs(ch:GetDescendants())do
				if p:IsA("BasePart") then p.CanCollide=true end
			end
		end
	end
end)

local tpOnceCell=cell(frMain,"Teleport (one click)","")
local tpOnceActive=false
bindToggle(tpOnceCell,function(on)
	tpOnceActive=on
end)
local mouse=LP:GetMouse()
mouse.Button1Down:Connect(function()
	if not tpOnceActive then return end
	local pos = mouse.Hit and mouse.Hit.p
	local root=hrp()
	if pos and root then
		root.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
	end
	tpOnceActive=false
	local t=tpOnceCell:FindFirstChild("Toggle")
	if t then local fill=t:FindFirstChild("Fill"); if fill then fill.Size=UDim2.fromOffset(0,0); task.defer(function() fill.Visible=false end) end end
end)

local frESP=makeTab("ESP/Aim")
section(frESP,"ESP & Aim")

local espMaster=cell(frESP,"Toggle ESP","")
local espName=cell(frESP,"Show Name","")
local espHP=cell(frESP,"Show Health","")
local espDist=cell(frESP,"Show Distance","")
local espPlayers=cell(frESP,"Include Players","")
local espNPC=cell(frESP,"Include NPCs","")
local espTeam=cell(frESP,"Team Check","")

section(frESP,"ESP Color")
local espColor=Color3.fromRGB(255,0,0)
local rowESP=Instance.new("Frame",frESP) rowESP.BackgroundTransparency=1 rowESP.Size=UDim2.new(1,0,0,40)
local espColors={Color3.fromRGB(255,0,0),Color3.fromRGB(255,120,80),Color3.fromRGB(255,220,60),Color3.fromRGB(80,220,120),Color3.fromRGB(0,170,255),Color3.fromRGB(200,200,210)}
for i,c in ipairs(espColors)do
	local b=Instance.new("TextButton",rowESP)
	b.Text=""
	b.AutoButtonColor=true
	b.BackgroundColor3=c
	b.BorderSizePixel=0
	b.Size=UDim2.fromOffset(28,28)
	b.Position=UDim2.fromOffset((i-1)*34,6)
	Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)
	b.MouseButton1Click:Connect(function() espColor=c end)
end

local aimOnCell=cell(frESP,"Aimbot ON","")
local aimTargetBtn,aimRight=listCell(frESP,"Aimbot Target","Head")
local aimTeamCell=cell(frESP,"Aimbot Team Check","")
local smoothCell=cell(frESP,"Aim Smoothing","")
local smoothIn=Instance.new("TextBox",frESP)
smoothIn.BackgroundColor3=C_SIDE; smoothIn.BorderSizePixel=0; smoothIn.PlaceholderText="Smooth (e.g. 0.15)"; smoothIn.PlaceholderColor3=C_MUT
smoothIn.TextColor3=C_TXT; smoothIn.Font=Enum.Font.Gotham; smoothIn.TextSize=14; smoothIn.Text="0.15"; smoothIn.Size=UDim2.new(1,0,0,30)
Instance.new("UICorner",smoothIn).CornerRadius=UDim.new(0,8)

section(frESP,"FOV")
local fovToggle=cell(frESP,"Show FOV","")
local fovSizeIn=Instance.new("TextBox",frESP)
fovSizeIn.BackgroundColor3=C_SIDE; fovSizeIn.BorderSizePixel=0; fovSizeIn.PlaceholderText="FOV radius (e.g. 120)"; fovSizeIn.PlaceholderColor3=C_MUT
fovSizeIn.TextColor3=C_TXT; fovSizeIn.Font=Enum.Font.Gotham; fovSizeIn.TextSize=14; fovSizeIn.Text="120"; fovSizeIn.Size=UDim2.new(1,0,0,30)
Instance.new("UICorner",fovSizeIn).CornerRadius=UDim.new(0,8)
local fovRow=Instance.new("Frame",frESP) fovRow.BackgroundTransparency=1 fovRow.Size=UDim2.new(1,0,0,40)
local fovColor=Color3.fromRGB(255,0,0)
for i,c in ipairs(espColors)do
	local b=Instance.new("TextButton",fovRow)
	b.Text=""
	b.AutoButtonColor=true
	b.BackgroundColor3=c
	b.BorderSizePixel=0
	b.Size=UDim2.fromOffset(28,28)
	b.Position=UDim2.fromOffset((i-1)*34,6)
	Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)
	b.MouseButton1Click:Connect(function() fovColor=c end)
end

local fovFrame=Instance.new("Frame")
fovFrame.Size=UDim2.fromOffset(240,240)
fovFrame.AnchorPoint=Vector2.new(0.5,0.5)
fovFrame.Position=UDim2.fromScale(0.5,0.5)
fovFrame.BackgroundTransparency=1
fovFrame.Visible=false
fovFrame.Parent=overlay
local fovStroke=Instance.new("UIStroke",fovFrame)
fovStroke.Thickness=2
fovStroke.Color=fovColor
local fovCorner=Instance.new("UICorner",fovFrame)
fovCorner.CornerRadius=UDim.new(1,0)

local espOn=false
local wantName=false
local wantHP=false
local wantDist=false
local wantPlayers=false
local wantNPC=false
local wantTeam=false
local highlights={}
local nameBoards={}

local function sameTeam(aPlr,bPlr)
	if not wantTeam then return false end
	if not aPlr or not bPlr then return false end
	return (aPlr.Team~=nil and bPlr.Team~=nil and aPlr.Team==bPlr.Team)
end

local function clearESP()
	for k,h in pairs(highlights)do if h and h.Parent then h:Destroy() end highlights[k]=nil end
	for k,g in pairs(nameBoards)do if g and g.Parent then g:Destroy() end nameBoards[k]=nil end
end

local function headOrRoot(m)
	return m:FindFirstChild("Head") or m:FindFirstChild("HumanoidRootPart") or m:FindFirstChildWhichIsA("BasePart")
end

local function attachHighlightFor(char,label)
	if not char then return end
	local root=headOrRoot(char); if not root then return end
	local key=char
	local h=highlights[key]
	if not h then
		h=Instance.new("Highlight")
		h.Adornee=char
		h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
		h.FillTransparency=1
		h.OutlineTransparency=0
		h.Parent=overlay
		highlights[key]=h
	end
	h.OutlineColor=espColor

	if wantName or wantHP or wantDist then
		local bg=nameBoards[key]
		if not bg then
			bg=Instance.new("BillboardGui",overlay)
			bg.AlwaysOnTop=true
			bg.Size=UDim2.fromOffset(260,36)
			bg.StudsOffset=Vector3.new(0,2.6,0)
			bg.Adornee=root
			local t=Instance.new("TextLabel",bg)
			t.Name="L"
			t.BackgroundTransparency=1
			t.Font=Enum.Font.GothamBold
			t.TextSize=16
			t.TextColor3=espColor
			t.Text=""
			t.Size=UDim2.fromScale(1,1)
			nameBoards[key]=bg
		else
			bg.Adornee=root
		end
		local txt=label or ""
		if wantDist then local me=hrp() if me then local d=(root.Position-me.Position).Magnitude txt=txt..string.format(" [%.0f]",d) end end
		if wantHP then local hmd=char:FindFirstChildOfClass("Humanoid"); if hmd then txt=txt..string.format(" (%d HP)",math.floor(hmd.Health)) end end
		nameBoards[key].L.Text=txt
		nameBoards[key].L.TextColor3=espColor
	else
		local bg=nameBoards[key]
		if bg then bg:Destroy() nameBoards[key]=nil end
	end
end

local function scanESP()
	if not espOn then clearESP() return end
	if wantPlayers then
		for _,p in ipairs(Players:GetPlayers())do
			if p~=LP and p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
				if not sameTeam(LP,p) then
					attachHighlightFor(p.Character, wantName and p.Name or "")
				end
			end
		end
	end
	if wantNPC then
		for _,m in ipairs(workspace:GetDescendants())do
			if m:IsA("Model") and m:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(m) then
				attachHighlightFor(m, wantName and m.Name or "")
			end
		end
	end
end

bindToggle(espMaster,function(on) espOn=on if not on then clearESP() end end)
bindToggle(espName,function(v) wantName=v end)
bindToggle(espHP,function(v) wantHP=v end)
bindToggle(espDist,function(v) wantDist=v end)
bindToggle(espPlayers,function(v) wantPlayers=v end)
bindToggle(espNPC,function(v) wantNPC=v end)
bindToggle(espTeam,function(v) wantTeam=v end)

local aimbotOn=false
local aimTargetName="Head"
local aimTeam=false
local function partForTarget(model)
	return model:FindFirstChild(aimTargetName) or model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart")
end

bindToggle(aimOnCell,function(on) aimbotOn=on end)
bindToggle(aimTeamCell,function(on) aimTeam=on end)

aimTargetBtn.MouseButton1Click:Connect(function()
	local abs=aimTargetBtn.AbsolutePosition-content.AbsolutePosition
	makeDropdown(Vector2.new(abs.X,abs.Y),{"Head","Body","Foot"},function(opt)
		if opt=="Body" then aimTargetName="HumanoidRootPart" aimRight.Text="Body"
		elseif opt=="Foot" then aimTargetName="RightFoot" aimRight.Text="Foot"
		else aimTargetName="Head" aimRight.Text="Head" end
	end)
end)

local showFOV=false
bindToggle(fovToggle,function(on) showFOV=on fovFrame.Visible=on end)

local function withinFOV(vp)
	local radius=tonumber(fovSizeIn.Text) or 120
	local center=UIS:GetMouseLocation()
	local d=(Vector2.new(vp.X,vp.Y)-center).Magnitude
	return d<=radius
end

local function gatherTargets()
	local t={}
	if wantPlayers then
		for _,p in ipairs(Players:GetPlayers())do
			if p~=LP and p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
				if not (aimTeam and sameTeam(LP,p)) then
					table.insert(t,p.Character)
				end
			end
		end
	end
	if wantNPC then
		for _,m in ipairs(workspace:GetDescendants())do
			if m:IsA("Model") and m:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(m) then
				table.insert(t,m)
			end
		end
	end
	return t
end

local function bestTarget()
	local best=nil
	local bestDist=math.huge
	for _,char in ipairs(gatherTargets())do
		local part=partForTarget(char)
		if part then
			local v,on=Camera:WorldToViewportPoint(part.Position)
			if on and withinFOV(v) then
				local m=UIS:GetMouseLocation()
				local d=(Vector2.new(v.X,v.Y)-m).Magnitude
				if d<bestDist then
					bestDist=d
					best={part=part}
				end
			end
		end
	end
	return best
end

local currentAim=nil
local aimMainConn
if aimMainConn then aimMainConn:Disconnect() end
aimMainConn=RunService.RenderStepped:Connect(function(dt)
	if espOn then scanESP() end

	if fovFrame.Visible then
		local r=math.max(20, math.min(600, tonumber(fovSizeIn.Text) or 120))
		fovFrame.Size=UDim2.fromOffset(r*2, r*2)
		fovStroke.Color=fovColor
		fovFrame.Position=UDim2.fromScale(0.5,0.5)
	end

	for _,h in pairs(highlights)do if h then h.OutlineColor=espColor end end
	for _,bg in pairs(nameBoards)do if bg and bg:FindFirstChild("L") then bg.L.TextColor3=espColor end end

	if not aimbotOn then currentAim=nil return end

	local function aimAt(part)
		local smooth=tonumber(smoothIn.Text) or 0.15
		smooth=math.clamp(smooth,0,1)
		local dir=(part.Position-Camera.CFrame.Position).Unit
		local targetCFrame=CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + dir)
		if smooth<=0.001 then
			Camera.CFrame = targetCFrame
		else
			Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, smooth)
		end
	end

	local stillValid=false
	if currentAim and currentAim.part and currentAim.part.Parent then
		local v,on=Camera:WorldToViewportPoint(currentAim.part.Position)
		if on and withinFOV(v) then
			stillValid=true
			aimAt(currentAim.part)
		end
	end
	if not stillValid then
		currentAim=bestTarget()
		if currentAim and currentAim.part then
			aimAt(currentAim.part)
		end
	end
end)

-- CONFIG
local frConfig=makeTab("Config")
section(frConfig,"Performance")

local fogCell=cell(frConfig,"Remove Fog","")
local grassCell=cell(frConfig,"Remove Vegetation (visual)","")
local alCell=cell(frConfig,"Anti-Lag (disable env light)","")
local shadowsCell=cell(frConfig,"Remove Shadows","")
local fullbrightCell=cell(frConfig,"NightVision (Fullbright)","")

local meshButton,meshRight=listCell(frConfig,"Mesh Quality","Auto")
local meshMap={["Auto"]="Automatic",["Very high"]="Precise",["High"]="Precise",["Medium"]="Automatic",["Low"]="Performance",["Very low"]="Performance"}
local function setFidelity(part,mode)
	if mode=="Automatic" then part.RenderFidelity=Enum.RenderFidelity.Automatic
	elseif mode=="Performance" then part.RenderFidelity=Enum.RenderFidelity.Performance
	else part.RenderFidelity=Enum.RenderFidelity.Precise end
end
local function applyMesh(humanOpt)
	local mode=meshMap[humanOpt] or "Automatic"
	for _,d in ipairs(workspace:GetDescendants())do
		if d:IsA("MeshPart") then setFidelity(d,mode) end
	end
	meshRight.Text=humanOpt
end
meshButton.MouseButton1Click:Connect(function()
	local abs=meshButton.AbsolutePosition-content.AbsolutePosition
	makeDropdown(Vector2.new(abs.X,abs.Y),{"Auto","Very high","High","Medium","Low","Very low"},function(opt) applyMesh(opt) end)
end)

local function setProp(o,p,v) pcall(function() o[p]=v end) end
local function getProp(o,p) local ok,v=pcall(function() return o[p] end) return ok and v or nil end
local savedBright={Brightness=getProp(Lighting,"Brightness"),Ambient=getProp(Lighting,"Ambient"),ClockTime=getProp(Lighting,"ClockTime"),ColorShift_Top=getProp(Lighting,"ColorShift_Top"),ColorShift_Bottom=getProp(Lighting,"ColorShift_Bottom"),OutdoorAmbient=getProp(Lighting,"OutdoorAmbient")}
local savedAtmos=Lighting:FindFirstChildOfClass("Atmosphere")
local effFolder=Instance.new("Folder",Lighting) effFolder.Name="_AM_Effects"
local function ensureCC() local cc=effFolder:FindFirstChildOfClass("ColorCorrectionEffect") if not cc then cc=Instance.new("ColorCorrectionEffect",effFolder) end return cc end
local function setFog(on)
	local atm=Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere",Lighting)
	if on then setProp(atm,"Density",0) setProp(Lighting,"FogEnd",1e6) setProp(Lighting,"FogStart",1e6)
	else setProp(atm,"Density",0.3) setProp(Lighting,"FogEnd",100000) setProp(Lighting,"FogStart",0) end
end
local function setAntiLag(on)
	if on then setProp(Lighting,"EnvironmentSpecularScale",0) setProp(Lighting,"EnvironmentDiffuseScale",0)
	else setProp(Lighting,"EnvironmentSpecularScale",1) setProp(Lighting,"EnvironmentDiffuseScale",1) end
end
local function setShadows(on) setProp(Lighting,"GlobalShadows", not on) end
local function nightVision(on)
	if on then
		local cc=ensureCC()
		cc.Brightness=0.15; cc.Contrast=0.1; cc.Saturation=0.05; cc.TintColor=Color3.new(1,1,1)
		setProp(Lighting,"Brightness",2.2); setProp(Lighting,"Ambient",Color3.new(1,1,1)); setProp(Lighting,"OutdoorAmbient",Color3.new(1,1,1))
		setProp(Lighting,"ClockTime",14); setProp(Lighting,"ColorShift_Top",Color3.new(1,1,1)); setProp(Lighting,"ColorShift_Bottom",Color3.new(1,1,1))
		setFog(true)
	else
		for k,v in pairs(savedBright)do if v~=nil then setProp(Lighting,k,v) end end
		if savedAtmos then savedAtmos.Parent=Lighting end
		local cc=effFolder:FindFirstChildOfClass("ColorCorrectionEffect") if cc then cc:Destroy() end
	end
end

bindToggle(fogCell,setFog)
bindToggle(alCell,setAntiLag)
bindToggle(shadowsCell,setShadows)
bindToggle(fullbrightCell,nightVision)

-- Vegetation visual hide
local _veg_on=false
local vegTouched={}
local VEG_KEYWORDS={"tree","arvore","árvore","bush","arbusto","leaf","folha","leaves","grass","grama","flower","flor","plant","planta","hedge","vine","vinha","foliage","vegetation","trunk","tronco","wood","madeira","palm","pine","oak","weed","mato","bamboo","cactus","leafy"}
local VEG_MATERIALS={[Enum.Material.Grass]=true,[Enum.Material.LeafyGrass]=true,[Enum.Material.Wood]=true,[Enum.Material.Fabric]=true}
local function looksLikeVegetation(part)
	if VEG_MATERIALS[part.Material] then return true end
	local n=(part.Name or ""):lower()
	for _,kw in ipairs(VEG_KEYWORDS)do if string.find(n,kw,1,true) then return true end end
	local p=part.Parent
	if p and p.Name then
		local pn=p.Name:lower()
		for _,kw in ipairs({"vegetation","foliage","trees","árvores","arvores","plants","nature","flora","grass"})do
			if string.find(pn,kw,1,true) then return true end
		end
	end
	return false
end
local function hideVeg(part)
	if vegTouched[part] then return end
	vegTouched[part]={ltm=part.LocalTransparencyModifier or 0, collide=part.CanCollide}
	part.LocalTransparencyModifier=1
	part.CanCollide=false
	for _,d in ipairs(part:GetDescendants())do
		if d:IsA("ParticleEmitter") or d:IsA("Trail") then d.Enabled=false end
	end
end
local function showVeg(part)
	local old=vegTouched[part]
	if not old then return end
	part.LocalTransparencyModifier=old.ltm
	part.CanCollide=old.collide
	vegTouched[part]=nil
end
local function applyVegetation(on)
	_veg_on=on
	if workspace.Terrain then workspace.Terrain.Decoration=not on end
	if on then
		for _,inst in ipairs(workspace:GetDescendants())do
			if inst:IsA("BasePart") and looksLikeVegetation(inst) then hideVeg(inst) end
		end
	else
		for part,_ in pairs(vegTouched)do if part and part.Parent then showVeg(part) end end
	end
end
bindToggle(grassCell,applyVegetation)
task.spawn(function()
	while true do
		if _veg_on then
			for _,inst in ipairs(workspace:GetDescendants())do
				if inst:IsA("BasePart") and looksLikeVegetation(inst) then hideVeg(inst) end
			end
		end
		task.wait(1.2)
	end
end)
LP.CharacterAdded:Connect(function()
	if _veg_on then task.defer(function() applyVegetation(true) end) end
end)

-- GUI Colors
section(frConfig,"GUI Colors")
local rowPal=Instance.new("Frame",frConfig) rowPal.BackgroundTransparency=1 rowPal.Size=UDim2.new(1,0,0,200) rowPal.ZIndex=20
local function refreshTheme()
	win.BackgroundColor3=C_BG
	content.BackgroundColor3=C_BG
	top.BackgroundColor3=C_SIDE
	side.BackgroundColor3=C_SIDE
end
local OLD_BG={Color3.fromRGB(24,24,28),Color3.fromRGB(30,30,36),Color3.fromRGB(35,35,42),Color3.fromRGB(40,40,48),Color3.fromRGB(50,50,60)}
local OLD_SIDE={Color3.fromRGB(35,35,42),Color3.fromRGB(44,44,54),Color3.fromRGB(58,58,70)}
local BLUES= (function()
	local t={}
	local src={{10,18,28},{12,22,36},{14,26,44},{16,30,52},{18,34,60},{20,38,68},{22,42,76},{24,46,84},{26,50,92},{28,54,100},{30,60,112},{32,66,124},{34,72,136},{36,78,148},{38,84,160},{40,90,172}}
	for _,rgb in ipairs(src)do table.insert(t,Color3.fromRGB(rgb[1],rgb[2],rgb[3])) end
	return t
end)()
local function uiDot(x,y,col,apply)
	local b=Instance.new("TextButton",rowPal)
	b.Text=""
	b.AutoButtonColor=true
	b.BackgroundColor3=col
	b.BorderSizePixel=0
	b.Size=UDim2.fromOffset(22,22)
	b.Position=UDim2.fromOffset(x,y)
	b.ZIndex=21
	Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)
	b.MouseButton1Click:Connect(function() pcall(apply,col) refreshTheme() end)
end
local x=0 for _,c in ipairs(OLD_BG)do uiDot(x,6,c,function(col) C_BG=col end) x+=26 end
for _,c in ipairs(BLUES)do uiDot(x,6,c,function(col) C_BG=col end) x+=26 end
x=0 for _,c in ipairs(OLD_SIDE)do uiDot(x,40,c,function(col) C_SIDE=col end) x+=26 end
for _,c in ipairs(BLUES)do uiDot(x,40,c,function(col) C_SIDE=col end) x+=26 end
x=0 for _,c in ipairs(OLD_BG)do uiDot(x,74,c,function(col) C_CARD=col end) x+=26 end
for _,c in ipairs(BLUES)do uiDot(x,74,c,function(col) C_CARD=col end) x+=26 end

local resetBtn=Instance.new("TextButton",rowPal)
resetBtn.Text="Reset GUI (full)"
resetBtn.Font=Enum.Font.GothamBold
resetBtn.TextSize=16
resetBtn.TextColor3=C_TXT
resetBtn.BackgroundColor3=C_CARD
resetBtn.BorderSizePixel=0
resetBtn.Size=UDim2.fromOffset(160,32)
resetBtn.Position=UDim2.fromOffset(0,108)
Instance.new("UICorner",resetBtn).CornerRadius=UDim.new(0,8)

local TXT_CHOICES={Color3.fromRGB(255,255,255),Color3.fromRGB(220,220,225),Color3.fromRGB(190,190,200),Color3.fromRGB(150,150,160),Color3.fromRGB(120,120,130),Color3.fromRGB(255,0,0),Color3.fromRGB(0,200,80),Color3.fromRGB(0,170,255)}
section(frConfig,"Text color")
local rowTxt=Instance.new("Frame",frConfig) rowTxt.BackgroundTransparency=1 rowTxt.Size=UDim2.new(1,0,0,36)
for i,c in ipairs(TXT_CHOICES)do
	local b=Instance.new("TextButton",rowTxt)
	b.Text=""
	b.AutoButtonColor=true
	b.BackgroundColor3=c
	b.BorderSizePixel=0
	b.Size=UDim2.fromOffset(28,28)
	b.Position=UDim2.fromOffset((i-1)*34,4)
	Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)
	b.MouseButton1Click:Connect(function()
		C_TXT=c; title.TextColor3=c
		for _,lbl in ipairs(recolorLabels)do if lbl and lbl.Parent then lbl.TextColor3=c end end
	end)
end

local function resetAll()
	C_BG=DEF_BG; C_SIDE=DEF_SIDE; C_CARD=DEF_CARD; C_TXT=DEF_TXT; refreshTheme()
	title.TextColor3=C_TXT
	for _,lbl in ipairs(recolorLabels)do if lbl and lbl.Parent then lbl.TextColor3=C_TXT end end

	for _,fr in ipairs(content:GetChildren())do
		if fr:IsA("Frame")then
			for _,cellFrame in ipairs(fr:GetDescendants())do
				if cellFrame:IsA("TextButton") and cellFrame.Name=="Toggle" then
					local fill=cellFrame:FindFirstChild("Fill")
					if fill then fill.Visible=false; fill.Size=UDim2.fromOffset(0,0) end
				end
			end
		end
	end

	if speedLoop then speedLoop:Disconnect() speedLoop=nil end
	stopFly()
	applyVegetation(false); setFog(false); setAntiLag(false); setShadows(false); nightVision(false)
	clearESP(); espOn=false; wantName=false; wantHP=false; wantDist=false; wantPlayers=false; wantNPC=false; wantTeam=false
	aimbotOn=false; currentAim=nil
	speedIn.Text=""; jumpIn.Text=""; flySpeedIn.Text="4"; meshRight.Text="Auto"; applyMesh("Auto")
	fovFrame.Visible=false
end
resetBtn.MouseButton1Click:Connect(resetAll)

for _,btn in pairs(buttons)do
	btn.MouseButton1Click:Connect(function() selectTab(btn) end)
end
selectTab(buttons["Credits"])

local dragging=false; local startPos; local dragStart
local function updateDrag(i)
	local d=i.Position-dragStart
	win.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
end
top.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
		dragging=true; dragStart=i.Position; startPos=win.Position
	end
end)
top.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end
end)
UIS.InputChanged:Connect(function(i)
	if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then updateDrag(i) end
end)

local minimized=false
btnMin.MouseButton1Click:Connect(function()
	minimized=not minimized
	local target = minimized and UDim2.new(win.Size.X.Scale,win.Size.X.Offset,0,44) or UDim2.fromScale(0.54,0.58)
	TweenService:Create(win,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=target}):Play()
	side.Visible=not minimized; content.Visible=not minimized
end)
local reopen=Instance.new("TextButton",gui)
reopen.Text="AM"
reopen.Font=Enum.Font.GothamBold
reopen.TextSize=14
reopen.TextColor3=C_TXT
reopen.BackgroundColor3=C_SIDE
reopen.BorderSizePixel=0
reopen.Size=UDim2.fromOffset(40,40)
reopen.Position=UDim2.new(0,16,1,-56)
reopen.Visible=false
Instance.new("UICorner",reopen).CornerRadius=UDim.new(1,0)
btnClose.MouseButton1Click:Connect(function() win.Visible=false reopen.Visible=true end)
reopen.MouseButton1Click:Connect(function() reopen.Visible=false win.Visible=true end)
