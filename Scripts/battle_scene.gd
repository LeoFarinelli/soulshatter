extends Node

var battle_triggered := false
# Called when the node enters the scene tree for the first time.
# BattleScene.gd
func _ready() -> void:
	if BattleTransition.pending_enemy_scene:
		setup_battle(
            BattleTransition.pending_enemy_scene,
            BattleTransition.pending_background
        )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func end_battle(player_won: bool) -> void:
	if player_won:
		get_tree().change_scene_to_file(BattleTransition.return_scene_path)
        # aqui você pode remover o inimigo derrotado do overworld,
        # via um id salvo em algum GameState autoload
	else:
		get_tree().change_scene_to_file("res://scenes/GameOverScene.tscn")

func _on_area_2d_body_entered(body: Node) -> void:
	if battle_triggered:
		return
	if body.is_in_group("player"):
		battle_triggered = true
		start_battle()