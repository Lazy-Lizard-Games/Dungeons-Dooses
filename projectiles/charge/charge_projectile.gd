extends Projectile

@export var damager: HurtboxComponent

var timer: Timer


func _ready():
	damager.faction = faction
	damager.hurtbox = hurtbox_component


func enter() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(func(): expired.emit(self) )
	timer.start(1)
