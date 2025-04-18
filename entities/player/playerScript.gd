extends CharacterBody2D

class_name PlatformerController2D

@export var README: String = "IMPORTANT: MAKE SURE TO ASSIGN 'left' 'right' 'jump' 'dash' 'up' 'down' in the project settings input map. Usage tips. 1. Hover over each toggle and variable to read what it does and to make sure nothing bugs. 2. Animations are very primitive. To make full use of your custom art, you may want to slightly change the code for the animations"
#INFO READEME 
#IMPORTANT: MAKE SURE TO ASSIGN 'left' 'right' 'jump' 'dash' 'up' 'down' in the project settings input map. THIS IS REQUIRED
#Usage tips. 
#1. Hover over each toggle and variable to read what it does and to make sure nothing bugs. 
#2. Animations are very primitive. To make full use of your custom art, you may want to slightly change the code for the animations

@export_category("Necesary Child Nodes")
@export var PlayerSprite: AnimatedSprite2D
@export var PlayerCollider: CollisionShape2D
@onready var collision_shape_2d: CollisionShape2D = $hitArea/CollisionShape2D

#audio effect
@onready var dash_sound: AudioStreamPlayer = $"../sounds_effect/dash_sound"
@onready var attack_sound: AudioStreamPlayer = $"../sounds_effect/attack_sound"
@onready var impact_attack: AudioStreamPlayer = $"../sounds_effect/impact_attack"
@onready var jump_sound: AudioStreamPlayer = $"../sounds_effect/jump_sound"
@onready var run_sound: AudioStreamPlayer = $"../sounds_effect/run_sound"
@onready var wall_jump_sound: AudioStreamPlayer = $"../sounds_effect/wallJump_sound"
@onready var land_sound: AudioStreamPlayer = $"../sounds_effect/land_sound"
@onready var getting_hit_sound: AudioStreamPlayer = $"../sounds_effect/gettingHit_sound"
@onready var shield_block_sound: AudioStreamPlayer = $"../sounds_effect/shieldBlock_sound"



#INFO HORIZONTAL MOVEMENT 
@export_category("L/R Movement")
##The max speed your player will move
@export_range(50, 500) var maxSpeed: float = 200.0
##How fast your player will reach max speed from rest (in seconds)
@export_range(0, 4) var timeToReachMaxSpeed: float = 0.2
##How fast your player will reach zero speed from max speed (in seconds)
@export_range(0, 4) var timeToReachZeroSpeed: float = 0.2
##If true, player will instantly move and switch directions. Overrides the "timeToReach" variables, setting them to 0.
@export var directionalSnap: bool = false
##If enabled, the default movement speed will by 1/2 of the maxSpeed and the player must hold a "run" button to accelerate to max speed. Assign "run" (case sensitive) in the project input settings.
@export var runningModifier: bool = false

#INFO JUMPING 
@export_category("Jumping and Gravity")
##The peak height of your player's jump
@export_range(0, 20) var jumpHeight: float = 2.0
##How many jumps your character can do before needing to touch the ground again. Giving more than 1 jump disables jump buffering and coyote time.
@export_range(0, 4) var jumps: int = 1
##The strength at which your character will be pulled to the ground.
@export_range(0, 100) var gravityScale: float = 20.0
##The fastest your player can fall
@export_range(0, 1000) var terminalVelocity: float = 500.0
##Your player will move this amount faster when falling providing a less floaty jump curve.
@export_range(0.5, 3) var descendingGravityFactor: float = 1.3
##Enabling this toggle makes it so that when the player releases the jump key while still ascending, their vertical velocity will cut in half, providing variable jump height.
@export var shortHopAkaVariableJumpHeight: bool = true
##How much extra time (in seconds) your player will be given to jump after falling off an edge. This is set to 0.2 seconds by default.
@export_range(0, 0.5) var coyoteTime: float = 0.2
##The window of time (in seconds) that your player can press the jump button before hitting the ground and still have their input registered as a jump. This is set to 0.2 seconds by default.
@export_range(0, 0.5) var jumpBuffering: float = 0.2

#INFO EXTRAS
@export_category("Wall Jumping")
##Allows your player to jump off of walls. Without a Wall Kick Angle, the player will be able to scale the wall.
@export var wallJump: bool = false
##How long the player's movement input will be ignored after wall jumping.
@export_range(0, 0.5) var inputPauseAfterWallJump: float = 0.1
##The angle at which your player will jump away from the wall. 0 is straight away from the wall, 90 is straight up. Does not account for gravity
@export_range(0, 90) var wallKickAngle: float = 60.0
##The player's gravity will be divided by this number when touch a wall and descending. Set to 1 by default meaning no change will be made to the gravity and there is effectively no wall sliding. THIS IS OVERRIDDED BY WALL LATCH.
@export_range(1, 20) var wallSliding: float = 1.0
##If enabled, the player's gravity will be set to 0 when touching a wall and descending. THIS WILL OVERRIDE WALLSLIDING.
@export var wallLatching: bool = false
##wall latching must be enabled for this to work. #If enabled, the player must hold down the "latch" key to wall latch. Assign "latch" in the project input settings. The player's input will be ignored when latching.
@export var wallLatchingModifer: bool = false
@export_category("Dashing")
##The type of dashes the player can do.
@export_enum("None", "Horizontal", "Vertical", "Four Way", "Eight Way") var dashType: int
##How many dashes your player can do before needing to hit the ground.
@export_range(0, 10) var dashes: int = 1
##If enabled, pressing the opposite direction of a dash, during a dash, will zero the player's velocity.
@export var dashCancel: bool = true
##How far the player will dash. One of the dashing toggles must be on for this to be used.
@export_range(1.5, 4) var dashLength: float = 2.5
@export_category("Corner Cutting/Jump Correct")
##If the player's head is blocked by a jump but only by a little, the player will be nudged in the right direction and their jump will execute as intended. NEEDS RAYCASTS TO BE ATTACHED TO THE PLAYER NODE. AND ASSIGNED TO MOUNTING RAYCAST. DISTANCE OF MOUNTING DETERMINED BY PLACEMENT OF RAYCAST.
@export var cornerCutting: bool = false
##How many pixels the player will be pushed (per frame) if corner cutting is needed to correct a jump.
@export_range(1, 5) var correctionAmount: float = 1.5
##Raycast used for corner cutting calculations. Place above and to the left of the players head point up. ALL ARE NEEDED FOR IT TO WORK.
@export var leftRaycast: RayCast2D
##Raycast used for corner cutting calculations. Place above of the players head point up. ALL ARE NEEDED FOR IT TO WORK.
@export var middleRaycast: RayCast2D
##Raycast used for corner cutting calculations. Place above and to the right of the players head point up. ALL ARE NEEDED FOR IT TO WORK.
@export var rightRaycast: RayCast2D
@export_category("Down Input")
##Holding down will crouch the player. Crouching script may need to be changed depending on how your player's size proportions are. It is built for 32x player's sprites.
@export var crouch: bool = false
##Holding down and pressing the input for "roll" will execute a roll if the player is grounded. Assign a "roll" input in project settings input.
@export var canRoll: bool
@export_range(1.25, 2) var rollLength: float = 2
##If enabled, the player will stop all horizontal movement midair, wait (groundPoundPause) seconds, and then slam down into the ground when down is pressed. 
@export var groundPound: bool
##The amount of time the player will hover in the air before completing a ground pound (in seconds)
@export_range(0.05, 0.75) var groundPoundPause: float = 0.25
##If enabled, pressing up will end the ground pound early
@export var upToCancel: bool = false

@export_category("Animations (Check Box if has animation)")
##Animations must be named "run" all lowercase as the check box says
@export var run: bool
##Animations must be named "jump" all lowercase as the check box says
@export var jump: bool
##Animations must be named "idle" all lowercase as the check box says
@export var idle: bool
##Animations must be named "walk" all lowercase as the check box says
@export var walk: bool
##Animations must be named "slide" all lowercase as the check box says
@export var slide: bool
##Animations must be named "latch" all lowercase as the check box says
@export var latch: bool
##Animations must be named "falling" all lowercase as the check box says
@export var falling: bool
##Animations must be named "crouch_idle" all lowercase as the check box says
@export var crouch_idle: bool
##Animations must be named "crouch_walk" all lowercase as the check box says
@export var crouch_walk: bool
##Animations must be named "roll" all lowercase as the check box says
@export var roll: bool

@export_category("statistics player")
@export var lives: int = 10
@onready var time_between_dash_object: Timer = $time_between_dash
var dash_available = true
@export_category("particles")
@export var jump_particles: PackedScene
@export var broken_heart_particles: PackedScene
@export var run_particles: PackedScene
@export var hit1_enemy_particles: PackedScene
var count_leaf: float = 0
@export var getting_hit_particles: PackedScene
@export var hit_explode_particles: PackedScene
@export var hit_enemy_explode2: PackedScene
@export var shield_particles: PackedScene

var gettingHit: bool = false
var shield_block: bool = false
var instantiated_rain



#Variables determined by the developer set ones.
var appliedGravity: float
var maxSpeedLock: float
var appliedTerminalVelocity: float

var friction: float
var acceleration: float
var deceleration: float
var instantAccel: bool = false
var instantStop: bool = false

var jumpMagnitude: float = 500.0
var jumpCount: int
var jumpWasPressed: bool = false
var coyoteActive: bool = false
var dashMagnitude: float
var gravityActive: bool = true
var dashing: bool = false
var dashCount: int
var rolling: bool = false

var twoWayDashHorizontal
var twoWayDashVertical
var eightWayDash

var wasMovingR: bool
var wasPressingR: bool
var movementInputMonitoring: Vector2 = Vector2(true, true) #movementInputMonitoring.x addresses right direction while .y addresses left direction

var gdelta: float = 1

var dset = false

var colliderScaleLockY
var colliderPosLockY

var latched
var wasLatched
var crouching
var groundPounding

var anim
var col
var animScaleLock : Vector2

#Input Variables for the whole script
var upHold
var downHold
var leftHold
var leftTap
var leftRelease
var rightHold
var rightTap
var rightRelease
var jumpTap
var jumpRelease
var runHold
var latchHold
var dashTap
var rollTap
var downTap
var twirlTap
var shieldHold
var shieldRelease

#attack variable
var attackBuss = 0
var on_Attack = false

var death = false

#defense variable

var on_defense: bool = false

#camara
@onready var cam = $Camera2D

func _ready():
	wasMovingR = true
	anim = PlayerSprite
	col = PlayerCollider
	collision_shape_2d.disabled = true
	
	_updateData()
	
func _updateData():
	acceleration = maxSpeed / timeToReachMaxSpeed
	deceleration = -maxSpeed / timeToReachZeroSpeed
	
	jumpMagnitude = (10.0 * jumpHeight) * gravityScale
	jumpCount = jumps
	
	dashMagnitude = maxSpeed * dashLength
	dashCount = dashes
	
	maxSpeedLock = maxSpeed
	
	animScaleLock = abs(anim.scale)
	colliderScaleLockY = col.scale.y
	colliderPosLockY = col.position.y
	
	if timeToReachMaxSpeed == 0:
		instantAccel = true
		timeToReachMaxSpeed = 1
	elif timeToReachMaxSpeed < 0:
		timeToReachMaxSpeed = abs(timeToReachMaxSpeed)
		instantAccel = false
	else:
		instantAccel = false
		
	if timeToReachZeroSpeed == 0:
		instantStop = true
		timeToReachZeroSpeed = 1
	elif timeToReachMaxSpeed < 0:
		timeToReachMaxSpeed = abs(timeToReachMaxSpeed)
		instantStop = false
	else:
		instantStop = false
		
	if jumps > 1:
		jumpBuffering = 0
		coyoteTime = 0
	
	coyoteTime = abs(coyoteTime)
	jumpBuffering = abs(jumpBuffering)
	
	if directionalSnap:
		instantAccel = true
		instantStop = true
	
	
	twoWayDashHorizontal = false
	twoWayDashVertical = false
	eightWayDash = false
	if dashType == 0:
		pass
	if dashType == 1:
		twoWayDashHorizontal = true
	elif dashType == 2:
		twoWayDashVertical = true
	elif dashType == 3:
		twoWayDashHorizontal = true
		twoWayDashVertical = true
	elif dashType == 4:
		eightWayDash = true
	
	

func _process(_delta):
	
	gettingHitAnimation()
	
	shieldBlockParticles()
	
	deathFunction()
	#INFO animations
	#directions
	if is_on_wall() and !is_on_floor() and latch and wallLatching and ((wallLatchingModifer and latchHold) or !wallLatchingModifer):
		latched = true
	else:
		latched = false
		wasLatched = true
		_setLatch(0.2, false)

	if rightHold and !latched:
		anim.scale.x = animScaleLock.x
	if leftHold and !latched:
		anim.scale.x = animScaleLock.x * -1
		
	#attack
	attack_procesor()
	
		
	#death
	if death and is_on_floor():
		var deathCount = 0
		movementInputMonitoring = Vector2(false, false)
		jump = false
		idle = false
		if deathCount == 0:
			anim.play("death")
			await get_tree().create_timer(1).timeout
			deathCount = 1
			
		if deathCount == 1:
			anim.play("on_death")
	
	#run
	if run and idle and !dashing and !crouching and not death and not on_Attack:
		if abs(velocity.x) > 13 and is_on_floor() and !is_on_wall() and not on_defense:
			anim.speed_scale = abs(velocity.x / 150)
			anim.play("run")
		elif abs(velocity.x) < 13 and is_on_floor() and not on_Attack and not on_defense:
			anim.speed_scale = 1
			anim.play("idle")
	elif run and idle and walk and !dashing and !crouching:
		if abs(velocity.x) > 13 and is_on_floor() and !is_on_wall() and not on_Attack:
			anim.speed_scale = abs(velocity.x / 150)
			if abs(velocity.x) < (maxSpeedLock):
				anim.play("walk")
			else:
				anim.play("run")
		elif abs(velocity.x) < 13 and is_on_floor():
			anim.speed_scale = 1
			anim.play("idle")
		
	#jump
	if velocity.y < 0 and jump and !dashing and not death and not on_Attack:
		anim.speed_scale = 1
		anim.play("jump")
		
	if velocity.y > 40 and falling and !dashing and !crouching and not death and not on_Attack:
		anim.speed_scale = 1
		anim.play("falling")
	
	#shield
	if shieldHold and not death and not on_Attack and velocity.y == 0:
		on_defense = true
		anim.speed_scale = 1
		anim.play("defend")
	
	if shieldRelease:
		on_defense = false
	
		
	if slide and not on_Attack:
		#wall slide and latch
		if latched and !wasLatched:
			anim.speed_scale = 1
			anim.play("latch")
		if is_on_wall() and velocity.y > 0 and slide and anim.animation != "slide" and wallSliding != 1:
			anim.speed_scale = 1
			anim.play("slide")
			
		#dash
		if dashing:
			anim.speed_scale = 1
			anim.play("dash")
			
		#crouch
		if crouching and !rolling:
			if abs(velocity.x) > 10:
				anim.speed_scale = 1
				anim.play("crouch_walk")
			else:
				anim.speed_scale = 1
				anim.play("crouch_idle")
		
		if rollTap and canRoll and roll:
			anim.speed_scale = 1
			anim.play("roll")
		
		

func _physics_process(delta):
	if !dset:
		gdelta = delta
		dset = true
	#INFO Input Detectio. Define your inputs from the project settings here.
	leftHold = Input.is_action_pressed("left")
	rightHold = Input.is_action_pressed("right")
	upHold = Input.is_action_pressed("up")
	downHold = Input.is_action_pressed("down")
	leftTap = Input.is_action_just_pressed("left")
	rightTap = Input.is_action_just_pressed("right")
	leftRelease = Input.is_action_just_released("left")
	rightRelease = Input.is_action_just_released("right")
	jumpTap = Input.is_action_just_pressed("jump")
	jumpRelease = Input.is_action_just_released("jump")
	runHold = Input.is_action_pressed("run")
	latchHold = Input.is_action_pressed("latch")
	dashTap = Input.is_action_just_pressed("dash")
	rollTap = Input.is_action_just_pressed("roll")
	downTap = Input.is_action_just_pressed("down")
	twirlTap = Input.is_action_just_pressed("twirl")
	shieldHold = Input.is_action_just_pressed("shield")
	shieldRelease = Input.is_action_just_released("shield")
	
	
	#INFO run particles
	if run_particles:
		count_leaf += 1 * delta
		if is_on_floor() and (velocity.x > 13 or velocity.x < -13) and count_leaf > 0.05 and not is_on_wall():
			var instantiated_run_particles = run_particles.instantiate()
			add_child(instantiated_run_particles)
			instantiated_run_particles.global_position = global_position + Vector2(0, 20)
			instantiated_run_particles.emitting = true
			count_leaf = 0
		else:
			pass
	else:
		pass
	#INFO Left and Right Movement
	
	if rightHold and leftHold and movementInputMonitoring and not death:
		if !instantStop:
			_decelerate(delta, false)
		else:
			velocity.x = -0.1
	elif rightHold and movementInputMonitoring.x and not on_defense:
		if velocity.x > maxSpeed or instantAccel:
			velocity.x = maxSpeed
		else:
			velocity.x += acceleration * delta
		if velocity.x < 0:
			if !instantStop:
				_decelerate(delta, false)
			else:
				velocity.x = -0.1
	elif leftHold and movementInputMonitoring.y and not on_defense:
		if velocity.x < -maxSpeed or instantAccel:
			velocity.x = -maxSpeed
		else:
			velocity.x -= acceleration * delta
		if velocity.x > 0:
			if !instantStop:
				_decelerate(delta, false)
			else:
				velocity.x = 0.1
	
	if velocity.x > 0:
		wasMovingR = true
	elif velocity.x < 0:
		wasMovingR = false
	if rightTap:
		wasPressingR = true
	if leftTap:
		wasPressingR = false
	
	if runningModifier and !runHold:
		maxSpeed = maxSpeedLock / 2
	elif is_on_floor(): 
		maxSpeed = maxSpeedLock
	
	if !(leftHold or rightHold) or on_defense:
		if !instantStop:
			_decelerate(delta, false)
		else:
			velocity.x = 0
			
	#INFO Crouching
	if crouch:
		if downHold and is_on_floor():
			crouching = true
		elif !downHold and ((runHold and runningModifier) or !runningModifier) and !rolling:
			crouching = false
			
	if !is_on_floor():
		crouching = false
			
	if crouching:
		maxSpeed = maxSpeedLock / 2
		col.scale.y = colliderScaleLockY / 2
		col.position.y = colliderPosLockY + (8 * colliderScaleLockY)
	else:
		maxSpeed = maxSpeedLock
		col.scale.y = colliderScaleLockY
		col.position.y = colliderPosLockY
		
	#INFO Rolling
	if canRoll and is_on_floor() and rollTap and crouching:
		_rollingTime(0.75)
		if wasPressingR and !(upHold):
			velocity.y = 0
			velocity.x = maxSpeedLock * rollLength
			dashCount += -1
			movementInputMonitoring = Vector2(false, false)
			_inputPauseReset(rollLength * 0.0625)
		elif !(upHold):
			velocity.y = 0
			velocity.x = -maxSpeedLock * rollLength
			dashCount += -1
			movementInputMonitoring = Vector2(false, false)
			_inputPauseReset(rollLength * 0.0625)
		
	if canRoll and rolling:
		#if you want your player to become immune or do something else while rolling, add that here.
		pass
			
	#INFO Jump and Gravity
	if velocity.y > 0:
		appliedGravity = gravityScale * descendingGravityFactor
	else:
		appliedGravity = gravityScale
	
	if is_on_wall() and !groundPounding:
		appliedTerminalVelocity = terminalVelocity / wallSliding
		if wallLatching and ((wallLatchingModifer and latchHold) or !wallLatchingModifer):
			appliedGravity = 0
			
			if velocity.y < 0:
				velocity.y += 50
			if velocity.y > 0:
				velocity.y = 0
				
			if wallLatchingModifer and latchHold and movementInputMonitoring == Vector2(true, true):
				velocity.x = 0
			
		elif wallSliding != 1 and velocity.y > 0:
			appliedGravity = appliedGravity / wallSliding
	elif !is_on_wall() and !groundPounding:
		appliedTerminalVelocity = terminalVelocity
	
	if gravityActive:
		if velocity.y < appliedTerminalVelocity:
			velocity.y += appliedGravity
		elif velocity.y > appliedTerminalVelocity:
				velocity.y = appliedTerminalVelocity
		
	if shortHopAkaVariableJumpHeight and jumpRelease and velocity.y < 0:
		velocity.y = velocity.y / 2
	
	if jumps == 1:
		if !is_on_floor() and !is_on_wall():
			if coyoteTime > 0:
				coyoteActive = true
				_coyoteTime()
				
		if jumpTap and !is_on_wall():
			if coyoteActive:
				coyoteActive = false
				_jump()
			if jumpBuffering > 0:
				jumpWasPressed = true
				_bufferJump()
			elif jumpBuffering == 0 and coyoteTime == 0 and is_on_floor():
				_jump()	
		elif jumpTap and is_on_wall() and !is_on_floor():
			if wallJump and !latched:
				_wallJump()
			elif wallJump and latched:
				_wallJump()
		elif jumpTap and is_on_floor():
			_jump()
		
		
			
		if is_on_floor():
			jumpCount = jumps
			coyoteActive = true
			if jumpWasPressed:
				_jump()

	elif jumps > 1:
		if is_on_floor():
			jumpCount = jumps
		if jumpTap and jumpCount > 0 and !is_on_wall():
			velocity.y = -jumpMagnitude
			jumpCount = jumpCount - 1
			_endGroundPound()
		elif jumpTap and is_on_wall() and wallJump:
			_wallJump()
			
			
	#INFO dashing
	if is_on_floor() or is_on_wall():
		dashCount = dashes
	if eightWayDash and dashTap and dashCount > 0 and !rolling:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		var dTime = 0.0625 * dashLength
		_dashingTime(dTime)
		_pauseGravity(dTime)
		velocity = dashMagnitude * input_direction
		dashCount += -1
		movementInputMonitoring = Vector2(false, false)
		_inputPauseReset(dTime)
		
	if twoWayDashVertical and dashTap and dashCount > 0 and !rolling:
		var dTime = 0.0625 * dashLength
		if upHold and downHold:
			_placeHolder()
		elif upHold:
			_dashingTime(dTime)
			_pauseGravity(dTime)
			velocity.x = 0
			velocity.y = -dashMagnitude
			dashCount += -1
			movementInputMonitoring = Vector2(false, false)
			_inputPauseReset(dTime)
		elif downHold and dashCount > 0:
			_dashingTime(dTime)
			_pauseGravity(dTime)
			velocity.x = 0
			velocity.y = dashMagnitude
			dashCount += -1
			movementInputMonitoring = Vector2(false, false)
			_inputPauseReset(dTime)
	
	if twoWayDashHorizontal and dashTap and dashCount > 0 and !rolling and dash_available and not death:
		var dTime = 0.0625 * dashLength
		if wasPressingR and !(upHold or downHold):
			velocity.y = 0
			velocity.x = dashMagnitude
			_pauseGravity(dTime)
			_dashingTime(dTime)
			dashCount += -1
			movementInputMonitoring = Vector2(false, false)
			_inputPauseReset(dTime)
		elif !(upHold or downHold):
			velocity.y = 0
			velocity.x = -dashMagnitude
			_pauseGravity(dTime)
			_dashingTime(dTime)
			dashCount += -1
			movementInputMonitoring = Vector2(false, false)
			_inputPauseReset(dTime)
		dash_available = false
		time_between_dash_object.start()
			
	if dashing and velocity.x > 0 and leftTap and dashCancel:
		velocity.x = 0
	if dashing and velocity.x < 0 and rightTap and dashCancel:
		velocity.x = 0
	
	#INFO Corner Cutting
	if cornerCutting:
		if velocity.y < 0 and leftRaycast.is_colliding() and !rightRaycast.is_colliding() and !middleRaycast.is_colliding():
			position.x += correctionAmount
		if velocity.y < 0 and !leftRaycast.is_colliding() and rightRaycast.is_colliding() and !middleRaycast.is_colliding():
			position.x -= correctionAmount
			
	#INFO Ground Pound
	if groundPound and downTap and !is_on_floor() and !is_on_wall():
		groundPounding = true
		gravityActive = false
		velocity.y = 0
		await get_tree().create_timer(groundPoundPause).timeout
		_groundPound()
	if is_on_floor() and groundPounding:
		_endGroundPound()
	move_and_slide()
	
	if upToCancel and upHold and groundPound:
		_endGroundPound()
	
func _bufferJump():
	await get_tree().create_timer(jumpBuffering).timeout
	jumpWasPressed = false

func _coyoteTime():
	await get_tree().create_timer(coyoteTime).timeout
	coyoteActive = false
	jumpCount += -1

	
func _jump():
	if jumpCount > 0 and not death:
		jump_sound.play()
		velocity.y = -jumpMagnitude
		jumpCount += -1
		jumpWasPressed = false
		if jump_particles:
			var instance = jump_particles.instantiate()
			add_child(instance)
			instance.set_global_position(global_position + Vector2(0, 10))
		else:
			pass
		
func _wallJump():
	var horizontalWallKick = abs(jumpMagnitude * cos(wallKickAngle * (PI / 180)))
	var verticalWallKick = abs(jumpMagnitude * sin(wallKickAngle * (PI / 180)))
	velocity.y = -verticalWallKick
	var dir = 1
	if wallLatchingModifer and latchHold:
		dir = -1
	if wasMovingR:
		velocity.x = -horizontalWallKick  * dir
	else:
		velocity.x = horizontalWallKick * dir
	if inputPauseAfterWallJump != 0:
		movementInputMonitoring = Vector2(false, false)
		_inputPauseReset(inputPauseAfterWallJump)
	wall_jump_sound.play()
	if jump_particles:
		var instance = jump_particles.instantiate()
		add_sibling(instance)
		instance.global_position = global_position + Vector2(0, 10)


func _setLatch(delay, setBool):
	await get_tree().create_timer(delay).timeout
	wasLatched = setBool
			
func _inputPauseReset(time):
	await get_tree().create_timer(time).timeout
	movementInputMonitoring = Vector2(true, true)
	
func _decelerate(delta, vertical):
	if !vertical:
		if velocity.x > 13:
			velocity.x += deceleration * delta
			if velocity.x < 13:
				velocity.x = 0
		elif velocity.x < -13:
			velocity.x -= deceleration * delta
			if velocity.x > -13:
				velocity.x = 0
	elif vertical and velocity.y > 0:
		velocity.y += deceleration * delta


func _pauseGravity(time):
	gravityActive = false
	await get_tree().create_timer(time).timeout
	gravityActive = true

func _dashingTime(time):
	dashing = true
	dash_sound.play()
	await get_tree().create_timer(time).timeout
	dashing = false

func _rollingTime(time):
	rolling = true
	await get_tree().create_timer(time).timeout
	rolling = false	

func _groundPound():
	appliedTerminalVelocity = terminalVelocity * 10
	velocity.y = jumpMagnitude * 2
	
func _endGroundPound():
	groundPounding = false
	appliedTerminalVelocity = terminalVelocity
	gravityActive = true

func _placeHolder():
	print("")


func _on_hit_area_body_entered(body: Node2D) -> void:
	if anim.get_animation() == "attack1" or anim.get_animation() == "attack2":
		body.lives -= 1
		
	if anim.get_animation() == "attack3":
		body.lives -= 2
		
	impact_attack.play()
	body.gettingHit = true
	body.velocity = global_position.direction_to(body.global_position) * Vector2(100, 100)
	if hit1_enemy_particles:
		var instantiated_particles1 = hit1_enemy_particles.instantiate()
		add_sibling(instantiated_particles1)
		instantiated_particles1.global_position = body.global_position
	
	if hit_explode_particles:
		var instantiated_hit_explode_particles = hit_explode_particles.instantiate()
		add_sibling(instantiated_hit_explode_particles)
		instantiated_hit_explode_particles.set_global_position(body.global_position)
	
	if hit_enemy_explode2:
		var instantiated_particles_explode2 = hit_enemy_explode2.instantiate()
		add_sibling(instantiated_particles_explode2)
		instantiated_particles_explode2.direction = global_position.direction_to(body.global_position)
		instantiated_particles_explode2.global_position = body.global_position
	
func gettingHitAnimation():
	if gettingHit:
		getting_hit_sound.play()
		var brokenHeartsInstantiated = broken_heart_particles.instantiate()
		add_child(brokenHeartsInstantiated)
		brokenHeartsInstantiated.set_global_position(global_position) 
		gettingHit = false
		if not death:
			get_tree().paused = true
			await get_tree().create_timer(0.1).timeout
			get_tree().paused = false
		if getting_hit_particles and not death:
			var getting_hit_Instantiated = getting_hit_particles.instantiate()
			add_child(getting_hit_Instantiated)
			getting_hit_Instantiated.global_position = global_position

func deathFunction():
	if lives < 1:
		death = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == "death":
		anim.play("on_death")


func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.get_animation() == "attack1" and anim.get_frame() == 3:
		collision_shape_2d.set_disabled(false)
		attack_sound.play()
		await get_tree().create_timer(0.1).timeout
		collision_shape_2d.set_disabled(true)
		
	if anim.get_animation() == "attack2" and anim.get_frame() == 1:
		collision_shape_2d.set_disabled(false)
		attack_sound.play()
		await get_tree().create_timer(0.1).timeout
		collision_shape_2d.set_disabled(true)
		
	if anim.get_animation() == "attack3" and anim.get_frame() == 2:
		collision_shape_2d.set_disabled(false)
		attack_sound.play()
		await get_tree().create_timer(0.1).timeout
		collision_shape_2d.set_disabled(true)
	
	if anim.get_animation() == "run" and anim.get_frame() == 0:
		run_sound.play()
	
	if anim.get_animation() == "run" and anim.get_frame() == 4:
		run_sound.play()

func attack_procesor():
	if Input.is_action_just_pressed("atack") and not on_Attack and not death:
		jump = false
		idle = false
		run = false
		on_Attack = true
		if attackBuss == 0 and is_on_floor():
			anim.play("attack1")
			if anim.scale.x > 0:
				collision_shape_2d.position.x = 16
				collision_shape_2d.scale = Vector2(1.5, 2)
				collision_shape_2d.position.y = 5
			else:
				collision_shape_2d.position.x = -16
				collision_shape_2d.scale = Vector2(1.5, 2)
				collision_shape_2d.position.y = 5
			await get_tree().create_timer(0.2).timeout
			attackBuss = 1
		elif attackBuss == 1 and is_on_floor():
			anim.play("attack2")
			if anim.scale.x > 0:
				collision_shape_2d.position.x = 12
				collision_shape_2d.scale = Vector2(2.4, 2)
				collision_shape_2d.position.y = 5
			else:
				collision_shape_2d.position.x = -12
				collision_shape_2d.scale = Vector2(2.4, 2)
				collision_shape_2d.position.y = 5
			await get_tree().create_timer(0.2).timeout
			attackBuss = 0
			
		if not is_on_floor():
			anim.play("attack3")
			if anim.scale.x > 0:
				collision_shape_2d.position.x = 20
				collision_shape_2d.position.y = -10
				collision_shape_2d.scale = Vector2(3.5, 1.6)
			else:
				collision_shape_2d.position.x = -20
				collision_shape_2d.position.y = -10
				collision_shape_2d.scale = Vector2(3.5, 1.6)
			await get_tree().create_timer(0.3).timeout
			attackBuss = 0
		on_Attack = false
		idle = true
		jump = true
		run = true


func _on_time_between_dash_timeout() -> void:
	dash_available = true


func _on_ground_sensor_body_entered(body: Node2D) -> void:
	land_sound.play()
	
	if body:
		pass

func shieldBlockParticles():
	if shield_block:
		shield_block_sound.play()
		var instantia = shield_particles.instantiate()
		add_child(instantia)
		instantia.global_position = global_position
		shield_block = false
		
