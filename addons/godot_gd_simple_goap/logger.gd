class_name Logger    ;
extends          Node;

enum LogLevel
{
	INFO   ,
	WARNING,
	ERROR  ,
	DEBUG  ,
};

var debugger_window;

func   _ready   () -> void :
	get_viewport().gui_embed_subwindows = false;
	debugger_window = preload("res://addons/godot_gd_simple_goap/DebuggerWindow.tscn").instantiate();
	add_child      (
	debugger_window);
	debugger_window.popup();
	pass                   ;

var log_messages : Array[String] = [
	"[INFO]: %s"                    ,
	"[WARNING]: %s"                 ,
	"[ERROR]: %s"                   ,
	"[DEBUG]: %s"                   ,
								   ];

var log_color__s : Array[String] = [
	"green"                         ,
	"yellow"                        ,
	"red"                           ,
	"white"                         ,
								   ];


func log(message: String, level : LogLevel = LogLevel.INFO)  ->  void:	
	var rich_text_label :    RichTextLabel = debugger_window.get_node("ScrollContainer/RichTextLabel");
	if  rich_text_label      !=                                  null:
		rich_text_label.text += "[color=%s]%s[/color]\n" % [log_color__s[level] , log_messages[level] % message];
	pass;

#
#
#
#
#
#
#
