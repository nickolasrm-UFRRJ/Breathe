tool
extends HBoxContainer

export var budget = 100 setget set_budget

func set_budget(budget_: int):
	budget = budget_
	if has_node('Text'):
		$Text.text = String(budget)

func earn(coins: int):
	set_budget(budget+coins)

func is_spendable(coins: int) -> bool:
	return budget >= coins

func spend(coins: int):
	if is_spendable(coins):
		set_budget(budget-coins)

func _on_Spawner_enemy_died(coins):
	earn(coins)
