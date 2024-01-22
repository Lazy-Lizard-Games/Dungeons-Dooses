extends Resource
class_name SkillTree

## Holds all skills for this skill tree.

## TODO: Implement color dispersion from the provided color -> primary, secondary, accent, etc.

## Name of the skill tree.
@export var name: String
## Color of the skill tree.
@export var color: Color
## Skills in row A.
@export var row_a: SkillRow
## Skills in row B.
@export var row_b: SkillRow
## Skills in row C.
@export var row_c: SkillRow
## Skills in row D.
@export var row_d: SkillRow
## Skills in row e.
@export var row_e: SkillRow
