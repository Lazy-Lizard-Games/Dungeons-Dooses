extends Entity

@export var velocity_component: VelocityComponent
@export var hitbox_component: HitboxComponent
@export var health_component: HealthComponent
@export var state_component: StateComponent

var selected_ability = 0:
	set(s):
		selected_ability = s % 4


func _ready() -> void:
	state_component.init(self)
	faction_changed.connect(on_faction_changed)
	faction_changed.emit()


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




func on_died(damage: DamageData, source: HurtboxComponent) -> void:
	source.entity_killed.emit(damage, self)
	health_component.current_health = health_component.max_health.get_final_value()


func on_faction_changed() -> void:
	if hitbox_component:
		hitbox_component.faction = faction


func _on_health_component_damaged(damage_data: DamageData, source: HurtboxComponent) -> void:
	print("%s %s damage taken." % [damage_data.amount, Globals.DAMAGE.find_key(damage_data.type)])
	TextHandler.create_damage_text(damage_data, global_position)
	if source:
		source.entity_damaged.emit(self)


func _on_health_component_died(damage_data: DamageData, source: HurtboxComponent) -> void:
	health_component.current_health = health_component.max_health.get_final_value()
	if source:
		source.entity_killed.emit(self)
