extends CanvasLayer

@export var entity: Entity
@export var hud: Hud
@export var menu: Menu


func toggle() -> void:
	if hud.visible:
		entity.get_tree().paused = true
		hud.hide()
		menu.show()
	else:
		entity.get_tree().paused = false
		hud.show()
		menu.hide()
		if entity and menu.inventory_menu.grabbed_slot.item:
			var drop_item = DropItemAction.new()
			drop_item.amount = menu.grabbed_slot.stack
			drop_item.execute(entity, menu.grabbed_slot.item)
			menu.grabbed_slot.set_slot(null, 0)


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()