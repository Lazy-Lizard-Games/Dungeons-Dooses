class_name AbilityLoadout
extends Resource

## Stores currently equipped abilites for the player.

@export var primary: AbilityData:
	set(ability):
		primary = ability
		print_debug('New primary: ', primary.name)
@export var secondary: AbilityData:
	set(ability):
		secondary = ability
		print_debug('New secondary: ', secondary.name)
@export var support: AbilityData:
	set(ability):
		support = ability
		print_debug('New support: ', support.name)
@export var passive: AbilityData:
	set(ability):
		passive = ability
		print_debug('New passive: ', passive.name)