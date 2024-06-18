extends Ability

## Raises the warrior's shield while active, increasing physical resistance but reducing movement speed.

const UID = &"Guard"

@export var resistance: float

var has_casted = false

func enter() -> void:
	mob.health_component.damaged.connect(_on_mob_health_component_damaged)
	mob.animation_player.play("shield_raise")
	cast()

func exit() -> void:
	mob.health_component.damaged.disconnect(_on_mob_health_component_damaged)
	if has_casted:
		mob.stats_component.physical_resistance.remove_modifier(UID)
		mob.stats_component.movement_speed.remove_modifier(UID)

func process_frame(_delta: float) -> State:
	if Input.is_action_just_released("ability_3"):
		return mob.state_component.starting_state
	return null

func process_physics(_delta: float) -> State:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.x != 0:
		mob.sprite.flip_h = direction.x < 0
	mob.velocity_component.accelerate_in_direction(direction * 0.1)
	mob.velocity_component.move(mob)
	return null

func _on_casted() -> void:
	has_casted = true
	var resistance_modifier = AttributeModifier.new(UID, Enums.OperationType.Addition, resistance)
	mob.stats_component.physical_resistance.add_modifier(resistance_modifier)

func _on_mob_health_component_damaged(damage_data: DamageData) -> void:
	mob.stamina_component.exhaust(damage_data.amount)

func _on_started() -> void:
	mob.state_component.change_state(self)