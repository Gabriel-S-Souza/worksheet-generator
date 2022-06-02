import 'package:formulario_de_atendimento/default_values/default_values.dart';

class ServicesModel {

  Map<String, String?> defect = {
    'cellAdress': 'B17',
  };
  Map<String, String?> cause = {
    'cellAdress': 'B22',
  };
  Map<String, String?> solution = {
    'cellAdress': 'B27',
  };
  Map<String, String?> motorOil = {
    'cellAdress': 'E32',
  };
  Map<String, String?> hydraulicOil = {
    'cellAdress': 'I32',
  };
  Map<String, String?> situation = {
    'cellAdress': 'C36',
  };
  Map<String, String?> pendencies = {
    'cellAdress': 'B38',
  };

  void treatTheProperties() {

    if (situation['value'] != null) {
      if(situation['value'] == Situation.released) {
        situation['value'] = '[ X ] LIBERADO                     [   ] LIBERADO COM RESTRIÇÕES                [   ] NÃO LIBERADO                [   ] FALTA PEÇAS';
      } else if(situation['value'] == Situation.releasedWithRestrictions) {
        situation['value'] = '[   ] LIBERADO                     [ X ] LIBERADO COM RESTRIÇÕES                [   ] NÃO LIBERADO                [   ] FALTA PEÇAS';
      } else if(situation['value'] == Situation.notReleased) {
        situation['value'] = '[   ] LIBERADO                     [   ] LIBERADO COM RESTRIÇÕES                [ X ] NÃO LIBERADO                [   ] FALTA PEÇAS';
      } else if(situation['value'] == Situation.missingParts) {
        situation['value'] = '[   ] LIBERADO                     [   ] LIBERADO COM RESTRIÇÕES                [   ] NÃO LIBERADO                [ X ] FALTA PEÇAS';
      }
    }
  }

  List<Map<String, String?>> toList() {
    final List<Map<String, String?>> list = [];
    list.add(defect);
    list.add(cause);
    list.add(solution);
    list.add(motorOil);
    list.add(hydraulicOil);
    list.add(situation);
    list.add(pendencies);
    return list;
  }
}