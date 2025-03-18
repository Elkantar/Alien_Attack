extends Node2D

var lives = 3
var score = 0

@onready var player = $Player
@onready var hud = $UI/Hud
@onready var ui = $UI

@onready var enemy_hit_sound = $EnemyHitSound
@onready var explode_sound = $ExplodeSound

var gos_scene = preload("res://Scene/game_over_screen.tscn")

func _ready() -> void:
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_player_took_damage() -> void:
	lives -= 1
	hud.set_lives(lives)
	explode_sound.play()
	if (lives == 0) :
		print("game over")
		player.die()
		
		await  get_tree().create_timer(1.5).timeout
		
		var gos = gos_scene.instantiate()
		gos.set_score(score)
		ui.add_child(gos)
	else :
		print(lives)

func _on_enemy_died() :
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()
	print("Score : " + str(score))

func _on_enemy_spawner_enemy_spwaned(enemy_instance: Variant) -> void:
	enemy_instance.connect("died", _on_enemy_died)


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance: Variant) -> void:
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)
