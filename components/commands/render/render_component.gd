extends AnimatedSprite2D
class_name RenderComponent


func update_animation(animation_name: String) -> void:
	if animation_name in sprite_frames.get_animation_names():
		set_animation(animation_name)
