package;

import flixel.FlxBasic;

// The idea here is to have a plugin that manages the window, and contains
// a list of things that can be shown in the window. User is allowed to
// toggle between what is shown the window.
class ExternalWindowPlugin extends FlxBasic {

	private var window:FlxWindowPOC;

	public function new() {
		super();
	}
}