class_name EffectComponent
extends Node

## Manages effects.

func get_effect(uid: StringName) -> Effect:
  for child in get_children() as Array[Effect]:
    if child.uid == uid:
      return child
  return null

func add_effect(effect: Effect) -> void:
  var existing_effect = get_effect(effect.uid)
  if existing_effect:
    existing_effect.add_stack()
  else:
    effect.expired.connect(on_effect_expired.bind(effect))
    add_child(effect)

func remove_effect(uid: StringName) -> void:
  for child in get_children() as Array[Effect]:
    if child.uid == uid:
      child.queue_free()
    
func clear_effects() -> void:
  for child in get_children() as Array[Effect]:
    child.queue_free()

func on_effect_expired(effect: Effect) -> void:
  effect.queue_free()