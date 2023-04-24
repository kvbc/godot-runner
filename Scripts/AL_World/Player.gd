extends CharacterBody2D

signal OnWeaponFired
signal OnCoinsChanged

enum WeaponType {
	GLOCK,
	UZI,
	AK47,
	ROCKET,
	PLASMA
}

class WeaponStats:
	var delay: float
	var dmg: int
	
	func _init (_delay: float, _dmg: int):
		delay = _delay
		dmg = _dmg

#
#
#

const SPEED := 400

var _weapon: WeaponType
var _coins = 0

#
#
#

func _ready ():
	setWeapon(WeaponType.GLOCK)
	
	ALUI.OnCoinCreated.connect(func (coin):
		coin.OnDestroyed.connect(func ():
			setCoins(_coins + 1)
		)	
	)

func _process (dt: float):
	var moveVec = Vector2(0, -1)
	
	if Input.is_action_pressed("LEFT"):
		moveVec.x -= 1
	if Input.is_action_pressed("RIGHT"):
		moveVec.x += 1
	
	velocity = moveVec * SPEED
	move_and_slide()

#
# Private
#

var timer: Timer
func setWeapon (type: WeaponType) -> void:
	_weapon = type
	
	if (timer != null):
		timer.queue_free()
	timer = Timer.new()
	timer.wait_time = getWeaponStats().delay
	timer.timeout.connect(func ():
		timer.start()
		OnWeaponFired.emit()
	)
	add_child(timer)
	timer.start()

func getWeaponStats () -> WeaponStats:
	match _weapon:
		WeaponType.GLOCK : return WeaponStats.new(0.1, 1)
	return null

func setCoins (coins):
	var changed = (_coins != coins)
	_coins = coins
	if changed:
		OnCoinsChanged.emit()

#
# Public
#

func GetCoins ():
	return _coins
