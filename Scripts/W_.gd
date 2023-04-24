extends Node
class_name Wrapper

#
# Public
#

static func Init (wrapper, wrappedNode: Node, parent = null) -> void:
	wrapper.set("node", wrappedNode)
	wrappedNode.set_script(preload("res://Scripts/W__WrappedNode.gd"))
	wrappedNode.wrapper = wrapper
	if parent != null:
		parent.add_child(wrappedNode)
