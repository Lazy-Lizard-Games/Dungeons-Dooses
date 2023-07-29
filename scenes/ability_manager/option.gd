extends PanelContainer

@onready var option_name: Label = $MarginContainer/OptionName

func set_title(title: String) -> void:
	option_name.text = title
