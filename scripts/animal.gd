extends KinematicBody

var max_health = 100
var current_health = max_health
var atk = 30
var speed = 10
var jump_force = 200
var gravity = -10
var direction = Vector3()
var velocity = Vector3()
var ACCEL = 5
var DEACCEL = 6
var is_moving: bool
var resource = preload("res://scenes/animals/snake.tscn")

var mesh
var raycast
var animation_player
onready var shape = $shape
onready var health_bar = $HealthBar3D/Viewport/HealthBar2D

var attack_ani
var move_ani
var idle_ani
var jump_ani

func _ready():
	#punch.hide()
	# instantiate a character
	add_character()
	setup_variables()
	
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()
		
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func _physics_process(delta):
	walk(delta)
	pass

func _input(event):
	if event.is_action_pressed("attack"):
		attack()

func setup_variables():
	mesh = get_tree().get_root().get_node("world/animal/body")
	raycast = get_tree().get_root().get_node("world/animal/body/RayCast")
	animation_player = get_tree().get_root().get_node("world/animal/body/AnimationPlayer")
	animation_player.connect("animation_finished",self,"attack_done")
	
	match Game.character:
		"snake":
			attack_ani = "SnakeArmature|Snake_Attack"
			move_ani = "SnakeArmature|Snake_Walk"
			idle_ani = "SnakeArmature|Snake_Idle"
			jump_ani = "SnakeArmature|Snake_Jump"
		"wasp":
			attack_ani = "Armature|Wasp_Attack"
			move_ani = "Armature|Wasp_Flying"
			idle_ani = "Armature|Wasp_Flying"
			jump_ani = "Armature|Wasp_Flying"
		"frog":
			attack_ani = "Armature|Frog_Attack"
			move_ani = "Armature|Frog_Jump"
			idle_ani = "Armature|Frog_Idle"
			jump_ani = "Armature|Frog_Jump"
		"rat":
			attack_ani = "Armature|Rat_Attack"
			move_ani = "Armature|Rat_Walk"
			idle_ani = "Armature|Rat_Idle"
			jump_ani = "Armature|Rat_Jump"

func add_character():
	match Game.character:
		"snake":
			resource = preload("res://scenes/animals/snake.tscn")
			shape.rotation_degrees.x = 90
			shape.translation = Vector3(0,1.701,0.105)
			shape.scale = Vector3(0.6,1.35,1.1)
			$HealthBar3D.translation = Vector3(0,3.426,0)
		"wasp":
			resource = preload("res://scenes/animals/wasp.tscn")
			shape.rotation_degrees.x = 90
			shape.translation = Vector3(0.583,2.083,0)
			shape.scale = Vector3(1.2,0.6,0.92)
			$HealthBar3D.translation = Vector3(0,4.203,0)
		"frog":
			resource = preload("res://scenes/animals/frog.tscn")
			shape.translation = Vector3(0,0.752,0.128)
			shape.scale = Vector3(1.2,0.7,1.1)
			$HealthBar3D.translation = Vector3(0,3.012,0)
		"rat":
			resource = preload("res://scenes/animals/rat.tscn")
			shape.translation = Vector3(0,1.061,-0.016)
			shape.scale = Vector3(0.8,1.2,1.4)
			$HealthBar3D.translation = Vector3(0,3.048,0)
	
	var body = resource.instance()
	body.name = "body"
	self.add_child(body)
	
	pass

func walk(delta):
	if animation_player.is_playing() and animation_player.current_animation == attack_ani:
		return
	direction = Vector3()
	var temp_velocity = Vector3()
	if Input.is_action_pressed("walk_down"):
		direction.x -= 1
	if Input.is_action_pressed("walk_up"):
		direction.x += 1
	if Input.is_action_pressed("walk_left"):
		direction.z -= 1
	if Input.is_action_pressed("walk_right"):
		direction.z += 1
	direction = direction.normalized()
	if direction != Vector3():
		is_moving = true
	else:
		is_moving = false
	temp_velocity = velocity
	
	if is_moving:
		if direction.y > 0:
			animation_player.play(jump_ani)
		else:
			animation_player.play(move_ani)
		var angle = atan2(-direction.z,direction.x) + deg2rad(90)
		var char_rot = mesh.get_rotation()
		if Game.character != "wasp":
			char_rot.y = angle 
		else:
			print(2)
			char_rot.y = angle - deg2rad(90)
		mesh.set_rotation(char_rot)
		shape.set_rotation(char_rot)
	else:
		animation_player.play(idle_ani)
		
	velocity = speed * direction
	velocity.y = temp_velocity.y + gravity
	var acceleration
	if direction.dot(temp_velocity) >0:
		acceleration = ACCEL
	else:
		acceleration = DEACCEL
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	temp_velocity = temp_velocity.linear_interpolate(velocity,acceleration*delta)
	
	velocity = temp_velocity
	velocity = move_and_slide(velocity,Vector3.UP)

func attack():
	if animation_player.is_playing() and animation_player.current_animation == attack_ani:
		return
		
	animation_player.play(attack_ani)
	var collided_body = raycast.get_collider()
	if collided_body and collided_body.is_in_group("living"):
		collided_body.health_decrease(atk)
	pass

func health_decrease(damage):
	current_health -= damage
	if current_health <= 0:
		print(self.name," die")
		queue_free()
	if current_health > 0:
		health_bar.update_bar(current_health,max_health)
		print(self.name,": ",current_health)
