extends Ability

@export var total_time := 2.0
@export var particle_emitter: CPUParticles2D
@export var charge_projectile: PackedScene

var charge_time : float:
	get:
		if fully_charged:
			return total_time
		if charge_timer.is_stopped():
			return 0
		return total_time - charge_timer.time_left

var charge_timer: Timer
var fully_charged := false


func _ready() -> void:
	expired.connect(on_expired)
	charge_timer = Timer.new()
	charge_timer.one_shot = true
	charge_timer.timeout.connect(on_fully_charged)
	add_child(charge_timer)


## Signals that the ability should start doing things.
func start() -> void:
	fully_charged = false
	charge_timer.start(total_time)
	update_control.emit(0.5)
	current_state = state.ACTIVE
	particle_emitter.emitting = true


## Signals that the ability should release the charging ability or stop.
func release() -> void:
	var charge = (charge_time / total_time) * 100
	update_control.emit(1)
	var projectile = charge_projectile.instantiate() as Projectile
	projectile.hurtbox_component = hurtbox_component
	projectile.faction = faction
	projectile.position = get_global_mouse_position()
	projectile.scale = Vector2(1 + charge/100, 1 + charge/100)
	ProjectileHandler.add(projectile)
	expire()


## Signals the end of the ability and that it should probably go home.
func cancel() -> void:
	update_control.emit(1)
	expire()


func on_fully_charged() -> void:
	fully_charged = true
	update_color.emit(Color.CRIMSON)
	update_control.emit(0.7)


func on_expired() -> void:
	charge_timer.stop()
	particle_emitter.emitting = false
