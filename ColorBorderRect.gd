extends AspectRatioContainer


func set_color(color: Color):
	$Color.color = color

func set_border_visible(vis: bool):
	$Border.visible = vis

func set_rect_size_x(size: float):
	$Color.rect_min_size.x = size
	$Color.rect_size.x = size
	$Border.rect_min_size.x = size
	$Border.rect_size.x = size
	self.rect_min_size.x = size
	self.rect_size.x = size

func set_rect_size_y(size: float):
	$Color.rect_min_size.y = size
	$Color.rect_size.y = size
	$Border.rect_min_size.y = size
	$Border.rect_size.y = size
	self.rect_min_size.y = size
	self.rect_size.y = size
