package org.papervision3d.objects.lights {

	import flash.display.BitmapData;

	/**
	 * 光源接口
	 * @author LinkWu
	 */	
	public interface ILight {
		function getFlatMap():BitmapData;
		function getGouraudMap():BitmapData;
	}
}
