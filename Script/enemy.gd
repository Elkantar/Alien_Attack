extends Area2D

@export var enemy_speed = 200
signal died
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) :
	global_position.x -= enemy_speed * delta

func die() :
	emit_signal("died")
	queue_free()
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	body.take_damage()
	die()
