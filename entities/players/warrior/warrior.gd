extends Entity

@export var velocity_component: VelocityComponent
@export var hitbox_component: HitboxComponent
@export var health_component: HealthComponent


func _ready() -> void:
	if hitbox_component:
		hitbox_component.hit_by_damage.connect(on_hit_by_damage)
		hitbox_component.hit_by_knockback.connect(on_hit_by_knockback)
		health_component.died.connect(on_died)


func _physics_process(_delta):
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity_component.accelerate_to_velocity(direction * velocity_component.max_speed)
	velocity_component.move(self)


func on_hit_by_damage(damage: DamageData, source: HurtboxComponent) -> void:
	print("Damaged!")
	source.entity_damaged.emit(damage, self)
	health_component.damage(damage, source)


func on_hit_by_knockback(knockback: KnockbackData, _source: HurtboxComponent) -> void:
	velocity_component.set_velocity(knockback.direction * knockback.force)


func on_died(damage: DamageData, source: HurtboxComponent) -> void:
	print("Died!")
	source.entity_killed.emit(damage, self)
	health_component.current_health = health_component.max_health
