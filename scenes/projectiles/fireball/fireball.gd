extends Projectile

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var state_manager: StateManager


func _ready() -> void:
	state_manager = StateManager.new()
	state_manager.add_state(normal)
	state_manager.add_state(death)
	state_manager.set_initial_state(normal)
	rotate(Vector2.RIGHT.angle_to(direction))
	animation_player.play("normal")

func _physics_process(delta: float) -> void:
	state_manager.update()

func normal() -> void:
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)

func death() -> void:
	pass

func set_death() -> void:
	state_manager.change_state(death)
	animation_player.play("death")
	await  animation_player.animation_finished
	queue_free()

func _on_timer_timeout() -> void:
	set_death()

func _on_entity_damaged(hitbox, damage_datas) -> void:
	parent.entity_damaged.emit(hitbox, damage_datas)
	set_death()
