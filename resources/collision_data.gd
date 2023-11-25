extends Resource
class_name CollisionData

## Packs damage, effects, and knockbacks into one transmittable box.

@export
var damages : Array[DamageData] = []

@export
var effects : Array[EffectData] = []

@export
var knockbacks : Array[KnockbackData] = []
