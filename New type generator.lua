--[[

		Type generator @ 2.0.0-rewrite
			A rewrite of the old type generator, currently in beta.
			Also, This was published for testing.
			(most likely faster than the old one)

--]]
local serializer = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local getgenv = getgenv or getfenv
local info = debug.info
local getDebugId = game.GetDebugId
local runExample = true

local specialCharacters = {
	["\a"] = "\\a",
	["\b"] = "\\b",
	["\f"] = "\\f",
	["\n"] = "\\n",
	["\r"] = "\\r",
	["\t"] = "\\t",
	["\v"] = "\\v",
	["\0"] = "\\0",
}
local keywords = {
	["and"] = true,
	["break"] = true,
	["do"] = true,
	["else"] = true,
	["elseif"] = true,
	["end"] = true,
	["false"] = true,
	["for"] = true,
	["function"] = true,
	["if"] = true,
	["in"] = true,
	["local"] = true,
	["nil"] = true,
	["not"] = true,
	["or"] = true,
	["repeat"] = true,
	["return"] = true,
	["then"] = true,
	["true"] = true,
	["until"] = true,
	["while"] = true,
	["continue"] = true,
}

local generation = {}

local options = {
	MAX_TABLE_SIZE = 1000, -- how many tables it can handle at max
	INDENT = 1, -- how many indent characters are inserted.
	-- e.g. `a | b` is 5 characters, if you set this to 5, it will be
	--[[
		a
		| b
	]]
	MAX_LENGTH_BEFORE_NEWLINE = 110,
	-- the character used for indenting, usually "\t" or " "
	INDENT_CHARACTER = "\t",
	DEBUG = true,
	-- if enabled,
	-- profiles
	-- and other debugging
	-- features provided by the debug library will be activated
	DEBUG_FEATURES_ENABLED = false,
	BASE_MEMORY_CATEGORY = "Serializer",
	MEMORY_CATEGORIES = {
		SERIALIZE = "%s/Serialize/",
		TABLE_SERIALIZE = "%s/Serialize/TableSerialize",
		FUNCTION_SERIALIZE = "%s/Serialize/FunctionSerialize"
	},
}

local cloneref = cloneref or function(ref)
	return ref
end

local function SafeGetService(service)
	return cloneref(game:GetService(service))
end

local function profileBegin(category: string)
	if not options.DEBUG_FEATURES_ENABLED then
		return
	end
	local cat = options.MEMORY_CATEGORIES[category]
	debug.profilebegin(cat)
end
local function setMemoryCategory(category: string)
	if not options.DEBUG_FEATURES_ENABLED then
		return
	end
	local cat = options.MEMORY_CATEGORIES[category]
	debug.setmemorycategory(cat)
end

local function reSetMemoryCategory()
	if not options.DEBUG_FEATURES_ENABLED then
		return
	end
	debug.resetmemorycategory()
end

local function profileEnd()
	if not options.DEBUG_FEATURES_ENABLED then
		return
	end
	debug.profileend()	
end

type getTypeOptions = {
	InstanceClassName: boolean,
}

local defaultOptions: getTypeOptions = {
	-- "Narrow" down types to class names if they're an Instance?
	InstanceClassName = true,
}

local function getType(obj: any, _options: getTypeOptions?)
	local options = (_options or defaultOptions)
	local typeStr = type(obj)
	if typeStr == "userdata" or typeStr == "vector" then
		typeStr = typeof(obj)
		if options.InstanceClassName then
			if typeof(obj) == "Instance" then
				typeStr = obj.ClassName
			end
		end
	end
	if typeStr == "userdata" then
		warn("typeStr is userdata!")
		print("obj:", obj)
	end
	return typeStr
end

type tableToTypeInfo = {
	path: string,
	level: number,
	--tables: {},
	--previous: {},
	--previousInfo: tableToTypeInfo?
}

local defaultInfo: tableToTypeInfo = {
	path = "",
	level = 0,
	--tables = {},
	--previous = {},
}

local methods = {
	type = {},
	value = {},
}

serializer.methods = methods

type mode = "type" | "value"

local function serialize(v: any, mode: mode, ...)
	profileBegin("SERIALIZE")
	setMemoryCategory("SERIALIZE")
	local t = getType(v, {
		InstanceClassName = false,
	})
	local result
	local method = methods[mode][t]
	if not method and mode ~= "type" and type(v) ~= "userdata" and type(v) ~= "vector" then
		warn(('No serializer for "%s" (mode: %s)'):format(t, mode))
	end
	if mode == "type" and not method then
		result = t
	end
	if type(v) ~= "userdata" and type(v) ~= "vector" and not method then
		result = tostring(t)
	end
	if not result and method then
		result = method(v, ...)
	end
	if not result and not method then
		warn("huh", v, method)
	end
	profileEnd()
	reSetMemoryCategory()
	return result
end

serializer.serialize = serialize

function methods.value.table(t: {}, info: tableToTypeInfo)
	local index = table.find(getgenv(), t)
	if index and type(index) == "string" then
		return index
	end
	profileBegin("TABLE_SERIALIZE")
	setMemoryCategory("TABLE_SERIALIZE")
	local s = "{"
	local size = 0
	info = info or defaultInfo
	local oldLevel = info.level
	info.level += 1
	local indentCount = options.INDENT * info.level
	local types = {}
	for k, v in t do -- iterates over table
		-- no metamethods
		if type(k) == "string" and k:match("^__%w+$") then
			continue
		end
		if size > (options.MAX_TABLE_SIZE or 1000) then
			s = s
				.. "\n"
				.. options.INDENT_CHARACTER:rep(indentCount)
				.. ("-- MAXIMUM TABLE SIZE REACHED (%d), CHANGE 'MAX_TABLE_SIZE' TO ADJUST MAXIMUM SIZE."):format(size)
			break
		end
		size += 1 -- changes size for max limit
		-- actually serializes the member of the table
		local val = serialize(v, "value", info)
		local str = ""
		if type(k) == "string" and k:match("^[_%a][_%w]*$") then
			--print("serialize member/string:", k)
			str = k .. " = " .. val
		elseif type(k) == "number" then
			--print("serialize member/number:", k, "/", v)
			str = val
		else
			str = "[" .. serialize(k, "value", info) .. "] = " .. val
		end
		s ..= ("\n%s%s%s"):format(
			options.INDENT_CHARACTER:rep(indentCount), str, ","
		)
	end
	-- removes the last comma because it looks nicer
	-- (no way to tell if it's done 'till it's done so...)
	if #s > 1 and s:sub(-1) == "," then
		s = s:sub(1, #s - 1)
	end
	if size > 0 then -- cleanly indents the last curly bracket
		info.level -= 1
		s ..= "\n" ..
			(info.level > 0 and
				options.INDENT_CHARACTER:rep(indentCount - info.level) or
				""
			)
	end
	reSetMemoryCategory()
	profileEnd()
	return s .. "}"
end

-- --            MISC SERIALIZERS                            -- --

function methods.value.boolean(v: boolean)
	return tostring(v)
end

do
	local specialCharacters = {
		["\a"]  = "\\a",
		["\b"]  = "\\b",
		["\\"]  = "\\",
		["\f"]  = "\\f",
		["\n"]  = "\\n",
		["\r"]  = "\\r",
		["\t"]  = "\\t",
		["\v"] = "\\v"
	}
	local quotes = {
		'"', -- double quotes
		"'", -- single quotes
		"`"  -- format quotes/interpolated quotes
		-- multi-line quotes/([[/]]) quotes are garbag so not here ;)
	}
	--- Escapes `v` to make it as if it was a string.
	--- (aka. replace escapes like \t, \v,
	--- and \a with something like \\t, \\v, and \\a)
	local function handleEscapes(v: string)
		for char, replace in specialCharacters do
			v = v:gsub(char, replace)
		end
		return v
	end
	--- gets the most optimal quote pairs for the string.
	--- double quotes are prioritized because
	--- I personally don't like single quotes.
	--- how it works:
	---  - function searches for the '"' character in the string
	---    - if it finds the double quote, it moves on to single quotes
	---  - function searches for the "'" character in the string
	---    - if it finds the single quote,
	---       it moves on to interpolated strings.
	---  - if none are optimal (optimal = 
	---     we don't have to escape the quotes in the actual string),
	---    it moves on and escapes the double quotes.
	local function getOptimalQuotePair(s: string)
		local result
		for _, quote in quotes do
			if s:find(quote) then
				continue
			end
			result = quote
			if not s:find(result) then
				break
			end
		end
		if not result then
			return quotes[1]
		end
		return result
	end
	function methods.value.string(v: string)
		local quote = getOptimalQuotePair(v)
		v = v:gsub('"', '\\"')
		return quote .. v .. quote
	end
end

do
	local function formatNumber(amount: string)
		local formatted = amount
		-- not sure if I can use standard lib doing this
		-- but I can check later.
		local zeroPadding = ("0"):rep(#amount - 2)
		-- check if it all ends in 0s
		-- (to format 9e9 as 9e9)
		if amount:sub(2, #amount - 1) == zeroPadding and #zeroPadding > 2 then
			return amount:sub(
				1,
				#amount - (#zeroPadding + 1)
			) .. "e" .. #zeroPadding + 1
		end
		while true do
			local k = -math.huge
			formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", '%1_%2')
			if k == 0 then
				break
			end
		end
		return formatted
	end
	function methods.value.number(v: number)
		if v == math.pi then
			return "math.pi"
		end
		if v == math.huge then
			return "math.huge"
		end
		return formatNumber(tostring(v))
	end
end
do
	--- Gets the player an instance is descended from
	local function getplayer(instance)
		for _, v in Players:GetPlayers() do
			if v.Character and (instance:IsDescendantOf(v.Character) or
					instance == v.Character
				) then
				return v
			end
		end
	end
	local function i2p(i, customgen)
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
						out = ":FindFirstChild(" .. serialize(parent.Name, "value") .. ")" .. out
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
							return "game:FindFirstChild(" .. serialize(parent.Name, "value") .. ")" .. out
						end
					end
				else
					if not parent then
						return "nil"
					end
					if parent.Name:match("^[_%a][_%w]*$") ~= parent.Name then
						out = ("[%s]%s"):format(serialize(parent.Name, "value"), out)
					else
						out = ('.%s%s'):format(parent.Name, out)
					end
				end
				parent = parent.Parent
				task.wait()
			end
		else
			return "game"
		end
	end
	function methods.value.Instance(v: Instance)
		local suc, DebugId = pcall(getDebugId, v)
		return i2p(v, suc and generation[DebugId] or nil)
	end
end

-- //            MISC SERIALIZERS                            // --

-- --            DATA TYPE SERIALIZER FUNCTIONS              -- --


-- --             VECTOR 3                                   -- --
do
	function methods.value.Vector3(v: Vector3)
		if v == Vector3.zero then
			return "Vector3.zero"
		end
		if v == Vector3.one then
			return "Vector3.one"
		end
		return ("Vector3.new(%d, %d, %d)"):format(v.X, v.Y, v.Z)
	end
end
-- //             VECTOR 3                                   // --

-- --             CFRAME                                     -- --
do
	local BLANK_CFRAME = CFrame.new()
	function methods.value.CFrame(v: CFrame)
		local s = "CFrame.new("
		if v == CFrame.identity then
			return "CFrame.identity"
		end
		if v == BLANK_CFRAME then
			s ..= ")"
			return s
		end
		local args = {}
		if v.Position ~= BLANK_CFRAME.Position then
			table.insert(args, methods.value.Vector3(v.Position))
		end
		-- append args
		s ..= table.concat(args, ", ") .. ")"
		if v.LookVector ~= BLANK_CFRAME.LookVector then
			s = ("CFrame.new(%s) * CFrame.Angles(%d, %d, %d)"):format(
				methods.value.Vector3(v.Position),
				v:ToEulerAnglesXYZ()
			)
		end
		return s
	end
end
-- //             CFRAME                                     // --

-- //            DATA TYPE SERIALIZER FUNCTIONS              // --

function methods.type.table(t: {}, info: tableToTypeInfo)
	local index = table.find(getgenv(), t)
	if index and type(index) == "string" then
		return index
	end
	profileBegin("TABLE_SERIALIZE")
	setMemoryCategory("TABLE_SERIALIZE")
	local s = "{"
	local size = 0
	info = info or defaultInfo
	info.level += 1
	local indentCount = options.INDENT * info.level
	local types = {}
	local serializedTypes = {}
	for k, v in t do -- iterates over table
		-- no metamethods
		if type(k) == "string" and k:match("^__%w+$") then
			continue
		end
		if size > (options.MAX_TABLE_SIZE or 1000) then
			s = s
				.. "\n"
				.. options.INDENT_CHARACTER:rep(indentCount)
				.. ("-- MAXIMUM TABLE SIZE REACHED (%d), CHANGE 'MAX_TABLE_SIZE' TO ADJUST MAXIMUM SIZE."):format(size)
			break
		end
		size += 1 -- changes size for max limit
		-- actually serializes the member of the table
		local val = serialize(v, "type", info)
		if table.find(serializedTypes, val) then
			continue
		end
		local str = ""
		if type(k) == "string" and k:match("^[_%a][_%w]*$") then
			--print("serialize member/string:", k)
			str = k .. ": " .. val
		elseif type(k) == "number" then
			--print("serialize member/number:", k, "/", v)
			str = val
		else
			--print("serialize member/unknown:", k)
			str = "[" .. serialize(k, "value", info) .. "]: " .. val
		end
		table.insert(serializedTypes, val)
		s ..= ("\n%s%s%s"):format(
			options.INDENT_CHARACTER:rep(indentCount), str,
			type(k) == "string" and "," or " |"
		)
		-- removes the last OR because it looks nicer + fixes syntax error
		-- (no way to tell if it's done 'till it's done so...)
		if #s > 1 and s:sub(-1) == "|" then
			s = s:sub(1, #s - 1)
		end
	end
	if size > 0 then -- cleanly indents the last curly bracket
		info.level -= 1
		s ..= "\n" ..
			(info.level > 0 and
				options.INDENT_CHARACTER:rep(indentCount - info.level) or
				""
			)
	end
	reSetMemoryCategory()
	profileEnd()
	return s .. "}"
end

-- can't do function methods.type["function"] or function methods.type.function
-- so...
methods.type["function"] = function(f: (unknown) -> unknown)
	profileBegin("FUNCTION_SERIALIZE")
	setMemoryCategory("FUNCTION_SERIALIZE")
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
	profileEnd()
	reSetMemoryCategory()
	return `({table.concat(params, ", ")}) -> any`
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
				return true, (path .. "[" .. serialize(i, "value") .. "]")
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
						return true, "[" .. serialize(i, "value") .. "]" .. p
					end
				end
			end
		end
	end
	return false, ""
end
-- can't do function methods.type["function"] or function methods.type.function
-- so...
methods.value["function"] = function(f: (unknown) -> unknown)
	for k, x in getgenv() do
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
				return "getgenv()[" .. serialize(k, "value") .. "]" .. gpath
			end
		end
	end
	local source, name, argCount, hasVararg = info(f, "sna")
	--local name = info(f, "n")
	--local argCount, hasVararg = info(f, "a")

	if name and name:match("^[%a_]+[%w_]*$") then
		return
			`{name}()\
		--[[\
		Function name: {name}, \
		param count: {argCount}, \
		has vararg: {hasVararg}\
		\
		generated type: {serialize(f, "type")}\
		Source: {source}\
		Is defined in C: {source == "[C]" and "yes (true)" or "no (false)"}\
		--]]`
	end
	return tostring(f)
end

local function toLuauTypeString(name: string, obj: any, ...)
	return ("type %s = %s"):format(name, serialize(obj, "type", ...))
end
serializer.toLuauTypeString = toLuauTypeString



if script:IsA("ModuleScript") then
	return serializer
else
	if not runExample then
		return
	end
  -- note: this was written and intended for voxels skywars only, it may not work on other games.
	local items = require(ReplicatedStorage.TS.item.item).Items
	
	serialize(items, "value")
end
