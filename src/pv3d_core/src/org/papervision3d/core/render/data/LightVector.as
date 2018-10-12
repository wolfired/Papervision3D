package org.papervision3d.core.render.data {

	import org.papervision3d.objects.lights.ILight;

	public class LightVector {
		public function LightVector() {
			vector = new Vector.<ILight>();
		}

		public var vector:Vector.<ILight>;

		public function addLight(light:ILight):void {
			vector.push(light);
		}

		public function clear():void {
			vector.length = 0;
		}
	}
}
