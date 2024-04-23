package;

import lime.ui.MouseButton;

interface ExternalWindowListener {
	public function mouseDown(x:Float, y:Float, button:MouseButton):Void;
	public function mouseDrag(x:Float, y:Float):Void;
	public function mouseUp(x:Float, y:Float):Void;
}