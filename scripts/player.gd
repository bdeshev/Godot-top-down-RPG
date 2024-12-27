extends CharacterBody2D


const speed = 100
var direction = "none"

func _physics_process(delta: float):
	player_movement(delta )
	
	
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		direction = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		direction = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		direction = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		direction = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		direction = "none"
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	print(direction)
	move_and_slide()
	
func play_anim(movement):
	var dir = direction
	var anim = $AnimatedSprite2D 
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_idle")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
