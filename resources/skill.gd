extends Resource
class_name Skill

@export var name: String
@export var description: String
@export var max_stacks: int
@export var effect: Effect
@export var color: Color = Color.ALICE_BLUE

var stacks = 0
