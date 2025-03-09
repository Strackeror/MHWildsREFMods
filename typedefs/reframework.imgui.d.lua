---@meta
---@enum ImGuiCond_
ImGuiCond_ = {
    ImGuiCond_None = 0, -- No condition (always set the variable), same as _Always
    ImGuiCond_Always = 1 << 0, -- No condition (always set the variable)
    ImGuiCond_Once = 1 << 1, -- Set the variable once per runtime session (only the first call will succeed)
    ImGuiCond_FirstUseEver = 1 << 2, -- Set the variable if the object/window has no persistently saved data (no entry in .ini file)
    ImGuiCond_Appearing = 1 << 3 -- Set the variable if the object/window is appearing after being hidden/inactive (or the first time)
}

---@class imgui
imgui = {}
---Creates a new window with the title of `name`.
---`begin_window` must have a corresponding `end_window` call.
-- This function may only be called in `on_frame`, not `on_draw_ui`.
---@param name string
---@param open boolean|nil If not `nil`, a close button will be shown in the top right of the window.
---@param flags any ImGuiWindowFlags
---@return boolean # Returns false if the user wants to close the window.
function imgui.begin_window(name, open, flags) end
---Ends the last begin_window call. Required.
function imgui.end_window() end

---@param size Vector2f
---@param border boolean
---@param flags any ImGuiWindowFlags
function imgui.begin_child_window(size, border, flags) end

function imgui.end_child_window() end

function imgui.begin_group() end
function imgui.end_group() end

---draw a rectangle around the elements between `begin_rect` and `end_rect`
function imgui.begin_rect() end

---draw a rectangle around the elements between `begin_rect` and `end_rect`
function imgui.end_rect(additional_size, rounding) end
---Draws a button with `label` text.
---@param label string
---@return boolean # true when user presses button
function imgui.button(label) end
---Draws a small button with `label` text.
---@param label string
---@return boolean # true when user presses button
function imgui.small_button(label) end

---invisible_button
---@param id any
---@param size Vector2f|number[] size is a `Vector2f` or a size 2 array.
---@param flags any
function imgui.invisible_button(id, size, flags) end

---@param id any
---@param dir any dir is an `ImguiDir`
function imgui.arrow_button(id, dir) end
---Draws text.
function imgui.text(text) end
---Draws text with color.
---@param color integer integer color in the form **ARGB**.
function imgui.text_colored(text, color) end
---@param label string
---@param value boolean
---@return boolean changed,boolean value
function imgui.checkbox(label, value) end

---@param label string
---@param value number
---@param speed number
---@param min number
---@param max number
---@param display_format? string optional
---@return boolean changed if value updated this frame
---@return number value new value
function imgui.drag_float(label, value, speed, min, max, display_format) end
---@param label string
---@param value Vector2f
---@param speed number
---@param min number
---@param max number
---@param display_format? string optional
---@return boolean changed if value updated this frame
---@return Vector2f value new value
function imgui.drag_float2(label, value, speed, min, max, display_format) end
---@param label string
---@param value Vector3f
---@param speed number
---@param min number
---@param max number
---@param display_format? string optional
---@return boolean changed if value updated this frame
---@return Vector3f value new value
function imgui.drag_float3(label, value, speed, min, max, display_format) end
---@param label string
---@param value Vector4f
---@param speed number
---@param min number
---@param max number
---@param display_format? string optional
---@return boolean changed if value updated this frame
---@return Vector4f value new value
function imgui.drag_float4(label, value, speed, min, max, display_format) end

---@param label string
---@param value integer
---@param speed number
---@param min number
---@param max number
---@param display_format? string optional
---@return boolean changed if value updated this frame
---@return integer value new value
function imgui.drag_int(label, value, speed, min, max, display_format) end

---@param label string
---@param value number
---@param min number
---@param max number
---@param display_format? string optional
---@return boolean changed if value updated this frame
---@return number value new value
function imgui.slider_float(label, value, min, max, display_format) end

---@param label string
---@param value integer
---@param min number
---@param max number
---@param display_format? string optional
---@return boolean changed if value updated this frame
---@return integer value new value
function imgui.slider_int(label, value, min, max, display_format) end

---comment
---@param label string
---@param value string
---@param flags? any ImGuiInputTextFlags
---@return boolean changed
---@return string value
---@return integer selection_start
---@return integer selection_end
function imgui.input_text(label, value, flags) end
---comment
---@param label string
---@param value string
---@param size integer
---@param flags? any ImGuiInputTextFlags
---@return boolean changed
---@return string value
---@return integer selection_start
---@return integer selection_end
function imgui.input_text_multiline(label, value, size, flags) end

---@generic T
---Draws a combo box.
---@param label string
---@param selection T
---@param values table<T, string> can be a table with any type of keys, as long as the values are strings.
---@return boolean # true when selection changes
---@return T value selection index within values (a table)
function imgui.combo(label, selection, values) end

---@param label string
---@param color integer integer color in the form **ABGR** which imgui and draw APIs expect.
---@param flags any ImGuiColorEditFlags
---@return boolean changed
---@return integer value
function imgui.color_picker(label, color, flags) end

---@param label string
---@param color integer integer color in the form **ARGB**.
---@param flags any ImGuiColorEditFlags
---@return boolean changed
---@return integer value
function imgui.color_picker_argb(label, color, flags) end

---@param label string
---@param color Vector3f
---@param flags any ImGuiColorEditFlags
---@return boolean changed
---@return integer value
function imgui.color_picker3(label, color, flags) end

---@param label string
---@param color Vector4f
---@param flags any ImGuiColorEditFlags
---@return boolean changed
---@return integer value
function imgui.color_picker4(label, color, flags) end

---@param label string
---@param color integer integer color in the form **ABGR** which imgui and draw APIs expect.
---@param flags any ImGuiColorEditFlags
---@return boolean changed
---@return integer value
function imgui.color_edit(label, color, flags) end

---@param label string
---@param color integer integer color in the form **ARGB**.
---@param flags any ImGuiColorEditFlags
---@return boolean changed
---@return integer value
function imgui.color_edit_argb(label, color, flags) end

---@param label string
---@param color Vector3f
---@param flags any ImGuiColorEditFlags
---@return boolean changed
---@return integer value
function imgui.color_edit3(label, color, flags) end

---@param label string
---@param color Vector4f
---@param flags any ImGuiColorEditFlags
---@return boolean changed
---@return integer value
function imgui.color_edit4(label, color, flags) end

function imgui.tree_node(label) end

function imgui.tree_node_ptr_id(id, label) end

function imgui.tree_node_str_id(id, label) end
---All of the above tree functions must have a corresponding tree_pop!
function imgui.tree_pop() end

function imgui.same_line() end

function imgui.spacing() end

function imgui.new_line() end

function imgui.is_item_hovered(flags) end

function imgui.is_item_active() end

function imgui.is_item_focused() end

function imgui.collapsing_header(name) end
---Loads a font file from the `reframework/fonts` subdirectory at the specified `size` with optional Unicode `ranges`
---(an array of start, end pairs ending with 0).
---Returns a handle for use with `imgui.push_font()`.
---If `filepath` is nil, it will load the default font at the specified size.
function imgui.load_font(filepath, size, ranges) end
---Sets the font to be used for the next set of ImGui widgets/draw commands until `imgui.pop_font` is called.
function imgui.push_font(font) end

---Unsets the previously pushed font.
function imgui.pop_font() end
---Returns size of the default font for REFramework's UI.
function imgui.get_default_font_size() end

---@param pos any
---@param condition ImGuiCond_
---@param pivot any
function imgui.set_next_window_pos(pos, condition, pivot) end

---@param size any
---@param condition ImGuiCond_
function imgui.set_next_window_size(size, condition) end

---@param id integer|string|void_ptr can be an `int`, `const char*`, or `void*`.
function imgui.push_id(id) end

function imgui.pop_id() end

function imgui.get_id() end

---@return Vector2f # Returns a `Vector2f` corresponding to the user's mouse position in window space.
function imgui.get_mouse() end

---TODO

function imgui.get_key_index(...) end
function imgui.is_key_down(...) end
function imgui.is_key_pressed(...) end
function imgui.is_key_released(...) end
function imgui.is_mouse_down(...) end
function imgui.is_mouse_clicked(...) end
function imgui.is_mouse_released(...) end
function imgui.is_mouse_double_clicked(...) end
function imgui.indent(...) end
function imgui.unindent(...) end
function imgui.begin_tooltip(...) end
function imgui.end_tooltip(...) end
function imgui.set_tooltip(...) end
function imgui.open_popup(...) end
function imgui.begin_popup(...) end
function imgui.begin_popup_context_item(...) end
function imgui.end_popup(...) end
function imgui.close_current_popup(...) end
function imgui.is_popup_open(...) end
function imgui.calc_text_size(...) end
function imgui.get_window_size(...) end
function imgui.get_window_pos(...) end
function imgui.set_next_item_open(...) end
function imgui.begin_list_box(...) end
function imgui.end_list_box(...) end
function imgui.begin_menu_bar(...) end
function imgui.end_menu_bar(...) end
function imgui.begin_main_menu_bar(...) end
function imgui.end_main_menu_bar(...) end
function imgui.begin_menu(...) end
function imgui.end_menu(...) end
function imgui.menu_item(...) end
function imgui.get_display_size(...) end
function imgui.push_item_width(...) end
function imgui.pop_item_width(...) end
function imgui.set_next_item_width(...) end
function imgui.calc_item_width(...) end
function imgui.push_style_color(...) end
function imgui.pop_style_color(...) end
function imgui.push_style_var(...) end
function imgui.pop_style_var(...) end
function imgui.get_cursor_pos(...) end
function imgui.set_cursor_pos(...) end
function imgui.get_cursor_start_pos(...) end
function imgui.get_cursor_screen_pos(...) end
function imgui.set_cursor_screen_pos(...) end
function imgui.set_item_default_focus(...) end
function imgui.begin_table(...) end
function imgui.end_table(...) end
function imgui.table_next_row(...) end
function imgui.table_next_column(...) end
function imgui.table_set_column_index(...) end
function imgui.table_setup_column(...) end
function imgui.table_setup_scroll_freeze(...) end
function imgui.table_headers_row(...) end
function imgui.table_header(...) end
function imgui.table_get_sort_specs(...) end
function imgui.table_get_column_count(...) end
function imgui.table_get_column_index(...) end
function imgui.table_get_row_index(...) end
function imgui.table_get_column_name(...) end
function imgui.table_get_column_flags(...) end
function imgui.table_set_bg_color(...) end
