package;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObjectContainer;

class ExternalTool extends FlxBasic
{
	var window:FlxWindowPOC;
	var bitmap:Bitmap;
	var bgBitmap:Bitmap;

	var extCamera:FlxCamera;
	var group:FlxGroup;

	var WIN_HEIGHT = 200;
	var WIN_WIDTH = 200;

	public function new()
	{
		super();
		group = new FlxGroup();
	}

	public function init()
	{
		extCamera = new FlxCamera(0, 0, WIN_HEIGHT, WIN_WIDTH);
		// move our camera out of the main window so it doesn't draw on top of our game
		extCamera.x = -WIN_WIDTH;
		// setting the camera bg to anything but transparent seems to crash on window open
		extCamera.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(extCamera, false);

		var clickTest = new FlxSprite(20, 20);
		clickTest.makeGraphic(20, 20, FlxColor.YELLOW);
		// clickTest.camera = extCamera;
		// clickTest.cameras = [extCamera];
		group.cameras = [extCamera];
		group.add(clickTest);

		FlxG.state.add(group);

		FlxG.plugins.addPlugin(this);

		createWindow();
	}

	// TODO: For some reason opening this window is now causing the app to crash.
	private function createWindow():Void
	{
		if (window != null)
			return;

		window = new FlxWindowPOC(20, 100, WIN_WIDTH, WIN_HEIGHT);

		// Return focus to main window so keypresses work
		FlxG.game.stage.window.focus();

		// Add Window to MovieClip, as FlxGame's Document is added to its MovieClip
		// This will cause the FlxWindowPOC create() function to be called to complete
		// window setup.
		cast(window._win.stage.getChildByName("mc"), DisplayObjectContainer).addChild(window);

		// Add base sprite the size of the window.
		// This BitmapData will be updated by drawing the ofCamera.canvas onto itself.
		// It is added to the display list of the second window.
		bgBitmap = new Bitmap(new BitmapData(WIN_WIDTH, WIN_HEIGHT, false, FlxColor.PINK));
		window.addChild(bgBitmap);
	}

	public override function update(delta:Float)
	{
		// Copy _ofCamera pixels to the _ofBgBitmap
		if (bgBitmap != null && extCamera != null)
		{
			// This is the heart of the second window function. This
			// copies the rendered image BitmapData from the camera to
			// to the BitmapData which is on the second window.
			bgBitmap.bitmapData.draw(extCamera.canvas);
		}
	}
}
