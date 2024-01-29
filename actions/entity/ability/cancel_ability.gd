extends EntityAction
class_name CancelAbilityEntityAction

## Cancels an ability for the entity.

## Ability to cancel.
@export var ability: Ability


func execute(entity: Entity, _scale := 1.0) -> void:
	ability.cancel(entity)
