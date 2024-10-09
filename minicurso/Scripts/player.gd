extends CharacterBody2D

@export var SPEED = 110

func _physics_process(delta: float) -> void:

	var direction = Vector2.ZERO
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	if direction.x != 0 or direction.y != 0:
		$Animation.play("Move")
		if direction.x > 0:
			$Animation.flip_h = false
		else:
			$Animation.flip_h = true
	else:
		$Animation.play("Idle")
	
	velocity = direction.normalized() * SPEED
	move_and_slide()
