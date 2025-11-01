 
extends Node

@export var texture_width: float = 288.0 
@export var scroll_speed: float = -50.0  

@onready var bg1 = $Nuvem1
@onready var bg2 = $Nuvem2

func _process(delta):
	var movement = scroll_speed * delta
	bg1.position.x += movement
	bg2.position.x += movement
	
	if bg1.position.x < -texture_width:
		bg1.position.x += 2 * texture_width
		
	if bg2.position.x < -texture_width:
		bg2.position.x += 2 * texture_width
