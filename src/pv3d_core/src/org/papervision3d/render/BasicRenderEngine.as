package org.papervision3d.render {

	import flash.errors.IllegalOperationError;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.core.geom.provider.TriangleGeometry;
	import org.papervision3d.core.memory.Timing;
	import org.papervision3d.core.memory.pool.DrawablePool;
	import org.papervision3d.core.ns.pv3d;
	import org.papervision3d.core.render.clipping.ClipFlags;
	import org.papervision3d.core.render.clipping.IPolygonClipper;
	import org.papervision3d.core.render.clipping.SutherlandHodgmanClipper;
	import org.papervision3d.core.render.data.RenderData;
	import org.papervision3d.core.render.data.RenderStats;
	import org.papervision3d.core.render.draw.items.TriangleDrawable;
	import org.papervision3d.core.render.draw.list.IDrawableList;
	import org.papervision3d.core.render.draw.manager.DefaultDrawManager;
	import org.papervision3d.core.render.engine.AbstractRenderEngine;
	import org.papervision3d.core.render.object.ObjectRenderer;
	import org.papervision3d.core.render.pipeline.BasicPipeline;
	import org.papervision3d.core.render.raster.DefaultRasterizer;
	import org.papervision3d.core.render.raster.IRasterizer;
	import org.papervision3d.materials.textures.TextureManager;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.view.Viewport3D;

	/**
	 * @author Tim Knip / floorplanner.com
	 */
	public class BasicRenderEngine extends AbstractRenderEngine {
		use namespace pv3d;

		/**
		 *
		 */
		public function BasicRenderEngine() {
			super();
			init();
		}

		public var renderList:IDrawableList;
		public var clipper:IPolygonClipper;
		public var viewport:Viewport3D;
		public var rasterizer:IRasterizer;
		public var geometry:TriangleGeometry;
		public var renderData:RenderData;
		public var stats:RenderStats;
		public var renderer:ObjectRenderer;
		public var drawManager:DefaultDrawManager;

		private var _clipFlags:uint;

		private var _drawablePool:DrawablePool;

		/**
		 *
		 */
		override public function renderScene(scene:DisplayObject3D, camera:Camera3D, viewport:Viewport3D):void {

			renderData.scene = scene;
			renderData.camera = camera;
			renderData.viewport = viewport;
			renderData.stats = stats;
			renderData.drawManager = drawManager;

			renderData.lights.clear();

			Timing.startTime();
			TextureManager.updateTextures();
			Timing.transformTime = Timing.stopTime();
			Timing.startTime();
			camera.update(renderData.viewport.sizeRectangle);

			pipeline.execute(renderData);
			Timing.projectTime = Timing.stopTime();

			drawManager.reset();
			stats.clear();

			_drawablePool.reset();

			Timing.startTime();
			fillRenderList(camera, scene);

			drawManager.handleList();
			Timing.renderTime = Timing.stopTime();
			rasterizer.rasterize(renderData);

		}

		/**
		 * Clip flags.
		 *
		 * @see org.papervision3d.core.render.clipping.ClipFlags
		 */
		public function get clipFlags():int {
			return _clipFlags;
		}

		public function set clipFlags(value:int):void {
			if(value >= 0 && value <= ClipFlags.ALL) {
				_clipFlags = value;
			} else {
				throw new IllegalOperationError("clipFlags should be a value between 0 and " + ClipFlags.ALL + "\nsee org.papervision3d.core.render.clipping.ClipFlags");
			}
		}

		/**
		 *
		 */
		protected function init():void {
			pipeline = new BasicPipeline();
			drawManager = new DefaultDrawManager();
			//(drawManager as DefaultDrawManager).drawList.sorter  = new NullDrawSorter();

			clipper = new SutherlandHodgmanClipper();
			rasterizer = new DefaultRasterizer();
			renderData = new RenderData();
			stats = new RenderStats();

			_clipFlags = ClipFlags.NEAR;

			_drawablePool = new DrawablePool(TriangleDrawable);
		}

		/**
		 * Fills our renderlist.
		 * <p>Get rid of triangles behind the near plane, clip straddling triangles if needed.</p>
		 *
		 * @param	camera
		 * @param	object
		 */

		private function fillRenderList(camera:Camera3D, object:DisplayObject3D):void {

			var child:DisplayObject3D;
			drawManager.pushDisplayObject(object);
			object.renderer.fillRenderList(camera, renderData, clipper, _drawablePool, _clipFlags);

			if(object.material)
				object.material.shader.process(renderData, object);

			for each(child in object._children) {
				fillRenderList(camera, child);
			}

			drawManager.popDisplayObject();
		}
	}
}
