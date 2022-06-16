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

class OS {
  static const Map<String, int> os = {'os_priracicaba': 01, 'os_iracemapolis': 01};
}

class DefaultKeys{
  static const osPiracicaba = 'os_piracicaba';
  static const osIracemapolis = 'os_iracemapolis';

  static const piracicabaSufix = 'piracicaba_sufix';
  static const iracemapolisSufix = 'iracemapolis_sufix';

  static const basicInfoControllerClient = 'basic_info_controller_client';
  static const basicInfoControllerEquipment = 'basic_info_controller_equipment';
}

class ProductCodeAndSpecification {
  //VTN 4000
  static const List<Map<String, String>> screwsVtn4000 = [
    {'FVPG-07568': '24X100'},
    {'FVPG-07570': '24X130'},
    {'FVPG-07574': '24X160'},
    {'FVPG-05273': '24X107'},
    {'FVPG- 140194': '24X70'},
    {'FVPG-140257': '24X110'},
    {'FVPG-140256': '24X100'},
    {'FDPG-02011': 'PORCA'},
    {'FR09-007': 'ARRUELA'},
  ];

  static const List<Map<String, String>> shimsVtn4000 = [
    {'CSKC-14000RBMM1': '3 FUROS- 1MM'},
    {'CSKC-14000RBMM2': '4 FUROS-2MM'},
    {'CSCD-TB140MM1': 'LOSANGO-1MM'},
    {'CSCD-TB140MM2': 'LOSANGO-2MM'},
    {'CSKC-14000RB': '3 FUROS-10MM'},
    {'CSCD-TB140': 'LOSANGO 10MM'},
  ];

  static const List<Map<String, String>> knivesVtn4000 = [
    {'CI500-00X7070': 'BICO L.D'},
    {'CI500-00X7071': 'BICO L.E'},
    {'CVCD-TB250': 'LATERAL 3F'},
    {'CVCD-TB140': 'LOSANGO'},
    {'CVCD-S155': 'BASE'},
  ];

  //INDECO 45/90
  static const List<Map<String, String>> screwsIndeco45_90 = [
    {'301892': '27X150'},
    {'301742': '27X140'},
    {'301272': '27X120'},
    {'301302': '27X200'},
    {'301282': '27X100'},
  ];

  static const List<Map<String, String>> shimsIndeco45_90 = [
    {'S4501712MM1': '4 FUROS- 1MM'},
    {'S4501712MM2': '4 FUROS-2MM'},
    {'S4501741MM1': 'LOSANGO-1MM'},
    {'S4501741MM2': 'LOSANGO-2MM'},
    {'S4501731MM1': 'BASE-1MM'},
    {'S4501731MM2': 'BASE-2MM'},
    {'S4501812': '4 FUROS-5MM'},
    {'S4501822': 'BICO-5MM'},
  ];

  static const List<Map<String, String>> knivesIndeco45_90 = [
    {'S450-2613': 'BICO'},
    {'S450-1612': '4 FUROS'},
    {'S450-1641A': 'LOSANGO'},
    {'S450-1631': 'BASE'},
  ];

  //INDECO 35/60
  static const List<Map<String, String>> screwsIndeco35_60 = [
    {'3019-12': '24X130'},
    {'3019-22': '24X180'},
    {'3019-32': '24X120'},
    {'3001-92': '24X90'},
  ];

  static const List<Map<String, String>> shimsIndeco35_60 = [
    {'S3501710MM1':'4 FUROS-1MM'},
    {'S3501710MM2':'4 FUROS-2MM'},
    {'S350-174MM1':'LOSANGO-1MM'},
    {'S350-1741MM2':'LOSANGO-2MM'},
    {'S350-1730MM1':'BASE-1MM'},
    {'S350-1739MM2':'BASE-2MM'},
    {'S350-1810':'4 FUROS-4MM'},
    {'S350-1820':'BICO-4MM'},
  ];

  static const List<Map<String, String>> knivesIndeco35_60 = [
    {'S350-2611': 'BICO'},    
    {'S350-1610': '4 FUROS'},    
    {'S350-1641': 'LOSANGO'},
    {'S350-1630': 'BASE'},
  ];

  //LABOUNTY MSD 2500
  static const List<Map<String, String>> screwsLabountyMsd2500 = [
    {'5130-07': 'M24X100'},
    {'1201-0238': 'M24X100'},
    {'1201-0239': 'M24X140'},
    {'1201-0241': 'M24X150'},
    {'1201-0240': 'M24X160'},
    {'5014-45': 'ARRUELA'},
  ];

  static const List<Map<String, String>> shimsLabountyMsd2500 = [
    {'5117-34': '4 FUROS-1MM'},
    {'5117-34MM2': '4 FUROS-2MM'},
    {'5121-26': '3 FUROS-1MM'},
    {'5121-26MM2': '3FUROS-2MM'},
    {'5107-65': 'LOSANGO-1MM'},
    {'5107-65MM2': 'LOSANGO-2MM'},
    {'1651-09': '3 FUROS-10MM'},
    {'1445-90': '4FUROS-10MM'},
  ];

  static const List<Map<String, String>> knivesLabountyMsd2500 = [
    {'5132-81': 'BICO'},
    {'5132-83': '4 FUROS'},
    {'5118-35': '3 FUROS'},
    {'5119-92': 'LOSANGO'},
    {'5129-20': 'BASE'},
  ];

  //LABOUNTY MSD 4000
  static const List<Map<String, String>> screwslabountyMsd4000 = [
    {'501517': '24X150'},
    {'503082': '24X160'},
    {'503227': '24X130'},
    {'510824': '24X110'},
    {'512390': 'PINO GUIA'},
    {'513007': '24X100'},
  ];
  
  static const List<Map<String, String>> shimslabountyMsd4000 = [
    {'141586': '4 FUROS- 10MM'},
    {'144127': '6 FUROS-10MM'},
    {'SDXZWER': '4 FUROS- 1MM'},
    {'511746': '6 FUROS-1MM'},
    {'510765': 'LOSANGO-1MM'},
    {'510606MM2': '4 FUROS-2MM'},
    {'511746MM2': '6 FUROS-2MM'},
    {'510765MM2': 'LOSANGO-2MM'},
  ];

  static const List<Map<String, String>> kniveslabountyMsd4000 = [
    {'5121-48': '6 FUROS'},
    {'5117-60': '4 FUROS'},
    {'5134-35': 'BICO'},
    {'5119-92': 'LOSANGO'},
    {'5129-20': 'BASE'},
  ];
}