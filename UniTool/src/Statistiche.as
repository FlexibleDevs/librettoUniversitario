package
{
	public class Statistiche
	{
		import flash.data.SQLConnection;
		import flash.data.SQLStatement;
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		
		import mx.collections.ArrayCollection;
		
		private var stmt:SQLStatement;
		
		public function Statistiche(){
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
		
		public function getAndamento():Array{
			stmt.text = "SELECT strftime('%d/%m/%Y',voe_data) as data, " +
						"v.val_valo as Numero, " +
						"v.val_desc " +
						"from tabella_votiesami t " +
						"inner join tabella_valutazioni v " +
						"on t.val_codi = v.val_codi " +
						"where t.val_codi > 0 " +
						"order by date(t.voe_data)";
			stmt.execute();
			
			var result:Array = stmt.getResult().data;
			return result;
		}
		
		
	}
}