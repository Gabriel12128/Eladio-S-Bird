extends Area2D

# sinais
signal gameOver
signal scored 

# referencias
@onready var canos: Area2D = $"."
@onready var score_zone = $ScoreZone 

#exportaveis
@export var speed: float = -150.0 

#variaveis normais
var pausado: bool = false



func _ready():
	score_zone.body_entered.connect(interacao_pontuacao)
	canos.body_entered.connect(Game_over)





   

func _process(delta):
	global_position.x += speed * delta
	
	if global_position.x < -100:
		queue_free()



func interacao_pontuacao(body):
	if body.is_in_group("player"):
		scored.emit() 
		score_zone.set_deferred("set_monitoring", false)


func Game_over(body):
	if body.is_in_group("player"):
		gameOver.emit()
		canos.set_deferred("set_monitoring", false)
