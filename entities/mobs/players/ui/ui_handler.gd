extends CanvasLayer

@export var hud: Hud
@export var menu: Menu


func toggle(entity: Entity) -> void:
	if hud.visible:
		hud.hide()
		menu.show()
	else:
		hud.show()
		menu.hide()
		if entity and menu.inventory_menu.grabbed_slot.item:
			var drop_item = DropItemAction.new()
			drop_item.amount = menu.grabbed_slot.stack
			drop_item.execute(entity, menu.grabbed_slot.item)
			menu.grabbed_slot.set_slot(null, 0)
