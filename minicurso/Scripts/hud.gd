extends Control

func update_hud(player):
	$ProgressBar.max_value = player.maxHp
	$ProgressBar.value = player.hp
	$Coins.text = "Coins: " + str(player.coins)
