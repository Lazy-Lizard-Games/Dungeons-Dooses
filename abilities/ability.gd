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
## Recharge time in seconds of the ability.
@export var recharge_time: float 
## Cast time in seconds of the ability.
@export var cast_time: float

var is_recharging := false
var entity: Entity
var direction: Vector2

## Starts the ability with the entity as the caster.
func cast(_entity: Entity, _direction := Vector2.ZERO) -> void:
	if is_recharging:
		return
	entity = _entity
	direction = _direction
	if cast_time > 0:
		entity.get_tree().create_timer(cast_time).timeout.connect(
			func():
				casted.emit()
				on_cast_timout()
		)
	else:
		casted.emit()
		on_cast_timout()


func on_cast_timout() -> void:
	is_recharging = true
	var recharge_timer = Timer.new()
	recharge_timer.timeout.connect(
		func():
			entity.remove_child(recharge_timer)
			is_recharging = false
			recharged.emit()
	)
	entity.add_child(recharge_timer)
	recharge_timer.start(recharge_time)
