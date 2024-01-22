extends Ability
class_name CastedAbility

## Actions to execute on the caster when the ability is cast.
@export var actions_on_cast: Array[EntityAction]


func cast(entity: Entity) -> void:
	entity.remove_child(cast_timer)
	is_casting = false
	casted.emit()
	for action in actions_on_cast:
		action.execute(caster)
	start_recharge(entity)

