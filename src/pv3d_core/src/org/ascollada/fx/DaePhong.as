package org.ascollada.fx {

	import org.ascollada.core.DaeDocument;
	import org.ascollada.core.ns.collada;

	/**
	 * @author Tim Knip / floorplanner.com
	 */
	public class DaePhong extends DaeLambert {
		use namespace collada;

		/**
		 *
		 */
		public function DaePhong(document:DaeDocument, element:XML = null) {
			super(document, element);
		}

		public var specular:DaeColorOrTexture;
		public var shininess:Number = 0;

		/**
		 *
		 */
		override public function destroy():void {
			super.destroy();
		}

		/**
		 *
		 */
		override public function read(element:XML):void {
			super.read(element);

			var children:XMLList = element.children();
			var numChildren:int = children.length();

			for(var i:int = 0; i < numChildren; i++) {
				var child:XML = children[i];

				switch(child.localName()) {
					case "specular":
						this.specular = new DaeColorOrTexture(document, child);
						break;
					case "shininess":
						this.shininess = child["float"][0] ? parseFloat(readText(child["float"][0])) : this.shininess;
						break;
					default:
						break;
				}
			}
		}
	}
}
