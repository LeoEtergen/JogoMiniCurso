extends Node2D

var enemy = preload("res://Scenes/enemy.tscn")

func _on_timer_timeout() -> void:
	var new_enemy = enemy.instantiate()
	get_tree().root.add_child(new_enemy)
	new_enemy.position = global_position
	
