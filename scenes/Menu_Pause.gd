extends Panel

#Variables
@onready var panelPause = $PanelMenu
@onready var reprendre = $PanelMenu/ButtonReprendre
@onready var mainMenu = $PanelMenu/ButtonMainMenu
@onready var quitter = $PanelMenu/ButtonQuitter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	get_tree().paused = false;
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#Quand la touche Echap est appuyé, on va mettre soit mettre le jeu en pause et affiché le menu si le menu n'est pas déjà affiché
	#Et quand le menu est déjà présent, le menu va disparaitre et le jeu va reprendre
	if Input.is_action_just_pressed("Pause"):
		panelPause.visible = !panelPause.visible
		get_tree().paused = !get_tree().paused
		
	#Quand le bouton reprendre est appuyé, on va reprendre le jeu
	if (reprendre.button_pressed):
		panelPause.visible = !panelPause.visible
		get_tree().paused = !get_tree().paused
	
	#Quand le bouton mainMenu est appuyé, on va revenir au menu principal du jeu
	if (mainMenu.button_pressed):
		get_tree().change_scene_to_file("res://scenes/mainMenu.tscn")
	
	#Quand le bouton quitter est appuyé, on va quitter le jeu
	if (quitter.button_pressed):
		get_tree().quit(0)
	
	pass
