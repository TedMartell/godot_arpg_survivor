extends CharacterBody2D
@onready var general_functions = %general_functions
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D

var movement_speed = 10.0
var is_dodging = false
var is_meele_attacking = false
var is_ranged_attacking = false
var action = "idle"
var direction = "front"

func _process(_delta: float) -> void:
	player_sprite.play(action + "_" + direction)

func _physics_process(_delta: float) -> void:
	var x_direction := Input.get_axis("move_left", "move_right")
	var y_direction := Input.get_axis("move_up", "move_down")

	# Flip sprite horizontally
	if x_direction > 0:
		player_sprite.flip_h = false
	elif x_direction < 0:
		player_sprite.flip_h = true

	# Movement
	velocity.x = x_direction * movement_speed if x_direction else move_toward(velocity.x, 0, movement_speed)
	velocity.y = y_direction * movement_speed if y_direction else move_toward(velocity.y, 0, movement_speed)

	move_and_slide()

	# Animation logic
	if is_dodging:
		action = "dodge"
		direction = "roll"
	else:
		if is_meele_attacking:
			action = "attack"
			direction = "meele"
		else:
			if x_direction != 0 or y_direction != 0:
				action = "run"
			else:
				action = "idle"

			if y_direction > 0:
				direction = "down"
			elif y_direction < 0:
				direction = "up"
			elif x_direction != 0:
				direction = "side"
			else:
				direction = "front"

	# Dodge trigger
	if Input.is_action_just_pressed("dodge_roll") and not is_dodging:
		_start_dodge_roll()
	# Meele Attack trigger
	if Input.is_action_just_pressed("meele_attack") and not is_meele_attacking:
		_start_meele_attack()
	
		
	move_and_slide()
	
# Dodge Roll mechanic
func _start_dodge_roll() -> void:
	is_dodging = true
	movement_speed *= 2
	await general_functions.wait(0.5)
	movement_speed /= 2
	is_dodging = false

# Meele Attack mechanic
func _start_meele_attack() -> void:
	is_meele_attacking = true
	await general_functions.wait(0.5)
	is_meele_attacking = false
	
#Ranged attack Mechanic
func _start_ranged_attack() -> void:
	is_ranged_attacking = true
	await general_functions.wait(0.5)
	is_ranged_attacking = false
	
