extends TravellingProjectileObject
class_name HomingProjectileObject

## Shape of the targetting area.
@export var target_shape: Shape2D
## Strength of the homing.
@export_range(0, 1) var homing_strength: float
