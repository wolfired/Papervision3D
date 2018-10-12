package org.papervision3d.core.render.draw.sort {

	import org.papervision3d.core.render.draw.list.IDrawableList;

	public class NullDrawSorter implements IDrawSorter {
		public function NullDrawSorter() {
		}

		protected var _drawList:IDrawableList;

		public function sort():void {

		}

		public function set sortMode(value:String):void {

		}

		public function get sortMode():String {
			return "";
		}

		public function set drawlist(list:IDrawableList):void {
			_drawList = list;
		}
	}
}
