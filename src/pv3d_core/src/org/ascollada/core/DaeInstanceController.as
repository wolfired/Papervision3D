package org.ascollada.core {

	import org.ascollada.core.ns.collada;
	import org.ascollada.fx.DaeBindMaterial;

	/**
	 * @author Tim Knip / floorplanner.com
	 */
	public class DaeInstanceController extends DaeElement {
		use namespace collada;

		/**
		 *
		 */
		public function DaeInstanceController(document:DaeDocument, element:XML = null) {
			super(document, element);
		}

		/**
		 *
		 */
		public var url:String;

		/**
		 *
		 */
		public var skeletons:Array;

		/**
		 *
		 */
		public var bindMaterial:DaeBindMaterial;

		/**
		 *
		 */
		override public function destroy():void {
			super.destroy();

			if(this.skeletons) {
				while(this.skeletons.length) {
					this.skeletons.pop();
				}
				this.skeletons = null;
			}

			if(this.bindMaterial) {
				this.bindMaterial.destroy();
				this.bindMaterial = null;
			}
		}

		/**
		 *
		 */
		override public function read(element:XML):void {
			super.read(element);

			var list:XMLList = element.children();
			var child:XML;
			var num:int = list.length();
			var i:int;

			this.url = readAttribute(element, "url", true);
			this.skeletons = new Array();

			for(i = 0; i < num; i++) {
				child = list[i];

				switch(child.localName() as String) {
					case "skeleton":
						var skeleton:String = readText(child);
						if(skeleton.charAt(0) == "#") {
							skeleton = skeleton.substr(1);
						}
						this.skeletons.push(skeleton);
						break;
					case "bind_material":
						this.bindMaterial = new DaeBindMaterial(this.document, child);
						break;
					default:
						break;
				}
			}
		}
	}
}
