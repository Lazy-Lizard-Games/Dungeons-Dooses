extends CanvasLayer

@export var player: Player
@export var hud: HUD
@export var menu: PlayerMenu

func _unhandled_input(event):
	if Input.is_action_just_pressed("inventory"):
		update_ui()

func update_ui() -> void:
	match hud.visible:
		true:
			player.set_process_input(false)
			hud.visible = false
			menu.visible = true
		false:
			player.set_process_input(true)
			hud.visible = true
			menu.visible = false
