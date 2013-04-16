package
{
	public class User
	{
		import flash.data.SQLConnection;
		import flash.data.SQLStatement;
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		
		import mx.collections.ArrayCollection;
		import mx.events.FlexEvent;
		
		private var stmt:SQLStatement;
		
		public function User(){
			stmt = new SQLStatement();
			stmt.sqlConnection = new SQLConnection();
			stmt.sqlConnection.open(File.applicationDirectory.resolvePath("db/Libretto.s3db"));
		}
		
		/**
		 * Resistuisce lo stato dell'utente configurato/non configurato
		 **/
		public function status():Boolean{
			
			stmt.text = "SELECT * FROM tabella_utenti where usr_conf = 1";	
			stmt.execute();
			
			var result:Array = stmt.getResult().data;
			
			if(result){
				if (result.length > 0){
					return true;
				} else {
					return false;
				} 
			}else{
				return false;
			}
		}

		
		public function callquery(query:String,mode:String):Boolean{
			stmt.text = query;
			stmt.execute();
			
			var _rows:Number=stmt.getResult().rowsAffected;
			return (_rows > 0) ? true : false;
		}
		
		public function getinfo():Array{
			stmt.text = "SELECT * FROM tabella_utenti where usr_conf = 1";	
			stmt.execute();
			
			var result:Array = stmt.getResult().data;
			return result;
		}
	}
}