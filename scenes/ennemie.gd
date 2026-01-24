extends CharacterBody2D
class_name Enemy

signal hit_player

@export var speed = 250.0 # Vitesse en pixels par seconde
var direction = 1  # 1 = droite, -1 = gauche

@onready var raycastRight = $RayCastRight
@onready var raycastLeft = $RayCastLeft
@onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	velocity.x = direction * speed
	
	# ajoute la gravité
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# change la direction lorsque l'ennemi entre en colision avec un mur
	if raycastRight.is_colliding() and raycastRight.get_collider() != player:
		direction = -1
	elif raycastLeft.is_colliding() and raycastLeft.get_collider() != player:
		direction = 1
	
	move_and_slide()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if (body == player):
		hit_player.emit()
