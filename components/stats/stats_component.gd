extends Node
class_name StatsComponent


@export var health_mult: float = 1.0
@export var stamina_mult: float = 1.0
@export var mana_mult: float = 1.0
@export var speed_mult: float = 1.0
@export var accelerate_mult: float = 1.0
@export var defence_mult: float = 1.0


# TODO
# Handle stat modifiers (add, remove)
# Handle damage reception modifiers
# - apply_damage_resistances(damage) return damage
# Handle damage dealt modifiers
# - apply_damage_multipliers(damage) return damage

func transform_damage(damage: float, damage_type: Globals.DAMAGE_TYPES) -> float:
	return damage
