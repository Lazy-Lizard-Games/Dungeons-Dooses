extends Resource
class_name KnockbackData

## Certain attacsk could also knock entitites around, that is where
## this guy comes in, keeping track of data for throwing people around.

## Direction of knockback.
@export
var direction := Vector2.ZERO
## Magnitude of knockback.
@export
var force := 0
