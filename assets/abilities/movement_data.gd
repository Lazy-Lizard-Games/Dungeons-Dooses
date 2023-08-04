extends Resource
class_name MovementData

@export_enum("Instant") var move_type
@export var angle: int
@export var force: int

func get_force() -> int:
	return force
