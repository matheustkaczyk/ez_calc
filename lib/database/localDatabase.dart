import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../components/item.dart';

class LocalDb {
  String dbName = 'produtos.db';
  late DatabaseClient db;
  var store = intMapStoreFactory.store('produtos');

  LocalDb() {
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    DatabaseFactory dbFactory = databaseFactoryIo;
    String dbPath = await getDbPath();

    try {
      db = await dbFactory.openDatabase(dbPath);
    } catch (e) {
      print('Error opening database: $e');
    }
  }

  Future<String> getDbPath() async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);

      var dbPath = join(dir.path, dbName);

      return dbPath;
    } catch (e) {
      print('Error getting database path: $e');
      rethrow;
    }
  }

  Future<List<RecordSnapshot<int, Map<String, Object?>>>> getProducts() async {
    try {
      return await store.find(db);
    } catch (e) {
      print('Error getting products: $e');
      rethrow;
    }
  }

  Future<void> addProduct(Item item) async {
    try {
      await store.add(db, {
        'id': item.id,
        'name': item.nome,
        'price': item.valor
      });
    } catch (e) {
      print('Error adding product: $e');
      rethrow;
    }
  }

  Future<void> removeProductById(String id) async {
    try {
      var finder = Finder(
        filter: Filter.equals('id', id),
      );

      await store.delete(db, finder: finder);
    } catch (e) {
      print('Error removing product: $e');
      rethrow;
    }
  }
}
