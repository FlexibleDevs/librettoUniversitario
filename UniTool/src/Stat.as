package
{
	public class Stat
	{
		import flash.data.SQLConnection;
		import flash.data.SQLStatement;
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		
		import mx.collections.ArrayCollection;
		import mx.controls.Alert;
		import mx.events.FlexEvent;
		
		private var stmt:SQLStatement;
		
		public function Stat(){
			stmt = new SQLStatement();
			stmt.sqlConnection = new SQLConnection();
			stmt.sqlConnection.open(File.applicationDirectory.resolvePath("db/Libretto.s3db"));
		}
		
		
	}
}