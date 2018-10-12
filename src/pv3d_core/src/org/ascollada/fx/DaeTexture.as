package org.ascollada.fx {

	import org.ascollada.core.DaeDocument;
	import org.ascollada.core.DaeElement;
	import org.ascollada.core.ns.collada;

	public class DaeTexture extends DaeElement {
		use namespace collada;

		/**
		 *
		 */
		public function DaeTexture(document:DaeDocument, element:XML = null) {
			super(document, element);
		}

		public var texture:String;
		public var texcoord:String;

		/**
		 *
		 */
		override public function read(element:XML):void {
			super.read(element);

			this.texture = readAttribute(element, "texture", true);
			this.texcoord = readAttribute(element, "texcoord", true);
		}
	}
}
