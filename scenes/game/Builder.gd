extends Node

const Turret = preload('res://nodes/turret/Turret.gd')
const Map = preload('res://nodes/map/Map.gd')
const Deck = preload('res://nodes/deck/Deck.gd')
const Wallet = preload('res://nodes/wallet/Wallet.gd')
const Sound = preload('res://nodes/sound/Sound.gd')

## Map node in the scene
export(NodePath) var map_path
onready var map: Map = get_node(map_path)

## Wallet node in the scene
export(NodePath) var wallet_path
onready var wallet: Wallet = get_node(wallet_path)

## Deck node in the scene
export(NodePath) var deck_path
onready var deck: Deck = get_node(deck_path)

export(NodePath) var sfx_path
onready var sfx: Sound = get_node(sfx_path)

var turret = null

func _ready():
	deck.connect("selected", self, "select_turret")
	deck.connect("deselected", self, "deselect_turret")

## Checks if build mode is enabled
func is_build_mode() -> bool:
	return turret != null

## Customizes placeholder turret to indicate a bad position
func reject_position():
	turret.modulate = Color(0.3, 0.3, 0.3)

## Customizes placeholder turret to indicate a placeable position
func accept_position():
	turret.modulate = Color(0.6, 0.6, 0.6)

## Sets the turret up to placeholder mode
func prepare_to_placeholder():
	reject_position()
	turret.enabled = false
	turret.show_range = true

## Sets build mode up
func start_build_mode(turret_: Turret):
	if turret != null:
		turret.queue_free()
	turret = turret_
	prepare_to_placeholder()
	add_child(turret)

## Stops build mode
func stop_build_mode():
	if is_build_mode():
		turret = null
		deck.deselect()

## Stops build mode and deletes the turret
func cancel_build_mode():
	if is_build_mode():
		turret.queue_free()
		turret = null
		deck.deselect()

## Sets the turret up to normal mode
func prepare_to_place():
	turret.modulate = Color(1,1,1)
	turret.show_range = false
	turret.enabled = true

## Moves the turret in map coordinades
func move(pos: Vector2):
	pos = Utils.convert_to_map_coords(pos)
	turret.global_position = pos

func is_buyable() -> bool:
	return wallet.is_spendable(turret.price)

## Checks if a turret can be placed
func is_placeable() -> bool:
	return is_build_mode() and not map.is_occupied(turret)

## Places a turret into the map
func place():
	prepare_to_place()
	remove_child(turret)
	map.place(turret)
	wallet.spend(turret.price)
	stop_build_mode()
	sfx.play_sound('place')

## Selects a turret from its class
func select_turret(turret_class):
	var turret_ = turret_class.instance() as Turret
	start_build_mode(turret_)

## Deselects a turret
func deselect_turret():
	cancel_build_mode()

func _unhandled_input(event: InputEvent):
	if event.is_action("ui_accept"):
		if is_build_mode():
			if is_placeable() and is_buyable():
				place()
			else:
				cancel_build_mode()

func _process(_delta):
	if is_build_mode():
		move(get_viewport().get_mouse_position())
		if is_placeable():
			accept_position()
		else:
			reject_position()
