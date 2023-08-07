extends CanvasLayer

@export var health_component: HealthComponent
@export var velocity_component: VelocityComponent

@onready var health_label: Label = $MarginContainer/VBoxContainer/HealthLabel
@onready var velocity_label: Label = $MarginContainer/VBoxContainer/VelocityLabel
@onready var speed_label: Label = $MarginContainer/VBoxContainer/SpeedLabel

func _process(_delta: float) -> void:
	health_label.text = "Health: %s" % str(health_component.current_health)
	velocity_label.text = "Velocity: %s" % str(velocity_component.velocity)
	speed_label.text = "Speed: %s" % str(int(velocity_component.velocity.length()))
