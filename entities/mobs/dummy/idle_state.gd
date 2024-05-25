extends State

@export var dummy: Dummy
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	animation_player.play('idle')

func _on_hitbox_component_impacted(_data: ImpactData, from: HurtboxComponent, _immunity: bool):
	sprite.flip_h = dummy.global_position.direction_to(from.global_position).x > 0
	animation_player.play('hit')
	animation_player.animation_finished.connect(_on_animation_player_animation_finished, CONNECT_ONE_SHOT)
