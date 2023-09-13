extends Resource
class_name Skill

@export var name: String
@export_multiline var description: String
@export var max_stacks: int = 5
@export var effect_instances: Array[EffectInstance]
@export var color: Color = Color.ALICE_BLUE
var stacks = 0

func get_effect_description(stacks: int) -> String:
	var desc = ""
	for effect_instance in effect_instances:
		desc += effect_instance.get_description(stacks)
		desc += "\n"
	return desc
