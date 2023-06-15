#Hello Trey, please treat this code as if it is uranium or some other structure that will combust the moment you touch it
#:) 
extends Node2D

const NUMBER_STARS = 69 
var starSprite: Texture  

func _ready():
	#we can replace the image once we find a sprite
	starSprite = preload("res://.import/bell.png-f23eb8d10b79024fd8e597ba841b0bbc.stex")
	
	# Spawner
	for i in range(NUMBER_STARS):
		spawn_star()

func spawn_star():
	var star = Sprite.new()
	star.texture = starSprite
	#randomizer
	star.position = Vector2(rand_range(0, get_viewport_rect().size.x), rand_range(0, get_viewport_rect().size.y))
	star.scale = Vector2(rand_range(0.5, 1.5), rand_range(0.5, 1.5))
	star.rotation_degrees = rand_range(0, 360)
	
	add_child(star)
