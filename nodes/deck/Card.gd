tool
extends Panel

const Turret = preload('res://nodes/turret/Turret.gd')
const Wallet = preload('res://nodes/wallet/Wallet.gd')

export(bool) var enabled = true
export(PackedScene) var turret setget set_turret
var wallet: Wallet = null

var toggled = false

var dmg
var price
var rate

signal selected(turret, card)
signal deselected

# Customizes card data
func set_turret(turret_):
	turret = turret_
	if has_node(@"Padding/Repr/TurretContainer/Positioner"):
		# cleanup
		for child in $Padding/Repr/TurretContainer/Positioner.get_children():
			child.queue_free()
		# instantiation
		var turret_instance = turret.instance() as Turret
		# initialization
		turret_instance.enabled = false
		turret_instance.size = rect_size.y / 1.5
		# data gathering
		dmg = turret_instance.damage
		rate = turret_instance.fire_delay
		price = turret_instance.price
		# adding to world
		$Padding/Repr/TurretContainer/Positioner.add_child(turret_instance)
	
	# setting card stats
	if has_node(@"Padding/Stats/Cost"):
		$Padding/Stats/Cost.text = '%.1f' % float(price)
	if has_node(@"Padding/Stats/Dmg"):
		$Padding/Stats/Dmg.text = '%.1f' % float(dmg)
	if has_node(@"Padding/Stats/Rate"):
		$Padding/Stats/Rate.text = '%.1f' % float(rate)

func set_toggled(toggled_: bool):
	if toggled_ != toggled:
		toggled = toggled_
		$Button.pressed = toggled

func _ready():
	set_turret(turret)

# Animation purposes
func hover():
	modulate = Color(0.75, 0.75, 0.75)

func unhover():
	modulate = Color(0.5, 0.5, 0.5)

# External use
func select():
	toggled = true
	hover()

func deselect():
	toggled = false
	unhover()

func is_enabled():
	return wallet.is_spendable(price) and enabled

# Signals
func _on_Button_mouse_entered():
	if is_enabled() and not toggled:
		hover()

func _on_Button_mouse_exited():
	if is_enabled() and not toggled:
		unhover()

func _on_Button_button_up():
	if is_enabled():
		toggled = not toggled
		if toggled:
			select()
			emit_signal("selected", turret, self)
		else:
			emit_signal("deselected")
