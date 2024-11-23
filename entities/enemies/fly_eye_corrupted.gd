extends CharacterBody2D

var player : CharacterBody2D = null
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float = 60
@export var acceleration: float = 300
@export var lives: float = 5
@export var death_particles: PackedScene
var gettingHit = false

var on_margin_area = false

func _ready() -> void:
	anim.play("fly")

func _physics_process(delta: float) -> void:
	
	if player and not on_margin_area:
		movement_to_player(delta)
	elif player and on_margin_area:
		run_away_to_player(delta)
	
	
	move_and_slide()
	
	if lives < 1:
		queue_free()
	
	
func _on_vision_area_body_entered(body: CharacterBody2D) -> void:
	player = body

func _on_vision_area_body_exited(body: CharacterBody2D) -> void:
	if body:
		player = null

func _on_margin_area_body_entered(body: CharacterBody2D) -> void:
	on_margin_area = true

func _on_margin_area_body_exited(body: Node2D) -> void:
	on_margin_area = false


func movement_to_player(delta):
	if player.global_position.x > global_position.x:
		velocity += Vector2.RIGHT * acceleration * delta
		if velocity.x > speed:
			velocity.x = speed
				
	if player.global_position.x < global_position.x:
		velocity += Vector2.LEFT * acceleration * delta
		if velocity.x < -speed:
			velocity.x = -speed 
		
	if player.global_position.y > global_position.y:
		velocity += Vector2.DOWN * acceleration * delta
		if velocity.y > speed:
			velocity.y = speed
		
	if player.global_position.y < global_position.y:
		velocity += Vector2.UP * acceleration * delta
		if velocity.y < -speed:
			velocity.y = -speed

func run_away_to_player(delta):
	if player.global_position.x < global_position.x:
		velocity += Vector2.RIGHT * acceleration * delta
		if velocity.x < -speed:
			velocity.x = -speed
				
	if player.global_position.x > global_position.x:
		velocity += Vector2.LEFT * acceleration * delta
		if velocity.x > speed:
			velocity.x = speed 
		
	if player.global_position.y < global_position.y:
		velocity += Vector2.DOWN * acceleration * delta
		if velocity.y < -speed:
			velocity.y = -speed
		
	if player.global_position.y > global_position.y:
		velocity += Vector2.UP * acceleration * delta
		if velocity.y > speed:
			velocity.y = speed
