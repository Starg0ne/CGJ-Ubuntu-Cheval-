extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -400.0

@onready var raycast2D = $RayCast2D

@onready var mouse_pos: Vector2
var pos_destination_x: float = 0.0
var has_destination: bool = false

func _ready() -> void:
	mouse_pos = get_global_mouse_position()

func _physics_process(delta: float) -> void:
	
	# ajoute la gravité
	if not is_on_floor():
		velocity += get_gravity() * delta

	# permet au joueur de sauter si au sol
	if Input.is_action_pressed("right click") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("left click"):
		# prépare le raycast pour trouver la position
		mouse_pos = get_global_mouse_position()
		raycast2D.global_position = mouse_pos
		
		# obtient la position
		raycast2D.set_enabled(true)
		if raycast2D.is_colliding():
			pos_destination_x = raycast2D.get_collision_point().x
			has_destination = true
			raycast2D.set_enabled(false)
	
	if has_destination:
		var position_difference: float = global_position.x - pos_destination_x
		if (position_difference < -10):
			velocity.x = SPEED * 1
		elif (position_difference > 10):
			velocity.x = SPEED * -1
		else:
			has_destination = false
	else:
		velocity.x = 0
	

	move_and_slide()
