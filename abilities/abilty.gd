extends Node
class_name Ability

signal expired

var started := false
var weapon: WeaponComponent
var direction: Vector2


## Initialises required data before activating the ability. 
func init(_weapon: WeaponComponent, _direction: Vector2) -> void:
	weapon = _weapon
	direction = _direction


func expire() -> void:
	expired.emit()


## Signals that the ability should start doing things.
func start() -> void:
	pass


## Signals that the ability should release the charging ability or stop.
func release() -> void:
	pass


## Signals the end of the ability and that it should probably go home.
func cancel() -> void:
	pass
