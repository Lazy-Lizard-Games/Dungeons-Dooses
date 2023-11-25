extends Ability

@export var total_time := 2.0
var charge_time : float:
	get:
		if fully_charged:
			return total_time
		if !charge_timer or charge_timer.is_stopped():
			return 0
		return total_time - charge_timer.time_left
var charge_timer: Timer
var fully_charged := false


## Signals that the ability should start doing things.
func start() -> void:
	charge_timer = Timer.new()
	add_child(charge_timer)
	charge_timer.one_shot = true
	charge_timer.timeout.connect(on_fully_charged)
	charge_timer.start(total_time)
	print("Charging started!")


## Signals that the ability should release the charging ability or stop.
func release() -> void:
	var charge = (charge_time / total_time) * 100
	print(("Released with %s" % charge) + "% charge!")
	fully_charged = false
	expire()


## Signals the end of the ability and that it should probably go home.
func cancel() -> void:
	charge_timer.stop()
	print("Charging cancelled!")
	expire()


func on_fully_charged() -> void:
	fully_charged = true
	print("Fully charged!")
