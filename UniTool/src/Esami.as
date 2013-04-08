package
{
	import mx.collections.ArrayList;

	public class Esami
	{
		import flash.data.SQLConnection;
		import flash.data.SQLStatement;
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		
		import mx.collections.ArrayCollection;
		//import mx.controls.Alert;
		import mx.events.FlexEvent;
		
		private var stmt:SQLStatement;
		
		public function Esami(){
			stmt = new SQLStatement();
			stmt.sqlConnection = new SQLConnection();
			stmt.sqlConnection.open(File.applicationDirectory.resolvePath("db/Libretto.s3db"));
		}
		
		public function callquery(query:String,mode:String):Boolean{
			stmt.text = query;
			stmt.execute();
			
			var _rows:Number=stmt.getResult().rowsAffected;
			return (_rows > 0) ? true : false;
		}
		
		public function getEsami(opzione:int):Array{
			stmt.text = "SELECT  t.voe_codi,t.voe_desc,"+
							   "t.voe_cred,val.val_desc,t.val_codi,t.media,"+
							   "strftime('%d/%m/%Y',t.voe_data) as voe_data, " +
							   "strftime('%m/%d/%Y',t.voe_data) as voe_data2 " +
							   
						"from tabella_votiesami t "+
						"left join tabella_valutazioni val "+
						"on t.val_codi = val.val_codi "+
						"where (case when "+opzione+" = 0 then 1 " +
								"when "+opzione+" = 1 and ifnull(t.val_codi,0) > 0 then 1 " +
								"when "+opzione+" = 2 and ifnull(t.val_codi,0) = 0 then 1 " +
								"else 0 end) = 1";	
			stmt.execute();
			
			var result:Array = stmt.getResult().data;
			return result;
		}
		
		public function getValutazioni():Array{
			stmt.text = "SELECT * from tabella_valutazioni";	
			stmt.execute();
			
			var result:Array = stmt.getResult().data;
			return result;
		}
	}
}