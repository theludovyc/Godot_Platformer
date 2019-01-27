extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const GRAVITY=300.0
const JUMP=138.0

var velocity=Vector2()

var jumping=false
var running=false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x=-100
		$Anim.flip_h=true
		if !jumping and !running:
			$Anim.animation="run"
			$Anim.play()
			running=true
	elif Input.is_action_pressed("ui_right"):
		velocity.x=100
		$Anim.flip_h=false
		if !jumping and !running:
			$Anim.animation="run"
			$Anim.play()
			running=true
	else:
		velocity.x=0
		if !jumping and running:
			$Anim.animation="idle"
			$Anim.stop()
			running=false

	if is_on_floor():
		if jumping:
			velocity.y=0
			if running:
				$Anim.animation="run"
			else:
				$Anim.animation="idle"
			jumping=false
		elif Input.is_action_pressed("ui_up"):
			velocity.y=-JUMP
			jumping=true
			$Anim.animation="jump"
	else:
		velocity.y+=GRAVITY*delta

	move_and_slide(velocity, Vector2(0, -1))
	pass