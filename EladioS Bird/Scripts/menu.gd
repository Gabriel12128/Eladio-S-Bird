extends Control

#@export var play: PackedScene





func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_exit_button_pressed() -> void:

	await get_tree().create_timer(1.0).timeout
	get_tree().quit()


func _on_play_button_pressed() -> void:
	get_tree().paused = false
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
