extends Node


export(PackedScene) var ColorBorderRect = preload("res://ColorBorderRect.tscn")
var ubuntu_nerd_font = DynamicFont.new()

export(int) var min_temp: int = -6
export(int) var max_temp: int = 6
var total_temp: int

var temp_labels: Array = []

var thermo = ColorBorderRect.instance()
var thermo_filled = ColorBorderRect.instance()

func _ready():
	ubuntu_nerd_font.font_data = load("res://assets/fonts/UbuntuMono_Nerd_Font_Regular.ttf")
	ubuntu_nerd_font.size = 20
	
	self.thermo.set_color(Color.white)
	self.thermo.show()
	self.add_child(self.thermo)
	self.thermo_filled.set_color(Color.red)
	self.thermo_filled.show()
	self.thermo_filled.set_border_visible(false)
	self.add_child(self.thermo_filled)
	
	$Slider.step = 1
	$Slider.min_value = self.min_temp
	$Slider.max_value = self.max_temp
	self.total_temp = self.max_temp - self.min_temp
	
	self.thermo.set_rect_size_x($Slider.rect_size.x / 2)
	self.thermo.set_rect_size_y($Slider.rect_size.y)
	self.thermo_filled.set_rect_size_x(self.thermo.rect_size.x - 4)
	
	self.thermo.rect_position = $Slider.rect_position
	self.thermo.rect_position.x += 2 * self.thermo.rect_size.x
	self.thermo_filled.rect_position = self.thermo.rect_position
	self.thermo_filled.rect_position.x += 2
	
	self.fill_to(0)
	self.write_temp()

func fill_to(level: float):
	self.thermo_filled.set_rect_size_y(
		float(level - self.min_temp) / self.total_temp
		* self.thermo.rect_size.y)
	self.thermo_filled.rect_position.y = (
		self.thermo.rect_position.y
		+ self.thermo.rect_size.y
		- self.thermo_filled.rect_size.y)

func write_temp():
	var spacing = self.thermo.rect_size.y / float(self.max_temp - self.min_temp)
	var y_position = self.thermo.rect_position.y + self.thermo.rect_size.y
	for temp in range(self.min_temp, self.max_temp + 1):
		var label = Label.new()
		label.text = str(temp) + "°C"
		label.set("custom_fonts/font", self.ubuntu_nerd_font)
		label.rect_position.y = y_position
		y_position -= spacing
		label.rect_position.x = self.thermo.rect_position.x + self.thermo.rect_size.x + 10
		label.rect_position.y -= label.rect_size.y / 2
		label.visible = false
		self.add_child(label)
		self.temp_labels.push_back(label)


func _on_DisplayTemps_pressed():
	for label in self.temp_labels:
		var visible = not label.visible
		label.visible = visible
