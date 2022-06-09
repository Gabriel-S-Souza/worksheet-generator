import 'package:formulario_de_atendimento/default_values/default_values.dart';

class ServicesModel {

  String? defect;
  String? cause;
  String? solution;
  String? motorOil;
  String? hydraulicOil;
  String? situation;
  String? pendencies;

  void treatTheProperties() {

    if (situation != null) {
      if(situation == Situation.released) {
        situation = '[ X ] LIBERADO     [   ] LIBERADO COM RESTRIÇÕES     [   ] NÃO LIBERADO     [   ] FALTA PEÇAS';
      } else if(situation == Situation.releasedWithRestrictions) {
        situation = '[   ] LIBERADO     [ X ] LIBERADO COM RESTRIÇÕES     [   ] NÃO LIBERADO     [   ] FALTA PEÇAS';
      } else if(situation == Situation.notReleased) {
        situation = '[   ] LIBERADO     [   ] LIBERADO COM RESTRIÇÕES     [ X ] NÃO LIBERADO     [   ] FALTA PEÇAS';
      } else if(situation == Situation.missingParts) {
        situation = '[   ] LIBERADO     [   ] LIBERADO COM RESTRIÇÕES     [   ] NÃO LIBERADO     [ X ] FALTA PEÇAS';
      }
    }
  }
}