extends Resource
class_name Ability

signal casted
signal recharged
signal finished

## Name of the ability.
@export var name: String
## Description of the ability.
@export_multiline var description: String
## Icon of the ability
@export var icon: Image
## Animtion to play for the ability.
@export var animation: String
## Minimum stamina required to start this ability.
@export var reactive_energy: Number
## Cast time in seconds of the ability.
@export var cast_time: Number
## Recharge time in seconds of the ability.
@export var recharge_time: Number 
## Actions to execute on the caster when the ability is started.
@export var actions_on_start: Array[EntityAction]
## Actions to execute on the caster when the ability is ended.
@export var actions_on_end: Array[EntityAction]

var is_recharging := false
var is_casting := false
var caster: Entity
var facing: Vector2
var recharge_timer: Timer
var cast_timer: Timer


## Checks whether the entity can start this ability.
func can_start(entity: Entity) -> bool:
	if 'stamina_component' in entity:
		if entity.stamina_component.current < reactive_energy.execute():
			return false
	if is_recharging:
		return false
	return true


## Starts the ability with the entity as the caster.
func start(entity: Entity) -> void:
	if !can_start(entity):
		return
	caster = entity
	for action in actions_on_start:
		action.execute(caster)
	entity.looking_at = entity.global_position.direction_to(entity.get_global_mouse_position())
	start_cast(entity)


func end(entity: Entity) -> void:
	if !caster:
		return
	for action in actions_on_end:
		action.execute(caster)
	caster = null


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
	end(entity)
	start_recharge(entity)


func release(_entity: Entity) -> void:
	pass

