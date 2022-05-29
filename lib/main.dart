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

  GetIt.I.registerSingleton<DataAccessObject>(dao);
  GetIt.I.registerSingleton<Box>(userDataBox, instanceName: DefaultBoxes.userData);

  runApp(const MyApp());
}