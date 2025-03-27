extends CharacterBody2D

# Movement variables
@export var speed = 400
@export var jump_force = -600
@export var gravity = 1250
@export var dash_speed = 800
@export var dash_time = 0.2

# State variables
var is_dashing = false
var dash_timer = 0.0
var can_dash = true
var dash_direction = Vector2.ZERO
var is_dead = false

# Load scenes
var Trail = preload("res://Scenes/DashLine.tscn")
var death_particles = preload("res://Scenes/death_particles.tscn")

func _ready():
	pass

func _physics_process(delta):
	if is_dead:
		return
	
	if not is_dashing:
		handle_gravity(delta)
		handle_movement()
		handle_jump()
	else:
		handle_dash(delta)
	
	move_and_slide()
	play_animation()
	
	if is_on_floor():
		can_dash = true

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
		velocity = Vector2.ZERO
		return
	
	# Maintain dash velocity during the dash period
	velocity = dash_direction * dash_speed  # No gravity during dash
	
	var trail = Trail.instantiate()
	add_child(trail)
	trail.modulate = Color(0.43, 0.25, 0.67, 1)

func start_dash(direction):
	if can_dash:
		is_dashing = true
		dash_timer = dash_time
		can_dash = false
		
		dash_direction = direction
		velocity = dash_direction * dash_speed

func _input(event):
	if event.is_action_pressed("dash") and not is_dashing:
		var direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
		if direction != Vector2.ZERO:
			start_dash(direction.normalized())

func play_animation():
	if Input.is_action_pressed("ui_right"):
		%PlayerAnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		%PlayerAnimatedSprite.flip_h = true
	
	if is_on_floor():
		if is_dashing:
			%PlayerAnimatedSprite.play("slide")
		elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
			%PlayerAnimatedSprite.play("idle")
		elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
			%PlayerAnimatedSprite.play("running")
		elif Input.is_action_pressed("ui_down"):
			%PlayerAnimatedSprite.play("crouching")
		else:
			%PlayerAnimatedSprite.play("idle")
	else:
		if velocity.y < 0:
			%PlayerAnimatedSprite.play("jump")
		elif velocity.y > 0:
			%PlayerAnimatedSprite.play("falling")
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		%PlayerAnimatedSprite.play("jump")

func die():
	is_dead = true
	var death = death_particles.instantiate()
	death.position = position
	death.emitting = true
	get_parent().add_child(death)
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()

func _on_hit_box_body_entered(_body) -> void:
	die()
