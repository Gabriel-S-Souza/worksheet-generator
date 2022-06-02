import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/data/data_access_object.dart';
import 'package:formulario_de_atendimento/view/my_app.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataAccessObject dao = DataAccessObject();
  await dao.openDataBase();
  Box<String> userDataBox = await dao.getBox<String>(DefaultBoxes.userData);

  // userDataBox.deleteAll(userDataBox.keys);
  final UserSettings userSettings;

  userSettings = UserSettings(
    email: userDataBox.get('email'),
    name: userDataBox.get('name'),
  );

  GetIt.I.registerSingleton<DataAccessObject>(dao);
  GetIt.I.registerSingleton<UserSettings>(userSettings);
  GetIt.I.registerSingleton<Box>(userDataBox, instanceName: DefaultBoxes.userData);

  runApp(const MyApp());
}

class UserSettings {
  final String? email;
  final String? name;

  UserSettings({this.email, this.name});
}