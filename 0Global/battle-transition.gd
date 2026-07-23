# BattleTransition.gd
extends Node

var pending_enemy_scene: PackedScene
var pending_background: Texture2D
var return_scene_path: String = ""

const BATTLE_SCENE_PATH := "res://scenes/Battle.tscn"
const OVERLAY_SCENE := preload("res://scenes/TransitionOverlay.tscn")

var overlay: CanvasLayer

func _ready() -> void:
    overlay = OVERLAY_SCENE.instantiate()
    get_tree().root.add_child.call_deferred(overlay)

func start_battle(enemy_scene: PackedScene, background: Texture2D) -> void:
    pending_enemy_scene = enemy_scene
    pending_background = background
    return_scene_path = get_tree().current_scene.scene_file_path
    
    await overlay.fade_out()  # tela fica preta
    get_tree().change_scene_to_file(BATTLE_SCENE_PATH)
    await get_tree().process_frame  # espera a cena nova carregar
    await overlay.fade_in()  # revela a batalha