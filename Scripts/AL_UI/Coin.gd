extends Control

signal OnDestroyed

@onready var coinIcon = ALUI.GetNav().GetCoinIcon()

func _ready ():
	$AnimatedSprite2D.play("default")

func _process (dt):
	if (self == coinIcon):
		return
	global_position = global_position.lerp(coinIcon.global_position, dt * 10)
	if (global_position.distance_to(coinIcon.global_position) < 10):
		queue_free()
		OnDestroyed.emit()
