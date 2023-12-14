extends Effect

## Time between poison damage ticks.
@export var tick_interval: float = 1
@export var tick_damage: DamageData

## Effect construction logic
func enter() -> void:
	print("Poisoned entering...")
	var timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(take_damage)
	timer.one_shot = false
	timer.start(tick_interval)

## Effect deconstruction logic
func exit() -> void:
	print("Poisoned exiting...")


func take_damage() -> void:
	if parent.health:
		parent.health.damage(tick_damage, null)
