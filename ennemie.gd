extends CharacterBody2D


# On crée des variables réglables dans l'inspecteur
@export var speed = 250.0
var direction = 1  # 1 = droite, -1 = gauche

func _physics_process(delta):
	velocity.x = direction * speed * delta
	
	move_and_collide(velocity)
	
	if (position.x > 1000):
		direction *= -1
	elif (position.x < 0):
		direction *= -1
