extends CharacterBody2D

enum MoveDirection {NONE, UP, DOWN, LEFT, RIGHT}
enum AnimationType {WALK, IDLE}

const speed = 100

func _physics_process(delta: float):
	player_movement(delta )


func player_movement(_delta):
	if Input.is_action_pressed("ui_right"):
		play_anim(MoveDirection.RIGHT, AnimationType.WALK)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		play_anim(MoveDirection.LEFT, AnimationType.WALK)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		play_anim(MoveDirection.DOWN, AnimationType.WALK)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		play_anim(MoveDirection.UP, AnimationType.WALK)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(MoveDirection.NONE, AnimationType.IDLE)
		velocity.x = 0
		velocity.y = 0

	move_and_slide()

func play_anim(direction: MoveDirection, type: AnimationType):
	print("direction: %s, type: %s" % [str(direction), str(type)])
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
			anim.play("back_idle")
