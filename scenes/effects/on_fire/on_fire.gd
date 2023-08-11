extends Effect

@export var damage_per_tick: float
@export var tick_rate: float

@onready var timer: Timer = $Timer
@onready var tick_timer: Timer = $TickRate

var damage: DamageData

func _ready() -> void:
	var damage_data = DamageData.new()
	damage_data.damage = damage_per_tick
	damage_data.type = Globals.DAMAGE_TYPES.FIRE
	damage = damage_data
	tick_timer.wait_time = 1/tick_rate
	print("Burning!")

func reset_timer() -> void:
	timer.stop()
	timer.wait_time = 1
	timer.start()

func _on_timer_timeout() -> void:
	queue_free()

func _on_tick_rate_timeout() -> void:
	if not container.health_component:
		return
	damage.damage = damage_per_tick * stacks
	container.health_component.damage(damage)
