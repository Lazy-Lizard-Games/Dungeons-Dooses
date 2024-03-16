extends Effect

## Increases physical damage taken for a short duration.

## Controls the increase to damage taken as a percentage, i.e: 0.1 -> 10% increase. 
## Negative values reduce damage taken, i.e: -0.5 -> 50% decrease.
@export var strength: float

func enter() -> void:
  var modifier = AttributeModifier.new()
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