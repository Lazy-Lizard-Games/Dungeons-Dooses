extends CanvasLayer

@export var hud: HudComponent
@export var menu: MenuComponent


func toggle(entity: Entity) -> void:
	if hud.visible:
		hud.hide()
		menu.show()
	else:
		hud.show()
		menu.hide()
		if entity and menu.grabbed_slot.item:
			var drop_item = DropItemAction.new()
			drop_item.amount = menu.grabbed_slot.stack
			drop_item.execute(entity, menu.grabbed_slot.item)
			menu.grabbed_slot.set_slot(null, 0)
