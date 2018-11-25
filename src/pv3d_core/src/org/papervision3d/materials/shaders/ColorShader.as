package org.papervision3d.materials.shaders {

	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsSolidFill;
	import flash.display.IGraphicsData;

	/**
	 * @author: andy zupko / zupko.info
	 */
	public class ColorShader extends AbstractShader {
		public function ColorShader() {
			super();
			_usesUV = false;
			this.drawProperties = graphicsFill = new GraphicsSolidFill(0, 1);
			this.clear = new GraphicsEndFill();

		}

		private var graphicsFill:GraphicsSolidFill;

		override public function get drawProperties():IGraphicsData {

			graphicsFill.color = _texture.color;
			graphicsFill.alpha = _texture.alpha;
			return _drawProperties;
		}
	}
}
