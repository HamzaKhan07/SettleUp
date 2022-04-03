import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SettleData {
  int id;
  String details;
  String expenseName;
  String category;
  String date;
  late Database database;

  SettleData(
      {this.id = 0,
      this.details = '',
      this.expenseName = '',
      this.category = '',
      this.date = ''});

  @override
  String toString() {
    return 'SettleData{id: $id, details: $details, expenseName: $expenseName, category: $category, date: $date}';
  }

  Future<void> createDatabase() async {
    print('creation started');
    database = await openDatabase(
      join(await getDatabasesPath(), 'settle_database'),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
          'CREATE TABLE IF NOT EXISTS settle(ID INTEGER PRIMARY KEY, Details TEXT, ExpenseName TEXT, Category TEXT, Date TEXT)',
        );
      },
      version: 1,
    );
    print('creation completed');
  }

  Future<void> insertData(List data) async {
    print('insertion started');

    final db =
        await openDatabase(join(await getDatabasesPath(), 'settle_database'));
    print(db.isOpen);

    await db.transaction((txn) async {
      int id2 = await txn.rawInsert(
          'INSERT INTO settle(Details, ExpenseName, Category, Date) VALUES(?, ?, ?, ?)',
          data);
      print('inserted2: $id2');
    });
    print('insertion completed');
  }

  Future<void> deleteData(data) async {
    try {
      final db =
          await openDatabase(join(await getDatabasesPath(), 'settle_database'));
      print(db.isOpen);

      //delete
      int count =
          await db.rawDelete('DELETE FROM settle WHERE ExpenseName = ?', data);

      print(count);
      print('deletion completed');
    } on Exception catch (exception) {
      //on exception
    } catch (error) {
      //on error
    }
  }

  Future<List<SettleData>> getData() async {
    //Get a reference to the database.
    final db =
        await openDatabase(join(await getDatabasesPath(), 'settle_database'));
    print(db.isOpen);

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('settle');
    print(maps.length);
    print(maps);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return SettleData(
        id: maps[i]['ID'], //Here the key name must be equal to Column Name
        details: maps[i]['Details'],
        expenseName: maps[i]['ExpenseName'],
        category: maps[i]['Category'],
        date: maps[i]['Date'],
      );
    });
  }

  Future<bool> searchData(String expenseName) async {
    bool isExists = false;
    final db =
        await openDatabase(join(await getDatabasesPath(), 'settle_database'));

    print(db.isOpen);
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('settle');

    for (int i = 0; i < maps.length; i++) {
      if (maps[i]['ExpenseName'] == expenseName) {
        print('entry already exists');
        isExists = true;
        break;
      }
    }
    return isExists;
  }

  Future<void> deleteAll() async {
    final db =
        await openDatabase(join(await getDatabasesPath(), 'settle_database'));
    print(db.isOpen);

    //delete
    int count = await db.rawDelete('DELETE FROM settle');

    print(count);
    print('all data deleted');
  }
}
