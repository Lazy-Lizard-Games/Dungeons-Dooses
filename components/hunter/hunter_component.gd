class_name HunterComponent
extends Area2D

## The hunter component is used to detect nearby hitboxes which may then be used as a target.

## The faction controls who this hunter can target.
@export var faction: Enums.FactionType
## The list of targets that the hunter is currently detecting.
var targets: Array[TargetComponent]
var is_hunting: bool:
	get:
		return targets.size() > 0


func _on_area_entered(area:Area2D) -> void:
	if area is TargetComponent:
		if area.faction != faction or area.faction == Enums.FactionType.None or faction == Enums.FactionType.None:
			targets.append(area)

func _on_area_exited(area:Area2D) -> void:
	if area is TargetComponent:
		if area in targets:
			targets.erase(area)
