extends Node

export (PackedScene) var Mob
export (PackedScene) var Coffee
var score
var denial
var mobs

func _ready():
	randomize()
	
func _input(event):
	if event.is_action_pressed("deny_everything"):
		if(self.denial != 0):
			remove_all_mobs()
			denial -= 1
			$HUD.show_denial_count(denial)

func _on_Player_hit():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	remove_all_mobs()
	score = 0
	denial = 3
	$HUD.update_score(score)
	$HUD.show_denial_count(denial)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_StartTimer_timeout():
	$MobTimer.start();
	$ScoreTimer.start();
	denial = 3
	$HUD.show_denial_count(denial)

func _on_ScoreTimer_timeout():
	score += 1;
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.set_offset(randi())
	
	var mob = Mob.Instance if randi() % 20 > 1 else Coffee.Instance 
    # Create a Mob instance and add it to the scene.
    # Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
    # Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
    # Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
    # Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)

func _on_HUD_start_game():
	new_game()

func remove_all_mobs():
	for child in self.get_children():
		if (is_hostile(child)):
			child.queue_free()

func is_hostile(node):
	return node.is_in_group("objects")