extends Area2D
class_name HurtboxComponent

signal entity_hit(entity: Node2D)

## Faction that the hurtbox belongs
@export var faction: Globals.FACTIONS = 0
## Damage data of the hurtbox
@export var damage_data: DamageData
## Number of damage instances per second per entity
@export var damage_rate: float = 0

var hurt_entities: Array[HurtEntity] = []

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		if hurt_entities.filter(func(entity: HurtEntity): return entity.area == area).is_empty() \
				and (area.faction != faction or area.faction == Globals.FACTIONS.NONE):
			area.handle_hurbox_collision(self)
			var hurt_entity = HurtEntity.new()
			hurt_entity.set_data(area, damage_rate)
			hurt_entity.connect("timeout", remove_entity)
			hurt_entities.append(hurt_entity)
			entity_hit.emit(area)

func remove_entity(hurt_entity: HurtEntity) -> void:
	hurt_entities.remove_at(hurt_entities.find(hurt_entity))
	if hurt_entity.area in get_overlapping_areas():
		_on_area_entered(hurt_entity.area)
