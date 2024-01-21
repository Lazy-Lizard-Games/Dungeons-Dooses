extends BaseProjectile
class_name TravellingProjectile

@export var speed: Number
@export var velocity_component: VelocityComponent


func _ready():
	super()
	velocity_component.speed.raw_value = speed.execute()


func set_variables(projectile_object: BaseProjectileObject) -> void:
	super(projectile_object)
	projectile_object = projectile_object as TravellingProjectileObject
	speed = projectile_object.speed


func _physics_process(_delta):
	velocity_component.accelerate_in_direction(_direction)
	velocity_component.move(self)
