class_name BattleManager extends Node

@onready var enemy_slot: Marker2D = $EnemySlot
@onready var player_slot: Marker2D = $PlayerSlot
@onready var background: Sprite2D = $Background

var current_enemy: Node = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup_battle(enemy_scene: PackedScene, background_texture: Texture2D) -> void:
	#change background
	background.texture = background_texture

	#Instance the enemy scene and add it to the enemy slot
	current_enemy = enemy_scene.instantiate()
	enemy_slot.add_child(current_enemy)
	current_enemy.global_position = enemy_slot.global_position

	