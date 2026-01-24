extends CharacterBody2D
class_name Player

const SPEED = 500.0
const JUMP_VELOCITY = -400.0


@export var vie: int = 3
var invincible: bool = false
var mode_grappin: bool = false
var currently_dragged: bool = false


@onready var raycast2D = $RayCast2D
@onready var anim_sprite = $AnimatedSprite2D
@onready var line = $Line2D
var mouse_pos: Vector2
var pos_destination_x: float = 0.0
var has_destination: bool = false
var position_difference: float
var destination_grappin: Vector2

func _ready() -> void:
	velocity = Vector2.ZERO
	line.add_point($Marker2D.position - line.position, 0)

func _physics_process(delta: float) -> void:
	
	# ajoute la gravité
	if not is_on_floor() and !currently_dragged:
		velocity += get_gravity() * delta

	if is_on_floor() and !currently_dragged:
		# permet au joueur de sauter si au sol
		if Input.is_action_pressed("right click"):
			anim_sprite.play("jump")
			velocity.y = JUMP_VELOCITY
		
		# retourne le sprite à l'animation par défaut lorsqu'il a fin l'animation de jump
		elif !anim_sprite.is_playing():
			if mode_grappin:
				anim_sprite.play("grappin")
			else:
				anim_sprite.play("default")
	
	if Input.is_action_just_released("middle click") and !currently_dragged:
		mode_grappin = !mode_grappin
		anim_sprite.play("grappin")
		if !mode_grappin:
			anim_sprite.play("default")
	
	# prépare le mouvement du joueur lors d'un click gauche
	if Input.is_action_pressed("left click"):
		# gère quand le joueur n'as pas de grappin sorti (déplacement normal)
		if !mode_grappin:
			# prépare le raycast pour trouver la position
			mouse_pos = get_global_mouse_position()
			raycast2D.global_position = mouse_pos
			
			# obtient la position
			raycast2D.set_enabled(true)
			if raycast2D.is_colliding():
				pos_destination_x = raycast2D.get_collision_point().x
				has_destination = true
				raycast2D.set_enabled(false)
		
		#gère quand le personnage a le grappin sorti
		elif !currently_dragged and is_on_floor():
			destination_grappin = get_global_mouse_position()
			if line.get_point_count() == 2:
				line.remove_point(1)
			line.add_point(get_global_mouse_position()-line.global_position, 1)
			currently_dragged = true
	
	# gère le mouvement du joueur en fonction de sa position par rapport à la position de la destination
	if currently_dragged:
		line.set_point_position(1, destination_grappin-line.global_position)
		velocity = Vector2(cos(line.get_point_position(1).angle())*SPEED, sin(line.get_point_position(1).angle())*SPEED)
		var pos_dif_grappin = line.get_point_position(0) - line.get_point_position(1)
		if pos_dif_grappin.x < 10 and pos_dif_grappin.x > -10 and pos_dif_grappin.y < 10 and pos_dif_grappin.y > -10:
			currently_dragged = false
			velocity = Vector2(0, 0)
			line.remove_point(1)
	
	elif has_destination:
		position_difference = global_position.x - pos_destination_x
		if (position_difference < -10):
			velocity.x = SPEED * 1
		elif (position_difference > 10):
			velocity.x = SPEED * -1
		else:
			has_destination = false
	else:
		velocity.x = 0
		
	move_and_slide()
	
func recevoir_degats(quantite):
	if invincible == false:
		vie -= quantite
		print("Aïe ! Vie restante : ", vie)
		invincible = true
		await get_tree().create_timer(1.0).timeout
		invincible = false
	
