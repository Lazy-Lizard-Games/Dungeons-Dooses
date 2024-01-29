extends Ability
class_name ChargedAbility

## Allows the ability to be released early, unleashing a lesser effect.

## Charge levels on release.
@export var charge_levels: Array[ChargeLevel]

var current_charge: float:
	get:
		if cast_timer.is_stopped():
			if is_casting:
				return 1.0
			return 0.0
		return (1 - cast_timer.time_left/cast_timer.wait_time)


## Returns the highest charge level that is satisfied by the charge. 
func get_charge_level(charge: float) -> ChargeLevel:
	for charge_level in charge_levels:
		if charge >= charge_level.minimum_charge:
			return charge_level
	return null


func start_cast(entity: Entity) -> void:
	var _cast_time = cast_time.execute()
	if _cast_time > 0:
		is_casting = true
		cast_timer = Timer.new()
		entity.add_child(cast_timer)
		cast_timer.one_shot = true
		cast_timer.start(_cast_time * entity.generics.cast_time.get_final_value())
	else:
		cast(entity)


func cast(entity: Entity) -> void:
	var charge_level = get_charge_level(current_charge)
	entity.remove_child(cast_timer)
	is_casting = false
	casted.emit()
	if charge_level:
		var exhaust = ExhaustEntityAction.new()
		exhaust.amount = charge_level.cost
		exhaust.execute(entity, entity.generics.cast_cost.get_final_value())
		for action in charge_level.actions_on_cast:
			action.execute(caster)
	start_recharge(entity)


func release(entity: Entity) -> void:
	if is_casting:
		cast(entity)
