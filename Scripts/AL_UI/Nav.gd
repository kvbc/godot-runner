extends Control

@onready var lvl = $margin/vbox/lvl
@onready var lvlbar = $margin/vbox/lvlbar
@onready var coinlabel = $margin/vbox/gold/Label2

var lvlbarTargetWidth = null

func _ready ():
	await get_tree().process_frame # wait for lvlbar's parent .size
	
	updateLvl()
	updateEnv()
	ALWorld.OnLevelChanged.connect(updateLvl)
	ALWorld.OnEnvCreated.connect(func (env):
		updateEnv()	
	)
	
	var plr = ALWorld.GetPlayer()
	plr.OnCoinsChanged.connect(func ():
		coinlabel.text = str(plr.GetCoins())
	)

func _process (dt):
	if lvlbarTargetWidth != null:
		lvlbar.custom_minimum_size.x = lerp(lvlbar.custom_minimum_size.x, lvlbarTargetWidth, dt * 5)

func updateLvl ():
	lvl.text = 'Level ' + str(ALWorld.GetLevel())
	
func updateEnv ():
	var percent = ((ALWorld.GetEnvNum() - 1) % ALWorld.ENVS_PER_LVL + 1) / float(ALWorld.ENVS_PER_LVL)
	lvlbarTargetWidth = lvlbar.get_parent().size.x * percent

#
# Public
#

func GetCoinIcon ():
	return $margin/vbox/gold/Coin
