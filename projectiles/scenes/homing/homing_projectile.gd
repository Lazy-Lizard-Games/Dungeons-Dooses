extends TravellingProjectile
class_name HomingProjectile

@export var target_component: TargetComponent
@export var target_shape: CollisionShape2D
var homing_strength: float = 0.5
var current_target: Entity


func _ready():
	super()
	target_component.entity = entity
	target_component.current_target = null


func set_variables(projectile_object: BaseProjectileObject) -> void:
	super(projectile_object)
	projectile_object = projectile_object as HomingProjectileObject
	homing_strength = projectile_object.homing_strength
	target_shape.shape = projectile_object.target_shape


func _physics_process(_delta):
	if current_target:
		_direction = _direction.lerp(global_position.direction_to(current_target.global_position), homing_strength)#.normalized()
	velocity_component.accelerate_in_direction(_direction)
	velocity_component.move(self)


func _on_target_component_target_updated(target: Entity):
	current_target = target
