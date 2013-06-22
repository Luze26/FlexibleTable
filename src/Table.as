package
{
	import flash.geom.Point;
	
	import mx.controls.Label;

	public class Table
	{
		private static var nbCol:Number = 0;
		
		public static var label:Label;
		public static var start:Point = null;
		
		public static var drag:Boolean = false;
		public static var resize:Boolean = false;
		
		public static var cell:Cell;
		public static var indexResize:int;
		
		public static var rootNode:Node;
		
		public static function getNbCol():Number
		{
			return nbCol;
		}
		
		public static function incNbCol():void
		{
			nbCol++;
		}
		
	}
}