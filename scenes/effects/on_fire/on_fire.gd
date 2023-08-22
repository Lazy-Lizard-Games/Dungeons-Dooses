extends Effect

@export var damage_per_tick: float = 5
@export var tick_rate: float = 5
@export var duration: float = 5

@onready var timer: Timer = $Timer
@onready var tick_timer: Timer = $TickRate

var fire_stacks: Array[TimedVariant]

var damage: DamageData

func _ready() -> void:
	var damage_data = DamageData.new()
	damage_data.damage = damage_per_tick
	damage_data.type = Globals.DAMAGE_TYPES.FIRE
	damage = damage_data
	tick_timer.start(1/tick_rate)
	timer.start(duration)

func _add_stack() -> void:
	var fire_stack = TimedVariant.new()
	add_child(fire_stack)
	if fire_stacks.size() >= effect_instance.max_stacks:
		fire_stacks.remove_at(0)
	fire_stack.timeout.connect(_on_fire_stack_end)
	fire_stack.start(fire_stack, duration)
	fire_stacks.append(fire_stack)
	stacks = fire_stacks.size()
	self.emit_signal("stack_changed", 1)

func _remove_stack() -> void:
	_on_fire_stack_end(fire_stacks[fire_stacks.size()-1])

func _on_fire_stack_end(fire_stack: TimedVariant) -> void:
	remove_child(fire_stack)
	fire_stacks.remove_at(fire_stacks.find(fire_stack))
	stacks = fire_stacks.size()
	self.emit_signal("stack_changed", -1)

func _on_stack_change(change: int) -> void:
	if change > 0:
		timer.stop()
		timer.wait_time = duration
		timer.start()

func _on_timer_timeout() -> void:
	queue_free()

func _on_tick_rate_timeout() -> void:
	if not container.hitbox_component:
		return
	damage.damage = damage_per_tick * fire_stacks.size()
	container.hitbox_component.deal_damage_with_transforms(damage)
