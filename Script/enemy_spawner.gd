extends Node2D

var enemy_scene = preload("res://Scene/enemy.tscn")
var path_enemy_scene = preload("res://Scene/pathEnemy.tscn")
signal enemy_spwaned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)

@onready var spawn_position = $Spawn_Position

func _on_timer_timeout():
	#print("Timeout")
	spawn_enemy()

func spawn_enemy() :
	var position_array =  spawn_position.get_children()
	var random_position = position_array.pick_random()
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_position.global_position
	emit_signal("enemy_spwaned", enemy_instance)
	
	add_child(enemy_instance)
	#enemy_instance.name = "enemy"

func _on_path_enemy_timer_timeout() -> void:
	spawn_path_enemy()

func spawn_path_enemy() :
	var path_enemy_instance = path_enemy_scene.instantiate()
	emit_signal("path_enemy_spawned", path_enemy_instance)
	
