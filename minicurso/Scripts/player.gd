extends CharacterBody2D

@export var SPEED = 110

var hp = 100
var maxHp = 100
var coins = 0
var hud = null
var isAttacking = false
var attack_damage = 25

func _ready() -> void:
	hud = get_tree().current_scene.get_node("CanvasLayer/HUD")
	
func add_coins(amount: float):
	coins += amount
	hud.update_hud(self)
	
func knockback(direction: Vector2):
	velocity = (direction - velocity) * 400
	move_and_slide()

func take_damage(damage: float):
	hp -= damage
	if hp <= 0:
		get_tree().reload_current_scene()
	hud.update_hud(self)
	
func attack():
	$Animation.play("Attack")
	isAttacking = true
	$AttackArea.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(0.5).timeout
	$AttackArea.process_mode = Node.PROCESS_MODE_DISABLED
	isAttacking = false

func _physics_process(delta: float) -> void:

	var direction = Vector2.ZERO
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	if Input.is_action_just_pressed("attack"):
		attack()
	
	if isAttacking == false:
		if direction.x != 0 or direction.y != 0:
			$Animation.play("Move")
			if direction.x > 0:
				transform.x.x = 1
			else:
				transform.x.x = -1
		else:
			$Animation.play("Idle")
		
		velocity = direction.normalized() * SPEED
		move_and_slide()

func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.name == "HitBox":
		area.get_parent().take_damage(attack_damage)
