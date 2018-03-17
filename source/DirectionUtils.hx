package;

import flixel.FlxObject;

/**
 * Utility class for working with Directions.
 */
class DirectionUtils {
	public static function flip(direction:Direction) {
		return switch (direction) {
			case Up: Direction.Down;
			case Down: Direction.Up;
			case Left: Direction.Right;
			case Right: Direction.Left;
		}
	}

	public static function manipulateX(x:Int, direction:Direction):Int {
		return switch(direction) {
			case Left: x - 1;
			case Right: x + 1;
			default: x;
		};
	}

	public static function manipulateY(y:Int, direction:Direction):Int {
		return switch(direction) {
			case Up: y + 1;
			case Down: y - 1;
			default: y;
		}
	}

	public static function toFlxDirection(direction:Direction):Int {
		return switch(direction) {
			case Up: FlxObject.UP;
			case Down: FlxObject.DOWN;
			case Left: FlxObject.LEFT;
			case Right: FlxObject.RIGHT;
		}
	}

	public static function toAngle(direction:Direction):Int {
		return switch (direction) {
			case Down: 0;
			case Right: 270;
			case Up: 180;
			case Left: 90;
		}
	}
}