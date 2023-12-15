extends Node
class_name Attribute

@export var type: Enums.AttributeType
@export var group: Enums.AttributeGroup
@export_multiline var description: String
@export var raw_value: float = 0
@export var multiplier_value: float = 1
@export var attribute_bonuses: Array[AttributeBonus]

## Returns the final attribute value after modifiers are applied.
func get_final_value() -> float:
	var temp_raw = raw_value
	var temp_multiplier = multiplier_value
	for attribute_bonus in attribute_bonuses:
		match attribute_bonus.bonus_type:
			Enums.AttributeBonusType.Raw:
				temp_raw += attribute_bonus.bonus
			Enums.AttributeBonusType.Multiplier:
				temp_multiplier *= attribute_bonus.bonus
			_:
				break
	return temp_raw * temp_multiplier

## Adds a bonus to the attribute
func add_attribute_bonus(attribute_bonus: AttributeBonus) -> void:
	attribute_bonuses.append(attribute_bonus)

## Removes a bonus to the attribute
func remove_attribute_bonus(attribute_bonus: AttributeBonus) -> void:
	var index = attribute_bonuses.find(attribute_bonus)
	if index >= 0:
		attribute_bonuses.remove_at(index)
