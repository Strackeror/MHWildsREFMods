local create_namespace
local namespace_functions = {}

---@param self Namespace
function namespace_functions.T(self)
	return function(ns)
		return ns._typedef
	end
end

---@param self Namespace
function namespace_functions.Instance(self)
	return sdk.get_managed_singleton(self._name)
end

local namespace_builder_metatable = {
	---@param name string
	__index = function(self, name)
		-- Fallback for fields that can't be taken as symbols
		if namespace_functions[name] then
			return namespace_functions[name](self)
		end
		local typedef = rawget(self, "_typedef")
		if typedef then
			local field = typedef:get_field(name)
			if field then
				if field:is_static() then
					return field:get_data()
				end
				return field
			end

			local method = typedef:get_method(name)
			if method then
				return method
			end
		end
		local force = false
		if name:sub(1, 2) == "__" then
			name = name:sub(3)
			force = true
		end
		return create_namespace(rawget(self, "_name") .. "." .. name, force)
	end,
}

---@return any
create_namespace = function(basename, force_namespace)
	force_namespace = force_namespace or false

	---@class Namespace
	local table = { _name = basename }
	if sdk.find_type_definition(basename) and not force_namespace then
		table = {
			_typedef = sdk.find_type_definition(basename),
			_name = basename,
		}
	else
		table = { _name = basename }
	end
	return setmetatable(table, namespace_builder_metatable)
end
local app = create_namespace("app", true)

local function to_model_id(byte)
	if byte == 0 then
		return -1
	end
	if byte == 255 then
		return 0
	end
	if byte >= 100 then
		return 100000 + byte - 100
	end
	if byte >= 50 then
		return 10000 + byte - 50
	end
	return byte
end

local function to_byte(model_id)
	if model_id == -1 then
		return 0
	end
	if model_id == 0 then
		return 255
	end
	if model_id >= 100000 then
		return model_id - 100000 + 100
	end
	if model_id >= 10000 then
		return model_id - 10000 + 50
	end
	return model_id
end

local function current_main_weapon()
	local save_data = app.SaveDataManager.Instance:getCurrentUserSaveData()
	local equip = save_data._Equip
	local main_weapon_idx = equip._EquipIndex.Index[0].m_value
	return equip._EquipBox[main_weapon_idx]
end

local function weapon_data(work)
	return app.WeaponUtil["getWeaponData(app.savedata.cEquipWork)"](nil, work)
end

local function reset_all_weapons()
	local save_data = app.SaveDataManager.Instance:getCurrentUserSaveData()
	for _, obj in pairs(save_data._Equip._EquipBox) do
		if obj:get_Category() == 1 then
			obj.FreeVal5 = 0
		end
	end
end

local current_weapons = {}
sdk.hook(
	app.PlayerManager.generateHunterCreateInfo,
	function(args)
		current_weapons = { sdk.to_managed_object(args[4]), sdk.to_managed_object(args[3]) }
	end, --
	function(retval)
		current_weapons = {}
		return retval
	end
)

local disable = false
sdk.hook(
	app.WeaponUtil["getModelId(app.user_data.WeaponData.cData, app.ArtianUtil.ArtianInfo)"],
	function(args) end,
	function(retval)
		if disable then
			return retval
		end
		local current_weapon = table.remove(current_weapons)
		if current_weapon and current_weapon.FreeVal5 ~= 0 then
			local ret = to_model_id(current_weapon.FreeVal5)
			return sdk.to_ptr(ret)
		end
		return retval
	end
)

local customModelId = "0"
re.on_draw_ui(function()
	if imgui.tree_node("HookWeaponLayer") then
		local current_weapon = current_main_weapon()
		if not current_weapon then
			imgui.text("Could not find current weapon")
		else
			imgui.text("Current weapon base model id: " .. tostring(weapon_data(current_weapon)._ModelId))
			imgui.text("Current weapon custom model id: " .. tostring(to_model_id(current_weapon.FreeVal5)))
			_, customModelId = imgui.input_text("Set Custom Model id", customModelId)
			if imgui.button("Set") then
				local id = tonumber(customModelId)
				if id ~= nil then
					current_weapon.FreeVal5 = to_byte(id)
				end
			end
			if imgui.button("Reset") then
				current_weapon.FreeVal5 = 0
			end
			if imgui.tree_node("Debug") then
				imgui.text("FreeVal5:" .. tostring(current_weapon.FreeVal5))
				_, disable = imgui.checkbox("Disable layering", disable)
				if imgui.button("Reset All") then
					reset_all_weapons()
				end
				imgui.tree_pop()
			end
		end
		imgui.tree_pop()
	end
end)
