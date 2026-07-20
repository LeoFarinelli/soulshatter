# BattleTransition.gd — adicionar em Project > Autoload
extends Node

var pending_enemy_scene: PackedScene
var pending_background: Texture2D
var return_scene_path: String = ""

const BATTLE_SCENE_PATH := "res://scenes/Battle.tscn"

func start_battle(enemy_scene: PackedScene, background: Texture2D) -> void:
    pending_enemy_scene = enemy_scene
    pending_background = background
    return_scene_path = get_tree().current_scene.scene_file_path
    
    get_tree().change_scene_to_file(BATTLE_SCENE_PATH)