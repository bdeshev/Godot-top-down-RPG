extends CharacterBody2D

var enemy_inrange = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

var attack_ip = false

enum MoveDirection {NONE, UP, DOWN, LEFT, RIGHT}
enum AnimationType {WALK, IDLE}

const speed = 75
var direction: MoveDirection = MoveDirection.NONE

func _physics_process(delta):
	player_movement(delta )
	enemy_attack()
	attack()
	
	if health <= 0:
		player_alive = false #end screen
		health = 0
		print("player has been killed")
		self.queue_free()


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

	if Global.player_current_attack == false:
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

func _on_player_range_body_entered(body):
	if body.has_method("slime"):
		enemy_inrange = true


func _on_player_range_body_exited(body):
	if body.has_method("slime"):
		enemy_inrange = false

func enemy_attack(): 
	if enemy_inrange and enemy_attack_cooldown:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
		
func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true

func attack():
	var dir = direction
	var anim = $AnimatedSprite2D
	var timer = $deal_attack_timer

	anim.flip_h = false
	anim.flip_v = false
	
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		if dir == MoveDirection.RIGHT:
			anim.flip_h = true
			anim.play("side_attack")
			timer.start()
		if dir == MoveDirection.LEFT:
			anim.flip_h = false
			anim.play("side_attack")
			timer.start()
		if dir == MoveDirection.DOWN:
			anim.play("front_attack")
			timer.start()
		if dir == MoveDirection.UP:
			anim.play("back_attack")
			timer.start()
	

func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false
