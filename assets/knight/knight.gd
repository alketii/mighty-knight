extends KinematicBody2D

var SPEED = 10
onready var check_down = get_node("check_down")
onready var check_up = get_node("check_up")
onready var check_right = get_node("check_right")
var jump_allow = false
var jumping = false
var attack_cool = true
var shield = false
var collide_right = 0
var dead = false
var jump_pressed = false

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if dead:
		get_node("Camera2D").clear_current()
		set_pos(Vector2(-256,-256))
	else:
		if check_down.is_colliding():
			jump_allow = true
		else:
			jump_allow = false
			
		if jumping:
			if get_pos().y > -128:
				move(Vector2(0,-SPEED))
			else:
				jumping = false
			
			if check_up.is_colliding():
				jumping = false
	
		else:
			move(Vector2(0,SPEED))
			
		if check_right.is_colliding():
			collide_right += 1
		else:
			if collide_right > 0:
				collide_right = 0
				
		if collide_right >= 50:
			collide_right = 0
			set_pos(Vector2(get_pos().x,-128))
			damaged()
			
		if get_pos().y > 976:
			set_pos(Vector2(get_pos().x,-256))
			damaged()
			
		move(Vector2(SPEED-1,0))
		
func _on_jump_button_down():
	if jump_allow:
		jumping = true

func _on_jump_button_up():
	jumping = false


func _on_AnimationPlayer_finished():
	get_node("sprites/AnimationPlayer").play("run")


func _on_attack_button_down():
	if get_node("sprites/AnimationPlayer").get_current_animation() != "attack" and attack_cool:
		attack_cool = false
		get_node("/root/main/gui/attack").set_disabled(true)
		get_node("attack_cooloff").start()
		get_node("sprites/AnimationPlayer").play("attack")


func _on_attack_cooloff_timeout():
	attack_cool = true
	get_node("/root/main/gui/attack").set_disabled(false)
	
func damaged():
	if not shield:
		shield = true
		get_node("damaged").start()
		set_opacity(0.4)
		get_node("/root/main").remove_life()


func _on_damaged_timeout():
	shield = false
	set_opacity(1)
