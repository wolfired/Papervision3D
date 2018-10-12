package org.papervision3d.core.render.draw.items {

	import flash.display.GraphicsTrianglePath;
	import flash.display.IGraphicsData;

	public class TriangleDrawable extends AbstractDrawable {

		public function TriangleDrawable() {
			this.screenZ = 0;
			_path = new GraphicsTrianglePath();
			_path.vertices = new Vector.<Number>(6, true);

		}

		public var x0:Number;
		public var y0:Number;
		public var x1:Number;
		public var y1:Number;
		public var x2:Number;
		public var y2:Number;

		private var _path:GraphicsTrianglePath;

		override public function toViewportSpace(hw:Number, hh:Number):void {
			x0 *= hw;
			y0 *= hh;
			x1 *= hw;
			y1 *= hh;
			x2 *= hw;
			y2 *= hh;
		}

		override public function get path():IGraphicsData {
			_path.vertices[0] = x0;
			_path.vertices[1] = y0;
			_path.vertices[2] = x1;
			_path.vertices[3] = y1;
			_path.vertices[4] = x2;
			_path.vertices[5] = y2;

			if(shader.usesUV)
				_path.uvtData = uvtData;
			else
				_path.uvtData = null;
			return _path;
		}
	}
}
