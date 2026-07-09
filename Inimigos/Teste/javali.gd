extends CharacterBody2D

class_name Javali
@export var health: int = 100
@export var speed: float = 200.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var animation_name: String = "Idle" # Default animation name


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_animation(animation_name: String) -> void:
	if animation_player.has_animation(animation_name):
		animation_player.play(animation_name)
	else:
		print("Animation not found: ", animation_name)