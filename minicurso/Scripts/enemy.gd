extends CharacterBody2D

var player = null
var speed = 50
	
func _physics_process(delta: float) -> void:
	if player: #mesma coisa que if player != null:
		velocity = global_position.direction_to(player.global_position)
		if velocity.x > 0:
			$AnimatedSprite2D.play("Move")
			$AnimatedSprite2D.flip_h = false
		elif velocity.x < 0:
			$AnimatedSprite2D.play("Move")
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.play("idle")
		
		move_and_collide(velocity * speed * delta)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Players"):
		player = null
		$AnimatedSprite2D.play("Idle")
