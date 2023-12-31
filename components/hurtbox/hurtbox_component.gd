extends Area2D
class_name HurtboxComponent

signal entity_damaged(hitbox: HitboxComponent, damage_datas: Array[DamageData])

## Faction that the hurtbox belongs
@export var faction: Globals.FACTIONS = 0
## Damage datas of the hurtbox
@export var damage_datas: Array[DamageData]
## Effect instances of the hurtbox
@export var effect_instances: Array[EffectInstance]
## Number of damage instances per second per entity
@export var damage_rate: float = 0

var hurt_entities: Array[TimedVariant] = []

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		if not area.can_accept_collisions():
			return
		if hurt_entities.filter(func(entity: TimedVariant): return entity.variant == area).is_empty() \
				and area.faction not in Relationships.get_allies_for(faction):
			area.handle_hurbox_collision(self)
			var hurt_entity = TimedVariant.new()
			add_child(hurt_entity)
			hurt_entity.start(area, 1/damage_rate)
			hurt_entity.timeout.connect(remove_entity)
			hurt_entities.append(hurt_entity)
			entity_damaged.emit(area, damage_datas)

func remove_entity(hurt_entity: TimedVariant) -> void:
	remove_child(hurt_entity)
	hurt_entities.remove_at(hurt_entities.find(hurt_entity))
	if hurt_entity.variant in get_overlapping_areas():
		_on_area_entered(hurt_entity.variant)
