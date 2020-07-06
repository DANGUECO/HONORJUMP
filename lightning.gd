extends KinematicBody2D
func _physics_process(delta):
	$lightning.play()
	$AnimatedSprite.play("light")
	
