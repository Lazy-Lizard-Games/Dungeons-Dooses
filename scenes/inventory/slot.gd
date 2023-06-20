extends PanelContainer

signal slot_clicked(index: int, button: int)

@onready var quantity_label = $MarginContainer/QuantityLabel
@onready var texture = $MarginContainer/TextureRect

func set_slot_data(slot_data: SlotData) -> void:
	var item_data = slot_data.item_data
	texture.texture = item_data.texture
	quantity_label.hide()
	if slot_data.quantity > 1:
		quantity_label.text = "x%s" % slot_data.quantity
		quantity_label.show()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
