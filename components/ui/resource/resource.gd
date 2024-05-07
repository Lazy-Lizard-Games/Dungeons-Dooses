extends MarginContainer
class_name ResourceContainer

@export var color_rect: ColorRect
@export var label: Label
@export var progress_bar: ProgressBar

var effect: Effect

func _ready() -> void:
	label.text = "x" + String.num_int64(effect.stacks)
	effect.stacks_changed.connect(on_stacks_changed)
	effect.expired.connect(on_expired)
	progress_bar.max_value = effect.duration_time

func _process(_delta: float) -> void:
	if effect != null:
		progress_bar.value = effect.duration_timer

func on_expired() -> void:
	queue_free()

func on_stacks_changed(_old: int, current: int) -> void:
	label.text = ''
	if current > 0:
		label.text = "x" + String.num_int64(current)
