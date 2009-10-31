package org.papervision3d.core.render.draw.list
{
	import org.papervision3d.core.render.draw.items.AbstractDrawable;
	import org.papervision3d.core.render.draw.sort.DefaultDrawSorter;
	import org.papervision3d.core.render.draw.sort.IDrawSorter;
	
	public class DrawableList extends AbstractDrawableList implements IDrawableList
	{
		private var _drawables :Vector.<AbstractDrawable>;
		
		public function DrawableList(sorter:IDrawSorter = null, sortMode:String = "z", sortIndex:Number = 0)
		{
			super(sorter ? sorter : new DefaultDrawSorter());
			this.sorter.sortMode = sortMode;
			this.sortIndex = sortIndex;									
										
			_drawables = new Vector.<AbstractDrawable>();
		}

		public override function addDrawable(drawable:AbstractDrawable):void
		{
			_drawables.push(drawable);
			screenZ += drawable.screenZ;
		}
		
		public override function getDepth():Number{
			screenZ /= _drawables.length;
			return screenZ;
		}
		
		public override function clear():void
		{
			screenZ = 0;
			_drawables.length = 0;
		}
		
		public override function get drawables():Vector.<AbstractDrawable>
		{
			return _drawables;
		}
		
		
	}
}