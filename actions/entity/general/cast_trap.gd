extends EntityAction
class_name CastTrapEntityAction

@export var trap_scene: PackedScene
@export var position: Vector = ConstantVector.new()


func execute(entity: Entity, _scale := 1.0) -> void:
	var trap = trap_scene.instantiate() as Trap
	trap.position = position.get_vector(entity)
	ProjectileHandler.add_trap(trap)
