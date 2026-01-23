extends CharacterBody2D

@export var speed = 250.0 # Vitesse de l'ennemie
var direction = 1  # 1 = droite, -1 = gauche

func _physics_process(delta):
	velocity.x = direction * speed * delta 
	
	move_and_collide(velocity) #Déplacement
	
	if (position.x > 1000): # Borne Droite
		direction = -1
	elif (position.x < 0): # Borne Gauche
		direction = 1
