extends PanelContainer

@onready var lbl_name: Label = $MarginContainer/VBoxContainer/Name
@onready var lbl_description: Label = $MarginContainer/VBoxContainer/Description

func set_info(_name: String, _description: String) -> void:
	lbl_name.text = _name
	lbl_description.text = _description

func clear_info() -> void:
	lbl_name.text = ""
	lbl_description.text = ""
