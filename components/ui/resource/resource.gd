extends MarginContainer
class_name ResourceContainer

@export var color_rect: ColorRect
@export var label: Label
@export var progress_bar: ProgressBar

var resource: StackingResource


func _ready() -> void:
	resource.stack_changed.connect(
		func():
			label.text = "x" + String.num_int64(resource.stacks)
	)
	resource.ended.connect(
		func():
			queue_free()
	)
	progress_bar.max_value = resource.decay_interval


func _process(_delta: float) -> void:
	if resource.decay_timer:
		progress_bar.value = resource.decay_interval - resource.decay_timer.time_left
