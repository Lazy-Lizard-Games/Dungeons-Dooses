extends ItemData
class_name EquipmentData

## Attribute modifiers
@export var modifiers: Array[AttributeModifier]
## Effect datas
@export var effects: Array[EffectData]


func equip(effect_component: EffectComponent, attribute_component: AttributeComponent) -> void:
	for effect_data in effects:
		var effect = effect_data.effect.instantiate()
		effect_component.add_effect(effect)
	for modifier in modifiers:
		var attribute = attribute_component.get_attribute_by_type(modifier.type)
		if attribute:
			attribute.add_attribute_bonus(modifier.bonus)


func unequip(effect_component: EffectComponent, attribute_component: AttributeComponent) -> void:
	for effect_data in effects:
		var effect = effect_data.effect.instantiate()
		effect_component.remove_effect(effect)
	for modifier in modifiers:
		var attribute = attribute_component.get_attribute_by_type(modifier.type)
		if attribute:
			attribute.remove_attribute_bonus(modifier.bonus)
