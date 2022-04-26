tool
extends GridContainer

const CardScene = preload('res://nodes/deck/Card.tscn')
const Card = preload('res://nodes/deck/Card.gd')
const Wallet = preload('res://nodes/wallet/Wallet.gd')

export(Array, PackedScene) var turrets setget set_turrets

export(NodePath) var wallet_path
onready var wallet: Wallet = get_node(wallet_path)

signal selected(turret_class)
signal deselected

func set_turrets(turrets_: Array):
	turrets = turrets_
	
	for child in get_children():
		child.queue_free()
	
	for turret in turrets:
		var card = CardScene.instance()
		card.turret = turret
		card.connect("selected", self, "_on_Card_selected")
		card.connect("deselected", self, "_on_Card_deselected")
		add_child(card)

func _ready():
	for child in get_children():
		(child as Card).wallet = wallet

func _on_Card_selected(turret_class, card: Card):
	_deselect()
	card.select()
	emit_signal("selected", turret_class)

func _on_Card_deselected():
	emit_signal("deselected")

func _deselect():
	for card in get_children():
		card.deselect()

func deselect():
	_deselect()
	emit_signal("deselected")
