extends TravellingProjectile
class_name HomingProjectile

@export var target_component: TargetComponent
var homing_strength: float = 0.5
var current_target: Entity


func set_variables(projectile_object: BaseProjectileObject) -> void:
	super(projectile_object)
	projectile_object = projectile_object as HomingProjectileObject
	homing_strength = projectile_object.homing_strength
	target_component.shape = projectile_object.target_shape


func _physics_process(_delta):
	current_target = target_component.get_target(entity)
	if current_target:
		_direction = _direction.slerp(global_position.direction_to(current_target.global_position), homing_strength)
		look_at(global_position + _direction)
	velocity_component.accelerate_in_direction(_direction)
	velocity_component.move(self)
