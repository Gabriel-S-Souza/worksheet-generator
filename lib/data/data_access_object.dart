class DataAccessObject {
  DataAccessObject();

  
  openDataBase() async {
    await Hive.initFlutter();
  }
}