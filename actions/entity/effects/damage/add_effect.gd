class_name AddDamageEffect
extends EntityAction

## Adds a damage effect to the entity.

## Packed scene of the damage effect to add.
@export var effect_scene: PackedScene

func execute(entity: Entity, _scale:=1.0) -> void:
	var effect = effect_scene.instantiate() as DamageEffect
	effect.init(entity)
	entity.effect_component.add_damage_effect(effect)