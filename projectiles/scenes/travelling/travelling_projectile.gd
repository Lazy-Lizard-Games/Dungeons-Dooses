extends BaseProjectile
class_name TravellingProjectile

@export var speed: Attribute
@export var direction: VectorAction
@export var velocity_component: VelocityComponent

var _direction: Vector2


func _ready():
	super()
	_direction = direction.get_vector(entity)
	velocity_component.speed = speed


func set_variables(projectile_object: BaseProjectileObject) -> void:
	super(projectile_object)
	projectile_object = projectile_object as TravellingProjectileObject
	speed = projectile_object.speed
	direction = projectile_object.direction


func _physics_process(_delta):
	velocity_component.accelerate_in_direction(_direction)
	velocity_component.move(self)
