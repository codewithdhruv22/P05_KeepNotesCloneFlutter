import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class NotesDatabse {
  static final NotesDatabse instance = NotesDatabse._init();
  static Database? _database;
  NotesDatabse._init();

  Future<Database?> get database async{
    if(_database != null) return _database;
    _database = await _initializeDB('Notes.db');
    return _database;
  }


  Future<Database> _initializeDB(String filepath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath , filepath);

    return await openDatabase(path , version:  1, onCreate: _createDB );
  }


  Future _createDB(Database db, int version) async{
    await db.execute('''
    CREATE TABLE Notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pin BOOLEAN NOT NULL,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      createdTime TEXT NOT NULL
    )
    ''');
  }

    Future<bool?> InsertEntry() async{
      final db = await instance.database;
      await db!.insert("Notes", {"id" : 233,"pin" : 0 , "title" : "CODE WITH DHRUV IS BEST CHANNEL FOR LEARNING FLUTTER" , "content" : "THIS IS MY NOTE CONTENT" , "createdTime" : "26 Jan 2018"});
      return true;
    }

Future<String> readAllNotes() async{
  final db = await instance.database;
  final orderBy = 'createdTime ASC';
  final query_result = await db!.query("Notes",orderBy: orderBy);
  print(query_result);
  return "SUCCESFULL";
}

Future<String?> readOneNote(int id) async{
  final db = await instance.database;
  final map = await db!.query("Notes" ,
   columns: ["title"] ,
   where: 'id = ?',
   whereArgs: [id] 
   );
   print(map);
}

Future updateNote(int id) async{
  final db = await instance.database;

 await db!.update("Notes", {"title" : "Telegram Group Join Kar LEna" } , where:  'id = ?' ,whereArgs: [id] );
}

Future delteNote(int id) async{
  final db = await instance.database;

  await db!.delete("Notes" , where: 'id = ?', whereArgs: [id]);
}


  }
