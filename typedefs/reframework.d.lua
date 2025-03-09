---@meta
---@alias void_ptr unknown
---@alias System.Type unknown
---@class REComponent
REComponent = {}
---@class REField
REField = {}
---@class REMethodDefinition
REMethodDefinition = {}

---@return RETypeDefinition return_type return type of method
function REMethodDefinition:get_return_type() end

---@return void_ptr pointer Pointer to the actual function in memory.
function REMethodDefinition:get_function() end

---@class RETypeDefinition
RETypeDefinition = {}
-- Returns the full name of the class.
-- Equivalent to concatenating self:get_namespace() and self:get_name().
---@return string full_name the full name of the class.
function RETypeDefinition:get_full_name() end

-- desc Returns the type name. Does not contain namespace.
function RETypeDefinition:get_name() end

-- desc Returns the namespace this type is contained in.
function RETypeDefinition:get_namespace() end

---Returns an REMethodDefinition. To be used in things like sdk.hook.
---The full function prototype can be supplied to get an overloaded function.
---Example: foo:get_method("Bar(System.Int32, System.Single)")
---@param name string method name
---@return REMethodDefinition
function RETypeDefinition:get_method(name) end

---Returns a list of REMethodDefinition
---Filters out methods that are potentially just stubs or null.
---@return REMethodDefinition[]
function RETypeDefinition:get_methods() end

---Returns an REField
---@param name string field name
---@return REField
function RETypeDefinition:get_field(name) end

---returns list of REField
---@return REField[]
function RETypeDefinition:get_fields() end

---Returns the RETypeDefinition this type inherits from.
---@return RETypeDefinition
function RETypeDefinition:get_parent_type() end

---Returns a System.Type. Useful for methods that require this. Equivalent to typeof in C#.
function RETypeDefinition:get_runtime_type() end

---Returns the full size of the object. e.g. 0x14 for System.Int32.
---@return integer
function RETypeDefinition:get_size() end

---@class REManagedObject
REManagedObject = {}
---@return integer
function REManagedObject.get_address() end

---Wrapper over sdk.call_object_func.
---Full function prototype can be passed as method_name if there are multiple functions with the same name but different parameters.
---e.g. self:call("foo(System.String, System.Single, System.UInt32, System.Object)", a, b, c, d)
---Valid method names can be found in the Object Explorer. Find the type you're looking for, and valid methods will be found under TDB Methods.
---@param method_name string name of method
---@param ... any function arguments
---@return nil|any return_value dependent on the method's return type
function REManagedObject:call(method_name, ...) end

---desc
---@param name string field name
---@return unknown field return type is dependent on the field type
function REManagedObject:get_field(name) end

---Set the value of the field specified
---@param name string field name
---@param value any value should match the field type
function REManagedObject:set_field(name, value) end

---@return number address address of object
function REManagedObject:get_address() end

---@class REComponent:REManagedObject

---@class sdk
sdk = {}

---@return integer version the version of the type database. A good approximation of the version of the RE Engine the game is running on.
function sdk.get_tdb_version() end

---Returns game_namespace.name.
---DMC5: name would get converted to app.name
---RE3: name would get converted to offline.name
---@param name string value to prefix
---@return string namespace combined string
function sdk.game_namespace(name) end

function sdk.get_thread_context() return end

---
---@param name string singleton name
---@return REManagedObject|nil error
function sdk.get_managed_singleton(name) end

---comment
---@param name string
---@return void_ptr
function sdk.get_native_singleton(name) end

---Returns an RETypeDefinition*.
---@param name string
---@return RETypeDefinition
function sdk.find_type_definition(name) end

---Returns a System.Type.
---Equivalent to calling sdk.find_type_definition(name):get_runtime_type().
---Equivalent to typeof in C#.
function sdk.typeof(name) end

------Returns an REManagedObject.
---Equivalent to calling sdk.find_type_definition(typename):create_instance()
---@param typename string
---@param simplify boolean defaults to false. Set this to true if this function is returning nil.
---@return REManagedObject
function sdk.create_instance(typename, simplify) end

---Creates and returns a new System.String from str.
function sdk.create_managed_string(str) end

-- Creates and returns a new SystemArray of the given type, with length elements.
---@param type System.Type|RETypeDefinition|string type can be any of the following:
-- - A System.Type returned from sdk.typeof
-- - An RETypeDefinition returned from sdk.find_type_definition
-- - A Lua string representing the type name.
---
---Any other type will throw a Lua error.
---If type cannot resolve to a valid System.Type, a Lua error will be thrown.
---@param length integer number of elements
function sdk.create_managed_array(type, length) end

-- Returns a fully constructed REManagedObject of type System.SByte given the value.
function sdk.create_sbyte(value) end

-- Returns a fully constructed REManagedObject of type System.Byte given the value.
function sdk.create_byte(value) end

-- Returns a fully constructed REManagedObject of type System.Int16 given the value.
function sdk.create_int16(value) end

-- Returns a fully constructed REManagedObject of type System.UInt16 given the value.
function sdk.create_uint16(value) end

-- Returns a fully constructed REManagedObject of type System.Int32 given the value.
function sdk.create_int32(value) end

-- Returns a fully constructed REManagedObject of type System.UInt32 given the value.
function sdk.create_uint32(value) end

-- Returns a fully constructed REManagedObject of type System.Int64 given the value.
function sdk.create_int64(value) end

-- Returns a fully constructed REManagedObject of type System.UInt64 given the value.
function sdk.create_uint64(value) end

-- Returns a fully constructed REManagedObject of type System.Single given the value.
function sdk.create_single(value) end

-- Returns a fully constructed REManagedObject of type System.Double given the value.
function sdk.create_double(value) end

-- Returns an REResource.
-- If the typename does not correctly correspond to the resource file or is not a resource type, nil will be returned.
function sdk.create_resource(typename, resource_path) end

-- Returns an REManagedObject which is a via.UserData. typename can be "via.UserData" unless you know the full typename.
function sdk.create_userdata(typename, userdata_path) end

-- Returns a list of REManagedObject generated from data.
-- data is the raw RSZ data contained for example in a .scn file, starting at the RSZ magic in the header.
-- data must in table format as an array of bytes.
---@param data any
---@return REManagedObject[] list
function sdk.deserialize(data) end

---Calls a function belonging to a Native Object
---
-- Should only be used with native types, not REManagedObject (though, it can be if wanted).
---@param object void_ptr native object to call on
---@param type_definition RETypeDefinition object type
---@param method_name string Full function prototype can be passed as method_name if there are multiple functions with the same name but different parameters.
---@param ... any function arguments
---@return unknown value dependent on what the method returns.
function sdk.call_native_func(object, type_definition, method_name, ...) end

---Calls a function belonging to a Managed Object
---
---Alternative calling method: managed_object:call(method_name, args...)
---@param managed_object REManagedObject object to call on
---@param method_name string Full function prototype can be passed as method_name if there are multiple functions with the same name but different parameters.
---@param ... any function arguments
---@return unknown value dependent on what the method returns.
function sdk.call_object_func(managed_object, method_name, ...) end

function sdk.get_native_field(object, type_definition, field_name) end

function sdk.set_native_field(object, type_definition, field_name, value) end

---returns the current camera being used by the engine
---@return REManagedObject camera camera object
function sdk.get_primary_camera() end

---Creates a hook for method_definition, intercepting all incoming calls the game makes to it.
---
---Using pre_function and post_function, the behavior of these functions can be modified.
---
---NOTE: Some native methods may not be able to be hooked with this, e.g. if they are just a wrapper over the native function.
---Some additional work will need to be done from our end to make those work.
---
---Documentation on formatting for pre_function and post_function can be found here: https://cursey.github.io/reframework-book/api/sdk.html#sdkhookmethod_definition-pre_function-post_function-ignore_jmp
---@param method_definition REMethodDefinition --method to hook
---@param pre_function fun(args:void_ptr[]) runs before start of hooked function
---@param post_function? fun(retval): void_ptr runs after end of hooked function
---@param ignore_jmp? boolean Skips trying to follow the first jmp in the function. Defaults to false.
function sdk.hook(method_definition, pre_function, post_function, ignore_jmp) end

-- Similar to sdk.hook but hooks on a per-object basis instead, instead of hooking the function globally for all objects.
--
-- Example: The objects (A,B,C) of the same type T exist in memory. By calling sdk.hook_vtable(B,"method",pre_func,post_func),
-- pre_func and post_func will now be called when object B runs "method", but not when object A or C run that method.
-- Only works if the target method is a virtual method.
---@param obj REManagedObject
---@param method REMethodDefinition
---@param pre fun(args:void_ptr[])
---@param post fun(retval): void_ptr
function sdk.hook_vtable(obj, method, pre, post) end

---Returns true if value is a valid REManagedObject.
---Use only if necessary. Does a bunch of checks and calls IsBadReadPtr a lot.
---@param value REManagedObject
---@return boolean is_managed_object
function sdk.is_managed_object(value) end

---Attempts to convert value to an REManagedObject*.
---@param value REManagedObject|number|void_ptr --value can be any of the following types:
-- - An REManagedObject*, in which case it is returned as-is
-- - A lua number convertible to uintptr_t, representing the object's address
-- - A void*
---@return REManagedObject|nil object A value that is not a valid REManagedObject* will return nil, equivalent to calling sdk.is_managed_object on it.
function sdk.to_managed_object(value) end

-- Attempts to convert value to a double.
---@param value void_ptr void*
---@return number double
function sdk.to_double(value) end

-- Attempts to convert value to a float.
---@param value void_ptr void*
---@return number float
function sdk.to_float(value) end

-- Attempts to convert value to a float.
-- If you need a smaller datatype, you can do:
-- - (sdk.to_int64(value) & 1) == 1 for a boolean
-- - (sdk.to_int64(value) & 0xFF) for an unsigned byte
-- - (sdk.to_int64(value) & 0xFFFF) for an unsigned short (2 bytes)
-- - (sdk.to_int64(value) & 0xFFFFFFFF) for an unsigned int (4 bytes)
---@param value void_ptr void*
---@return integer int
function sdk.to_int64(value) end

---Attempts to convert value to a void*.
---@param value REManagedObject|number|boolean|void_ptr value can be any of the following types:
-- - An REManagedObject*
-- - A lua number convertible to int64_t
-- - A lua number convertible to double
-- - A lua boolean
-- - A void*, in which case it is returned as-is
---
---Any other type will return nil.
---@return void_ptr|nil pointer
function sdk.to_ptr(value) end

---Converts number to a void*.
function sdk.float_to_ptr(number) end

---@class object_explorer
object_explorer = {
    ---@param addr void_ptr | REManagedObject
    handle_address = function(self, addr) end
}


---@class re
re = {}
---Creates a MessageBox with text. Note that this will pause game execution until the user presses OK.
function re.msg(text) end

---Calls function when scripts are being reset. Useful for cleaning up stuff. Calls on_config_save().
function re.on_script_reset(func) end

---Called when REFramework wants to save its config.
function re.on_config_save(func) end

---Called every frame when the "Script Generated UI" in the menu is open.
---`imgui` functions can be called here, and will be placed in their own dropdown in the REFramework menu.
---@param func fun()
function re.on_draw_ui(func) end

---Called every frame. draw functions can be used here.
---Don't use `imgui` functions unless using begin_window etc...
---
---Try to minimize calling game methods when inside `on_frame` and `on_draw_ui`.
function re.on_frame(func) end

function re.on_pre_application_entry(name, func) end

---Triggers function when the application/module entry associated with name is being executed.
---This is very powerful, and can be used to run code at many important points in the engine's logic loop.
---@param name string Function names can be found by viewing `via.ModuleEntry` in the Object Explorer, or at the list [here](https://cursey.github.io/reframework-book/api/re.html#valid-names-for-reon_application_entry).
---@param func function
function re.on_application_entry(name, func) end

function re.on_pre_gui_draw_element(func) end

---Function prototype: function on_*_draw_element(element, context)
---
---Triggers function when a GUI element is being drawn.
---
---Requires that a `bool` is returned in `on_pre_gui_draw_element`. When `false` is returned, the GUI element is not drawn.
---
---example:
---
---```
--re.on_pre_gui_draw_element(function(element, context)
--    local game_object = element:call("get_GameObject")
--    if game_object == nil then return true end
--
--    local name = game_object:call("get_Name")
--
--    log.info("drawing element: " .. name)
--
--    -- Stops the crosshair from being drawn in most RE Engine games.
--    if name == "GUIReticle" or name == "GUI_Reticle" then
--        return false
--    end
---
---    return true
---end)
---```
---@param func fun(element:REComponent,context:void_ptr)
function re.on_gui_draw_element(func) end