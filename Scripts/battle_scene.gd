extends Node2D

@onready var battle_manager: BattleManager = $BattleManager


func _ready() -> void:
    if BattleTransition.pending_enemy_scene:
        battle_manager.setup_battle(
            BattleTransition.pending_enemy_scene,
            BattleTransition.pending_background
        )


func end_battle(player_won: bool) -> void:
    if BattleTransition.overlay:
        await BattleTransition.overlay.fade_out()

    var next_scene_path := BattleTransition.return_scene_path
    if not player_won and ResourceLoader.exists("res://scenes/GameOverScene.tscn"):
        next_scene_path = "res://scenes/GameOverScene.tscn"

    if next_scene_path != "":
        get_tree().change_scene_to_file(next_scene_path)
        await get_tree().process_frame

    if BattleTransition.overlay:
        await BattleTransition.overlay.fade_in()