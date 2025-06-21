/*
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelperPage extends StatefulWidget {
  @override
  _DatabaseHelperPageState createState() => _DatabaseHelperPageState();
}

class _DatabaseHelperPageState extends State<DatabaseHelperPage> {
  Database? _database;
  List<Map<String, dynamic>> _items = [];
  List<TextEditingController> _nameControllers = [];
  List<TextEditingController> _weightControllers = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "items.db");

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            weight TEXT
          )
        ''');
      },
    );

    _fetchItems();
    _addFields(); // Start with one input set
  }

  Future<void> _fetchItems() async {
    final List<Map<String, dynamic>> items = await _database!.query('Items');
    setState(() {
      _items = items;
    });
  }

  void _addFields() {
    setState(() {
      _nameControllers.add(TextEditingController());
      _weightControllers.add(TextEditingController());
    });
  }

  Future<void> _submitItems() async {
    for (int i = 0; i < _nameControllers.length; i++) {
      String name = _nameControllers[i].text;
      String weight = _weightControllers[i].text;

      if (name.isNotEmpty && weight.isNotEmpty) {
        await _database!.insert('Items', {
          'name': name,
          'weight': weight,
        });
      }
    }

    _nameControllers.clear();
    _weightControllers.clear();
    _addFields(); // Add one empty field after submit

    _fetchItems();
  }

  @override
  void dispose() {
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    for (var controller in _weightControllers) {
      controller.dispose();
    }
    _database?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQFlite Item Entry')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: _nameControllers.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameControllers[index],
                          decoration: InputDecoration(labelText: 'Item Name'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _weightControllers[index],
                          decoration: InputDecoration(labelText: 'Item Weight'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle, color: Colors.green),
                        onPressed: _addFields,
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitItems,
              child: Text('Submit'),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Saved Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ..._items.map((item) => ListTile(
              title: Text('Name: ${item['name']}'),
              subtitle: Text('Weight: ${item['weight']}'),
            )),
          ],
        ),
      ),
    );
  }
}

 */