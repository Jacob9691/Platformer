extends CharacterBody2D

# Movement variables
@export var speed = 200
@export var jump_force = -400
@export var gravity = 800
@export var dash_speed = 600
@export var dash_time = 0.2

# State variables
var is_dashing = false
var dash_timer = 0.0

func _ready():
	pass

func _physics_process(delta):
	if not is_dashing:
		handle_gravity(delta)
		handle_movement()
		handle_jump()
	else:
		handle_dash(delta)

	move_and_slide()

func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_movement():
	var input_direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = input_direction * speed

func handle_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

func handle_dash(delta):
	dash_timer -= delta
	if dash_timer <= 0:
		is_dashing = false
		return

	# Maintain dash velocity during the dash period
	velocity.y = 0  # No gravity during dash

func start_dash(direction):
	is_dashing = true
	dash_timer = dash_time
	velocity.x = direction * dash_speed

func _input(event):
	if event.is_action_pressed("dash") and not is_dashing:
		var direction = sign(Input.get_axis("ui_left", "ui_right"))
		if direction != 0:
			start_dash(direction)
