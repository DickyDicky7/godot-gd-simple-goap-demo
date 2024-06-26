extends Window;

func    _ready() -> void:
	self.       position.x = randi_range(50, 500);
	self.       position.y = randi_range(50, 500);
	self.close_requested.connect(func(): queue_free());
	pass;

func  _process(
	  _delta   :
	   float  ):
	if ($ScrollContainer/RichTextLabel.text.length() > 5000):
		$ScrollContainer/RichTextLabel.text =     ""        ;
	pass;

#
#
#
#
