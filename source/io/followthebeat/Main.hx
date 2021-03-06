// This file is part of FollowTheBeat.
//
// FollowTheBeat is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// FollowTheBeat is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FollowTheBeat. If not, see <http://www.gnu.org/licenses/>.

package io.followthebeat;

import openfl.display.Sprite;

import flixel.FlxGame;
import flixel.FlxG;
import flixel.math.FlxRandom;

// This should only be imported TEMPORARILY.
// Eventually we will not be creating MapSegments
// in this class.
import io.followthebeat.core.map.Coordinate;
import io.followthebeat.core.map.Direction;
import io.followthebeat.core.map.MapSegment;
import io.followthebeat.core.objects.Piston;
import io.followthebeat.core.objects.RhythmBomb;

import io.followthebeat.game.states.MenuState;

class Main extends Sprite {
	public static inline var tileScale:Int = Std.int(360 / 3);
	public static inline var segmentWidth:Int = 3;
	public static inline var segmentHeight:Int = 8;
	public static inline var beatTime:Int = 500;
	public static inline var songLength:Int = 32;
	public static inline var animationFPS:Int = 15;

	public static inline var tileStartY:Int = Std.int(tileScale / 3);
	public static inline var tileEndY:Int = (tileScale * 4) + tileStartY;

	public static inline var tolerance:Float = 0.75;

	public static var random:FlxRandom;
	public static var exampleSegment1:MapSegment;
	public static var exampleSegment2:MapSegment;

	public function new() {
		super();

		// Initialize FlxRandom
		random = new FlxRandom(1);

		// Initialize exampleSegment1
		exampleSegment1 = new MapSegment(0, segmentWidth, segmentHeight);
		// exampleSegment1.addHazard(new Piston(new Coordinate(1, 1), Direction.Right, 2));
		// exampleSegment1.addHazard(new RhythmBomb(new Coordinate(2, 2), 1));
		// exampleSegment1.addHazard(new RhythmBomb(new Coordinate(1, 2), 2));
		// exampleSegment1.addHazard(new RhythmBomb(new Coordinate(1, 1), 4));
		// exampleSegment1.addHazard(new RhythmBomb(new Coordinate(2, 1), 8));
		exampleSegment1.addHazard(new Piston(new Coordinate(2, 0), Direction.Up, 8));
		exampleSegment1.addHazard(new Piston(new Coordinate(0, 1), Direction.Right, 4));
		exampleSegment1.addHazard(new Piston(new Coordinate(2, 2), Direction.Left, 2));
		exampleSegment1.addHazard(new Piston(new Coordinate(0, 3), Direction.Down, 1));
		exampleSegment1.addHazard(new RhythmBomb(new Coordinate(2, 3), 2));
		exampleSegment1.addHazard(new RhythmBomb(new Coordinate(0, 0), 4));
		// exampleSegment1.addHazard(new RhythmBomb(new Coordinate(2, 1), 4));
		// exampleSegment1.addHazard(new RhythmBomb(new Coordinate(2, 1), 4));
		exampleSegment2 = new MapSegment(8, segmentWidth, segmentHeight);
		exampleSegment2.addHazard(new RhythmBomb(new Coordinate(2, 8), 2));
		exampleSegment2.addHazard(new RhythmBomb(new Coordinate(0, 9), 4));

		addChild(new FlxGame(0, 0, MenuState, true));
	}
}
