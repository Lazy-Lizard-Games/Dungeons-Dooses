extends Ability

## Fire an explosive device at your enemies using a portable cannon. Dynamite comes in small packages, and big ones too.

const DAMAGE_TYPE = Enums.DamageType.Blunt

@export var damage: float
@export var knockback: float
@export var effect: Effect
@export var projectile_scene: PackedScene

var has_charged := false
var has_fired := false
var target := Vector2.ZERO

func enter() -> void:
	mob.animation_player.play("mortar_load")
	cast()

func exit() -> void:
	has_charged = false
	has_fired = false
	refresh()

func process_frame(_delta: float) -> State:
	var current_position = mob.animation_player.current_animation_position
	if has_fired and current_position >= mob.animation_player.current_animation_length:
		return mob.state_component.starting_state
	if Input.is_action_just_released("ability_2"):
		if has_charged:
			if !has_fired:
				fire()
		else:
			return mob.state_component.starting_state
	return null

func get_target_position() -> Vector2:
	return mob.get_global_mouse_position()

func fire() -> void:
	has_fired = true
	target = get_target_position()
	mob.animation_player.play("mortar_fire")
	mob.stamina_component.exhaust(cost * mob.stats_component.ability_efficiency.get_final_value())
	mob.get_tree().create_timer(0.5 * (min(mob.centre_position.distance_to(target) / 250, 1))).timeout.connect(_on_timeout)

func _on_timeout() -> void:
	var affinity = mob.stats_component.get_final_affinity_for(DAMAGE_TYPE)
	var damage_data = DamageData.new(damage * affinity, DAMAGE_TYPE)
	var effect_data = EffectData.new(effect, 1)
	var impact_data = ImpactData.new([damage_data], knockback, [effect_data])
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.init(target, mob.looking_at, impact_data, mob.faction, false)
	ProjectileHandler.add_projectile(projectile)

func _on_casted():
	mob.animation_player.play("mortar_idle")
	has_charged = true

func _on_started() -> void:
	mob.state_component.change_state(self)