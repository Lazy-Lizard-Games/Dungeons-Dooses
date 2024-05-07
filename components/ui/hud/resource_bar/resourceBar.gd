extends PanelContainer
class_name ResourceBar

## Renders a player resource against a maximum as a progress bar.

@export var background: StyleBox
@export var fill: StyleBox

@onready var progress_bar = $ProgressBar


func _ready():
	if background:
		progress_bar.add_theme_stylebox_override('background', background)
	if fill:
		progress_bar.add_theme_stylebox_override('fill', fill)
