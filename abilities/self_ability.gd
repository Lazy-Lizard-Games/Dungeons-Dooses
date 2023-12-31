extends Ability
class_name SelfAbility

## Actions to execute on the entity when the cast timer starts.
@export var actions_on_rise: Array[EntityAction]
## Actions to execute on the entity when the cast timer ends.
@export var actions_on_fall: Array[EntityAction]


func cast(entity: Entity, direction := Vector2.ZERO) -> void:
	super(entity, direction)
	for action in actions_on_rise:
		action.execute(entity)
	casted.connect(
		func():
			for action in actions_on_fall:
				action.execute(entity)
	)
