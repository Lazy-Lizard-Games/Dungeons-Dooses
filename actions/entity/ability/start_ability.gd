extends EntityAction
class_name StartAbilityEntityAction

## Starts an ability for the entity.

## Ability to start.
@export var ability: Ability


func execute(entity: Entity, _scale := 1.0) -> void:
	ability.start(entity)
