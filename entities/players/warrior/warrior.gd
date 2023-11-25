extends Entity

@export var velocity_component: VelocityComponent
@export var hitbox_component: HitboxComponent
@export var health_component: HealthComponent
@export var weapon_component: WeaponComponent


func _ready() -> void:
	faction_changed.connect(on_faction_changed)
	faction_changed.emit(faction)
	if hitbox_component:
		hitbox_component.hit_by_damage.connect(on_hit_by_damage)
		hitbox_component.hit_by_knockback.connect(on_hit_by_knockback)
	if health_component:
		health_component.died.connect(on_died)


func _physics_process(_delta):
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)
	
	if Input.is_action_just_pressed("ui_cancel"):
		weapon_component.cancel()
	if Input.is_action_just_pressed("primary"):
		weapon_component.start(0, global_position.direction_to(get_global_mouse_position()))
	if Input.is_action_just_released("primary"):
		weapon_component.release()


func on_hit_by_damage(damage: DamageData, source: HurtboxComponent) -> void:
	health_component.damage(damage, source)
	if health_component.is_dead:
		source.entity_killed.emit(damage, self)
	else:
		source.entity_damaged.emit(damage, self)


func on_hit_by_knockback(knockback: KnockbackData) -> void:
	velocity_component.handle_knockback(knockback)


func on_died(damage: DamageData, source: HurtboxComponent) -> void:
	health_component.current_health = health_component.max_health


func on_faction_changed(faction: Globals.FACTION) -> void:
	if hitbox_component:
		hitbox_component.faction = faction
