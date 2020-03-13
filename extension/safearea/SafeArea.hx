package extension.safearea;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if android
import lime.system.JNI;
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

	static function get_safeAreaInsets():Insets
	{
		#if ios

		return safearea_get_safeAreaInsets();

		#elseif android
		
		var insets:Array<Float> = JNI.callMember(safearea_update, safearea_instance.get(), []);

		if(insets != null){			
			return {
				top: insets[0],
				bottom: insets[1],
				left: insets[2],
				right: insets[3]
			};

		}else{
			trace('Error updating safe area!');
		}

		#end

		return { top: 0.0, bottom: 0.0, left: 0.0, right: 0.0 };
	}
	
	#if ios
	static var safearea_get_safeAreaInsets = Lib.load("safearea", "safearea_get_safeAreaInsets", 0);
	#elseif android
	static var safearea_instance = JNI.createStaticField("org/haxe/extension/NotchAndroid", "inst", "Lorg/haxe/extension/NotchAndroid;");
	static var safearea_update = JNI.createMemberMethod("org.haxe.extension.NotchAndroid", "updateSafeArea", "()[F");
	#end

}

typedef Insets =
{
	top:Float,
	bottom:Float,
	left:Float,
	right:Float
}