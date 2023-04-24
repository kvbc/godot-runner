extends Object
class_name Enemy

signal OnDeath

enum Type {
	A
}

var hp = 3
var node: Node2D

func _init (parent, type: Type):
	match type:
		Type.A:
			node = preload("res://Scenes/AL_World/Environment/W_Enemy/A.tscn").instantiate()
			node.area_entered.connect(func (area):
				if area.is_in_group("Bullets"):
					var dmg = area.wrapper.GetDamage()
					Damage(dmg)
			)
	Wrapper.Init(self, node, parent)

#
# Public
#

func Damage (dmg: int) -> void:
	if hp <= 0:
		return
	
	hp -= dmg
	if hp <= 0:
		OnDeath.emit()
		node.queue_free()
		return
	
	node.modulate = Color.RED
	await node.get_tree().create_timer(0.1).timeout
	if is_instance_valid(node):
		node.modulate = Color.WHITE
