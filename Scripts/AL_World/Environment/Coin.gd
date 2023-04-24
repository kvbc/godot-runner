extends Node2D

signal OnDestroyed

var target: Vector2

func _ready ():
	$AnimatedSprite2D.play("default")

	var angle = randi_range(0, 360)
	var dist = randi_range(10, 100)
	target = position + Vector2.from_angle(angle) * dist
	
	get_tree().create_timer(0.5).timeout.connect(func ():
		OnDestroyed.emit()
		queue_free()
	)

func _process (dt):
	position = position.lerp(target, dt * 10)
