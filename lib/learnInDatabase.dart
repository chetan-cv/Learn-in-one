import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'classroomModel.dart';

class DiscussionForumStorage {
//  Singleton DatabaseHelper

  static DiscussionForumStorage _instance;

//  Singleton Database

  static Database _database;

  DiscussionForumStorage._createInstance();

//  Named constructor to create instance of Database

  factory DiscussionForumStorage() {
    if (_instance == null) {
      _instance = DiscussionForumStorage._createInstance();
    }
    return _instance;
  }

//  getter for initiating database

  Future<Database> get database async {
    if (_database == null) {
      _database = await init();
    }
    return _database;
  }

// Database getter

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await init();

    return _database;
  }

//initiating database

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'DiscussionForumStorage.db');
    var database = openDatabase(dbPath,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return database;
  }

// creating database

  void _onCreate(Database db, int version) {
    db.execute("""
CREATE TABLE DiscussionForumStorage
  (
      title TEXT,
      postType TEXT,
      parentId: TEXT,
      creationDate: TEXT,
      score INTEGER,
      body TEXT,
      answerCount INTEGER,
      commentCount INTEGER,
      closedDate TEXT,
      author TEXT,
      tags BLOB
  )
  """);
    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

// Adding record to database

  Future<int> addProduct(DiscussionModel record) async {
    Database db = await this.database;
//    print(record.brand);
    return db.insert('DiscussionForumStorage', record.toMapforDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

//fetching record from Database

  Future<DiscussionModel> fetchRecord(int id) async {
    Database db = await this.database;
    final Future<List<Map<String, dynamic>>> futureMaps = db
        .query('DiscussionForumStorage', where: 'orderId = ?', whereArgs: [id]);
    var maps = await futureMaps;

    if (maps.length != 0) {
      return DiscussionModel.fromDb(maps.first);
    }
    return null;
  }

//Fetching all records from Database

  Future<List<DiscussionModel>> fetchingOrders() async {
    Database db = await this.database;
    var resAll = await db.query('DiscussionForumStorage');
    print(resAll.length);
    if (resAll.isNotEmpty) {
      List records =
          resAll.map((product) => DiscussionModel.fromDb(product)).toList();

      records.sort((a, b) => b.orderId.compareTo(a.orderId));
      return records;
    }
    return [];
  }

//removing record from Database

  Future<void> removeRecord(int id) async {
    Database db = await this.database;
    return db.delete(
      'DiscussionForumStorage',
      where: 'orderId = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    final db = await database;
    db.delete("DiscussionForumStorage");
  }

  Future closeDb() async {
    Database db = await this.database;
    db.close();
  }

  Future<int> clear() async {
    final db = await this.database;

    return db.delete("DiscussionForumStorage");
  }
}

DiscussionForumStorage discussionForumStorage = DiscussionForumStorage();
