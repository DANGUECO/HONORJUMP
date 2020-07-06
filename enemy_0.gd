extends KinematicBody2D

const enemyspeed = 100
const gravity = 10
#used for sorting his movement.
var velocity = Vector2()

#if 1 and hits wall, turn to -1.
var maindirection = 1
var UP = Vector2(0,-1)
var OPPOSITEdirection = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

func _physics_process(delta):
	
	#x motion and goes rightway.
	velocity.x = enemyspeed*maindirection
	
	#We have not hit wall
	if maindirection == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	
	$AnimatedSprite.play("run")
	
	#y motion of enemy
	velocity.y+=gravity
	
	#apply the velocity to enemy.
	velocity  = move_and_slide(velocity, UP)
	
	#if we hit wall.. times by opposite direction to go backwards.
	#if raycast is colliding, change direction for both direction and raycast
	if is_on_wall():
		maindirection = maindirection * -1
		#First raycast collision is for hitting walls and bumps
		$RayCast2D.position.x = $RayCast2D.position.x * -1
		#Second is for killing the player
		
	if $RayCast2D.is_colliding() == false:
		maindirection = maindirection * -1
		$RayCast2D.position.x = $RayCast2D.position.x * -1
		

			
			
