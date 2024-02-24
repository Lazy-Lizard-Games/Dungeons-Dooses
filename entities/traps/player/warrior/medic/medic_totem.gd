extends Trap
class_name MedicTotem

## Medic totem deployed by the warrior using one of their abilities.


func _ready():
	super()
	get_tree().create_timer(10).timeout.connect(on_timeout)


func on_timeout():
	queue_free()
