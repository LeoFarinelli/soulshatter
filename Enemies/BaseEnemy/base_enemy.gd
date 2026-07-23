# EnemyBase.gd
class_name EnemyBase
extends CharacterBody2D

signal health_changed(current_hp: int, max_hp: int)
signal died

@export var enemy_battle_scene: PackedScene
@export var battle_background: Texture2D
@export var max_hp: int = 100
@export var attack_power: int = 10
var current_hp: int

@onready var battle_trigger: Area2D = $BattleTrigger

func _ready() -> void:
	current_hp = max_hp
	health_changed.emit(current_hp, max_hp)  # HUD pega o valor inicial
	battle_trigger.body_entered.connect(_on_battle_trigger_body_entered)

func take_damage(amount: int) -> void:
	current_hp = max(current_hp - amount, 0)
	health_changed.emit(current_hp, max_hp)
	if current_hp <= 0:
		die()

func die() -> void:
	died.emit()
	queue_free()

func _on_battle_trigger_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		start_battle()

func start_battle() -> void:
	var battle_scene := enemy_battle_scene
	if battle_scene == null and scene_file_path != "":
		battle_scene = load(scene_file_path) as PackedScene

	if battle_scene == null:
		push_error("EnemyBase needs enemy_battle_scene or a valid scene_file_path.")
		return

	BattleTransition.start_battle(battle_scene, battle_background)
