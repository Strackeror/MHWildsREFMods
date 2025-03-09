---@meta
---@class Matrix4x4f
---@class Quaternion
---@class Vector2f
---@operator add(Vector2f):Vector2f
---@operator sub(Vector2f):Vector2f
---@operator mul(number):Vector2f
Vector2f = {}

---@class Vector3f
---@operator add(Vector3f):Vector3f
---@operator sub(Vector3f):Vector3f
---@operator mul(number):Vector3f
Vector3f = {}

---@class Vector4f
---@operator add(Vector4f):Vector4f
---@operator sub(Vector4f):Vector4f
---@operator mul(number):Vector4f

Vector4f = {}

---@param x number
---@param y number
---@return Vector2f
function Vector2f.new(x, y) end
---@param x number
---@param y number
---@param z number
---@return Vector3f
function Vector3f.new(x, y, z) end
---@param x number
---@param y number
---@param z number
---@param w number
---@return Vector4f
function Vector4f.new(x, y, z, w) end

---Returns the dot product between self and other.
---@param other Vector2f
---@return Vector2f product
function Vector2f:dot(other) end

---Returns the dot product between self and other.
---@param other Vector3f
---@return Vector3f product
function Vector3f:dot(other) end

---Returns the dot product between self and other.
---@param other Vector4f
---@return Vector4f product
function Vector4f:dot(other) end

---Returns the cross product between self and other.
---@param other Vector2f
---@return Vector2f product
function Vector2f:cross(other) end

---Returns the cross product between self and other.
---@param other Vector3f
---@return Vector3f product
function Vector3f:cross(other) end

---Returns the cross product between self and other.
---@param other Vector4f
---@return Vector4f product
function Vector4f:cross(other) end
---returns the length of self
function Vector2f:length() end
---returns the length of self
function Vector3f:length() end
---returns the length of self
function Vector4f:length() end

---Normalizes VectorXf. Nothing is returned.
function Vector2f:normalize() end
---Returns the normalization of self.
---@return Vector2f
function Vector2f:normalized() end
---Returns the reflection of self over normal.
---@param normal Vector2f
---@return Vector2f
function Vector2f:reflect(normal) end
---Returns the refraction of self over normal with the given eta.
---@param normal Vector2f
---@param eta any
---@return Vector2f
function Vector2f:refract(normal, eta) end
---Returns the linear interpolation between self and other with the given t.
---@param other Vector2f
---@param t number
---@return Vector2f
function Vector2f:lerp(other, t) end

---Converts self to a Vector3f.
---@return Vector3f vec3
function Vector2f:to_vec3() end
---Converts self to a Vector4f.
---@return Vector4f vec4
function Vector2f:to_vec4() end
---Converts self to a Matrix4x4f. Treats self as the forward vector.
---@return Matrix4x4f matrix
function Vector2f:to_mat() end
---Converts self to a Quaternion. Treats self as the forward vector.
---Equivalent to self:to_mat():to_quat().
---@return Quaternion quat
function Vector2f:to_quat() end

---Normalizes VectorXf. Nothing is returned.
function Vector3f:normalize() end
---Returns the normalization of self.
---@return Vector3f
function Vector3f:normalized() end
---Returns the reflection of self over normal.
---@param normal Vector3f
---@return Vector3f
function Vector3f:reflect(normal) end
---Returns the refraction of self over normal with the given eta.
---@param normal Vector3f
---@param eta any
---@return Vector3f
function Vector3f:refract(normal, eta) end
---Returns the linear interpolation between self and other with the given t.
---@param other Vector3f
---@param t number
---@return Vector3f
function Vector3f:lerp(other, t) end

---Converts self to a Vector2f.
---@return Vector2f vec2
function Vector3f:to_vec2() end

---Converts self to a Vector4f.
---@return Vector4f vec4
function Vector3f:to_vec4() end
---Converts self to a Matrix4x4f. Treats self as the forward vector.
---@return Matrix4x4f matrix
function Vector3f:to_mat() end
---Converts self to a Quaternion. Treats self as the forward vector.
---Equivalent to self:to_mat():to_quat().
---@return Quaternion quat
function Vector3f:to_quat() end

---Normalizes VectorXf. Nothing is returned.
function Vector4f:normalize() end
---Returns the normalization of self.
---@return Vector4f
function Vector4f:normalized() end
---Returns the reflection of self over normal.
---@param normal Vector4f
---@return Vector4f
function Vector4f:reflect(normal) end
---Returns the refraction of self over normal with the given eta.
---@param normal Vector4f
---@param eta any
---@return Vector4f
function Vector4f:refract(normal, eta) end
---Returns the linear interpolation between self and other with the given t.
---@param other Vector4f
---@param t number
---@return Vector4f
function Vector4f:lerp(other, t) end

---Converts self to a Vector2f.
---@return Vector2f vec2
function Vector4f:to_vec2() end
---Converts self to a Vector3f.
---@return Vector3f vec3
function Vector4f:to_vec3() end

---Converts self to a Matrix4x4f. Treats self as the forward vector.
---@return Matrix4x4f matrix
function Vector4f:to_mat() end
---Converts self to a Quaternion. Treats self as the forward vector.
---Equivalent to self:to_mat():to_quat().
---@return Quaternion quat
function Vector4f:to_quat() end
