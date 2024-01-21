extends BaseProjectile
class_name TravellingProjectile

## Travelling projectiles are projectile that have a velocity.

## Velocity component used to move the projectile.
@export var velocity_component: VelocityComponent
## Speed of the travelling projectile.
var speed: Number


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
