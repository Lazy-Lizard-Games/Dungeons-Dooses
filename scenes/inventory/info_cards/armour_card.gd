extends PanelContainer

@onready var lbl_name: Label = $MarginContainer/VBoxContainer/Name
@onready var lbl_description: Label = $MarginContainer/VBoxContainer/Description
@onready var lbl_defence: Label = $MarginContainer/VBoxContainer/Defence

func set_info(item: ArmourData) -> void:
	lbl_name.text = item.name
	lbl_description.text = item.description
	lbl_defence.text = "Armour: %s" % item.defence

func clear_info() -> void:
	lbl_name.text = ""
	lbl_description.text = ""
