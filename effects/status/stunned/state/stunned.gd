extends State

@export var entity: Entity
@export var velocity_component: VelocityComponent

func process_physics(_delta: float) -> State:
	velocity_component.accelerate_in_direction(Vector2.ZERO)
	velocity_component.move(entity)
	return null