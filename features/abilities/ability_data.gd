class_name AbilityData
extends Resource

## Holds information for an ability.

@export var type: Enums.AbilityType
@export var name: String
@export_multiline var description: String
@export var icon: Texture2D
## The scene of the ability.
@export var scene: PackedScene