extends Effect

@export var damage_per_tick: float = 5
@export var tick_rate: float = 5
@export var duration: float = 5

@onready var damage_timer: Timer = $DamageTimer
@onready var decay_timer: Timer = $DecayTimer

var damage: DamageData


func _ready() -> void:
	damage = DamageData.new()
	damage.type = Globals.DAMAGE_TYPES.FIRE
	damage_timer.start(1/tick_rate)
	decay_timer.start(duration)


func _add_stack() -> void:
	var prev_stacks = stacks
	stacks = min(stacks + 1, effect_instance.max_stacks)
	decay_timer.start(duration)
	if prev_stacks != stacks:
		stack_changed.emit(stacks - prev_stacks)


func _remove_stack() -> void:
	var prev_stacks = stacks
	stacks = max(stacks - 1, 0)
	if prev_stacks != stacks:
		stack_changed.emit(stacks - prev_stacks)


func _on_damage_timer_timeout() -> void:
	if not container.hitbox_component:
		return
	damage.damage = damage_per_tick * stacks
	container.hitbox_component.deal_damage_with_transforms(damage)


func _on_decay_timer_timeout():
	exit_tree()
