extends Ability

## Raises the warrior's shield while active, increasing physical resistance but reducing movement speed.

const UID = &"Guard"

@export var player: Player
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer
@export var resistance: float

var has_casted = false

func enter() -> void:
	player.health_component.damaged.connect(_on_player_health_component_damaged)
	animation_player.play("shield_raise")
	cast()

func exit() -> void:
	player.health_component.damaged.disconnect(_on_player_health_component_damaged)
	if has_casted:
		player.stats_component.physical_resistance.remove_modifier(UID)
		player.stats_component.movement_speed.remove_modifier(UID)

func process_frame(_delta: float) -> State:
	if Input.is_action_just_released("ability_3"):
		return player.state_component.starting_state
	return null

func process_physics(_delta: float) -> State:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.x != 0:
		sprite.flip_h = direction.x < 0
	player.velocity_component.accelerate_in_direction(direction * 0.1)
	player.velocity_component.move(player)
	return null

func _on_casted() -> void:
	has_casted = true
	var resistance_modifier = AttributeModifier.new(UID, Enums.OperationType.Addition, resistance)
	player.stats_component.physical_resistance.add_modifier(resistance_modifier)

func _on_player_health_component_damaged(damage_data: DamageData) -> void:
	player.stamina_component.exhaust(damage_data.amount)