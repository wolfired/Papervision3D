package org.papervision3d.core.animation.clip {

	/**
	 * @author Tim Knip / floorplanner.com
	 */
	public class AnimationClip {

		public function AnimationClip(name:String, start:uint, end:uint) {
			this.name = name;
			this.start = start;
			this.end = end;
		}

		public var name:String;
		public var start:uint;
		public var end:uint;

		public function toString():String {
			return "[" + name + " " + start + " " + end + "]";
		}
	}
}
