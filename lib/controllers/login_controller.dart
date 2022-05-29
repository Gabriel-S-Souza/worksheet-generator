import 'package:email_validator/email_validator.dart';
import 'package:formulario_de_atendimento/data/data_access_object.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  
  String email = '';

  String name = '';

  void setEmail(String value) => email = value;

  void setName(String value) => name = value;


  bool get isEmailValid => EmailValidator.validate(email);

  bool get isNameValid => name.isNotEmpty;

  bool get isFormValid => isEmailValid && isNameValid;

  @observable
  bool loading = false;

  @observable
  bool logged = false;

  @action
  Future<void> login() async {
    loading = true;
    DataAccessObject dao = DataAccessObject();
    Box<dynamic> userDataBox = await dao.getBox(DefaultBoxes.userData);
    await userDataBox.put('email', email);
    await userDataBox.put('name', name);
    loading = false;
    logged = true;
  }
}