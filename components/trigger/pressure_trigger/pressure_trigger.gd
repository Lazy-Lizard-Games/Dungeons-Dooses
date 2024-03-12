extends TriggerComponent
class_name PressureTriggerComponent


func _on_area_entered(area):
	if area is HitboxComponent:
		triggered.emit()
