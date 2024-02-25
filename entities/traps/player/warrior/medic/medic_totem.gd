extends Trap
class_name MedicTotem

## Medic totem deployed by the warrior using one of their abilities.

## Duration of the totem before it decays.
@export var duration: Number


func _ready():
	super()
	get_tree().create_timer(duration.execute()).timeout.connect(on_timeout)


func on_timeout():
	ProjectileHandler.remove_trap(self)
