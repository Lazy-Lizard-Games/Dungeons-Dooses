extends CanvasLayer

@export var health_component: HealthComponent
@export var velocity_component: VelocityComponent

@onready var health_label: Label = $MarginContainer/VBoxContainer/HealthLabel
@onready var velocity_label: Label = $MarginContainer/VBoxContainer/VelocityLabel

func _process(_delta: float) -> void:
	health_label.text = "Health: %s" % str(health_component.current_health)
	velocity_label.text = "Velocity: %s" % str(velocity_component.velocity)
