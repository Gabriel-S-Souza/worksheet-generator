class LocalOfAttendance {
  static const String piracicaba = 'Piracicaba';
  static const String iracenopolis = 'Iracemápolis';
  static const String other = 'Outro';
}

class Maintenance {
  static const String corrective = 'Corretiva';
  static const String preventive = 'Preventiva';
}

class CorrectiveMaintenanceOrigin {
  static const String operationalFailure = 'Falha operacional';
  static const String withoutPreventive = 'Falta de preventiva';
  static const String wearByLoadedMaterial = 'Desg. por material carregado/ local de operação';
  static const String wearCommon = 'Desgaste comum';
  static const String other = 'Outros';
}

class CorrectiveMaintenanceOriginEquipment {
  static const String operationalFailure = 'Falha operacional';
  static const String withoutPreventive = 'Falta de preventiva';
  static const String maintenanceFailure = 'Falha manutenção';
  static const String wearCommon = 'Desgaste comum';
  static const String other = 'Outros';
}

class Equipment {
  static const String loader = 'Carregadeira';
  static const String excavator = 'Escavadeira';
  static const String rollerCompactor = 'Rolo Compactador';
  static const String tractor = 'Trator';
  static const String other = 'Outros';
}

class EquipmentApplication {
  static const String loading = 'Carregamento';
  static const String excavation = 'Escavação';
  static const String terraplanning = 'Terraplanagem';
  static const String digger = 'Rompedor';
  static const String scrap = 'Sucata/Tesoura';
}

class YesNo {
  static const String yes = 'Sim';
  static const String no = 'Não';
}

class Situation {
  static const String released = 'Liberado';
  static const String releasedWithRestrictions = 'Librado com restrições';
  static const String notReleased = 'Não liberado';
  static const String missingParts = 'Falta peças';
}