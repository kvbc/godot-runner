extends Node

signal OnReady
signal OnProcess (dt: float)

var wrapper = null

func _ready () -> void:
	assert(wrapper != null)
	OnReady.emit()

func _process (dt: float) -> void:
	OnProcess.emit(dt)

func _get (prop: StringName) -> Variant:
	if prop == "wrapper":
		return wrapper
	return null

func _get_property_list ():
	return [
		{ "name": "wrapper", "type": TYPE_OBJECT }
	]
