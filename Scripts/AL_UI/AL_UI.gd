extends CanvasLayer

signal OnCoinCreated (coin)

func _ready ():
	var onEnv = func (env):
		env.OnCoinCreated.connect(func (coin):
			coin.OnDestroyed.connect(func ():
				var uicoin = preload("res://Scenes/AL_UI/Coin.tscn").instantiate()
				uicoin.global_position = coin.get_screen_transform().origin
				$Control/coins.add_child(uicoin)
				OnCoinCreated.emit(uicoin)
			)	
		)
	for env in ALWorld.GetEnvs():
		onEnv.call(env)
	ALWorld.OnEnvCreated.connect(onEnv)

#
# Public
#

func GetNav ():
	return $Control/nav
