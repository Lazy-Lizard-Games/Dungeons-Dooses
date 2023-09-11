extends Node2D
class_name EffectComponent

signal effect_added(effect: Effect)

@export_category("Components")
@export var stats_component: StatsComponent
@export var health_component: HealthComponent
@export var projectile_component: ProjectileComponent
@export var hitbox_component: HitboxComponent
@export var hurtbox_component: HurtboxComponent

var effects: Array[Effect]
var skill_effects: Array[Effect]


func add_effect(effect_instance: EffectInstance) -> void:
	var effect: Effect = effect_instance.effect_scene.instantiate()
	for child in effects:
		if child.effect_instance == effect_instance:
			child._add_stack()
			return
	effect.effect_instance = effect_instance
	effects.append(effect)
	effect.container = self
	add_child(effect)
	effect._add_stack()
	effect.exited_tree.connect(on_exited_tree)
	effect_added.emit(effect)


func remove_effect(effect_instance: EffectInstance) -> void:
	for child in effects:
		if child.effect_instance == effect_instance:
			child.exit_tree()


func get_effect(effect_instance: EffectInstance) -> Effect:
	for child in effects:
		if child.effect_instance == effect_instance:
			return child
	return null


func on_exited_tree(effect: Effect) -> void:
	var effect_index = effects.find(effect)
	effects.remove_at(effect_index)
	get_child(effect_index).queue_free()
	
