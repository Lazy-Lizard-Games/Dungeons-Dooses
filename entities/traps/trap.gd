extends Entity
class_name Trap

## Traps are entities that generally stand still and spawn projectiles when triggered.

@export var trigger: TriggerComponent
@export var cast_projectile: CastProjecitleAction


func _ready():
	super()
	trigger.triggered.connect(
		func():
			cast_projectile.execute(self)
	)
