extends Control

#referencias
@onready var moldura: Sprite2D = $Moldura
@onready var score: Label = $Score
@onready var high_score: Label = $High_Score
@onready var game_over_label: Label = $GameOverLabel
@onready var retry_texture: TextureRect = $RetryTexture
@onready var exit_texture: TextureRect = $ExitTexture
@onready var retry_button: Button = $RetryButton
@onready var exit_button: Button = $ExitButton




func _ready() -> void:
	$Moldura.hide()
	$GameOverLabel.hide()
	$RetryTexture.hide()
	$ExitTexture.hide()
	$RetryButton.hide()
	$ExitButton.hide()



func _process(_delta: float) -> void:
	pass
	


func Exit():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func Retry():
	get_tree().reload_current_scene()


func mostrar_hud():
	await get_tree().create_timer(2.0).timeout
	moldura.show()
	game_over_label.show()
	retry_texture.show()
	exit_texture.show()
	retry_button.show()
	exit_button.show()


func update_Score(n1: int):
	score.text = "Score:" + str(n1)
	

func update_High_Score(n1: int):
	high_score.text = "High Score:" + str(n1)


func _on_retry_button_pressed() -> void:
	get_tree().paused = false
	Retry()


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	Exit()
