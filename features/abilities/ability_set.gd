class_name AbilitySet
extends Resource

## Stores abilities available for the player character.

## The set of primary abilities available to the character.
@export var primary: Array[AbilityData]
## The set of secondary abilities available to the character.
@export var secondary: Array[AbilityData]
## The set of support abilities available to the character.
@export var support: Array[AbilityData]
## The set of passive abilities available to the character.
@export var passive: Array[AbilityData]