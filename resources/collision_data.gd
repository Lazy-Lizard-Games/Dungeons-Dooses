extends Resource
class_name CollisionData

## Packs damage, effects, and knockbacks into one transmittable box.

@export
var damage_datas : Array[DamageData] = []

@export
var effect_datas : Array[EffectData] = []

@export
var knockback_datas : Array[KnockbackData] = []
