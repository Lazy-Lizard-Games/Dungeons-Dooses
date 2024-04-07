extends ActiveEffect

## Increases health regen for a short duration.

## Strength of the health regen as a percentage, i.e: 0.1 -> 10% increase.
@export var strength: float

func apply_actor_transforms(actor: Entity) -> void:
	duration_time *= actor.generics.ability_duration.get_final_value()
	strength *= actor.generics.ability_power.get_final_value()

func enter() -> void:
	var modifier = AttributeModifier.new()
	modifier.uid = uid
	modifier.value = 1 + strength
	modifier.operation = Enums.OperationType.Multiplication
	var add_modifier = AddGenericModifierEntityAction.new()
	add_modifier.modifier = modifier
	add_modifier.generic_type = Enums.GenericType.HealthRegeneration
	add_modifier.execute(entity)

func exit() -> void:
	var remove_modifier = RemoveGenericModifierEntityAction.new()
	remove_modifier.uid = uid
	remove_modifier.generic_type = Enums.GenericType.HealthRegeneration
	remove_modifier.execute(entity)