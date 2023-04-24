extends Node2D

signal OnEnvChanged
signal OnLevelChanged
signal OnEnvCreated (env)

const ENVS_PER_LVL = 5

var envNum = 1
var lvl = 1
@onready var plr = $Player
@onready var camera = $Camera2D

const CAMERA_Y_OFFSET = -350

func _ready ():
	OnLevelChanged.connect(func ():
		get_tree().change_scene_to_file("res://Scenes/UI/Shop.tscn")	
	)
	
	plr.OnWeaponFired.connect(func ():
		var bullet = Bullet.new($Bullets, plr.getWeaponStats().dmg)
		bullet.node.position = plr.position	
	)
	
	createEnv()

var topEnv = null
func createEnv () -> Node2D:
	var env = preload("res://Scenes/AL_World/Environment/Environment.tscn").instantiate()
	
	var createNextEnv = func () -> void:
		var topY = topEnv.position.y - ProjectSettings.get_setting("display/window/size/viewport_height")
		createEnv().position.y = topY
	
	var isFirstEnv = (topEnv == null)
	topEnv = env
	if isFirstEnv:
		createNextEnv.call()
	
	env.GetVisNotifier().screen_exited.connect(func ():
		createNextEnv.call()
		
		env.queue_free()
		envNum += 1
		
		var newLvl = ceil(envNum / float(ENVS_PER_LVL))
		if (newLvl != lvl):
			lvl = newLvl
			OnLevelChanged.emit()
	)
	
	$Envs.add_child(env)
	OnEnvCreated.emit(env)
	return env

func _process (dt: float):
	camera.position.y = plr.position.y + CAMERA_Y_OFFSET

#
# Public
#

func GetEnvs ():
	return $Envs.get_children()

func GetPlayer ():
	return plr
	
func GetEnvNum ():
	return envNum
	
func GetLevel ():
	return lvl
