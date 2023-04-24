extends CanvasLayer

@onready var vbox = $Control/vbox
@onready var targetVBoxY = vbox.position.y

func _ready ():
	vbox.position.y += vbox.size.y
	
func _process (dt):
	vbox.position.y = lerp(vbox.position.y, targetVBoxY, dt * 5)
