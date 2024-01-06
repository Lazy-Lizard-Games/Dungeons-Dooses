extends Resource
class_name Ability

signal casted
signal recharged

## Name of the ability.
@export var name: String
## Description of the ability.
@export_multiline var description: String
## Icon of the ability
@export var icon: Image
## Cost in stamina of the ability.
@export var cost: float
## Cast time in seconds of the ability.
@export var cast_time: float
## Recharge time in seconds of the ability.
@export var recharge_time: float 
## Actions to execute on the caster when the ability is started.
@export var actions_on_start: Array[EntityAction]
## Actions to execute on the caster when the ability is cast.
@export var actions_on_cast: Array[EntityAction]

var is_recharging := false
var caster: Entity
var facing: Vector2


## Starts the ability with the entity as the caster.
func start(entity: Entity) -> void:
	if is_recharging:
		return
	caster = entity
	for action in actions_on_start:
		action.execute(caster)
	if cast_time > 0:
		caster.get_tree().create_timer(cast_time).timeout.connect(
			func():
				cast()
		)
	else:
		cast()


func cast() -> void:
	casted.emit()
	for action in actions_on_cast:
		action.execute(caster)
	recharge()



func recharge() -> void:
	if recharge_time <= 0:
		recharged.emit()
		return
	is_recharging = true
	var recharge_timer = Timer.new()
	recharge_timer.timeout.connect(
		func():
			caster.remove_child(recharge_timer)
			is_recharging = false
			recharged.emit()
	)
	caster.add_child(recharge_timer)
	recharge_timer.start(recharge_time)
