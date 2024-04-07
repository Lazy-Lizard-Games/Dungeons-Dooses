extends ActiveEffect

## Increases physical damage taken for a short duration.

## Controls the increase to damage taken as a percentage, i.e: 0.1 -> 10% increase. 
## Negative values reduce damage taken, i.e: -0.5 -> 50% decrease.
@export var strength: float
var modifier = AttributeModifier.new()

func apply_actor_transforms(actor: Entity) -> void:
	duration_time *= actor.generics.ability_duration.get_final_value()
	strength *= actor.generics.ability_power.get_final_value()

func enter() -> void:
	modifier.uid = uid
	modifier.value = 1 + strength
	modifier.operation = Enums.OperationType.Multiplication
	var add_modifier = AddResistanceModifierEntityAction.new()
	add_modifier.modifier = modifier
	add_modifier.damage_type = Enums.DamageType.Normal
	add_modifier.resistance_type = Enums.ResistanceType.Damage
	add_modifier.execute(entity)

func exit() -> void:
	var remove_modifier = RemoveResistanceModifierEntityAction.new()
	remove_modifier.uid = uid
	remove_modifier.damage_type = Enums.DamageType.Normal
	remove_modifier.resistance_type = Enums.ResistanceType.Damage
	remove_modifier.execute(entity)

func _on_stacks_changed(_prev: int, cur: int) -> void:
	modifier.value = 1 + (strength * cur)
