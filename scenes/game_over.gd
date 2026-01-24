extends Panel

#Variables
@onready var recommencer = $ButtonRecommencer
@onready var quitter = $ButtonQuitter


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#Quand le bouton commencer est appuyé, on va aller sur la scéne level
	if (recommencer.button_pressed):
		get_tree().reload_current_scene()
	
	#Quand le bouton quitter est appuyé, on va quitter le jeu
	if (quitter.button_pressed):
		get_tree().quit(0)
