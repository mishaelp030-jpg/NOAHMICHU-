-- NOAHMICHU🙊🙉🐵
-- Alerta SOLO: Mapinguari, Shenlong, Yeti, Mech, Destroyer, HydraTitan, UFO Alien, Wizard
local P,TS,HS=game.Players,game:GetService("TeleportService"),game:GetService("HttpService")
local LP,PID=P.LocalPlayer,game.PlaceId
local EO,ESP,AK=true,{},false
local open,leaving,hopping=true,false,false
local hadAnimal,animalTime=false,0
local visited={[tostring(game.JobId)]=true}
local alertShown=false
local lastHas,lastRares=false,{}
local AutoTop4Hop=true
local CF="Noah.cfg"
local ALERT_SOUND_ID="rbxassetid://139235100"

local g=Instance.new("ScreenGui")
g.Name="NOAHMICHU"
g.ResetOnSpawn=false
g.Parent=game:GetService("CoreGui")

local function playAlertMusic()
	pcall(function()
		local s=Instance.new("Sound")
		s.Name="NoahAlert"
		s.SoundId=ALERT_SOUND_ID
		s.Volume=3
		s.Parent=game:GetService("SoundService")
		s:Play()
		task.delay(8,function() pcall(function() s:Destroy() end) end)
	end)
	task.spawn(function()
		for i=1,4 do
			pcall(function()
				local b=Instance.new("Sound")
				b.SoundId="rbxassetid://12222216"
				b.Volume=2
				b.PlaybackSpeed=0.95+i*0.12
				b.Parent=game:GetService("SoundService")
				b:Play()
				task.delay(1,function() pcall(function() b:Destroy() end) end)
			end)
			task.wait(0.2)
		end
	end)
end

local alert=Instance.new("Frame")
alert.Size=UDim2.new(0,340,0,100)
alert.Position=UDim2.new(0.5,-170,0.1,0)
alert.BackgroundColor3=Color3.fromRGB(0,0,0)
alert.Visible=false
alert.ZIndex=100
alert.Parent=g
Instance.new("UICorner",alert).CornerRadius=UDim.new(0,12)
local alertStroke=Instance.new("UIStroke",alert)
alertStroke.Color=Color3.fromRGB(255,210,0)
alertStroke.Thickness=4
local alertTitle=Instance.new("TextLabel",alert)
alertTitle.Size=UDim2.new(1,-16,0,32)
alertTitle.Position=UDim2.new(0,8,0,8)
alertTitle.BackgroundTransparency=1
alertTitle.Text="⚠ RAREZA"
alertTitle.TextColor3=Color3.fromRGB(255,210,0)
alertTitle.Font=Enum.Font.GothamBold
alertTitle.TextSize=18
alertTitle.ZIndex=101
local alertBody=Instance.new("TextLabel",alert)
alertBody.Size=UDim2.new(1,-16,0,48)
alertBody.Position=UDim2.new(0,8,0,40)
alertBody.BackgroundTransparency=1
alertBody.Text=""
alertBody.TextColor3=Color3.fromRGB(255,230,120)
alertBody.Font=Enum.Font.GothamBold
alertBody.TextSize=14
alertBody.TextWrapped=true
alertBody.ZIndex=101

local function showAlert(title, body)
	alertTitle.Text=title
	alertBody.Text=body
	alert.Visible=true
	playAlertMusic()
	task.spawn(function()
		for i=1,12 do
			alertStroke.Thickness=(i%2==0) and 5 or 2
			alertStroke.Color=(i%2==0) and Color3.fromRGB(255,255,0) or Color3.fromRGB(255,180,0)
			task.wait(0.18)
		end
		task.wait(2)
		alert.Visible=false
	end)
end

local toggle=Instance.new("TextButton",g)
toggle.Size=UDim2.new(0,44,0,44)
toggle.Position=UDim2.new(0,8,0.5,-22)
toggle.BackgroundColor3=Color3.fromRGB(30,34,50)
toggle.Text="🙊"
toggle.TextSize=18
toggle.Font=Enum.Font.GothamBold
toggle.TextColor3=Color3.new(1,1,1)
toggle.ZIndex=10
Instance.new("UICorner",toggle).CornerRadius=UDim.new(1,0)

local f=Instance.new("Frame",g)
f.Size=UDim2.new(0,220,0,300)
f.Position=UDim2.new(0,58,0.5,-150)
f.BackgroundColor3=Color3.fromRGB(18,20,26)
f.Active=true
f.Draggable=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)

local title=Instance.new("TextLabel",f)
title.Size=UDim2.new(1,0,0,26)
title.BackgroundColor3=Color3.fromRGB(30,34,50)
title.Text="NOAHMICHU🙊🙉🐵"
title.TextColor3=Color3.new(1,1,1)
title.Font=Enum.Font.GothamBold
title.TextSize=11
Instance.new("UICorner",title).CornerRadius=UDim.new(0,8)

local st=Instance.new("TextLabel",f)
st.Size=UDim2.new(1,-8,0,18)
st.Position=UDim2.new(0,4,0,28)
st.BackgroundColor3=Color3.fromRGB(40,45,60)
st.Text="NOAHMICHU🙊..."
st.TextColor3=Color3.new(1,1,1)
st.Font=Enum.Font.GothamBold
st.TextSize=9
Instance.new("UICorner",st).CornerRadius=UDim.new(0,4)

local info=Instance.new("TextLabel",f)
info.Size=UDim2.new(1,-8,0,14)
info.Position=UDim2.new(0,4,0,50)
info.BackgroundColor3=Color3.fromRGB(35,40,55)
info.Text="Jugs: 0"
info.TextColor3=Color3.fromRGB(180,190,210)
info.Font=Enum.Font.Gotham
info.TextSize=9
Instance.new("UICorner",info).CornerRadius=UDim.new(0,4)

local eB=Instance.new("TextButton",f)
eB.Size=UDim2.new(0.48,-4,0,22)
eB.Position=UDim2.new(0,4,0,68)
eB.BackgroundColor3=Color3.fromRGB(0,150,70)
eB.Text="ESP ON"
eB.TextColor3=Color3.new(1,1,1)
eB.Font=Enum.Font.GothamBold
eB.TextSize=10
Instance.new("UICorner",eB).CornerRadius=UDim.new(0,4)

local hB=Instance.new("TextButton",f)
hB.Size=UDim2.new(0.48,-4,0,22)
hB.Position=UDim2.new(0.5,0,0,68)
hB.BackgroundColor3=Color3.fromRGB(180,90,0)
hB.Text="Hop"
hB.TextColor3=Color3.new(1,1,1)
hB.Font=Enum.Font.GothamBold
hB.TextSize=10
Instance.new("UICorner",hB).CornerRadius=UDim.new(0,4)

local kB=Instance.new("TextButton",f)
kB.Size=UDim2.new(1,-8,0,22)
kB.Position=UDim2.new(0,4,0,94)
kB.BackgroundColor3=Color3.fromRGB(120,40,40)
kB.Text="Auto Kick: OFF"
kB.TextColor3=Color3.new(1,1,1)
kB.Font=Enum.Font.GothamBold
kB.TextSize=10
Instance.new("UICorner",kB).CornerRadius=UDim.new(0,4)

local aB=Instance.new("TextButton",f)
aB.Size=UDim2.new(1,-8,0,22)
aB.Position=UDim2.new(0,4,0,120)
aB.BackgroundColor3=Color3.fromRGB(0,140,60)
aB.Text="Auto Rare Hop: ON"
aB.TextColor3=Color3.new(1,1,1)
aB.Font=Enum.Font.GothamBold
aB.TextSize=10
Instance.new("UICorner",aB).CornerRadius=UDim.new(0,4)

local sB=Instance.new("TextButton",f)
sB.Size=UDim2.new(0.48,-4,0,22)
sB.Position=UDim2.new(0,4,0,146)
sB.BackgroundColor3=Color3.fromRGB(50,80,140)
sB.Text="Save"
sB.TextColor3=Color3.new(1,1,1)
sB.Font=Enum.Font.GothamBold
sB.TextSize=10
Instance.new("UICorner",sB).CornerRadius=UDim.new(0,4)

local testB=Instance.new("TextButton",f)
testB.Size=UDim2.new(0.48,-4,0,22)
testB.Position=UDim2.new(0.5,0,0,146)
testB.BackgroundColor3=Color3.fromRGB(255,200,0)
testB.Text="Test alerta"
testB.TextColor3=Color3.fromRGB(0,0,0)
testB.Font=Enum.Font.GothamBold
testB.TextSize=10
Instance.new("UICorner",testB).CornerRadius=UDim.new(0,4)

local list=Instance.new("ScrollingFrame",f)
list.Size=UDim2.new(1,-8,1,-176)
list.Position=UDim2.new(0,4,0,172)
list.BackgroundTransparency=1
list.ScrollBarThickness=2
local lay=Instance.new("UIListLayout",list)
lay.Padding=UDim.new(0,2)

toggle.MouseButton1Click:Connect(function()
	open=not open
	f.Visible=open
	toggle.Text=open and "🙊" or "🙉"
end)

local function saveConfig()
	pcall(function()
		if writefile then writefile(CF,HS:JSONEncode({ESP=EO,Kick=AK,AutoHop=AutoTop4Hop})) end
	end)
	st.Text="Guardado"
	st.BackgroundColor3=Color3.fromRGB(30,100,50)
end

local function loadConfig()
	pcall(function()
		if isfile and isfile(CF) and readfile then
			local d=HS:JSONDecode(readfile(CF))
			if d.ESP~=nil then EO=d.ESP end
			if d.Kick~=nil then AK=d.Kick end
			if d.AutoHop~=nil then AutoTop4Hop=d.AutoHop end
		end
	end)
	eB.Text=EO and "ESP ON" or "ESP OFF"
	eB.BackgroundColor3=EO and Color3.fromRGB(0,150,70) or Color3.fromRGB(120,40,40)
	kB.Text=AK and "Auto Kick: ON" or "Auto Kick: OFF"
	kB.BackgroundColor3=AK and Color3.fromRGB(0,140,60) or Color3.fromRGB(120,40,40)
	aB.Text=AutoTop4Hop and "Auto Rare Hop: ON" or "Auto Rare Hop: OFF"
	aB.BackgroundColor3=AutoTop4Hop and Color3.fromRGB(0,140,60) or Color3.fromRGB(120,40,40)
end

local function matchRare(t)
	if not t or t=="" then return nil end
	local raw=string.lower(tostring(t))
	local n=string.gsub(string.gsub(string.gsub(raw,"%s+",""),"%-",""),"_","")
	if string.find(n,"mapinguari",1,true) then return "Mapinguari" end
	if string.find(n,"shenlong",1,true) then return "Shenlong" end
	if string.find(n,"yeti",1,true) then return "Yeti" end
	if string.find(n,"mecha",1,true) or string.find(n,"mech",1,true) then return "Mech" end
	if string.find(n,"destroyer",1,true) then return "Destroyer" end
	if string.find(n,"hydratitan",1,true) or (string.find(n,"hydra",1,true) and string.find(n,"titan",1,true)) then
		return "HydraTitan"
	end
	if string.find(n,"ufoalien",1,true) or string.find(n,"ufo",1,true) then return "UFO Alien" end
	if string.find(n,"wizard",1,true) or string.find(n,"mago",1,true) then return "Wizard" end
	return nil
end

local function isMyCharacter(obj)
	local c=LP.Character
	if not c then return false end
	local p=obj
	while p do
		if p==c then return true end
		p=p.Parent
	end
	return false
end

local function scanDeep()
	local rares={}
	local function checkText(tx)
		if not tx or tx=="" then return end
		local r=matchRare(tx)
		if r then rares[r]=true end
	end
	for _,v in pairs(workspace:GetDescendants()) do
		if not isMyCharacter(v) then
			if v:IsA("Model") or v:IsA("Tool") or v:IsA("Folder") then
				checkText(v.Name)
			elseif v:IsA("TextLabel") or v:IsA("TextButton") then
				checkText(v.Name)
				checkText(v.Text)
			elseif v:IsA("StringValue") then
				checkText(v.Name)
				checkText(tostring(v.Value))
			end
		end
	end
	local rl={}
	for k in pairs(rares) do table.insert(rl,k) end
	return #rl>0, rl
end

local function scanLight()
	local rares={}
	local function checkText(tx)
		if not tx or tx=="" then return end
		local r=matchRare(tx)
		if r then rares[r]=true end
	end
	for _,a in pairs(workspace:GetChildren()) do
		if not isMyCharacter(a) and (a:IsA("Model") or a:IsA("Folder")) then
			checkText(a.Name)
			for _,b in pairs(a:GetChildren()) do
				if b:IsA("Model") or b:IsA("Tool") or b:IsA("Folder") then
					checkText(b.Name)
					for _,c in pairs(b:GetChildren()) do
						if c:IsA("Model") or c:IsA("Tool") then
							checkText(c.Name)
						elseif c:IsA("TextLabel") then
							checkText(c.Text)
						end
					end
				elseif b:IsA("TextLabel") then
					checkText(b.Text)
				end
			end
		end
	end
	local rl={}
	for k in pairs(rares) do table.insert(rl,k) end
	return #rl>0, rl
end

local function clearESP()
	for k,v in pairs(ESP) do if v then v:Destroy() end end
	table.clear(ESP)
end

local function isStolen(n)
	n=string.lower(tostring(n or ""))
	if n=="" then return false end
	if string.find(n,"stolen",1,true) then return true end
	if string.find(n,"robado",1,true) then return true end
	if string.find(n,"brainrot",1,true) then return true end
	if string.find(n,"heldpet",1,true) then return true end
	if string.find(n,"carryingpet",1,true) then return true end
	return false
end

local function getStolenPet(p)
	local c=p.Character
	if not c then return false,nil end
	for _,v in pairs(c:GetChildren()) do
		if (v:IsA("Model") or v:IsA("Tool")) and isStolen(v.Name) then
			return true,v.Name
		end
	end
	return false,nil
end

local function makeESP(p,steal,pet)
	if not EO or p==LP or not p.Character then return end
	local h=p.Character:FindFirstChild("HumanoidRootPart")
	if not h then return end
	if ESP[p.Name] then ESP[p.Name]:Destroy() end
	local bb=Instance.new("BillboardGui")
	bb.Adornee=h
	bb.Size=UDim2.new(0,100,0,22)
	bb.StudsOffset=Vector3.new(0,2.6,0)
	bb.AlwaysOnTop=true
	bb.Parent=game:GetService("CoreGui")
	local l=Instance.new("TextLabel",bb)
	l.Size=UDim2.new(1,0,1,0)
	l.BackgroundTransparency=1
	l.Font=Enum.Font.GothamBold
	l.TextSize=9
	if steal then
		l.Text="⚠ "..tostring(pet or "?")
		l.TextColor3=Color3.fromRGB(255,80,80)
	else
		l.Text=p.DisplayName
		l.TextColor3=Color3.fromRGB(0,255,120)
	end
	ESP[p.Name]=bb
end

local function doKick()
	if leaving or not AK then return end
	leaving=true
	st.Text="KICK"
	pcall(function() game:Shutdown() end)
	pcall(function() LP:Kick("") end)
end

local function doHop()
	if hopping then return end
	hopping=true
	alertShown=false
	st.Text="Hop..."
	local cur=tostring(game.JobId)
	visited[cur]=true
	local prefer,other={},{}
	pcall(function()
		local url="https://games.roblox.com/v1/games/"..tostring(PID).."/servers/Public?sortOrder=Desc&limit=100"
		local s=HS:JSONDecode(game:HttpGet(url))
		for _,v in pairs(s.data or {}) do
			local id=tostring(v.id or "")
			local pl=tonumber(v.playing) or 0
			local mx=tonumber(v.maxPlayers) or 99
			if id~="" and id~=cur and not visited[id] and pl>=1 and pl<mx then
				if pl>=4 and pl<=10 then
					table.insert(prefer,{id=id,p=pl})
				else
					table.insert(other,{id=id,p=pl})
				end
			end
		end
	end)
	local cands=#prefer>0 and prefer or other
	table.sort(cands,function(a,b) return a.p>b.p end)
	if #cands>0 then
		local pick=cands[math.random(1,math.min(10,#cands))]
		visited[pick.id]=true
		TS:TeleportToPlaceInstance(PID,pick.id,LP)
	else
		visited={[cur]=true}
		TS:Teleport(PID)
	end
	hopping=false
end

local function checkKick()
	if leaving or not AK then return end
	local has,petName=getStolenPet(LP)
	if has then
		if not hadAnimal then
			hadAnimal=true
			animalTime=tick()
			st.Text="Robando... "..tostring(petName or "")
		elseif tick()-animalTime>=1.5 then
			doKick()
		end
	else
		hadAnimal=false
		animalTime=0
	end
end

local function updateList()
	for _,c in pairs(list:GetChildren()) do
		if c:IsA("TextLabel") then c:Destroy() end
	end
	clearESP()
	info.Text="Jugs: "..tostring(#P:GetPlayers())
	if lastHas then
		st.Text="🔥 "..table.concat(lastRares,", ")
		st.BackgroundColor3=Color3.fromRGB(20,110,40)
	else
		st.Text="Listo"
		st.BackgroundColor3=Color3.fromRGB(40,45,60)
	end
	for _,p in pairs(P:GetPlayers()) do
		if p~=LP then
			local steal,pet=getStolenPet(p)
			if EO then makeESP(p,steal,pet) end
			local row=Instance.new("TextLabel",list)
			row.Size=UDim2.new(1,0,0,18)
			row.BackgroundColor3=steal and Color3.fromRGB(80,30,30) or Color3.fromRGB(28,32,44)
			row.Text=(steal and "⚠ " or "")..p.DisplayName
			row.TextColor3=Color3.new(1,1,1)
			row.Font=Enum.Font.Gotham
			row.TextSize=10
			row.TextXAlignment=Enum.TextXAlignment.Left
			Instance.new("UICorner",row).CornerRadius=UDim.new(0,3)
		end
	end
	list.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+2)
end

local function applyFound(hasR,rares)
	lastHas,lastRares=hasR,rares
	if not alertShown and hasR then
		showAlert("⚠ RAREZA", table.concat(rares," · "))
		alertShown=true
	end
	return hasR
end

eB.MouseButton1Click:Connect(function()
	EO=not EO
	eB.Text=EO and "ESP ON" or "ESP OFF"
	eB.BackgroundColor3=EO and Color3.fromRGB(0,150,70) or Color3.fromRGB(120,40,40)
	updateList()
end)
hB.MouseButton1Click:Connect(doHop)
kB.MouseButton1Click:Connect(function()
	AK=not AK
	kB.Text=AK and "Auto Kick: ON" or "Auto Kick: OFF"
	kB.BackgroundColor3=AK and Color3.fromRGB(0,140,60) or Color3.fromRGB(120,40,40)
	leaving=false
	hadAnimal=false
	animalTime=0
end)
aB.MouseButton1Click:Connect(function()
	AutoTop4Hop=not AutoTop4Hop
	aB.Text=AutoTop4Hop and "Auto Rare Hop: ON" or "Auto Rare Hop: OFF"
	aB.BackgroundColor3=AutoTop4Hop and Color3.fromRGB(0,140,60) or Color3.fromRGB(120,40,40)
end)
sB.MouseButton1Click:Connect(saveConfig)
testB.MouseButton1Click:Connect(function()
	showAlert("⚠ TEST","Mapinguari · Destroyer · Wizard")
end)

P.PlayerRemoving:Connect(function(p)
	if ESP[p.Name] then ESP[p.Name]:Destroy() ESP[p.Name]=nil end
end)

pcall(loadConfig)

task.spawn(function()
	st.Text="NOAHMICHU🙊..."
	task.wait(8)
	local hasR,rares=scanDeep()
	if applyFound(hasR,rares) then
		updateList()
		return
	end
	st.Text="Sin rareza"
	updateList()
	if AutoTop4Hop and not hopping and not leaving then
		st.Text="Sin rareza → Hop"
		task.wait(0.4)
		doHop()
	end
end)

task.spawn(function()
	task.wait(22)
	while g.Parent do
		if not hopping and not leaving then
			local hasR,rares=scanLight()
			applyFound(hasR,rares)
		end
		task.wait(10)
	end
end)

task.spawn(function()
	while g.Parent do
		updateList()
		task.wait(2)
	end
end)

task.spawn(function()
	while g.Parent do
		if AK then pcall(checkKick) end
		task.wait(0.5)
	end
end)

updateList()
print("[NOAHMICHU] 8 rares only")