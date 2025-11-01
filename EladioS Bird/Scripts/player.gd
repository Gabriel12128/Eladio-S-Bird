extends CharacterBody2D
@onready var flap: AudioStreamPlayer2D = $"../Sons/Flap"
#signal Area
@onready var hud: Control = $"../HUD"
var gameO: String = "Game over"
const SPEED = 120.0
const JUMP_VELOCITY = -310.0

@onready var seta: Sprite2D = $"../tutorial/seta"
@onready var eladios_sombra: Sprite2D = $"../tutorial/Eladios_sombra"
@onready var space: AnimatedSprite2D = $"../tutorial/Space"
@onready var mão: AnimatedSprite2D = $"../tutorial/mão"
@onready var exit_texture: TextureRect = $"../tutorial/ExitTexture"
@onready var exit_button: Button = $"../tutorial/ExitButton"



func _ready() -> void:
	
	$".".set_physics_process(false)

func _process(_delta):
	tutorial()

func tutorial():
	if Input.is_action_just_pressed("pulo"):
		await get_tree().create_timer(1.0).timeout
		$".".set_physics_process(true)
		seta.hide()
		eladios_sombra.hide()
		space.hide()
		mão.hide()
		exit_texture.hide()
		exit_button.hide()


func _physics_process(delta: float) -> void:
	rotation_degrees += 60 * delta

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("pulo") && get_tree().paused == false: 
		
		flap.play()
		rotation_degrees = -10
		velocity.y = JUMP_VELOCITY

	#if global_position.y < 13 || global_position.y > 200:
	#	Area.emit()


	move_and_slide()
