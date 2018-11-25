package org.papervision3d.materials.textures {

	/**
	 * @author: andy zupko / zupko.info
	 */
	public class Texture {

		public function Texture(color:uint = 0x666666, alpha:Number = 1) {
			this.color = color;
			this.alpha = alpha;
			TextureManager.addTexture(this);
		}

		public var color:uint = 0x66666666;
		public var alpha:Number = 1;

		public function update():void {

		}
	}
}
