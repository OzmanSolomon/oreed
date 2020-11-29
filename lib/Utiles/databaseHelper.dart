import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  static int versionFirst = 1;
  final String tableUser = 'userTable';
  final String columnId = 'id';
  final String columnUserName = 'user_name';
  final String columnFirstName = 'first_name';
  final String columnLastName = 'last_name';
  final String columnGender = 'gender';
  final String columnDefaultAddressId = 'default_address_id';
  final String columnCountryCode = 'country_code';
  final String columnPhone = 'phone';
  final String columnEmail = 'email';
  final String columnAvatar = 'avatar';
  final String columnPhoneVerified = 'phone_verified';
  final String columnRememberToken = 'remember_token';
  final String columnDob = 'dob';
  final String columnCreatedAt = 'created_at';
  final String columnLikedProducts = 'liked_products';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    // String path = directory.path + 'notes.db';
    String pathP = p.join(directory.toString(), "oreeed.db");
    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(pathP, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    //print("############################## DatabaseHelper => _createDb ");
    print("creating table user ");
    Batch batch = db.batch();
    batch.execute('''
          create table $tableUser (
          $columnId text primary key,
          $columnUserName text ,
          $columnFirstName text,
          $columnLastName text,
          $columnGender text,
          $columnDefaultAddressId text,
          $columnCountryCode text,
          $columnPhone text,
          $columnEmail text,
          $columnAvatar text,
          $columnPhoneVerified text,
          $columnRememberToken text,
          $columnDob text,
          $columnCreatedAt text,
          $columnLikedProducts text)
        ''');
    batch.execute('''
          create table appSettings (
          firstTimeLogin integer primary key autoincrement,
          language text not null,
          timeZone text not null,
          createdAt text,
          updatedAt text)
        ''');
    batch.execute('''
          create table liked_Products (
          id integer primary key autoincrement,
          products_id integer not null)
        ''');
    List<dynamic> res = await batch.commit();
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;
    var result = await db.query(tableUser, orderBy: '$columnId ASC');
    return result;
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getLikedProductsMapList() async {
    Database db = await this.database;
    var result = await db.query("liked_Products", orderBy: 'id ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertUser(User user) async {
    print(
        "############################################ DatabaseHelper => insertUser ");
    print("user to be inserted ${user.toMap()} ");
    Database db = await this.database;
    var result = await db.insert(tableUser, user.toMap());
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertLikedProduct(List<dynamic> likedProduct) async {
    print(
        "############################################ DatabaseHelper => insertUser ");
    Database db = await this.database;
    List resultList = [];
    likedProduct.forEach((element) async {
      print("user to be inserted ${element.toMap()} ");
      var result = await db.insert("liked_Products", element.toMap());
      resultList.add(result);
    });
    if (resultList.contains(0)) {
      return 0;
    } else {
      return 1;
    }
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateUser(User user) async {
    print(
        "############################################ DatabaseHelper => updateUser ");
    print("user to be updated ${user.toMap()} ");
    var db = await this.database;
    var result = await db.update(tableUser, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateUserPartially(User user) async {
    print(
        "############################################ DatabaseHelper => updateUser ");
    print("user to be updated ${user.toMap()} ");
    var db = await this.database;
    var result = await db.update(tableUser, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteUser(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $tableUser WHERE $columnId = $id');
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteLikedProduct(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM liked_Products WHERE id = $id');
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteAllLikedProduct() async {
    var allLikes = await getLikedProductList();
    List<int> result = [];
    var db = await this.database;
    allLikes.forEach((elem) async {
      var resultInt = await db.rawDelete(
          'DELETE FROM liked_Products WHERE liked_Products = ${elem.productsId}');
      result.add(resultInt);
    });
    if (result.contains(0)) {
      return 0;
    } else {
      return 1;
    }
  }

  // Get number of Note objects in database
  Future<int> getUserCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $tableUser');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<User>> getUserList() async {
    var userMapList = await getUserMapList(); // Get 'Map List' from database
    int count =
        userMapList.length; // Count the number of map entries in db table
    List<User> userList = List<User>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      userList.add(User.fromMapObject(userMapList[i]));
    }
    return userList;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<LikedProductsModel>> getLikedProductList() async {
    var likedProductMapList =
        await getLikedProductsMapList(); // Get 'Map List' from database
    int count = likedProductMapList
        .length; // Count the number of map entries in db table
    List<LikedProductsModel> likedPList = List<LikedProductsModel>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      likedPList.add(LikedProductsModel(
          productsId: likedProductMapList[i]["products_id"]));
    }
    return likedPList;
  }
}

class User {
  String _id;
  String _userName;
  String _firstName;
  String _lastName;
  String _gender;
  String _defaultAddressId;
  String _countryCode;
  String _phone;
  String _email;
  String _avatar;
  String _phoneVerified;
  String _rememberToken;
  String _dob;
  String _createdAt;

  User(
      this._userName,
      this._firstName,
      this._lastName,
      this._gender,
      this._defaultAddressId,
      this._countryCode,
      this._phone,
      this._email,
      this._avatar,
      this._phoneVerified,
      this._dob,
      this._rememberToken,
      this._createdAt);

  User.withId(
      this._id,
      this._userName,
      this._firstName,
      this._lastName,
      this._gender,
      this._defaultAddressId,
      this._countryCode,
      this._phone,
      this._email,
      this._avatar,
      this._phoneVerified,
      this._dob,
      this._rememberToken,
      this._createdAt);

  String get id => _id;
  String get userName => _userName;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get gender => _gender;
  String get defaultAddressId => _defaultAddressId;
  String get countryCode => _countryCode;
  String get phone => _phone;
  String get email => _email;
  String get avatar => _avatar;
  String get phoneVerified => _phoneVerified;
  String get dob => _dob;
  String get rememberToken => _rememberToken;
  String get createdAt => _createdAt;

  set userName(String userName) {
    if (_userName.length >= 1) {
      this._userName = userName;
    }
  }

  set firstName(String firstName) {
    if (firstName.length <= 1) {
      this._firstName = firstName;
    }
  }

  set lastName(String lastName) {
    if (lastName.length <= 1) {
      this._lastName = lastName;
    }
  }

  set gender(String gender) {
    this._gender = gender;
  }

  set defaultAddressId(String defaultAddressId) {
    this._defaultAddressId = defaultAddressId;
  }

  set countryCode(String countryCode) {
    this._countryCode = countryCode;
  }

  set phone(String phone) {
    this._phone = phone;
  }

  set email(String email) {
    this._email = email;
  }

  set avatar(String avatar) {
    this._avatar = avatar;
  }

  set phoneVerified(String phoneVerified) {
    this._phoneVerified = phoneVerified;
  }

  set dob(String dob) {
    this._dob = dob;
  }

  set rememberToken(String rememberToken) {
    this._rememberToken = rememberToken;
  }

  set createdAt(String createdAt) {
    this._createdAt = createdAt;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id.toString();
    }
    map['user_name'] = _userName;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['gender'] = _gender;
    map['default_address_id'] = _defaultAddressId.toString();
    map['country_code'] = _countryCode.toString();
    map['phone'] = _phone;
    map['email'] = _email;
    map['avatar'] = _avatar;
    map['phone_verified'] = _phoneVerified;
    map['remember_token'] = _rememberToken;
    map['dob'] = _dob;
    map['created_at'] = _createdAt;

    print('Object Type Map<String , dynamic> : $map');
    return map;
  }

  // Extract a Note object from a Map object
  User.fromMapObject(Map<String, dynamic> map) {
    print('Map To Be Converted $map');
    this._id = map['id'].toString();
    this._userName = map['user_name'];
    this._firstName = map['first_name'];
    this._lastName = map['last_name'];
    this._gender = map['gender'];
    this._defaultAddressId = map['default_address_id'].toString();
    this._countryCode = map['country_code'].toString();
    this._phone = map['phone'];
    this._email = map['email'];
    this._avatar = map['avatar'];
    this._phoneVerified = map['phone_verified'];
    this._rememberToken = map['remember_token'];
    this._dob = map['dob'];
    this._createdAt = map['created_at'];
  }
}

//     final likedProductsModel = likedProductsModelFromMap(jsonString);

List<LikedProductsModel> likedProductsModelFromMap(String str) =>
    List<LikedProductsModel>.from(
        json.decode(str).map((x) => LikedProductsModel.fromMap(x)));

String likedProductsModelToMap(List<LikedProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class LikedProductsModel {
  LikedProductsModel({
    this.productsId,
  });

  int productsId;

  factory LikedProductsModel.fromMap(Map<String, dynamic> json) =>
      LikedProductsModel(
        productsId: json["products_id"],
      );

  Map<String, dynamic> toMap() => {
        "products_id": productsId,
      };
}
