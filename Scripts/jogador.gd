extends CharacterBody2D

const VELOCIDADE = 50.0

@onready var sprite = $Sprite2D

func _ready() -> void:
	add_to_group("player")

func _physics_process(_delta):
	var direcao = Vector2.ZERO
	
	if Input.is_action_pressed("mover_direita"):
		direcao.x = 1
	elif Input.is_action_pressed("mover_esquerda"):
		direcao.x = -1
	elif Input.is_action_pressed("mover_baixo"):
		direcao.y = 1
	elif Input.is_action_pressed("mover_cima"):
		direcao.y = -1
		
	if direcao != Vector2.ZERO:
		velocity = direcao * VELOCIDADE
		
		# Verifica a direção horizontal (Esquerda / Direita)
		if direcao.x != 0:
			sprite.play("andar_lado")
			# O truque do espelho: se a direção for menor que 0 (esquerda), ele inverte a imagem!
			sprite.flip_h = direcao.x > 0
			
		# Verifica a direção vertical (Cima / Baixo)
		elif direcao.y > 0:
			sprite.play("andar_baixo")
			sprite.flip_h = false # Garante que a imagem não fique invertida sem querer
		elif direcao.y < 0:
			sprite.play("andar_cima")
			sprite.flip_h = false
			
	else:
		velocity = Vector2.ZERO
		sprite.stop()
		sprite.frame = 0

	move_and_slide()