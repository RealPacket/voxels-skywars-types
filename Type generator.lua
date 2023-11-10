--[[
	Type Generator @ 1.0.1
		Generates typings for you (won't have syntax errors lol).
		It's slow for really big objects, but I don't have time to optimize.
		(I'll rewrite based off of another type generator, which is way faster for big things)
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local OldDebugId = game.GetDebugId
local lower = string.lower
local byte = string.byte
local running = coroutine.running
local resume = coroutine.resume
local status = coroutine.status
local yield = coroutine.yield
local create = coroutine.create
local close = coroutine.close
local info = debug.info
local clear = table.clear
local indent = 2
local scheduled = {}
local generation = {}
-- constants
local MAX_STRING_SIZE = 10000
local MAX_TABLE_SIZE = 1000
local MAX_SCHEDULED = 4000
local connections = {}
local getgenv: () -> {[string]: any} = getgenv or getfenv

--- schedules the provided function (and calls it with any args after)

local function schedule(f, ...)
	table.insert(scheduled, { f, ... })
end

local function getType(obj: any)
	local typeStr = type(obj)
	if typeStr == "userdata" or typeStr == "vector" then
		typeStr = typeof(obj)
		if typeof(obj) == "Instance" then
			typeStr = obj.ClassName
		end
	end
	if typeStr == "userdata" then
		warn("typeStr is userdata!")
		print("obj:", obj)
	end
	return typeStr
end

local cloneref = cloneref or function(ref)
	return ref
end

local function SafeGetService(service)
	return cloneref(game:GetService(service))
end

--- yields the current thread until the scheduler gives the ok
function scheduleWait()
	local thread = running()
	schedule(function()
		resume(thread)
	end)
	yield()
end

--- the big (well tbh small now) boi task scheduler himself, handles p much anything as quicc as possible
local function taskScheduler()
	if #scheduled > MAX_SCHEDULED + 100 then
		table.remove(scheduled, #scheduled)
	end
	if #scheduled > 0 then
		local currentf = scheduled[1]
		table.remove(scheduled, 1)
		if type(currentf) == "table" and type(currentf[1]) == "function" then
			pcall(unpack(currentf))
		end
	end
end

table.insert(connections, RunService.Heartbeat:Connect(taskScheduler))

local function rawtostring(userdata)
	if not getrawmetatable or not isreadonly or not makewritable or not makereadonly then
		return
	end
	if type(userdata) == "table" or typeof(userdata) == "userdata" then
		local rawmetatable = getrawmetatable(userdata)
		local cachedstring = rawmetatable and rawget(rawmetatable, "__tostring")

		if cachedstring then
			local wasreadonly = isreadonly(rawmetatable)
			if wasreadonly then
				makewritable(rawmetatable)
			end
			rawset(rawmetatable, "__tostring", nil)
			local safestring = tostring(userdata)
			rawset(rawmetatable, "__tostring", cachedstring)
			if wasreadonly then
				makereadonly(rawmetatable)
			end
			return safestring
		end
	end
	return tostring(userdata)
end

local CustomGeneration = {
	Vector3 = (function()
		local temp = {}
		for i, v in Vector3 do
			if type(v) == "vector" then
				temp[v] = `Vector3.{i}`
			end
		end
		return temp
	end)(),
	Vector2 = (function()
		local temp = {}
		for i, v in Vector2 do
			if type(v) == "userdata" then
				temp[v] = `Vector2.{i}`
			end
		end
		return temp
	end)(),
	CFrame = {
		[CFrame.identity] = "CFrame.identity",
	},
}

local number_table = {
	inf = "math.huge",
	["-inf"] = "-math.huge",
	nan = "0/0 --[[NaN (Not a Number)]]",
}

local ufunctions
ufunctions = {
	TweenInfo = function(u: TweenInfo)
		return `TweenInfo.new({u.Time}, {u.EasingStyle}, {u.EasingDirection}, {u.RepeatCount}, {u.Reverses}, {u.DelayTime})`
	end,
	Ray = function(u: Ray)
		local Vector3tostring = ufunctions.Vector3

		return `Ray.new({Vector3tostring(u.Origin)}, {Vector3tostring(u.Direction)})`
	end,
	BrickColor = function(u: BrickColor)
		return `BrickColor.new({u.Number})`
	end,
	NumberRange = function(u: NumberRange)
		return `NumberRange.new({u.Min}, {u.Max})`
	end,
	Region3 = function(u: Region3)
		local center = u.CFrame.Position
		local centersize = u.Size / 2
		local Vector3tostring = ufunctions.Vector3

		return `Region3.new({Vector3tostring(center - centersize)}, {Vector3tostring(center + centersize)})`
	end,
	Faces = function(u: Faces)
		local faces = {}
		if u.Top then
			table.insert(faces, "Top")
		end
		if u.Bottom then
			table.insert(faces, "Enum.NormalId.Bottom")
		end
		if u.Left then
			table.insert(faces, "Enum.NormalId.Left")
		end
		if u.Right then
			table.insert(faces, "Enum.NormalId.Right")
		end
		if u.Back then
			table.insert(faces, "Enum.NormalId.Back")
		end
		if u.Front then
			table.insert(faces, "Enum.NormalId.Front")
		end
		return `Faces.new({table.concat(faces, ", ")})`
	end,
	EnumItem = function(u: EnumItem)
		return tostring(u)
	end,
	Enums = function(u: Enums)
		return "Enum"
	end,
	Enum = function(u: Enum)
		return `Enum.{u}`
	end,
	Vector3 = function(u: Vector3)
		return CustomGeneration.Vector3[u] or `Vector3.new({u})`
	end,
	Vector2 = function(u: Vector2)
		return CustomGeneration.Vector2[u] or `Vector2.new({u})`
	end,
	CFrame = function(u: CFrame)
		return CustomGeneration.CFrame[u] or `CFrame.new({table.concat({ u:GetComponents() }, ", ")})`
	end,
	PathWaypoint = function(u: PathWaypoint)
		return `PathWaypoint.new({ufunctions.Vector3(u.Position)}, {u.Action}, "{u.Label}")`
	end,
	UDim = function(u: UDim)
		return `UDim.new({u})`
	end,
	UDim2 = function(u: UDim2)
		return `UDim2.new({u})`
	end,
	Rect = function(u: Rect)
		local Vector2tostring = ufunctions.Vector2
		return `Rect.new({Vector2tostring(u.Min)}, {Vector2tostring(u.Max)})`
	end,
	Color3 = function(u: Color3)
		return `Color3.new({u.R}, {u.G}, {u.B})`
	end,
	RBXScriptSignal = function() -- The server doesn't recive this
		return "RBXScriptSignal --[[RBXScriptSignals are not supported]]"
	end,
	RBXScriptConnection = function() -- The server doesn't recive this
		return "RBXScriptConnection --[[RBXScriptConnections are not supported]]"
	end,
}

--- format s: string, byte encrypt (for weird symbols)
function formatstr(s, indentation)
	if not indentation then
		indentation = 0
	end
	local handled, reachedMax = handlespecials(s, indentation)
	return '"'
		.. handled
		.. '"'
		.. (
			reachedMax and " --[[ MAXIMUM STRING SIZE REACHED, CHANGE 'MAX_STRING_SIZE' TO ADJUST MAXIMUM SIZE ]]"
			or ""
		)
end

--- Adds \'s to the text as a replacement to whitespace chars and other things because string.format can't yayeet

local function isFinished(coroutines: table)
	for _, v in next, coroutines do
		if status(v) == "running" then
			return false
		end
	end
	return true
end

local specialstrings = {
	["\n"] = function(thread, index)
		resume(thread, index, "\\n")
	end,
	["\t"] = function(thread, index)
		resume(thread, index, "\\t")
	end,
	["\\"] = function(thread, index)
		resume(thread, index, "\\\\")
	end,
	['"'] = function(thread, index)
		resume(thread, index, '\\"')
	end,
}

function handlespecials(s, indentation)
	local i = 0
	local n = 1
	local coroutines = {}
	local function coroutineFunc(i, r)
		s = s:sub(0, i - 1) .. r .. s:sub(i + 1, -1)
	end
	local timeout = 0
	repeat
		i += 1
		if timeout >= 10 then
			task.wait()
			timeout = 0
		end
		local char = s:sub(i, i)

		if byte(char) then
			timeout += 1
			local c = create(coroutineFunc)
			table.insert(coroutines, c)
			local specialfunc = specialstrings[char]

			if specialfunc then
				specialfunc(c, i)
				i += 1
			elseif byte(char) > 126 or byte(char) < 32 then
				resume(c, i, "\\" .. byte(char))
				-- s = s:sub(0, i - 1) .. "\\" .. byte(char) .. s:sub(i + 1, -1)
				i += #rawtostring(byte(char))
			end
			if i >= n * 100 then
				local extra = string.format('" ..\n%s"', string.rep(" ", indentation + indent))
				s = s:sub(0, i) .. extra .. s:sub(i + 1, -1)
				i += #extra
				n += 1
			end
		end
	until char == "" or i > (MAX_STRING_SIZE or 10000)
	while not isFinished(coroutines) do
		RunService.Heartbeat:Wait()
	end
	clear(coroutines)
	if i > (MAX_STRING_SIZE or 10000) then
		s = string.sub(s, 0, MAX_STRING_SIZE or 10000)
		return s, true
	end
	return s, false
end

--- value-to-path (in table)
function v2p(x, t, path, prev)
	if not path then
		path = ""
	end
	if not prev then
		prev = {}
	end
	if rawequal(x, t) then
		return true, ""
	end
	for i, v in next, t do
		if rawequal(v, x) then
			if type(i) == "string" and i:match("^[%a_]+[%w_]*$") then
				return true, (path .. "." .. i)
			else
				return true, (path .. "[" .. v2s(i) .. "]")
			end
		end
		if type(v) == "table" then
			local duplicate = false
			for _, y in next, prev do
				if rawequal(y, v) then
					duplicate = true
				end
			end
			if not duplicate then
				table.insert(prev, t)
				local found, p
				found, p = v2p(x, v, path, prev)
				if found then
					if type(i) == "string" and i:match("^[%a_]+[%w_]*$") then
						return true, "." .. i .. p
					else
						return true, "[" .. v2s(i) .. "]" .. p
					end
				end
			end
		end
	end
	return false, ""
end
local bottomstr

--- table-to-string
--- @param t table
--- @param l number
--- @param p table
--- @param n string
--- @param vtv boolean
--- @param i any
--- @param pt table
--- @param path string
--- @param tables table
--- @param tI table
function t2s(t, l, p, n, vtv, i, pt, path, tables, tI)
	local globalIndex = table.find(getgenv(), t) -- checks if table is a global
	if type(globalIndex) == "string" then
		return globalIndex
	end
	if not tI then
		tI = { 0 }
	end
	if not path then -- sets path to empty string (so it doesn't have to manually provided every time)
		path = ""
	end
	if not l then -- sets the level to 0 (for indentation) and tables for logging tables it already serialized
		l = 0
		tables = {}
	end
	if not p then -- p is the previous table but doesn't really matter if it's the first
		p = t
	end
	for _, v in next, tables do -- checks if the current table has been serialized before
		if n and rawequal(v, t) then
			bottomstr = bottomstr
				.. "\n"
				.. rawtostring(n)
				.. rawtostring(path)
				.. " = "
				.. rawtostring(n)
				.. rawtostring(({ v2p(v, p) })[2])
			return `\{}\ --[[Duplicate Found: "{rawtostring(n)}"]]`
		end
	end
	table.insert(tables, t) -- logs table to past tables
	local s = "{" -- start of serialization
	local size = 0
	l += indent -- set indentation level
	for k, v in next, t do -- iterates over table
		if type(k) == "string" and k:match("^__%w+$") then
			continue
		end
		size = size + 1 -- changes size for max limit
		if size > (MAX_TABLE_SIZE or 1000) then
			s = s
				.. "\n"
				.. string.rep(" ", l)
				.. "-- MAXIMUM TABLE SIZE REACHED, CHANGE 'MAX_TABLE_SIZE' TO ADJUST MAXIMUM SIZE "
			break
		end
		if rawequal(k, t) then -- checks if the table being iterated over is being used as an index within itself (yay, lua)
			bottomstr ..= `\n{n}{path}[{n}{path}] = {(rawequal(v, k) and `{n}{path}` or v2s(
				v,
				l,
				p,
				n,
				vtv,
				k,
				t,
				`{path}[{n}{path}]`,
				tables
				))}`
			size -= 1
			continue
		end
		local currentPath = "" -- initializes the path of 'v' within 't'
		if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then -- cleanly handles table path generation (for the first half)
			currentPath = "." .. k
		else
			currentPath = "[" .. v2s(k, l, p, n, vtv, k, t, path .. currentPath, tables, tI) .. "]"
		end
		if size % 100 == 0 then
			scheduleWait()
		end
		-- actually serializes the member of the table
		if type(k) == "string" and k:match("^[_%a][_%w]*$") then
			s = s
				.. "\n"
				.. string.rep(" ", l)
				.. k
				.. " = "
				.. v2s(v, l, p, n, vtv, k, t, path .. currentPath, tables, tI)
				.. ","
		elseif type(k) == "number" then
			s = s .. "\n" .. string.rep(" ", l) .. v2s(v, l, p, n, vtv, k, t, path .. currentPath, tables, tI) .. ","
		else
			s = s
				.. "\n"
				.. string.rep(" ", l)
				.. "["
				.. v2s(k, l, p, n, vtv, k, t, path .. currentPath, tables, tI)
				.. "] = "
				.. v2s(v, l, p, n, vtv, k, t, path .. currentPath, tables, tI)
				.. ","
		end
	end
	if #s > 1 and s:sub(-1) == "," then -- removes the last comma because it looks nicer (no way to tell if it's done 'till it's done so...)
		s = s:sub(1, #s - 1)
		print("remove last comma")
	end
	if size > 0 then -- cleanly indents the last curly bracket
		s = s .. "\n" .. string.rep(" ", l - indent)
	end
	return s .. "}"
end

--- table-to-type
--- @param t table
--- @param l number
--- @param p table
--- @param n string
--- @param vtv boolean
--- @param i any
--- @param pt table
--- @param path string
--- @param tables table
--- @param tI table
function t2t(t, l, p, n, vtv, i, pt, path, tables, tI)
	local globalIndex = table.find(getgenv(), t) -- checks if table is a global
	if type(globalIndex) == "string" then
		return globalIndex
	end
	if not tI then
		tI = { 0 }
	end
	if not path then -- sets path to empty string (so it doesn't have to manually provided every time)
		path = ""
	end
	if not l then -- sets the level to 0 (for indentation) and tables for logging tables it already serialized
		l = 0
		tables = {}
	end
	if not p then -- p is the previous table but doesn't really matter if it's the first
		p = t
	end
	for _, v in next, tables do -- checks if the current table has been serialized before
		if n and rawequal(v, t) then
			bottomstr = bottomstr
				.. "\n"
				.. rawtostring(n)
				.. rawtostring(path)
				.. " = "
				.. rawtostring(n)
				.. rawtostring(({ v2p(v, p) })[2])
			return `\{}\ --[[Duplicate Found: "{rawtostring(n)}"]]`
		end
	end
	table.insert(tables, t) -- logs table to past tables
	local s = "{" -- start of serialization
	local size = 0
	l += indent -- set indentation level
	for k, v in next, t do -- iterates over table
		size = size + 1 -- changes size for max limit
		if size > (MAX_TABLE_SIZE or 1000) then
			s = s
				.. "\n"
				.. string.rep(" ", l)
				.. "-- MAXIMUM TABLE SIZE REACHED, CHANGE 'MAX_TABLE_SIZE' TO ADJUST MAXIMUM SIZE "
			break
		end
		if type(k) == "string" and k:match("^__%w+$") then
			continue
		end
		if rawequal(k, t) then -- checks if the table being iterated over is being used as an index within itself (yay, lua)
			bottomstr ..= `\n{n}{path}[{n}{path}] = {(rawequal(v, k) and `{n}{path}` or v2t(
				v,
				l,
				p,
				n,
				vtv,
				k,
				t,
				`{path}[{n}{path}]`,
				tables
				))}`
			size -= 1
			continue
		end
		local currentPath = "" -- initializes the path of 'v' within 't'
		if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then -- cleanly handles table path generation (for the first half)
			currentPath = "." .. k
		else
			currentPath = "[" .. v2s(k, l, p, n, vtv, k, t, path .. currentPath, tables, tI) .. "]"
		end
		if size % 100 == 0 then
			scheduleWait()
		end
		-- actually serializes the member of the table
		if type(k) == "string" and not k:match("^__%w+$") and k:match("^[_%a][_%w]*$") then
			s = s
				.. "\n"
				.. string.rep(" ", l)
				.. k
				.. ": "
				.. v2t(v, l, p, n, vtv, k, t, path .. currentPath, tables, tI)
				.. ","
		elseif type(k) == "number" then
			if k > 1 then
				s = s .. " | " .. v2t(v, l, p, n, vtv, k, t, path .. currentPath, tables, tI)
			else
				s = s .. "\n" .. string.rep(" ", l) .. v2t(v, l, p, n, vtv, k, t, path .. currentPath, tables, tI)
			end
		else
			s = s
				.. "\n"
				.. string.rep(" ", l)
				.. "["
				.. v2s(k, l, p, n, vtv, k, t, path .. currentPath, tables, tI)
				.. "]: "
				.. v2t(v, l, p, n, vtv, k, t, path .. currentPath, tables, tI)
				.. ","
		end
	end
	if #s > 1 and s:sub(-1) == "," then -- removes the last comma because it looks nicer (no way to tell if it's done 'till it's done so...)
		s = s:sub(1, #s - 1)
	end
	if size > 0 then -- cleanly indents the last curly bracket
		s = s .. "\n" .. string.rep(" ", l - indent)
	end
	return s .. "}"
end

local typeofv2sfunctions = {
	number = function(v)
		local number = tostring(v)
		return number_table[number] or number
	end,
	boolean = function(v)
		return tostring(v)
	end,
	string = function(v, l)
		return formatstr(v, l)
	end,
	["function"] = function(v) -- The server doesnt recive this
		return f2s(v)
	end,
	table = function(v, l, p, n, vtv, i, pt, path, tables, tI)
		return t2s(v, l, p, n, vtv, i, pt, path, tables, tI)
	end,
	Instance = function(v)
		local DebugId = OldDebugId(v)
		return i2p(v, generation[DebugId])
	end,
	userdata = function(v) -- The server doesnt recive this
		return "newproxy(true)"
	end,
}

--- Gets the player an instance is descended from
function getplayer(instance)
	for _, v in next, Players:GetPlayers() do
		if v.Character and (instance:IsDescendantOf(v.Character) or instance == v.Character) then
			return v
		end
	end
end

--- instance-to-path
--- @param i userdata
function i2p(i, customgen)
	if customgen then
		return customgen
	end
	local player = getplayer(i)
	local parent = i
	local out = ""
	if parent == nil then
		return "nil"
	elseif player then
		while true do
			if parent and parent == player.Character then
				if player == Players.LocalPlayer then
					return 'game:GetService("Players").LocalPlayer.Character' .. out
				else
					return i2p(player) .. ".Character" .. out
				end
			else
				if parent.Name:match("[%a_]+[%w+]*") ~= parent.Name then
					out = ":FindFirstChild(" .. formatstr(parent.Name) .. ")" .. out
				else
					out = "." .. parent.Name .. out
				end
			end
			task.wait()
			parent = parent.Parent
		end
	elseif parent ~= game then
		while true do
			if parent and parent.Parent == game then
				if SafeGetService(parent.ClassName) then
					if parent.ClassName:lower() == "workspace" then
						return `workspace{out}`
					else
						return 'game:GetService("' .. parent.ClassName .. '")' .. out
					end
				else
					if parent.Name:match("[%a_]+[%w_]*") then
						return "game." .. parent.Name .. out
					else
						return "game:FindFirstChild(" .. formatstr(parent.Name) .. ")" .. out
					end
				end
			else
				if not parent then
					return "nil"
				end
				if parent.Name:match("[%a_]+[%w_]*") ~= parent.Name then
					out = ":WaitForChild(" .. formatstr(parent.Name) .. ")" .. out
				else
					out = ':WaitForChild("' .. parent.Name .. '")' .. out
				end
			end
			if i:IsDescendantOf(Players.LocalPlayer) then
				return 'game:GetService("Players").LocalPlayer' .. out
			end
			parent = parent.Parent
			task.wait()
		end
	else
		return "game"
	end
end

--- function-to-string
function f2s(f)
	for k, x in next, getgenv() do
		local isgucci, gpath
		if rawequal(x, f) then
			isgucci, gpath = true, ""
		elseif type(x) == "table" then
			isgucci, gpath = v2p(f, x)
		end
		if isgucci and type(k) ~= "function" then
			if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then
				return k .. gpath
			else
				return "getgenv()[" .. v2s(k) .. "]" .. gpath
			end
		end
	end
	local funcname = info(f, "n")
	local args, hasVararg = info(f, "a")

	if funcname and funcname:match("^[%a_]+[%w_]*$") then
		return `{funcname}() -- Function: {funcname}, param count: {args}, has vararg: {hasVararg}`
	end
	return tostring(f)
end

--- function-to-type
--- NOTE: you might want to manually rename and re-type any functions, because
--- Luau doesn't give us much debug info in
--- the stack so we don't really know anything,
--- (for performance reasons, we don't really any type or name info
--- to run the bytecode)
function f2t(f)
	local argCount, hasVararg = info(f, "a")
	local params = {}
	if argCount > 0 then
		for i = 1, argCount do
			table.insert(params, `p{i}: any`)
		end
	end
	-- varargs are always at the end of the
	-- parameter list, anywhere else is invalid.
	if hasVararg then
		table.insert(params, "...any")
	end
	return `({table.concat(params, ", ")}) -> any`
end

local typev2sfunctions = {
	userdata = function(v, vtypeof)
		if ufunctions[vtypeof] then
			return ufunctions[vtypeof](v)
		end
		return `{vtypeof}({rawtostring(v)}) --[[Generation Failure]]`
	end,
	vector = ufunctions.Vector3,
}

local v2tFunctions = {
	table = function(v, l, p, n, vtv, i, pt, path, tables, tI)
		return t2t(v, l, p, n, vtv, i, pt, path, tables, tI)
	end,
	["function"] = function(f)
		return f2t(f)
	end,
}

function v2t(v, l, p, n, vtv, i, pt, path, tables, tI)
	local t = getType(v)
	if v2tFunctions[t] then
		return v2tFunctions[t](v, l, p, n, vtv, i, pt, path, tables, tI)
	end
	return getType(v)
end

function v2s(v, l, p, n, vtv, i, pt, path, tables, tI)
	local vtypeof = typeof(v)
	local vtypeoffunc = typeofv2sfunctions[vtypeof]
	local vtypefunc = typev2sfunctions[type(v)]
	local vtype = type(v)
	if not tI then
		tI = { 0 }
	else
		tI[1] += 1
	end

	if vtypeoffunc then
		return vtypeoffunc(v, l, p, n, vtv, i, pt, path, tables, tI)
	elseif vtypefunc then
		return vtypefunc(v, vtypeof)
	end
	return `{vtypeof}({rawtostring(v)}) --[[Generation Failure]]`
end

local function toLuauTypeString(name, object)
	return `type {name} = {v2t(object)}`
end

-- example:
local PlayerScripts = LocalPlayer.PlayerScripts
local controller = require(PlayerScripts.TS.controllers["projectile-controller"]).ProjectileController
print(toLuauTypeString("ProjectileController", controller))

connections[1]:Disconnect()

return toLuauTypeString
