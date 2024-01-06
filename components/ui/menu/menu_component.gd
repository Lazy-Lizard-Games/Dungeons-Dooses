extends MarginContainer
class_name MenuComponent

@export var inventory_component: InventoryComponent
@onready var inventory_grid_container: GridContainer = $HSplitContainer/Inventory/MarginContainer/GridContainer


func _ready() -> void:
	visibility_changed.connect(on_visibility_changed)


func on_visibility_changed() -> void:
	for child in inventory_grid_container.get_children():
		child.queue_free()
	if visible:
		for slot in inventory_component.inventory.slots:
			var color_rect = ColorRect.new()
			color_rect.custom_minimum_size = Vector2(50, 50)
			color_rect.color = Color.WHITE_SMOKE
			if slot:
				color_rect.color = Color.AQUA
			inventory_grid_container.add_child(color_rect)
