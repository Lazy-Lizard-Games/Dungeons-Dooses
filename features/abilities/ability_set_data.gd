class_name AbilitySetData
extends Resource

## Contains information for a set of abilities, such as:
##   - Title
##   - Description
##   - Theme
##   - Abilities

@export var group: Enums.AbilityGroup
@export var name: String
@export_multiline var description: String
@export var theme: Color
