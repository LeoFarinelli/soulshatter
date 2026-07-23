class_name BattleManager extends Node

@onready var enemy_slot: Marker2D = get_parent().get_node("EnemyMarker")
@onready var player_slot: Marker2D = get_parent().get_node("PlayerMarker")
@onready var background: Sprite2D = get_parent().get_node("Background")

var current_enemy: Node = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func setup_battle(enemy_scene: PackedScene, background_texture: Texture2D) -> void:
	background.texture = background_texture
	
	current_enemy = enemy_scene.instantiate()
	enemy_slot.add_child(current_enemy)
	current_enemy.global_position = enemy_slot.global_position
	
	var hud := get_parent().get_node_or_null("CanvasLayer/HUD") as Control
	if hud == null:
		push_error("BattleManager could not find CanvasLayer/HUD in Battle.tscn.")
		return

	hud.connect_to_enemy(current_enemy)
