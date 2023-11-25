extends Resource
class_name AbilityData

## Holds the ability scene and other information realted to the ability, like name, duration, cooldown, etc.

## The name of the ability.
@export
var id := ""

## Ability cooldown after it expires.
@export
var cooldown := 0.0

## The packed ability scene.
@export
var ability : PackedScene
