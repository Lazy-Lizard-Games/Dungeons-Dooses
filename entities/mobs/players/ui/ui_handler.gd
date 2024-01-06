extends CanvasLayer

@export var hud: HudComponent
@export var menu: MenuComponent


func toggle() -> void:
	if hud.visible:
		hud.hide()
		menu.show()
	else:
		hud.show()
		menu.hide()
