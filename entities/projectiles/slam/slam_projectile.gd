extends Projectile

@export var animation: AnimationPlayer
@export var sprite: Sprite2D

func _ready():
	sprite.flip_h = direction.x < 0
	animation.play('trail')
	animation.animation_finished.connect(on_finished, CONNECT_ONE_SHOT)

func on_finished(_anim_name: StringName) -> void:
	ProjectileHandler.remove_projectile(self)
