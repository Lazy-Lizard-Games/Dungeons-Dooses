class_name AbilitySetData
extends Resource

## Contains information for a set of abilities, such as:
##   - Title
##   - Description
##   - Theme
##   - Abilities

@export var title: String
@export_multiline var description: String
@export var theme: Color
@export var abilities: Array[AbilityData]
