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

package io.followthebeat.game.controls;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

import io.followthebeat.core.map.PlayerDirection;

import io.followthebeat.game.rhythm.IGameConductor;
import io.followthebeat.game.controls.IControllableGamePlayer;

class GamePlayerController {

	private var playerNumber:Int;
	private var player:IControllableGamePlayer;
	private var conductor:IGameConductor;

	private var lastBeatMoved:Int;

	private static var keyboardControls:Map<Array<FlxKey>, PlayerDirection>;
	// APPARENTLY THIS DOESN'T WORK ON JS TARGET????
	/*= [
		[UP, W]    => PlayerDirection.Up,
		[LEFT, A]  => PlayerDirection.Left,
		[RIGHT, D] => PlayerDirection.Right
		];*/

	public function new(playerNumber:Int, player:IControllableGamePlayer, conductor:IGameConductor) {
		GamePlayerController.keyboardControls = new Map<Array<FlxKey>, PlayerDirection>();
		GamePlayerController.keyboardControls.set([UP, W], PlayerDirection.Up);
		GamePlayerController.keyboardControls.set([LEFT, A], PlayerDirection.Left);
		GamePlayerController.keyboardControls.set([RIGHT, D], PlayerDirection.Right);
		this.playerNumber = playerNumber;
		this.player = player;
		this.conductor = conductor;

		// Prevents the player from moving on the first beat,
		// which is intended
		this.lastBeatMoved = 0;
	}

	// Updates this `GamePlayerController` and moves the player
	// appropriately.
	public function update():Void {
		var beatProgress:Float = conductor.getBeatProgress();

		// If we were to process input at this time, what beat
		// would we move on?
		var moveBeat:Int =
			GamePlayerController.getMoveBeat(
				conductor.getBeat(), beatProgress);

		if (this.shouldProcessInput(moveBeat, beatProgress)) {
			this.processInput(moveBeat);
		}
	}

	// Should we be processing input right now? Essentially,
	// is the current beat progress within the rhythm tolerance?
	private function shouldProcessInput(moveBeat:Int, beatProgress:Float):Bool {
		return (moveBeat > this.lastBeatMoved)
			&& GamePlayerController.isWithinTolerance(beatProgress,
				Main.tolerance);
	}

	// Process the given input and move the player accordingly.
	// Will modify `this.lastBeatMoved` if we actually move.
	private function processInput(newBeat:Int):Void {

		for (control in keyboardControls.keys()) {
			if (FlxG.keys.anyJustPressed(control)) {
				trace("moving player!");

				this.lastBeatMoved = newBeat;
				this.player.move(keyboardControls[control], newBeat);
				break;
			}
		}
	}

	// Is the given progress within the given tolerance?
	// The result is true if
	//
	//     (progress % (1 - tolerance/2)) <= (tolerance / 2).
	//
	// To see why this is, let's look at what it means to
	// be in a tolerance:
	// 
	// tolerance/2                 tolerance/2
	// |---|                             |---|
	// [-------------------------------------]
	// 0              progress               1
	// 
	// For this progress to be within a tolerance, it must be within
	// the zones on the top row. If we mod progress by
	// (1 - tolerance/2), we get
	// 
	// tolerance/2
	// |---|
	// [-------------------------------------]
	// 0              progress   (1 - tolerance/2)
	// 
	// where the first and only region captured represents both
	// the high and the low regions from the first diagram.
	private static function isWithinTolerance(progress:Float, tolerance:Float):Bool {
		return (progress % (1 - (tolerance / 2)))
			<= (tolerance / 2);
	}

	// If we were to move right now, what beat would this move be
	// associated with?
	private static function getMoveBeat(currentBeat:Int, progress:Float):Int {
		if (GamePlayerController.isEarlyHit(progress)) {
			return currentBeat + 1;
		} else {
			return currentBeat;
		}
	}

	// If we are processing input at the given progress, is this
	// input early (before the beat actually happened) or late
	// (after the beat actually happened).
    private static function isEarlyHit(progress:Float):Bool {
		return progress >= 0.5;
	}
}