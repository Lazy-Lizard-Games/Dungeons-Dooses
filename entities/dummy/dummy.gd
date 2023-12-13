extends Entity

@export var health: HealthComponent
@export var hitbox: HitboxComponent
@export var hurtbox: HurtboxComponent


func _ready():
	hitbox.faction = faction
	hurtbox.faction = faction


func _on_hitbox_component_hit_by_damage(damage: DamageData, source: HurtboxComponent):
	source.entity_damaged.emit(damage, self)
	health.damage(damage, source)
