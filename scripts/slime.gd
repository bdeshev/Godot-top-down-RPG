extends CharacterBody2D

var speed = 52

var player_chase = false
var player = null

var health = 100
var player_inrange = false

func _physics_process(delta):
	deal_with_damage()
	
	
	if player_chase:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")


func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false

func slime():
	pass


func _on_enemy_range_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_inrange = true 

func _on_enemy_range_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_inrange = false
		
func deal_with_damage():
	if player_inrange and Global.player_current_attack == true:
		health = health - 20
		print ("slime = ", health)
		if health <= 0:
			self.queue_free() 
