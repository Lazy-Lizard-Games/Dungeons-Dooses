extends Panel
class_name SlotContainer

signal clicked(slot: Slot, index: int, button: MouseButton)

@onready var texture: TextureRect = $TextureRect
@onready var label: Label = $Label

var index: int
var slot: Slot:
	set(s):
		slot = s
		if label:
			update_slot()


func _ready() -> void:
	update_slot()
	if slot:
		slot.updated.connect(update_slot)


func update_slot() -> void:
	label.text = ""
	texture.texture = null
	if slot:
		label.text = "x" + String.num_int64(slot.stack)
		if slot.item and slot.item.icon:
			texture.texture = ImageTexture.create_from_image(slot.item.icon)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			clicked.emit(slot, index, event.button_index)
