extends Panel

#Variables
@onready var panelPause = $PanelMenu
@onready var reprendre = $PanelMenu/ButtonReprendre
@onready var mainMenu = $PanelMenu/ButtonMainMenu
@onready var quitter = $PanelMenu/ButtonQuitter
@onready var pause = $ButtonPause


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#Quand la touche Echap est appuyé, on va mettre soit mettre le jeu en pause et affiché le menu si le menu n'est pas déjà affiché
	#Et quand le menu est déjà présent, le menu va disparaitre et le jeu va reprendre
	if pause.button_pressed and $clickDelayTimer.is_stopped():
		$Fond.visible = !$Fond.visible
		panelPause.visible = !panelPause.visible
		get_tree().paused = !get_tree().paused
		$clickDelayTimer.start()
		
	#Quand le bouton reprendre est appuyé, on va reprendre le jeu
	if (reprendre.button_pressed):
		$Fond.visible = !$Fond.visible
		panelPause.visible = !panelPause.visible
		get_tree().paused = false
	
	#Quand le bouton mainMenu est appuyé, on va revenir au menu principal du jeu
	if (mainMenu.button_pressed):
		get_tree().change_scene_to_file("res://scenes/mainMenu.tscn")
	
	#Quand le bouton quitter est appuyé, on va quitter le jeu
	if (quitter.button_pressed):
		get_tree().quit(0)
