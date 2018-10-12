package org.papervision3d.core.render.draw.sort {

	import org.papervision3d.core.render.draw.items.AbstractDrawable;
	import org.papervision3d.core.render.draw.list.IDrawableList;

	public class DefaultDrawSorter implements IDrawSorter {
		public static const ZSORT:String = "z";
		public static const INDEXSORT:String = "index";

		public function DefaultDrawSorter(sortMode:String = "z") {
			this.sortMode = sortMode;
		}

		protected var _drawList:IDrawableList;
		protected var _sortMode:String;

		public function sort():void {
			var v:Vector.<AbstractDrawable> = _drawList.drawables;

			if(_sortMode == ZSORT)
				v.sort(screenZCompare);
			else if(_sortMode == INDEXSORT)
				v.sort(sortIndexCompare);

		}

		public function set drawlist(list:IDrawableList):void {
			_drawList = list;
		}

		public function set sortMode(value:String):void {
			_sortMode = value;
		}

		public function get sortMode():String {
			return _sortMode;
		}

		private function sortIndexCompare(x:AbstractDrawable, y:AbstractDrawable):Number {
			return x.sortIndex - y.sortIndex;
		}

		private function screenZCompare(x:AbstractDrawable, y:AbstractDrawable):Number {
			return x.screenZ - y.screenZ;
		}
	}
}
