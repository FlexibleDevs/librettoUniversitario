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
		
		public function getPieExam():Array{
			stmt.text = "select count(0) as Numero,"+
						          "'Fatti' as Label "+
						"from tabella_votiesami "+
						"where val_codi > 0 "+
						"union all " +
						"select count(0) as Numero, "+
						          "'DaFare' as Label "+
						"from tabella_votiesami "+
						"where val_codi = 0";
			stmt.execute();
			
			var result:Array = stmt.getResult().data;
			return result;
		}
		
		public function getMedie():Array{
			stmt.text = "SELECT sum(v.val_valo)/(count(0)) as Artimetica, "+
							"sum(v.val_valo*t.voe_cred)/(sum(t.voe_cred)) as Ponderata, "+
							"(select sum(voe_cred) from tabella_votiesami) as Crediti "+
				"from tabella_votiesami t "+
				"left join tabella_valutazioni v "+
				"on t.val_codi = v.val_codi "+
				"where media = 1";
			stmt.execute();
			
			var result:Array = stmt.getResult().data;
			return result;
		}
		
		
		
		
	}
}