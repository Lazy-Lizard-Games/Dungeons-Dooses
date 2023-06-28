extends PanelContainer

signal slot_clicked(index: int, button: int, type: Globals.ITEM_TYPES, armour_type: Globals.ARMOUR_TYPES)
signal slot_focused(index: int)
signal slot_unfocused(index: int)

@onready var quantity_label = $MarginContainer/QuantityLabel
@onready var texture = $MarginContainer/TextureRect

var item_data = null
@export var type_restriction: Globals.ITEM_TYPES
@export var armour_type_restriciton: Globals.ARMOUR_TYPES

func set_slot_data(slot_data: SlotData) -> void:
	item_data = slot_data.item_data
	texture.texture = item_data.texture
	quantity_label.hide()
	if slot_data.quantity > 1:
		quantity_label.text = "x%s" % slot_data.quantity
		quantity_label.show()

func clear_slot_data() -> void:
	item_data = null
	texture.texture = null
	quantity_label.hide()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index, type_restriction, armour_type_restriciton)

func _on_texture_rect_mouse_entered() -> void:
	slot_focused.emit(get_index())

func _on_texture_rect_mouse_exited() -> void:
	slot_unfocused.emit(get_index())
