extends CharacterBody2D
class_name Enemy

@export var speed = 250.0 # Vitesse en pixels par seconde
var direction = 1  # 1 = droite, -1 = gauche

@onready var sprite = $Sprite2D
@onready var player = $"../Player" 


func _physics_process(delta):
	velocity.x = direction * speed
	velocity.y = 0
	move_and_slide()
	#var collision = move_and_collide(velocity * delta)
	var nbcoll = get_slide_collision_count()
	for i in range(nbcoll):
		var c= get_slide_collision(i)
		var coll = c.get_collider()
		if coll is Player:
			if coll.has_method("recevoir_degats"): 
				player.recevoir_degats(1)
			else:
				player.vie -= 1

	
	
	
	if (position.x > 1000): # Borne Droite
		direction = -1
	elif (position.x < 0): # Borne Gauche
		direction = 1
