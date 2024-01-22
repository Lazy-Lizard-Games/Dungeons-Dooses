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
@export var cost: Number
## Cast time in seconds of the ability.
@export var cast_time: Number
## Recharge time in seconds of the ability.
@export var recharge_time: Number 
## Actions to execute on the caster when the ability is started.
@export var actions_on_start: Array[EntityAction]

var is_recharging := false
var is_casting := false
var caster: Entity
var facing: Vector2
var recharge_timer: Timer
var cast_timer: Timer


## Starts the ability with the entity as the caster.
func start(entity: Entity) -> void:
	if is_recharging:
		return
	caster = entity
	for action in actions_on_start:
		action.execute(caster)
	start_cast(entity)


func start_cast(entity: Entity) -> void:
	var _cast_time = cast_time.execute()
	if _cast_time > 0:
		is_casting = true
		cast_timer = Timer.new()
		cast_timer.timeout.connect(cast.bind(entity))
		entity.add_child(cast_timer)
		cast_timer.start(_cast_time * entity.generics.cast_time.get_final_value())
	else:
		cast(entity)


func cast(entity: Entity) -> void:
	entity.remove_child(cast_timer)
	is_casting = false
	casted.emit()
	start_recharge(entity)


func start_recharge(entity: Entity) -> void:
	var _recharge_time = recharge_time.execute()
	if _recharge_time > 0:
		is_recharging = true
		recharge_timer = Timer.new()
		recharge_timer.timeout.connect(recharge.bind(entity))
		entity.add_child(recharge_timer)
		recharge_timer.start(_recharge_time * entity.generics.recharge_time.get_final_value())
	else:
		recharge(entity)


func recharge(entity: Entity) -> void:
	entity.remove_child(recharge_timer)
	is_recharging = false
	recharged.emit()


func cancel(entity: Entity) -> void:
	if is_casting:
		entity.remove_child(cast_timer)
		is_casting = false
		casted.emit()
	start_recharge(entity)


func release(_entity: Entity) -> void:
	pass

