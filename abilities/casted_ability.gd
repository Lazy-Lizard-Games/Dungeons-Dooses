extends Ability
class_name CastedAbility

## Cost in stamina of the ability.
@export var cost: Number
## Actions to execute on the caster when the ability is cast.
@export var actions_on_cast: Array[EntityAction]

func cast(entity: Entity) -> void:
	var exhaust = ExhaustEntityAction.new()
	exhaust.amount = cost
	exhaust.execute(entity, entity.generics.cast_cost.get_final_value())
	if cast_timer in entity.get_children():
		entity.remove_child(cast_timer)
	is_casting = false
	casted.emit()
	for action in actions_on_cast:
		action.execute(caster)
	start_recharge(entity)
