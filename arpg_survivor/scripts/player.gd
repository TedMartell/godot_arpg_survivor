extends CharacterBody2D
@onready var general_functions = %general_functions


var movement_speed = 100.0
var is_dodging = false


func _physics_process(delta: float) -> void:
	# Handle Dodge Roll.
	if Input.is_action_just_pressed("dodge_roll") and not is_dodging:
		start_dodge_roll()
	# Move Left / Right
	var x_direction := Input.get_axis("move_left", "move_right")
	if x_direction:
		velocity.x = x_direction * movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
	# Move Up / Down
	var y_direction := Input.get_axis("move_up", "move_down")
	if y_direction:
		velocity.y = y_direction * movement_speed
	else:
		velocity.y = move_toward(velocity.y, 0, movement_speed)
	move_and_slide()


# Dodge Roll mechanic
func start_dodge_roll() -> void:
	is_dodging = true
	movement_speed *=2
	await general_functions.wait_x_seconds(2.0)
	movement_speed /=2
	is_dodging = false
	
	
