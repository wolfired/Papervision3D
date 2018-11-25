package org.papervision3d.core.proto {

	import flash.geom.Vector3D;
	import org.papervision3d.core.math.utils.MathUtil;
	import org.papervision3d.core.ns.pv3d;
	import org.papervision3d.objects.DisplayObject3D;

	/**
	 * 3D显示容器
	 * @author Tim Knip / floorplanner.com
	 */
	public class DisplayObjectContainer3D {
		use namespace pv3d;

		/** */
		private static var _newID:int = 0;

		/**
		 * @param name 容器名称
		 */
		public function DisplayObjectContainer3D(name:String = null) {
			this.name = name || "Object" + (_newID++);

			this.transform = new Transform3D();
			this.cullingState = 0;

			_children = new Vector.<DisplayObject3D>();
		}

		/** 容器名称 */
		public var name:String;

		/** 父容器 */
		public var parent:DisplayObjectContainer3D;

		/** */
		public var transform:Transform3D;

		/** */
		public var cullingState:int;

		/** */
		pv3d var _children:Vector.<DisplayObject3D>;

		/**
		 *
		 */
		public function addChild(child:DisplayObject3D):DisplayObject3D {
			var root:DisplayObjectContainer3D = this;

			while(root.parent)
				root = root.parent;

			if(root.findChild(child, true)) {
				throw new Error("This child was already added to the scene!");
			}

			child.parent = this;
			//	child.transform.parent = this.transform;

			_children.push(child);

			return child;
		}

		/**
		 * Find a child.
		 *
		 * @param	child	The child to find.
		 * @param	deep	Whether to search recursivelly
		 *
		 * @return The found child or null on failure.
		 */
		public function findChild(child:DisplayObject3D, deep:Boolean = true):DisplayObject3D {
			var index:int = _children.indexOf(child);

			if(index < 0) {
				if(deep) {
					var object:DisplayObject3D;

					for each(object in _children) {
						var c:DisplayObject3D = object.findChild(child, true);

						if(c)
							return c;
					}
				}
			} else {
				return _children[index];
			}

			return null;
		}

		/**
		 *
		 */
		public function getChildAt(index:uint):DisplayObject3D {
			if(index < _children.length) {
				return _children[index];
			} else {
				return null;
			}
		}

		/**
		 * Gets a child by name.
		 *
		 * @param	name	Name of the DisplayObject3D to find.
		 * @param	deep	Whether to perform a recursive search
		 *
		 * @return	The found DisplayObject3D or null on failure.
		 */
		public function getChildByName(name:String, deep:Boolean = false):DisplayObject3D {
			var child:DisplayObject3D;

			for each(child in _children) {
				if(child.name == name) {
					return child;
				}

				if(deep) {
					var c:DisplayObject3D = child.getChildByName(name, true);

					if(c)
						return c;
				}
			}

			return null;
		}

		/**
		 *
		 */
		public function lookAt(object:DisplayObject3D, up:Vector3D = null):void {
			//transform.lookAt(object.transform, up);
		}

		/**
		 * Removes a child.
		 *
		 * @param	child	The child to remove.
		 * @param	deep	Whether to perform a recursive search.
		 *
		 * @return	The removed child or null on failure.
		 */
		public function removeChild(child:DisplayObject3D, deep:Boolean = false):DisplayObject3D {
			var index:int = _children.indexOf(child);

			if(index < 0) {
				if(deep) {
					var object:DisplayObject3D;

					for each(object in _children) {
						var c:DisplayObject3D = object.removeChild(object, true);

						if(c) {
							c.parent = null;
							return c;
						}
					}
				}
				return null;
			} else {
				child = _children.splice(index, 1)[0];
				child.parent = null;
				return child;
			}
		}

		/**
		 *
		 */
		public function removeChildAt(index:int):DisplayObject3D {
			if(index < _children.length) {
				return _children.splice(index, 1)[0];
			} else {
				return null;
			}
		}

		/**
		 *
		 */
		public function rotateAround(degrees:Number, axis:Vector3D, pivot:* = null):void {
		/*
		 * pivot = pivot || this.parent;
		 *
		 * var pivotPoint :Vector3D;
		 *
		 * if (pivot === this.parent)
		 * {
		 * pivotPoint = this.parent.transform.localPosition;
		 * }
		 * else if (pivot is Vector3D)
		 * {
		 * pivotPoint = pivot as Vector3D;
		 * }
		 *
		 * if (pivotPoint)
		 * {
		 * transform.rotate(axis, false);
		 * }
		 */
		}

		/**
		 *
		 */
		public function pitch(degrees:Number):void {
			//		transform.local.prependRotation(degrees, Vector3D.X_AXIS);
			//		transform.dirty = true;
		}

		/**
		 *
		 */
		public function yaw(degrees:Number):void {
			//		transform.local.prependRotation(degrees, Vector3D.Y_AXIS);
			//		transform.dirty = true;
		}

		/**
		 *
		 */
		public function roll(degrees:Number):void {
			//		transform.local.prependRotation(degrees, Vector3D.Z_AXIS);
			//		transform.dirty = true;
		}

		/**
		 *
		 */
		public function get x():Number {
			return transform.translation.x;
		}

		public function set x(value:Number):void {
			transform.translation.x = value;
			transform.dirty = true;
		}

		/**
		 *
		 */
		public function get y():Number {
			return transform.translation.y;
		}

		public function set y(value:Number):void {
			transform.translation.y = value;
			transform.dirty = true;
		}

		/**
		 *
		 */
		public function get z():Number {
			return transform.translation.z;
		}

		public function set z(value:Number):void {
			transform.translation.z = value;
			transform.dirty = true;
		}

		/**
		 *
		 */
		public function get rotationX():Number {
			return transform.rotation.x * MathUtil.TO_DEGREES;
		}

		public function set rotationX(value:Number):void {
			//	pitch(value - this.rotationX);
			transform.rotation.x = value * MathUtil.TO_RADIANS;
			transform.dirty = true;
		}

		/**
		 *
		 */
		public function get rotationY():Number {
			return transform.rotation.y * MathUtil.TO_DEGREES;
		}

		public function set rotationY(value:Number):void {
			//yaw(value - transform.rotation.y);
			transform.rotation.y = value * MathUtil.TO_RADIANS;
			transform.dirty = true;
		}

		/**
		 *
		 */
		public function get rotationZ():Number {
			return transform.rotation.z * MathUtil.TO_DEGREES;
		}

		public function set rotationZ(value:Number):void {
			//roll(value - transform.rotation.z);
			transform.rotation.z = value * MathUtil.TO_RADIANS;
			transform.dirty = true;
		}

		/**
		 *
		 */
		public function get scaleX():Number {
			return transform.scale.x;
		}

		public function set scaleX(value:Number):void {
			transform.scale.x = value;
			transform.dirty = true;
		}

		/**
		 *
		 */
		public function get scaleY():Number {
			return transform.scale.y;
		}

		public function set scaleY(value:Number):void {
			transform.scale.y = value;
			transform.dirty = true;
		}

		/**
		 *
		 */
		public function get scaleZ():Number {
			return transform.scale.z;
		}

		public function set scaleZ(value:Number):void {
			transform.scale.z = value;
			transform.dirty = true;
		}
	}
}
