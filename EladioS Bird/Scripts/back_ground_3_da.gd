extends Node



@export var texture_width: float = 288.0 
@export var scroll_speed: float = -25.0  

@onready var bg1d = $Nuvem1d
@onready var bg2d = $Nuvem2d

func _process(delta):
	var movement = scroll_speed * delta
	bg1d.position.x += movement
	bg2d.position.x += movement
	
	if bg1d.position.x < -texture_width:
		bg1d.position.x += 2 * texture_width
		
	if bg2d.position.x < -texture_width:
		bg2d.position.x += 2 * texture_width
