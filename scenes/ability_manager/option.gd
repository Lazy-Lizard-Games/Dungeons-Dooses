extends PanelContainer

signal slot_clicked(index: int)

@onready var option_name: Label = $MarginContainer/OptionName

var option = null

func set_option(object) -> void:
	option = object
	visible = false
	if option:
		visible = true
		option_name.text = option.name

func get_abilities() -> Array[AbilityData]:
	if option:
		return option.get_abilities()
	else:
		return [null, null, null]

func get_type() -> Globals.WEAPON_TYPES:
	return option.get_type()

func can_edit(index: int) -> bool:
	if option:
		return true
	else:
		return false


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT) \
			and event.is_pressed():
		slot_clicked.emit(get_index())
