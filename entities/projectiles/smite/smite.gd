extends Projectile

## Projectile for the smite ability of the warrior

## The animation player for the projectile.
@export var animation: AnimationPlayer

func _ready():
	animation.play('trail')
	animation.animation_finished.connect(on_finished, CONNECT_ONE_SHOT)

func on_finished(_anim_name: StringName) -> void:
	ProjectileHandler.remove_projectile(self)