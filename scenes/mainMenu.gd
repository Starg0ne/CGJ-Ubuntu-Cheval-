extends Panel
#Variables
@onready var commencer = $ButtonCommencer
@onready var quitter = $ButtonQuitter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#Quand le bouton commencer est appuyé, on va aller sur la scéne level
	if (commencer.button_pressed):
		get_tree().change_scene_to_file("res://scenes/level.tscn")
	
	#Quand le bouton quitter est appuyé, on va quitter le jeu
	if (quitter.button_pressed):
		get_tree().quit(0)
	
	pass
