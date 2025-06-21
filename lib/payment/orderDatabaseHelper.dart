import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:thaaja/payment/OrderModel.dart';

class OrderDatabaseHelper {
  static final OrderDatabaseHelper _instance = OrderDatabaseHelper._();
  static Database? _database;

  OrderDatabaseHelper._();

  factory OrderDatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    final path = join(await getDatabasesPath(), 'orders.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE orders(orderId TEXT PRIMARY KEY, totalAmount REAL, timestamp TEXT)',
        );
      },
    );
    return _database!;
  }

  Future<void> insertOrder(OrderModel order) async {
    final db = await database;
    await db.insert('orders', order.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<OrderModel>> getAllOrders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('orders');
    return maps.map((e) => OrderModel.fromMap(e)).toList();
  }
}
