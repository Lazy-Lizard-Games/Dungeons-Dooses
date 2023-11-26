extends State

@export
var color_rect: ColorRect

@export
var idle_state: State

@export
var move_state: State

@export
var stats_component: StatsComponent

@export
var weapon_component: WeaponComponent

var direction := Vector2.ZERO
var ability_expired := false


func enter() -> void:
	color_rect.color = Color.YELLOW
	ability_expired = false
	weapon_component.ability_expired.connect(func(): ability_expired = true)
	weapon_component.start(4, direction)


func exit() -> void:
	color_rect.color = Color.WHITE


func process_frame(delta: float) -> State:
	if ability_expired:
		if direction.length() > 0:
			return move_state
		return idle_state
	return null


func process_physics(delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	return null
