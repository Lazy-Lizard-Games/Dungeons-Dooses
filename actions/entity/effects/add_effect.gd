class_name AddEffect
extends EntityAction

## Adds an effect to an entity.

## Packed scene of the effect to add.
@export var effect_scene: PackedScene

func execute(entity: Entity, _scale:=1.0) -> void:
  var effect = effect_scene.instantiate() as Effect
  effect.init(entity)
  entity.effect_component.add_effect(effect)
