extends CharacterBody3D


const SPEED = 8.0
const JUMP_VELOCITY = 12


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if Input.is_action_just_pressed("cam_left"):
		$control_camara.rotate_y(rad_to_deg(-23.55))
	if Input.is_action_just_pressed("cam_right"):
		$control_camara.rotate_y(rad_to_deg(23.55))
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction: Vector3 = ($control_camara.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	$control_camara.position=lerp($control_camara.position,position,0.15)


func _on_death_zone_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://nivel_1.tscn")
	print('moriste vuelve a empezar')
