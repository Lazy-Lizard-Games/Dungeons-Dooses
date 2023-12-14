extends Entity

@export var velocity_component: VelocityComponent
@export var hitbox_component: HitboxComponent
@export var health_component: HealthComponent
@export var stats: StatsComponent
@export var state_component: StateComponent

var selected_ability = 0:
	set(s):
		selected_ability = s % 4


func _ready() -> void:
	print(health_component.current_health)
	state_component.init(self)
	faction_changed.connect(on_faction_changed)
	faction_changed.emit()
	if hitbox_component:
		hitbox_component.hit_by_damage.connect(on_hit_by_damage)
		hitbox_component.hit_by_knockback.connect(on_hit_by_knockback)
	if health_component:
		health_component.died.connect(on_died)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		event as InputEventMouseButton
		if event.pressed:
			match event.button_index:
				MOUSE_BUTTON_WHEEL_DOWN:
					selected_ability += 1
					print(selected_ability)
				MOUSE_BUTTON_WHEEL_UP:
					selected_ability -= 1
					print(selected_ability)
	
	if Input.is_action_just_pressed("select_ability_1"):
		selected_ability = 0
	
	if Input.is_action_just_pressed("select_ability_2"):
		selected_ability = 1
	
	if Input.is_action_just_pressed("select_ability_3"):
		selected_ability = 2
	
	if Input.is_action_just_pressed("select_ability_4"):
		selected_ability = 3
	
	state_component.process_input(event)


func _process(delta: float) -> void:
	state_component.process_frame(delta)


func _physics_process(delta):
	state_component.process_physics(delta)


func on_hit_by_damage(damage: DamageData, source: HurtboxComponent) -> void:
	source.entity_damaged.emit(damage, self)
	health_component.damage(damage, source)


func on_hit_by_knockback(knockback: KnockbackData) -> void:
	velocity_component.handle_knockback(knockback)


func on_died(damage: DamageData, source: HurtboxComponent) -> void:
	source.entity_killed.emit(damage, self)
	health_component.current_health = health_component.max_health.get_final_value()


func on_faction_changed() -> void:
	if hitbox_component:
		hitbox_component.faction = faction
