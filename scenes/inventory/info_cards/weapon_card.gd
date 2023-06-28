extends PanelContainer

@onready var lbl_name: Label = $MarginContainer/VBoxContainer/Name
@onready var lbl_description: Label = $MarginContainer/VBoxContainer/Description

func set_info(item: ItemData) -> void:
	lbl_name.text = item.name
	lbl_description.text = item.description

func clear_info() -> void:
	lbl_name.text = ""
	lbl_description.text = ""
