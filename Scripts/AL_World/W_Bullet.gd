extends Object
class_name Bullet

const SPEED = 800
var dmg: int
var node: Node2D

func _init (parent, _dmg: int) -> void:
	dmg = _dmg
	
	node = preload("res://Scenes/AL_World/W_Bullet.tscn").instantiate()
	Wrapper.Init(self, node, parent)
		
	node.OnReady.connect(func ():
		var visNotifier = VisibleOnScreenNotifier2D.new()
		node.add_child(visNotifier)
		visNotifier.screen_exited.connect(node.queue_free)
		
		node.area_entered.connect(func (area):
			if not area.is_in_group("Bullets"):
				node.queue_free()	
		)
	)
	
	node.OnProcess.connect(func (dt):
		node.position.y -= SPEED * dt
	)

#
# Public
#

func GetDamage () -> int:
	return dmg
