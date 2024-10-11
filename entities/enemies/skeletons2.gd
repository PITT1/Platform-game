extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var vision_area: Area2D = $visionArea
@onready var hit_area_collision_shape: CollisionShape2D = $hitArea/hitArea_collisionShape

var attack = false
var death = false
var idle = false
var shield = false
var takeHit = false
var walk = false

@export var lives: int = 5
var gettingHit = false

func _ready() -> void:
	pass
