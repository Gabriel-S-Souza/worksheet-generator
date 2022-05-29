import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/data/data_access_object.dart';
import 'package:formulario_de_atendimento/view/my_app.dart';


void main() {
  DataAccessObject dao = DataAccessObject();
  dao.openDataBase();
  runApp(const MyApp());
}
