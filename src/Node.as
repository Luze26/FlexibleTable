package
{
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	
	import spark.components.Group;

	public class Node extends Group
	{
		private var view:NodeView = new NodeView();
		private var subNodes:ArrayList = new ArrayList();
		public var index:int;
		
		public function Node(index:int=0):void
		{
			this.index = index;
			
			if(index == 0) {
				this.percentWidth = 100;
				view.removeElement(view.cell);
				view.subNodes.percentWidth = 100;
			}
			else {
				view.cell.percentWidth = 100 / (Table.getNbCol() - index + 1);
				view.subNodes.percentWidth = 100 - view.cell.percentWidth;
			}
			
			addElement(view);
			
			if(index > 0 && index < Table.getNbCol()) {
				addSubNode();
			}
		}
		
		public function changeNbCol():void
		{
			if (index > 0) {
				view.cell.percentWidth = 100 / (Table.getNbCol() - index + 1);
				view.subNodes.percentWidth = 100 - view.cell.percentWidth;
			}
			
			if(index == Table.getNbCol() - 1 && subNodes.length == 0) {
				addSubNode();
			}
			else if (index == Table.getNbCol() && subNodes.length > 0) {
				for each (var node:Node in subNodes.source) {
					removeElement(node);
				}
			}
			else {
				for each (var node2:Node in subNodes.source) {
					node2.changeNbCol();
				}
			}
		}
		
		public function addSubNode(i:int=-1):void
		{
			var next:Node = new Node(index+1);
			next.percentWidth = 100;
			
			if (index > 0 && subNodes.length == 0) {
				next.percentHeight = 100;
			}

			if (i == -1) {
				view.subNodes.addElement(next);
			}
			else {
				view.subNodes.addElementAt(next, index);
			}

			subNodes.addItem(next);

		}
		
		public function split():void
		{
			var group:Group = Group(this.parent);
			Node(group.parent.parent).addSubNode();
		}
		
		public function propagate(size:int):void
		{
			if (subNodes.length > 0) {
				var s:int = size / subNodes.length;

				for each (var node2:Node in subNodes.source) {
					node2.propagateSize(s);
				}
			}
		}
		
		public function propagateSize(size:int):void
		{
			var newSize:int = view.cell.height + size;
			if (newSize > view.cell.minHeight && newSize < view.cell.maxHeight) {
				view.cell.height = newSize;
			}
			propagate(size);
		}
		
		public function  maxHeightNode():int
		{
			var max:int, tmp:int=0;
			
			for each (var node2:Node in subNodes.source) {
				tmp += node2.maxHeightNode();
			}
			
			max = tmp;
			var cellH:int = view["cell"]["content"].measuredHeight;
			if (cellH > max) {
				max = cellH;
			}
			return max + 5;
		}
		
		public function resizeCol(index:int, percent:int, first:Boolean):void
		{
			if(index == this.index && subNodes.length > 0) {
				view.cell.percentWidth -= percent;
				view.subNodes.percentWidth += percent;
			}
			
			if(first) {
				if(index == this.index) {
					index++;
					percent = - percent;
					first = false;
				}
				for each (var node2:Node in subNodes.source) {
					node2.resizeCol(index, percent, first);
				}
			}
		}
	}
}
