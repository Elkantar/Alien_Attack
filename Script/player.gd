extends CharacterBody2D

signal took_damage

var rocket_scene = preload("res://Scene/rocket.tscn")
@onready var rocket_container = $RocketContainer 
@onready var laser_sound = $LaserSound

func _physics_process(delta):
	if Input.is_action_pressed("RIGHT") :
		velocity = Vector2(300 , 0)
		move_and_slide()
	if Input.is_action_pressed("LEFT") :    
		velocity = Vector2(-300 , 0)
		move_and_slide()   
	if Input.is_action_pressed("UP") :
		velocity = Vector2(0 , -300)
		move_and_slide()
	if Input.is_action_pressed("DOWN") :
		velocity = Vector2(0 , 300)
		move_and_slide()
	
	var window_size = get_viewport_rect().size

	global_position = global_position.clamp(Vector2(0,0), window_size)

func _process(delta):
	if Input.is_action_just_pressed("shoot_rocket") : 
		Shoot()

func Shoot() :
	laser_sound.play()
	var rocket_instance = rocket_scene.instantiate()
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x +=  75
	 
func take_damage():
	emit_signal("took_damage")

func die(): 
	queue_free()
