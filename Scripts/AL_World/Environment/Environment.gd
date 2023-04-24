extends Node2D

signal OnCoinCreated (coin)

func _ready ():
	for i in randi_range(1, 3):
		var enemy = Enemy.new($Enemies, Enemy.Type.A)
		const padding = 100
		enemy.node.position.x = randi_range(padding, ProjectSettings.get_setting("display/window/size/viewport_width") - padding)
		enemy.node.position.y = randi_range(padding, ProjectSettings.get_setting("display/window/size/viewport_height") - padding)
		enemy.OnDeath.connect(func ():
			for j in 10:
				var coin = preload("res://Scenes/AL_World/Environment/Coin.tscn").instantiate()
				coin.position = enemy.node.position
				$Coins.add_child(coin)
				OnCoinCreated.emit(coin)
		)

#
# Public
#

func GetVisNotifier () -> VisibleOnScreenNotifier2D:
	return $VisNotifier
