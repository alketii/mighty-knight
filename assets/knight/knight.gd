extends KinematicBody2D


var jump_allow = false
var just_jumped = false
var jumping = false
var pressed = false

var attack_cool = true
var shield = false
var collide_right = 0
var dead = false
var jump_pressed = false

const move_speed = 9
const jump_speed = 25
const limit = 976
var vertical_speed = 0

onready var check_down = get_node("check_down")
onready var check_up = get_node("check_up")
onready var check_right = get_node("check_right")

func _ready():
	set_fixed_process(true)
	check_up.add_exception(self)
	check_down.add_exception(self)

func _fixed_process(delta):
	if dead:
		get_node("Camera2D").clear_current()
		set_pos(Vector2(-256,-256))
	else:
		if check_down.is_colliding():
			vertical_speed = 0
			jump_allow = true
		else:
			if pressed:
				vertical_speed += 0.75
			else:
				vertical_speed += 2
			
			jump_allow = false
		
		if just_jumped:
			vertical_speed = -jump_speed
			jumping = true
			just_jumped = false
		elif jumping and check_up.is_colliding():
			vertical_speed = 0
			jumping = false
		
		if check_right.is_colliding():
			collide_right += 1
		else:
			if collide_right > 0:
				collide_right = 0
		
		if collide_right >= 50 or get_pos().y > limit:
			collide_right = 0
			respawn()
		
		if pressed:
			get_node("/root/main/gui/jump/Sprites").show()
		else:
			get_node("/root/main/gui/jump/Sprites").hide()
		
		move(Vector2(move_speed, vertical_speed))


func _on_jump_button_down():
	if jump_allow:
		pressed = true
		just_jumped = true

func _on_jump_button_up():
	pressed = false


func _on_AnimationPlayer_finished():
	get_node("sprites/AnimationPlayer").play("run")


func _on_attack_button_down():
	if get_node("sprites/AnimationPlayer").get_current_animation() != "attack" and attack_cool:
		attack_cool = false
		get_node("/root/main/gui/attack").set_disabled(true)
		get_node("/root/main/gui/attack/attack_cooloff").play("cooloff")
		get_node("sprites/AnimationPlayer").play("attack")


func _on_attack_cooloff_timeout(anim=null):
	attack_cool = true
	get_node("/root/main/gui/attack").set_disabled(false)


func respawn():
	vertical_speed = 0
	set_pos(Vector2(get_pos().x,-128))
	damaged()

func damaged():
	if not shield:
		shield = true
		get_node("damaged").play("blinking")
		get_node("/root/main").remove_life()
