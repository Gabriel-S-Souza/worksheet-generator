import 'package:hive_flutter/hive_flutter.dart';

class DataAccessObject {
  
  Future<Box> getBox(String boxName) async {
    Box box = await Hive.openBox(boxName);
    return box;
  }

  Future<void> closeBox(Box box) async {
    await box.close();
  }
  
  openDataBase() async {
    await Hive.initFlutter();
  }
}

class DefaultBoxes {
  static const userData = 'user_data';
}