extends Control
class_name Menu

## The player who will be using the menu.
@export var player: Player
## The inventory menu used by the menu.
@onready var inventory_menu: InventoryMenu = $MarginContainer/VBoxContainer/TabContainer/InventoryMenu
## The ability menu used by the menu.
@onready var ability_menu: AbilityMenu = $MarginContainer/VBoxContainer/TabContainer/AbilityMenu

func _ready():
	inventory_menu.init(player)
	ability_menu.init(player)
