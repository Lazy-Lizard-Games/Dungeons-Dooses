class_name DamageEffect
extends ActiveEffect

## Damage effects deal damage to the affected entity over time.

@export var type: Enums.DamageType
@export var amount: float
@export var interval_time: float
var interval_timer: Timer

func _ready():
	interval_timer = Timer.new()
	add_child(interval_timer)
	interval_timer.timeout.connect(on_interval_timer_timeout)
	interval_timer.start(interval_time)

func on_interval_timer_timeout() -> void:
	var damage = DamageEntity.new(type, amount)
	damage.execute(entity)
	interval_timer.start(interval_time)