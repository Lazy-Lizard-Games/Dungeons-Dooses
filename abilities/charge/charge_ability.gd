extends Ability

@export var total_time := 2.0
@export var particle_emitter: CPUParticles2D

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
	print(("Released with %s" % charge) + "% charge!")
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
	current_state = state.READY
	charge_timer.stop()
	particle_emitter.emitting = false
