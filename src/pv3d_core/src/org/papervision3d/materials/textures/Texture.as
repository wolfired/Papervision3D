package org.papervision3d.materials.textures {

	/**
	 * @author: andy zupko / zupko.info
	 */
	public class Texture {

		public function Texture(color:uint = 0x666666, alpha:Number = 1) {
			trace(alpha);
			this.color = color;
			this.alpha = alpha;
			trace(this.alpha);
			TextureManager.addTexture(this);
		}

		public var color:uint = 0x66666666;
		public var alpha:Number = 1;

		public function update():void {

		}
	}
}
