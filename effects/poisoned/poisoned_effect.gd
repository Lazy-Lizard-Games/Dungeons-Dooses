extends Effect

## Time between poison damage ticks.
@export var tick_interval: float = 1
@export var tick_damage: float = 1

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


func add_stack() -> void:
	expire_timer.start(duration)
	if current_stacks < max_stacks:
		current_stacks += 1


func take_damage() -> void:
	if parent.health:
		var temp_tick_damage = DamageData.new()
		temp_tick_damage.amount = tick_damage * current_stacks
		temp_tick_damage.type = Globals.DAMAGE.POISON
		parent.health.damage(temp_tick_damage, null)
