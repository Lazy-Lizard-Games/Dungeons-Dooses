extends Projectile

## Projectile for the slash ability of the warrior

@export var animation: AnimationPlayer

func _ready():
	look_at(direction)
	animation.play('trail')
	animation.animation_finished.connect(on_finished, CONNECT_ONE_SHOT)

func on_finished(_anim_name: StringName) -> void:
	ProjectileHandler.remove_projectile(self)
