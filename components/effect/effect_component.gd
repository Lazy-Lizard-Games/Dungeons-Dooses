extends Node2D
class_name EffectComponent

signal health_changed(prev_health: float, cur_health: float, damage: DamageData)
signal entity_damaged(entity: Node2D, damage, DamageData)
signal hit_by_hurtbox(hurtbox: HurtboxComponent, damage: float)

@export_category("Components")
@export var stats_component: StatsComponent
@export var health_component: HealthComponent
@export var projectile_component: ProjectileComponent
@export var hitbox_component: HitboxComponent
@export var hurtbox_component: HurtboxComponent

var effects: Array[Effect]

func _ready() -> void:
	if health_component:
		health_component.health_changed.connect(_on_health_changed)
	if projectile_component:
		projectile_component.entity_damaged.connect(_on_entity_damaged)
	if hurtbox_component:
		hurtbox_component.entity_damaged.connect(_on_entity_damaged)
	if hitbox_component:
		hitbox_component.hit_by_hurtbox.connect(_on_hit_by_hurtbox)

func _on_health_changed(prev_health: float, cur_health: float, damage: DamageData) -> void:
	health_changed.emit(prev_health, cur_health, damage)

func _on_hit_by_hurtbox(hurtbox: HurtboxComponent, damage: float) -> void:
	hit_by_hurtbox.emit(hurtbox, damage)

func _on_entity_damaged(entity: Node2D, damage, DamageData) -> void:
	entity_damaged.emit(entity, damage)

func add_effect(effect_instance: EffectInstance) -> void:
	var effect: Effect = effect_instance.effect_scene.instantiate()
	for child in effects:
		if child.effect_instance == effect_instance:
			child.add_stack()
			return
	effect.effect_instance = effect_instance
	effects.append(effect)
	effect.container = self
	add_child(effect)

func remove_effect(effect: Effect) -> void:
	var effect_index = effects.find(effect)
	effects.remove_at(effect_index)
