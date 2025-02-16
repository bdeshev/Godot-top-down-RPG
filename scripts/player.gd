extends CharacterBody2D

var enemy_inrange = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

enum MoveDirection {NONE, UP, DOWN, LEFT, RIGHT}
enum AnimationType {WALK, IDLE}

const speed = 100
var direction: MoveDirection = MoveDirection.NONE

func _physics_process(delta: float):
	player_movement(delta )
	enemy_attack()


func player_movement(_delta):
	if Input.is_action_pressed("ui_right"):
		direction = MoveDirection.RIGHT
		play_anim(AnimationType.WALK)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		direction = MoveDirection.LEFT
		play_anim(AnimationType.WALK)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		direction = MoveDirection.DOWN
		play_anim(AnimationType.WALK)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		direction = MoveDirection.UP
		play_anim(AnimationType.WALK)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(AnimationType.IDLE)
		velocity.x = 0
		velocity.y = 0

	move_and_slide()

func play_anim(type: AnimationType):
	var anim = $AnimatedSprite2D

	anim.flip_h = false
	anim.flip_v = false

	if direction == MoveDirection.RIGHT:
		if type == AnimationType.WALK:
			anim.play("side_walk")
		elif type == AnimationType.IDLE:
			anim.play("side_idle")
	if direction == MoveDirection.LEFT:
		anim.flip_h = true
		if type == AnimationType.WALK:
			anim.play("side_walk")
		elif type == AnimationType.IDLE:
			anim.play("side_idle")
	if direction == MoveDirection.UP:
		if type == AnimationType.WALK:
			anim.play("back_walk")
		elif type == AnimationType.IDLE:
			anim.play("back_idle")
	if direction == MoveDirection.DOWN:
		if type == AnimationType.WALK:
			anim.play("front_walk")
		elif type == AnimationType.IDLE:
			anim.play("front_idle")
	if direction == MoveDirection.NONE:
		if type == AnimationType.WALK:
			anim.play("back_walk")
		elif type == AnimationType.IDLE:
			anim.play("front_idle")

func player():
	pass

func _on_player_range_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inrange = true


func _on_player_range_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inrange = false

func enemy_attack(): 
	if enemy_inrange:
		print("took damage")
