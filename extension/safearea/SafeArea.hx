package extension.safearea;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

import openfl.display.Stage;
import openfl.events.Event;
import openfl.geom.Rectangle;

class SafeArea
{

	static var stage:Stage;

	public static var paddingTop(default, null):Float;
	public static var paddingBottom(default, null):Float;
	public static var paddingLeft(default, null):Float;
	public static var paddingRight(default, null):Float;
	public static var safeArea(default, null):Rectangle;

	public static function init()
	{
		stage = openfl.Lib.current.stage;

		update();

		stage.addEventListener(Event.RESIZE, onResize);
	}

	static function onResize(event:Event)
	{
		update();
	}

	static function update()
	{
		var insets = get_safeAreaInsets();

		paddingTop = insets.top;
		paddingBottom = insets.bottom;
		paddingLeft = insets.left;
		paddingRight = insets.right;

		safeArea = new Rectangle(paddingLeft,
								 paddingTop,
								 stage.stageWidth - paddingLeft - paddingRight,
								 stage.stageHeight - paddingTop - paddingBottom);
	}

	inline static function get_safeAreaInsets():Insets
	{
		#if ios
		return safearea_get_safeAreaInsets();
		#else
		return { top: 0.0, bottom: 0.0, left: 0.0, right: 0.0 };
		#end
	}
	
	#if ios
	static var safearea_get_safeAreaInsets = Lib.load("safearea", "safearea_get_safeAreaInsets", 0);
	#end

}

typedef Insets =
{
	top:Float,
	bottom:Float,
	left:Float,
	right:Float
}