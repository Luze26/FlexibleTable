package
{
	import flash.geom.Point;
	
	import mx.controls.Label;

	public class Table
	{
		private static var nbCol:Number = 1;
		
		public static var label:Label;
		public static var start:Point = null;
		public static var drag:Boolean = false;
		public static var casee:Case;
		
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