local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local PhysicsService = game:GetService("PhysicsService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local DEF_BG = Color3.fromRGB(24,24,28)
local DEF_SIDE = Color3.fromRGB(35,35,42)
local DEF_CARD = Color3.fromRGB(40,40,48)
local DEF_TXT = Color3.fromRGB(235,235,240)
local C_BG,C_SIDE,C_CARD,C_TXT = DEF_BG,DEF_SIDE,DEF_CARD,DEF_TXT
local C_MUT = Color3.fromRGB(170,170,178)
local C_STK = Color3.fromRGB(58,58,70)
local ACCENT = Color3.fromRGB(150,105,255)

local function hum() local ch=LP.Character or LP.CharacterAdded:Wait() return ch:FindFirstChildOfClass("Humanoid") end
local function hrp() local ch=LP.Character or LP.CharacterAdded:Wait() return ch:FindFirstChild("HumanoidRootPart") end
local function safeHum() local ok,v=pcall(hum) if ok then return v end end
local function safeHRP() local ok,v=pcall(hrp) if ok then return v end end

local gui = Instance.new("ScreenGui",LP:WaitForChild("PlayerGui"))
gui.Name = "AimMany_Menu"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local overlay = Instance.new("ScreenGui",LP.PlayerGui)
overlay.Name = "AimMany_Overlay"
overlay.IgnoreGuiInset = true
overlay.ResetOnSpawn = false
overlay.DisplayOrder = 1000

local win = Instance.new("Frame",gui)
win.Size = UDim2.fromScale(0.55,0.6)
win.Position = UDim2.fromScale(0.22,0.2)
win.BackgroundColor3 = C_BG
win.BorderSizePixel = 0
Instance.new("UICorner",win).CornerRadius = UDim.new(0,14)
local ws = Instance.new("UIStroke",win) ws.Color=C_STK ws.Transparency=0.35

local top = Instance.new("Frame",win)
top.Size = UDim2.new(1,0,0,44)
top.BackgroundColor3 = C_SIDE
top.BorderSizePixel = 0
Instance.new("UICorner",top).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel",top)
title.BackgroundTransparency=1
title.Font=Enum.Font.GothamBold
title.Text="AimMany Menu by K3ngx1RIV"
title.TextSize=30
title.TextColor3=C_TXT
title.TextXAlignment=Enum.TextXAlignment.Left
title.Position=UDim2.fromOffset(12,0)
title.Size=UDim2.new(1,-120,1,0)

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
	b.Size=UDim2.fromOffset(28,28)
	b.AnchorPoint=Vector2.new(1,0.5)
	b.Position=UDim2.new(1,-off,0.5,0)
	return b
end
local btnClose=topBtn(12,"×","Close")
local btnMin=topBtn(48,"–","Min")

local side = Instance.new("Frame",win)
side.BackgroundColor3=C_SIDE
side.Position=UDim2.new(0,0,0,44)
side.Size=UDim2.new(0,180,1,-44)
side.BorderSizePixel=0
Instance.new("UICorner",side).CornerRadius=UDim.new(0,14)
local sl=Instance.new("UIListLayout",side) sl.Padding=UDim.new(0,8)

local content = Instance.new("ScrollingFrame",win)
content.BackgroundTransparency=1
content.Position=UDim2.new(0,180,0,44)
content.Size=UDim2.new(1,-180,1,-44)
content.ScrollBarThickness=6
content.CanvasSize=UDim2.fromOffset(0,0)
content.AutomaticCanvasSize=Enum.AutomaticSize.Y
local cpad=Instance.new("UIPadding",content)
cpad.PaddingTop=UDim.new(0,6);cpad.PaddingBottom=UDim.new(0,6);cpad.PaddingLeft=UDim.new(0,6);cpad.PaddingRight=UDim.new(0,6)

local function vlist(p) local l=Instance.new("UIListLayout",p) l.Padding=UDim.new(0,10) l.SortOrder=Enum.SortOrder.LayoutOrder return l end
local function section(p,txt) local h=Instance.new("TextLabel",p) h.BackgroundTransparency=1 h.Font=Enum.Font.GothamBold h.Text=txt h.TextSize=16 h.TextColor3=C_TXT h.TextXAlignment=Enum.TextXAlignment.Left h.Size=UDim2.new(1,0,0,22) end

local function makeToggleCell(parent,labelText,rightText)
	local f=Instance.new("Frame",parent)
	f.Size=UDim2.new(1,0,0,48)
	f.BackgroundColor3=C_CARD
	f.BorderSizePixel=0
	Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
	local st=Instance.new("UIStroke",f) st.Color=C_STK st.Transparency=0.45
	local lbl=Instance.new("TextLabel",f)
	lbl.BackgroundTransparency=1
	lbl.Font=Enum.Font.Gotham
	lbl.Text=labelText
	lbl.TextSize=16
	lbl.TextColor3=C_TXT
	lbl.TextXAlignment=Enum.TextXAlignment.Left
	lbl.Position=UDim2.fromOffset(12,0)
	lbl.Size=UDim2.new(0.6,0,1,0)
	if rightText then
		local r=Instance.new("TextLabel",f)
		r.Name="Right";r.BackgroundTransparency=1;r.Font=Enum.Font.GothamBold;r.Text=rightText;r.TextSize=16;r.TextColor3=C_TXT
		r.TextXAlignment=Enum.TextXAlignment.Right;r.Position=UDim2.new(1,-200,0,0);r.Size=UDim2.new(0,190,1,0);r.TextTruncate=Enum.TextTruncate.AtEnd
	end
	local btn=Instance.new("TextButton",f)
	btn.Name="Toggle";btn.Size=UDim2.fromOffset(36,36);btn.Position=UDim2.new(1,-64,0.5,-18);btn.BackgroundColor3=C_SIDE;btn.Text="";btn.AutoButtonColor=true
	Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)
	local fill=Instance.new("Frame",btn)
	fill.Name="Fill";fill.Size=UDim2.fromOffset(0,0);fill.Position=UDim2.fromScale(0.5,0.5);fill.AnchorPoint=Vector2.new(0.5,0.5);fill.BackgroundColor3=ACCENT;fill.Visible=false
	Instance.new("UICorner",fill).CornerRadius=UDim.new(0,8)
	return f,btn,fill
end

local function makeListCell(parent,labelText, initialRight)
	local f=Instance.new("TextButton",parent)
	f.BackgroundColor3=C_CARD;f.BorderSizePixel=0;f.AutoButtonColor=true;f.Size=UDim2.new(1,0,0,48);f.Text=""
	Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
	local st=Instance.new("UIStroke",f) st.Color=C_STK st.Transparency=0.45
	local lbl=Instance.new("TextLabel",f)
	lbl.BackgroundTransparency=1;lbl.Font=Enum.Font.Gotham;lbl.Text=labelText;lbl.TextSize=18;lbl.TextColor3=C_TXT;lbl.TextXAlignment=Enum.TextXAlignment.Left;lbl.Position=UDim2.fromOffset(12,0);lbl.Size=UDim2.new(0.6,0,1,0)
	local right=Instance.new("TextLabel",f)
	right.Name="Right";right.BackgroundTransparency=1;right.Font=Enum.Font.GothamBold;right.Text=initialRight or "Select";right.TextSize=16;right.TextColor3=C_TXT
	right.TextXAlignment=Enum.TextXAlignment.Right;right.Position=UDim2.new(1,-260,0,0);right.Size=UDim2.new(0,240,1,0);right.TextTruncate=Enum.TextTruncate.AtEnd
	return f,right
end

local tabFrames={}
local function makeSideButton(name)
	local b=Instance.new("TextButton",side)
	b.Size=UDim2.new(1,0,0,36);b.Text=name;b.Font=Enum.Font.Gotham;b.TextSize=15;b.TextColor3=C_MUT;b.BackgroundColor3=C_SIDE;b.BorderSizePixel=0
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
	local st=Instance.new("UIStroke",b) st.Color=C_STK st.Transparency=0.5
	b.MouseButton1Click:Connect(function()
		for _,fr in pairs(tabFrames) do fr.Visible=false end
		tabFrames[name].Visible=true
		for _,btn in ipairs(side:GetChildren()) do if btn:IsA("TextButton") then btn.BackgroundColor3=C_SIDE end end
		b.BackgroundColor3=C_CARD
	end)
	return b
end

local function makeTab(name)
	local fr=Instance.new("Frame",content)
	fr.Name=name;fr.Size=UDim2.fromScale(1,1);fr.BackgroundTransparency=1;fr.Visible=false;vlist(fr);tabFrames[name]=fr;return fr
end

local btnMain=makeSideButton("Main")
local btnAim=makeSideButton("ESP/Aim")
local btnCredits=makeSideButton("Credits")

local frMain=makeTab("Main")
local frAim=makeTab("ESP/Aim")
local frCredits=makeTab("Credits")

section(frCredits,"About")
local crLabel=Instance.new("TextLabel",frCredits)
crLabel.BackgroundTransparency=1;crLabel.Font=Enum.Font.GothamBold;crLabel.TextSize=16;crLabel.TextColor3=C_TXT;crLabel.Size=UDim2.new(1,0,0,110)
crLabel.Text="AimMany Menu TEST + Admin Commands \nVersion: 1.5.2\n\nmore updates coming soon :3"
crLabel.TextXAlignment=Enum.TextXAlignment.Left;crLabel.TextYAlignment=Enum.TextYAlignment.Top

section(frMain,"Movement")
local wsCell,wsBtn,wsFill=makeToggleCell(frMain,"Walk Speed","")
local wsBox=Instance.new("TextBox",frMain)
wsBox.BackgroundColor3=C_SIDE;wsBox.Text="16";wsBox.Font=Enum.Font.Gotham;wsBox.TextColor3=C_TXT;wsBox.Size=UDim2.new(1,0,0,34)
Instance.new("UICorner",wsBox).CornerRadius=UDim.new(0,8)

local jpCell,jpBtn,jpFill=makeToggleCell(frMain,"Jump Power","")
local jpBox=wsBox:Clone() jpBox.Text="50" jpBox.Parent=frMain

local flyCell,flyBtn,flyFill=makeToggleCell(frMain,"Fly (WASD/Space/Shift)","")
local flySpeedBox=Instance.new("TextBox",frMain)
flySpeedBox.Name="FlySpeedBox"
flySpeedBox.BackgroundColor3=C_SIDE
flySpeedBox.BorderSizePixel=0
flySpeedBox.PlaceholderText="Fly Speed (e.g. 4)"
flySpeedBox.PlaceholderColor3=C_MUT
flySpeedBox.Text="4"
flySpeedBox.TextColor3=C_TXT
flySpeedBox.Font=Enum.Font.Gotham
flySpeedBox.TextSize=14
flySpeedBox.Size=UDim2.new(1,0,0,34)
Instance.new("UICorner",flySpeedBox).CornerRadius=UDim.new(0,8)

local noclipCell,ncBtn,ncFill=makeToggleCell(frMain,"Noclip (passes anchored)","")
local tpCell,tpBtn,tpFill=makeToggleCell(frMain,"Click Teleport (one-shot)","")
local fcCell,fcBtn,fcFill=makeToggleCell(frMain,"Freecam (testing)","")

local function setToggleVisual(btn,fill,on)
	if on then fill.Visible=true fill.Size=UDim2.fromOffset(32,32) else fill.Size=UDim2.fromOffset(0,0) task.delay(0.12,function() if fill then fill.Visible=false end end) end
	btn:SetAttribute("On",on and true or false)
end
local function connectToggle(btn,fill,cb) btn:SetAttribute("On",false) btn.MouseButton1Click:Connect(function() local on=not (btn:GetAttribute("On") or false) setToggleVisual(btn,fill,on) if cb then cb(on) end end) return btn end

connectToggle(wsBtn,wsFill,function(on) local h=safeHum() if h then if on then h.WalkSpeed=tonumber(wsBox.Text) or 16 else h.WalkSpeed=16 end end end)
wsBox.FocusLost:Connect(function(e) if e then local h=safeHum() if h then h.WalkSpeed=tonumber(wsBox.Text) or 16 end end end)

connectToggle(jpBtn,jpFill,function(on) local h=safeHum() if h then pcall(function() h.UseJumpPower=true end) h.JumpPower=on and (tonumber(jpBox.Text) or 50) or 50 end end)
jpBox.FocusLost:Connect(function(e) if e then local h=safeHum() if h then pcall(function() h.UseJumpPower=true end) h.JumpPower=tonumber(jpBox.Text) or 50 end end end)

local flyConn, antiFallConn, bgRef, bvRef, prevPlatform
local function stopFly()
	if flyConn then flyConn:Disconnect() flyConn=nil end
	if antiFallConn then antiFallConn:Disconnect() antiFallConn=nil end
	if bvRef then bvRef:Destroy() bvRef=nil end
	if bgRef then bgRef:Destroy() bgRef=nil end
	local r=safeHRP()
	if r then r.AssemblyLinearVelocity=Vector3.new() end
	local h=safeHum()
	if h then h.PlatformStand = prevPlatform or false end
end
connectToggle(flyBtn,flyFill,function(on)
	stopFly()
	if not on then return end
	local r=safeHRP()
	local h=safeHum()
	if not r or not h then return end
	prevPlatform = h.PlatformStand
	h.PlatformStand = true
	bgRef = Instance.new("BodyGyro",r)
	bgRef.P=9e4
	bgRef.MaxTorque=Vector3.new(9e9,9e9,9e9)
	bgRef.CFrame=Camera.CFrame
	bvRef = Instance.new("BodyVelocity",r)
	bvRef.P=9e4
	bvRef.MaxForce=Vector3.new(9e9,9e9,9e9)
	bvRef.Velocity=Vector3.new()
	antiFallConn = RunService.Heartbeat:Connect(function()
		if r then r.AssemblyLinearVelocity = r.AssemblyLinearVelocity*0 end
	end)
	flyConn = RunService.RenderStepped:Connect(function()
		if not r or not r.Parent then
			stopFly()
			setToggleVisual(flyBtn,flyFill,false)
			return
		end
		bgRef.CFrame = Camera.CFrame
		local s = tonumber(flySpeedBox.Text) or 4
		local d = Vector3.new()
		if UIS:IsKeyDown(Enum.KeyCode.W) then d+=Camera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then d-=Camera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then d-=Camera.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then d+=Camera.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then d+=Vector3.new(0,1,0) end
		if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then d-=Vector3.new(0,1,0) end
		if d.Magnitude>0 then d=d.Unit*s*30 else d=Vector3.new() end
		bvRef.Velocity=d
	end)
end)

local NOGR="AM_NoClip"
pcall(function() PhysicsService:CreateCollisionGroup(NOGR) end)
for _,g in ipairs(PhysicsService:GetCollisionGroups()) do
	pcall(function()
		PhysicsService:CollisionGroupSetCollidable(NOGR,g.name,false)
		PhysicsService:CollisionGroupSetCollidable(g.name,NOGR,false)
	end)
end
local function setCharGroupAndStore(char,group)
	for _,p in ipairs(char:GetDescendants()) do
		if p:IsA("BasePart") then
			if p:GetAttribute("__am_prev_cc")==nil then p:SetAttribute("__am_prev_cc", p.CanCollide and 1 or 0) end
			PhysicsService:SetPartCollisionGroup(p,group);p.CanCollide=false
		end
	end
end
local function restoreCharCollision(char)
	for _,p in ipairs(char:GetDescendants()) do
		if p:IsA("BasePart") then
			PhysicsService:SetPartCollisionGroup(p,"Default")
			local prev=p:GetAttribute("__am_prev_cc");if prev==nil then p.CanCollide=true else p.CanCollide=(prev==1) end
			p:SetAttribute("__am_prev_cc",nil)
		end
	end
end
local noclipOn=false
local noclipLoop
connectToggle(ncBtn,ncFill,function(on)
	if noclipLoop then noclipLoop:Disconnect() noclipLoop=nil end
	noclipOn=on
	if on then
		local ch=LP.Character or LP.CharacterAdded:Wait()
		setCharGroupAndStore(ch,NOGR)
		noclipLoop=RunService.Stepped:Connect(function()
			local c=LP.Character
			if not c then return end
			for _,p in ipairs(c:GetDescendants()) do
				if p:IsA("BasePart") then
					if p.CollisionGroup ~= NOGR then pcall(function() PhysicsService:SetPartCollisionGroup(p,NOGR) end) end
					if p.CanCollide then p.CanCollide=false end
				end
			end
		end)
	else
		local ch=LP.Character;if ch then restoreCharCollision(ch) end
	end
end)
LP.CharacterAdded:Connect(function(c) if noclipOn then task.defer(function() setCharGroupAndStore(c,NOGR) end) end end)

connectToggle(tpBtn,tpFill,function(on)
	if on then
		local m=LP:GetMouse();local conn
		conn=m.Button1Down:Connect(function()
			if not (tpBtn:GetAttribute("On") or false) then if conn then conn:Disconnect() end return end
			local pos=m.Hit and m.Hit.p;local r=hrp()
			if pos and r then r.CFrame=CFrame.new(pos+Vector3.new(0,3,0)) end
			if conn then conn:Disconnect() end
			setToggleVisual(tpBtn,tpFill,false)
		end)
	end
end)

local fcConn;local savedCamType,savedSubject
connectToggle(fcBtn,fcFill,function(on)
	if fcConn then fcConn:Disconnect() fcConn=nil end
	if not on then Camera.CameraType=savedCamType or Enum.CameraType.Custom Camera.CameraSubject=savedSubject return end
	savedCamType=Camera.CameraType;savedSubject=Camera.CameraSubject;Camera.CameraType=Enum.CameraType.Scriptable
	fcConn=RunService.RenderStepped:Connect(function()
		local spd=6;local cf=Camera.CFrame;local move=Vector3.new()
		if UIS:IsKeyDown(Enum.KeyCode.W) then move+=cf.LookVector*spd end
		if UIS:IsKeyDown(Enum.KeyCode.S) then move-=cf.LookVector*spd end
		if UIS:IsKeyDown(Enum.KeyCode.A) then move-=cf.RightVector*spd end
		if UIS:IsKeyDown(Enum.KeyCode.D) then move+=cf.RightVector*spd end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then move+=Vector3.new(0,spd,0) end
		if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move-=Vector3.new(0,spd,0) end
		local newPos=cf.Position+move;Camera.CFrame=CFrame.new(newPos,newPos+cf.LookVector)
	end)
end)

section(frAim,"ESP")
local espMaster,espBtn,espFill=makeToggleCell(frAim,"Toggle ESP","")
local espNameCell,espNameBtn,espNameFill=makeToggleCell(frAim,"Show Name","")
local espHPCell,espHPBtn,espHPFill=makeToggleCell(frAim,"Show HP","")
local espDistCell,espDistBtn,espDistFill=makeToggleCell(frAim,"Show Distance","")
local espPlayersCell,espPlayersBtn,espPlayersFill=makeToggleCell(frAim,"Include Players","")
local espNPCCell,espNPCBtn,espNPCFill=makeToggleCell(frAim,"Include NPCs","")

local distLabel=Instance.new("TextLabel",frAim)
distLabel.BackgroundTransparency=1;distLabel.Font=Enum.Font.Gotham;distLabel.Text="Max Distance (0 = unlimited)";distLabel.TextColor3=C_TXT;distLabel.TextSize=14;distLabel.Size=UDim2.new(1,0,0,18)
local distBox=Instance.new("TextBox",frAim)
distBox.BackgroundColor3=C_SIDE;distBox.Text="0";distBox.Font=Enum.Font.Gotham;distBox.TextColor3=C_TXT;distBox.Size=UDim2.new(1,0,0,30)
Instance.new("UICorner",distBox).CornerRadius=UDim.new(0,8)

local espPlayerColor = Color3.fromRGB(150,105,255)
local espNPCColor    = Color3.fromRGB(255,120,80)

local function makeColorRow(parent, title, onPick)
	local t = Instance.new("TextLabel", parent)
	t.BackgroundTransparency = 1
	t.Font = Enum.Font.GothamBold
	t.Text = title
	t.TextSize = 14
	t.TextColor3 = C_TXT
	t.Size = UDim2.new(1,0,0,18)

	local holder = Instance.new("Frame", parent)
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.new(1,0,0,40)

	local palette = {
		Color3.fromRGB(150,105,255), Color3.fromRGB(0,170,255),
		Color3.fromRGB(80,220,120),  Color3.fromRGB(255,220,60),
		Color3.fromRGB(255,120,80),  Color3.fromRGB(255,64,128),
		Color3.fromRGB(200,200,210), Color3.fromRGB(140,140,150)
	}

	for i,col in ipairs(palette) do
		local b = Instance.new("TextButton", holder)
		b.Text = ""
		b.AutoButtonColor = true
		b.BackgroundColor3 = col
		b.BorderSizePixel = 0
		b.Size = UDim2.fromOffset(28,28)
		b.Position = UDim2.fromOffset((i-1)*34,6)
		Instance.new("UICorner",b).CornerRadius = UDim.new(1,0)
		b.MouseButton1Click:Connect(function() onPick(col) end)
	end
end
makeColorRow(frAim, "Player color", function(c) espPlayerColor=c end)
makeColorRow(frAim, "NPC color", function(c) espNPCColor=c end)

local function isPlayerModel(m) return Players:GetPlayerFromCharacter(m) ~= nil end
local espEnabled=false;local wantName=false;local wantHP=false;local wantDist=false;local wantPlayers=true;local wantNPC=false
local highlights={};local nameGuis={}
local function clearAllESP() for _,v in pairs(highlights)do if v and v.Parent then v:Destroy() end end highlights={} for _,v in pairs(nameGuis)do if v and v.Parent then v:Destroy() end end nameGuis={} end
local function withinDistance(root) local lim=tonumber(distBox.Text) or 0 if lim<=0 then return true end local me=hrp() if not me then return true end return (root.Position-me.Position).Magnitude<=lim end

local function ensureNameBoard(model)
	local root = model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
	if not root then return nil end
	local bg = nameGuis[model]
	if not bg then
		bg = Instance.new("BillboardGui", overlay)
		bg.AlwaysOnTop = true
		bg.Size = UDim2.fromOffset(260,36)
		bg.StudsOffset = Vector3.new(0,2.6,0)
		bg.Adornee = root
		local t = Instance.new("TextLabel", bg)
		t.BackgroundTransparency = 1
		t.Font = Enum.Font.GothamBold
		t.TextSize = 16
		t.TextColor3 = Color3.new(1,1,1)
		t.Text = ""
		t.Size = UDim2.fromScale(1,1)
		nameGuis[model] = bg
	else
		bg.Adornee = root
	end
	return nameGuis[model]
end

local function attachHighlight(model)
	if not model or highlights[model] then return end
	local h=Instance.new("Highlight",overlay)
	h.Adornee=model
	h.FillTransparency=1
	h.OutlineTransparency=0
	h.OutlineColor = isPlayerModel(model) and espPlayerColor or espNPCColor
	highlights[model]=h
end

local function updateHighlight(model)
	local h=highlights[model]; if not h then return end
	local col = isPlayerModel(model) and espPlayerColor or espNPCColor
	h.OutlineColor = col

	local txt = ""
	if wantName then
		local pl = Players:GetPlayerFromCharacter(model)
		txt = pl and pl.Name or (model.Name or "")
	end
	if wantDist then
		local root = model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
		local me = hrp()
		if root and me then
			txt = string.format("%s [%.0f]", txt, (root.Position - me.Position).Magnitude)
		end
	end
	if wantHP then
		local hmd = model:FindFirstChildOfClass("Humanoid")
		if hmd then
			txt = string.format("%s (%d HP)", txt, math.floor(hmd.Health))
		end
	end

	if (wantName or wantHP or wantDist) and espEnabled then
		local bg = ensureNameBoard(model)
		if bg then
			local lab = bg:FindFirstChildOfClass("TextLabel")
			if lab then
				lab.Text = txt
				lab.TextColor3 = col
				bg.Enabled = true
			end
		end
	else
		local bg=nameGuis[model]
		if bg then bg.Enabled=false end
	end
end

local function scanAndAttach()
	if not espEnabled then clearAllESP() return end
	if wantPlayers then
		for _,p in ipairs(Players:GetPlayers()) do
			if p~=LP and p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
				local root=p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("HumanoidRootPart")
				if root and withinDistance(root) then
					if not highlights[p.Character] then attachHighlight(p.Character) end
					updateHighlight(p.Character)
				end
			end
		end
	end
	if wantNPC then
		for _,m in ipairs(workspace:GetDescendants()) do
			if m:IsA("Model") and m:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(m) then
				local root=m:FindFirstChild("Head") or m:FindFirstChild("HumanoidRootPart")
				if root and withinDistance(root) then
					if not highlights[m] then attachHighlight(m) end
					updateHighlight(m)
				end
			end
		end
	end
end

local function bindTogglePair(btn,fill,setter) connectToggle(btn,fill,function(v) setter(v) end) end
bindTogglePair(espBtn,espFill,function(v) espEnabled=v if not v then clearAllESP() end end)
bindTogglePair(espNameBtn,espNameFill,function(v) wantName=v end)
bindTogglePair(espHPBtn,espHPFill,function(v) wantHP=v end)
bindTogglePair(espDistBtn,espDistFill,function(v) wantDist=v end)
bindTogglePair(espPlayersBtn,espPlayersFill,function(v) wantPlayers=v end)
bindTogglePair(espNPCBtn,espNPCFill,function(v) wantNPC=v end)
RunService.RenderStepped:Connect(function() if espEnabled then scanAndAttach() end end)

section(frAim,"Aimbot")
local aimbotCell,aimBtn,aimFill=makeToggleCell(frAim,"Aimbot","")
local aimListBtn,aimListRight=makeListCell(frAim,"Aimbot Target","Head")
local aimTarget="Head"

local function makeDropdown(anchorAbs,options,onChoose)
	local dd=Instance.new("Frame",content);dd.BackgroundColor3=C_SIDE;dd.BorderSizePixel=0;Instance.new("UICorner",dd).CornerRadius=UDim.new(0,8)
	local h=(#options*36)+12;dd.Size=UDim2.new(0,260,0,h);local y=6
	for _,opt in ipairs(options) do local b=Instance.new("TextButton",dd) b.Text=opt b.Font=Enum.Font.Gotham b.TextSize=16 b.TextColor3=C_TXT b.BackgroundColor3=C_CARD b.BorderSizePixel=0 b.Size=UDim2.new(1,-12,0,30) b.Position=UDim2.new(0,6,0,y) Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
		b.MouseButton1Click:Connect(function() dd:Destroy() pcall(onChoose,opt) end) y=y+36 end
	dd.Position=UDim2.new(0,anchorAbs.X,0,anchorAbs.Y+44+content.CanvasPosition.Y);return dd
end

aimListBtn.MouseButton1Click:Connect(function()
	local abs=aimListBtn.AbsolutePosition-content.AbsolutePosition
	makeDropdown(Vector2.new(abs.X,abs.Y),{"Head","Body","Foot"},function(opt)
		if opt=="Body" then aimTarget="HumanoidRootPart" aimListRight.Text="Body"
		elseif opt=="Foot" then aimTarget="RightFoot" aimListRight.Text="Foot"
		else aimTarget="Head" aimListRight.Text="Head" end
	end)
end)

local function gatherTargets()
	local list={}
	for _,p in ipairs(Players:GetPlayers()) do
		if p~=LP and p.Character and p.Character:FindFirstChildOfClass("Humanoid") then table.insert(list,p.Character) end
	end
	for _,m in ipairs(workspace:GetDescendants()) do
		if m:IsA("Model") and m:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(m) then table.insert(list,m) end
	end
	return list
end
local function findAimPart(model)
	if aimTarget=="HumanoidRootPart" then return model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso") or model:FindFirstChild("LowerTorso") or model:FindFirstChild("Head")
	elseif aimTarget=="RightFoot" then return model:FindFirstChild("RightFoot") or model:FindFirstChild("RightLowerLeg") or model:FindFirstChild("LeftFoot") or model:FindFirstChild("Head")
	else return model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart") end
end
local function nearestTarget()
	local bestPart=nil local bestD=math.huge local mousePos=UIS:GetMouseLocation()
	for _,char in ipairs(gatherTargets()) do
		local part=findAimPart(char)
		if part then
			local v,on=Camera:WorldToViewportPoint(part.Position)
			if on then
				local d=(Vector2.new(v.X,v.Y)-mousePos).Magnitude
				if d<bestD then bestD=d bestPart=part end
			end
		end
	end
	return bestPart
end
local aimConn
local function setAimbot(on)
	if aimConn then aimConn:Disconnect() aimConn=nil end
	if not on then return end
	aimConn=RunService.RenderStepped:Connect(function()
		if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
			local part=nearestTarget()
			if part then
				local camPos=Camera.CFrame.Position
				local dir=(part.Position-camPos).Unit
				local desired=CFrame.new(camPos,camPos+dir)
				Camera.CFrame=Camera.CFrame:Lerp(desired,0.92)
			end
		end
	end)
end
connectToggle(aimBtn,aimFill,function(on) setAimbot(on) end)

local dragging=false;local startPos;local dragStart
top.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true dragStart=i.Position startPos=win.Position end end)
top.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
UIS.InputChanged:Connect(function(i) if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local d=i.Position - dragStart win.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y) end end)

local minimized=false
btnMin.MouseButton1Click:Connect(function()
	minimized=not minimized
	local target=minimized and UDim2.new(win.Size.X.Scale,win.Size.X.Offset,0,44) or UDim2.fromScale(0.55,0.6)
	TweenService:Create(win,TweenInfo.new(0.18,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=target}):Play()
	for _,c in pairs({side,content}) do if c then c.Visible=not minimized end end
end)

local reopen = gui:FindFirstChild("AM_Reopen")
if not reopen then
	reopen = Instance.new("TextButton")
	reopen.Name = "AM_Reopen"
	reopen.Text = "AM"
	reopen.Font = Enum.Font.GothamBold
	reopen.TextSize = 14
	reopen.TextColor3 = C_TXT
	reopen.BackgroundColor3 = C_SIDE
	reopen.BorderSizePixel = 0
	reopen.Size = UDim2.fromOffset(40,40)
	reopen.Position = UDim2.new(0,16,1,-56)
	reopen.Visible = false
	Instance.new("UICorner",reopen).CornerRadius = UDim.new(1,0)
	reopen.Parent = gui
end

btnClose.MouseButton1Click:Connect(function()
	win.Visible = false
	reopen.Visible = true
end)
reopen.MouseButton1Click:Connect(function()
	reopen.Visible = false
	win.Visible = true
end)

tabFrames["Main"].Visible=true
