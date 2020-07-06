extends KinematicBody2D

#NOTE: ROGUE has some collision errors.

var score : int= 0
var speed : int=300
var jumpforce : int=-500
var gravity : int=800
var on_ground = false
var is_attacking = false

func _ready():
	set_physics_process(true)
	set_process(true)
	
func _process(delta):
	#---------Score counter------------
	var labelnode = get_parent().get_parent().get_node("MainScene/UI/Control/RichTextLabel")
	labelnode.text= str(score)
	labelnode.add_text(" Coin(s) Collected For Milady")
	labelnode.newline()
	labelnode.add_text("Collect all 14 coins for Milady")
	if score == 14:
		labelnode.newline()
		labelnode.add_text("You have collected enough coins! Milady will be very pleased.")
		labelnode.newline()
		labelnode.add_text("1. press [enter] to replay level")
		labelnode.newline()
		labelnode.add_text("2. Or goto flag to reach next level.")
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene()
	#----------------------------------
	
#how many pixels moving per second
#datatype that holds 2 values.
var vel : Vector2 = Vector2()
#variable that stores sprite node
#get child node of playerrogue
#Onready - when initialized this var will find node rogue.
onready var rogue : AnimatedSprite = get_node("goldknight")
#This function implements player mobility.
#Gets called 60 times a second.
func _physics_process(delta):
	
	#gravity. y vel.
	#Since delta is time duration per frame.
	#This will convert to pixel per seconds, 
	#rather than pixels per frame.
	vel.y+=gravity*delta
	
	vel.x=0
	
	#if Input.is_action_pressed('jump') and Input.is_action_pressed("move_right"):
		#$jump.play()	
	#built in function on_floor()
	if is_on_floor():
		on_ground=true
		is_attacking=true
		if Input.is_action_just_pressed('jump'):	
			$jump.play()		
			vel.y=jumpforce
			#Breath it in.
			$dreambreath.play()
	#Code below checks everytime you are in the air.	
	# jump at apex = high neg, that drops to zero.	
	else:
		on_ground=false
		is_attacking=false
		if vel.y < 0:
			$goldknight.play("jump")
		else:
			$goldknight.play("idle")
			
	
	if Input.is_action_pressed("move_left"):		
		vel.x -= speed
		rogue.flip_h = true
		#accounts for combination of left/right and jump.
		if on_ground == true:
			$goldknight.play("run")
		
		
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		rogue.flip_h = false
		if on_ground == true:
			$goldknight.play("run")
		
	
	#If actions is released, go back to idling.	
	if Input.is_action_just_released("move_left"):
		$goldknight.play("idle")
		$dreambreath.stop()
		#$running.stop()
	if Input.is_action_just_released("move_right"):
		$goldknight.play("idle")
		$dreambreath.stop()
		#$running.stop()
		
	#-----Attack mode
		#attack 1 - left click
	if Input.is_action_just_pressed('attack1'):
		$goldknight.play("attack")
		$swordslash.play()
		#jump attack
		if Input.is_action_just_pressed('jump') and Input.is_action_just_pressed('attack1'):
			$goldknight.play("attack")
			$swordslash.play()
	#when relasing attack go idle.
	if Input.is_action_just_released("attack1"):
		$goldknight.play("idle")
		$swordslash.stop()
	#---------------
	

	#now apply the velocity to player.
	vel = move_and_slide(vel,Vector2.UP)
	
	

#--------Music
#when player hits coin. play pickup sound.
func _on_Coin_0_body_entered(body):
	var musicnode = $coin
	musicnode.play()
	#musicnode.set_loop(false)
	score+=1
	print(score)
	
#----------



