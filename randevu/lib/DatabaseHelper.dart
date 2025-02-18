import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "proje.sqlite";
  static final _databaseVersion = 1;

  static final tableUye = 'uye';
  static final tableRandevu = 'randevular';

  static final columnUyeId = 'Id';
  static final columnKullaniciAdi = 'KullaniciAdi';
  static final columnSifre = 'Sifre';
  static final columnTelefonNumarasi = 'TelefonNumarasi';

  static final columnRandevuId = 'RandevuId';
  static final columnUyeIdRandevu = 'UyeId';
  static final columnTarih = 'Tarih';
  static final columnSaat = 'Saat';


  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();


  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUye (
        $columnUyeId INTEGER PRIMARY KEY,
        $columnKullaniciAdi TEXT NOT NULL,
        $columnSifre TEXT NOT NULL,
        $columnTelefonNumarasi TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $tableRandevu (
        $columnRandevuId INTEGER PRIMARY KEY,
        $columnUyeIdRandevu INTEGER NOT NULL,
        $columnTarih TEXT NOT NULL,
        $columnSaat TEXT NOT NULL,
        FOREIGN KEY ($columnUyeIdRandevu) REFERENCES $tableUye ($columnUyeId)
      )
    ''');
  }


  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }


  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }


  Future<int> insertUye(Map<String, dynamic> row) async {
    return await insert(tableUye, row);
  }


  Future<List<Map<String, dynamic>>> queryAllUye() async {
    return await queryAllRows(tableUye);
  }


  Future<int> deleteUye(int uyeId) async {
    Database db = await instance.database;
    return await db.delete(tableUye, where: '$columnUyeId = ?', whereArgs: [uyeId]);
  }


  Future<int> updateUye(int uyeId, String kullaniciAdi, String sifre, String telefon) async {
    Database db = await instance.database;
    return await db.update(
      tableUye,
      {
        columnKullaniciAdi: kullaniciAdi,
        columnSifre: sifre,
        columnTelefonNumarasi: telefon,
      },
      where: '$columnUyeId = ?',
      whereArgs: [uyeId],
    );
  }


  Future<int> insertRandevu(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableRandevu, row);
  }


  Future<Map<String, dynamic>?> queryUser(String username, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(tableUye,
        where: '$columnKullaniciAdi = ? AND $columnSifre = ?', whereArgs: [username, password]);
    return result.isNotEmpty ? result.first : null;
  }
}
