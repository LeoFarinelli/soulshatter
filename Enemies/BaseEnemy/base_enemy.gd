# EnemyBase.gd
class_name EnemyBase
extends CharacterBody2D

@export var enemy_battle_scene: PackedScene  # ex: Goblin.tscn
@export var battle_background: Texture2D
@export var max_hp: int = 100
@export var attack_power: int = 10
var current_hp: int

@onready var battle_trigger: Area2D = $BattleTrigger

func _ready() -> void:
	battle_trigger.body_entered.connect(_on_area_2d_body_entered)

func take_damage(amount: int) -> void:
	current_hp -= amount
	if current_hp <= 0:
		die()

func die() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		start_battle()

func start_battle() -> void:
	BattleTransition.start_battle(enemy_battle_scene, battle_background)
