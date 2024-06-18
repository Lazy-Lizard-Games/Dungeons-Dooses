class_name AbilityLoadout
extends Resource

## Stores currently equipped abilites for the player.

## Emitted whenever any item of the loudout is changed.
signal loadout_updated(loudout: AbilityLoadout)

## The primary ability equipped by the player.
@export var primary: AbilityData:
	set(ability):
		primary = ability
		loadout_updated.emit(self)
## The secondary ability equipped by the player.
@export var secondary: AbilityData:
	set(ability):
		secondary = ability
		loadout_updated.emit(self)
## The support ability equipped by the player.
@export var support: AbilityData:
	set(ability):
		support = ability
		loadout_updated.emit(self)
## The passive ability equipped by the player.
@export var passive: AbilityData:
	set(ability):
		passive = ability
		loadout_updated.emit(self)