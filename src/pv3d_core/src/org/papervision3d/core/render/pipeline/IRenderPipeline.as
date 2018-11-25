package org.papervision3d.core.render.pipeline {

	import org.papervision3d.core.render.data.RenderData;

	/**
	 * 渲染管线接口
	 * @author LinkWu
	 */	
	public interface IRenderPipeline {
		/**
		 * 执行渲染
		 * @param renderData 渲染数据
		 */		
		function execute(renderData:RenderData):void
	}
}
