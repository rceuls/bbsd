extends CanvasLayer

signal start_game

func _on_MessageTimer_timeout():
	$MessageLabel.hide()
	
func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func show_message(text):
	$MessageLabel.set_text(tr(text))
	$MessageLabel.show()
	$MessageTimer.start()
	
func show_denial_count(left):
	$DenialLabel.set_text("Denial: " + str(left))
	
func show_game_over():
	show_message("Oh no, you have to work now!")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Dodge the tickets!"
	$MessageLabel.show()
	yield(get_tree().create_timer(2), 'timeout')
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)