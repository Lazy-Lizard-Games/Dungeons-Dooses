extends MarginContainer
class_name EffectContainer

@onready var effect_icon: TextureRect = $EffectIcon
@onready var stacks_label: Label = $StacksLabel

var effect: Effect

func _ready() -> void:
	if effect:
		#effect_icon = effect.effect_instance.icon
		update_effect(0)
		effect.stack_changed.connect(update_effect)
		effect.tree_exited.connect(queue_free)

func update_effect(change: int) -> void:
	stacks_label.text = ""
	if effect.stacks > 1:
		stacks_label.text = "x%s" % str(effect.stacks)
