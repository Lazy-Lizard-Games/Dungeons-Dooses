extends Resource
class_name SkillTree

## Holds all skills for this skill tree.

## TODO: Implement color dispersion from the provided color -> primary, secondary, accent, etc.

## Name of the skill tree.
@export var name: String
## Color of the skill tree.
@export var color: Color
## Skills in skill tree.
@export var skills: Array[Skill]
