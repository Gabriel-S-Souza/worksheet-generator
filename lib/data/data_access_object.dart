import 'package:hive_flutter/hive_flutter.dart';

class DataAccessObject {
  
  Future<Box<type>> getBox<type>(String boxName) async {
    Box<type> box = await Hive.openBox<type>(boxName);
    return box;
  }

  Future<LazyBox<type>> getLazyBox<type>(String boxName) async {
    LazyBox<type> box = await Hive.openLazyBox<type>(boxName);
    return box;
  }

  Future<void> closeBox(Box box) async {
    await box.close();
  }
  
  Future<void> openDataBase() async {
    await Hive.initFlutter();
  }
}

class DefaultBoxes {
  /// Name of the box that stores the name and email of the user
  static const userData = 'user_data';
}