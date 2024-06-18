class_name AbilityData
extends Resource

## Stores the ability's details and current state.

## Toggles whether the player has access to the ability or not.
@export var locked: bool
## The name for the ability to show in UI.
@export var name: String
## The description for the ability to show in UI.
@export_multiline var description: String
## The icon for the ability to show in UI.
@export var icon: Texture2D
## The ability scene to add to the character if selected.
@export var ability: PackedScene

# TODO: ability upgrades