# extension-safearea

An OpenFL extension that adds support for querying the screen safe area on iOS.

This allows you to avoid placing important elements behind the notch and rounded corners on the iPhone X, as well as any future devices.

## Usage

Initialize extension-safearea:
```haxe
SafeArea.init();
```

Note: `SafeArea.init()` should be called before any `Event.RESIZE` event listeners are added.

Query the unsafe border on each edge of the screen:
```haxe
var paddingTop:Float = SafeArea.paddingTop;
var paddingBottom:Float = SafeArea.paddingBottom;
var paddingLeft:Float = SafeArea.paddingLeft;
var paddingRight:Float = SafeArea.paddingRight;
```

Query the safe area of the screen (the screen area inset by the padding):
```haxe
var safeArea:Rectangle = SafeArea.safeArea;
```

### Simple usage example

In this example, the screen safe area will be drawn.

```haxe
import extension.safearea.SafeArea;
import openfl.display.Sprite;
import openfl.events.Event;

class SafeAreaExample extends Sprite
{
    public function new()
    {
        super();

        SafeArea.init();

        stage.addEventListener(Event.RESIZE, onResize);

        drawSafeArea();
    }

    function onResize(e:Event)
    {
        graphics.clear();

        drawSafeArea();
    }

    function drawSafeArea()
    {
        graphics.beginFill(0xFF0000, 0.5);

        graphics.drawRect(SafeArea.safeArea.x, SafeArea.safeArea.y, SafeArea.safeArea.width, SafeArea.safeArea.height);

        graphics.endFill();
    }
}
```

## License

The MIT License (MIT) - [LICENSE.md](LICENSE.md)