extends CharacterBody2D

@export var velocidade := 50.0
@export var aceleracao := 800.0
@export var desaceleracao := 800.0
@export var sprite_facing_right := true # ajustar se o sprite padrão olhar para a esquerda

@onready var sprite = $Sprite2D

func _physics_process(delta):
	# Lê o input como vetor (esquerda, direita, cima, baixo)
	var entrada = Input.get_vector("mover_esquerda", "mover_direita", "mover_cima", "mover_baixo")

	var alvo = entrada * velocidade

	# Suaviza a velocidade (acelera/desacelera)
	if entrada.length() > 0:
		velocity = velocity.move_toward(alvo, aceleracao * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, desaceleracao * delta)

	# Animação e espelhamento
	if entrada.length() > 0.01:
		# Prioriza animação horizontal quando o componente X for maior
		if abs(entrada.x) > abs(entrada.y):
			sprite.play("andar_lado")
			# Se o sprite aponta para a direita por padrão, inverta quando x < 0
			sprite.flip_h = (entrada.x > 0) if sprite_facing_right else (entrada.x < 0)
		elif entrada.y > 0:
			sprite.play("andar_baixo")
			sprite.flip_h = false
		elif entrada.y < 0:
			sprite.play("andar_cima")
			sprite.flip_h = false
	else:
		# Parado
		sprite.stop()
		sprite.frame = 0

	move_and_slide()
