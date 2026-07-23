# HUD.gd
extends Control

@onready var enemy_hp_bar: ProgressBar = $EnemyHealthBar/HPBar
@onready var enemy_name_label: Label = $EnemyHealthBar/NameLabel

func connect_to_enemy(enemy: EnemyBase) -> void:
    enemy_name_label.text = enemy.name  # ou enemy.display_name, se tiver
    enemy.health_changed.connect(_on_enemy_health_changed)
    enemy.died.connect(_on_enemy_died)

func _on_enemy_health_changed(current: int, max: int) -> void:
    enemy_hp_bar.max_value = max
    enemy_hp_bar.value = current

func _on_enemy_died() -> void:
    enemy_hp_bar.value = 0
    # aqui dá pra disparar animação de "derrota", esconder a barra, etc.