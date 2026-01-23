extends Node2D

@onready var heart1 = $CanvasLayer/Control/PlayerHP/FirstHeart/Heart
@onready var heart2 = $CanvasLayer/Control/PlayerHP/SecondHeart/Heart
@onready var heart3 = $CanvasLayer/Control/PlayerHP/ThirdHeart/Heart

@onready var player = $Player
@onready var gameover = $CanvasLayer/Control/GameOver
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Si le joueur a trois vie, les 3 coeurs sont affichés
	if(player.vie >= 3):
		heart1.visible = true
		heart2.visible = true
		heart3.visible = true
	#Si le joueur a 2 vie, que 2 coeurs on été affiché
	elif(player.vie == 2):
		heart3.visible = false
	#Si le joueur a 1 vie, que 1 coeur sera affiché
	elif(player.vie == 1):
		heart2.visible = false
	#Si le joueur a pus de vie, aucun coeur sera affiché, le jeu sera mis en pause, et le menu de game over s'affichera
	elif(player.vie <= 0):
		heart1.visible = false
		get_tree().paused = !get_tree().paused
		gameover.visible = !gameover.visible
	
	pass
