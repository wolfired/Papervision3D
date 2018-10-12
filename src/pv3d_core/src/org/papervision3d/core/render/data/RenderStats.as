package org.papervision3d.core.render.data {

	public class RenderStats {

		public function RenderStats() {

		}

		public var totalObjects:uint;
		public var culledObjects:uint;
		public var clippedObjects:uint;
		public var totalTriangles:uint;
		public var culledTriangles:uint;
		public var clippedTriangles:uint;

		public function clear():void {
			totalObjects = 0;
			culledObjects = 0;
			clippedObjects = 0;
			totalTriangles = 0;
			culledTriangles = 0;
			clippedTriangles = 0;
		}
	}
}
