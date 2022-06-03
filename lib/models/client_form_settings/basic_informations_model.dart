import 'package:formulario_de_atendimento/default_values/default_values.dart';

class BasicInformationsModel {

  Map<String, String?> date = {
    'cellAdress': 'J5',
  };
  Map<String, String?> client = {
    'cellAdress': 'D6',
  };
  Map<String, String?> localOfAttendance = {
    'cellAdress': 'D7',
  };
  Map<String, String?> os = {
    'cellAdress': 'I6',
  };
  Map<String, String?> requester = {
    'cellAdress': 'D9',
  };
  Map<String, String?> attendant = {
    'cellAdress': 'I9',
  };
  Map<String, String?> maintenance = {
    'cellAdress': '',
  };
  Map<String, String?> correctiveMaintenanceOrigin = {
    'cellAdress': '',
  };
  Map<String, String?> isStoppedMachine = {
    'cellAdress': '',
  };
  Map<String, String?> isWarranty = {
    'cellAdress': '',
  };
  Map<String, String?> equipment = {
    'cellAdress': '',
  };
  Map<String, String?> equipmentApplication = {
    'cellAdress': '',
  };
  Map<String, String?> plate = {
    'cellAdress': 'B45',
  };
  Map<String, String?> fleet = {
    'cellAdress': 'B15',
  };
  Map<String, String?> fleetSecond = {
    'cellAdress': 'D45',
  };
  Map<String, String?> model = {
    'cellAdress': 'D15',
  };
  Map<String, String?> serie = {
    'cellAdress': 'F15',
  };
  Map<String, String?> hourMeter = {
    'cellAdress': 'J15',
  };

  void treatTheProperties() {

    date['value'] == null ? date['value'] = 'DATA: ' : date['value'] = 'DATA: ${date['value']}';
    
    if (maintenance['value'] != null) {
      if (maintenance['value'] == Maintenance.corrective) {
        maintenance['cellAdress'] = 'H7';
      } else {
        maintenance['cellAdress'] = 'J7';
        correctiveMaintenanceOrigin['value'] = null;
      }
       maintenance['value'] = '[ X ] ${maintenance['value']?.toUpperCase()}';
    }
    if(correctiveMaintenanceOrigin['value'] != null) {
      if(correctiveMaintenanceOrigin['value'] == CorrectiveMaintenanceOrigin.operationalFailure) {
        correctiveMaintenanceOrigin['cellAdress'] = 'B14';
      } else if (correctiveMaintenanceOrigin['value'] == CorrectiveMaintenanceOrigin.withoutPreventive) {
        correctiveMaintenanceOrigin['cellAdress'] = 'D14';
      } else if (correctiveMaintenanceOrigin['value'] == CorrectiveMaintenanceOrigin.wearByLoadedMaterial) {
        correctiveMaintenanceOrigin['cellAdress'] = 'F14';
      } else if (correctiveMaintenanceOrigin['value'] == CorrectiveMaintenanceOrigin.wearCommon) {
        correctiveMaintenanceOrigin['cellAdress'] = 'I14';
      } else if (correctiveMaintenanceOrigin['value'] == CorrectiveMaintenanceOrigin.other) {
        correctiveMaintenanceOrigin['cellAdress'] = 'K14';
      }
      correctiveMaintenanceOrigin['value'] = '[ X ] ${correctiveMaintenanceOrigin['value']?.toUpperCase()}';
    }

    if(isStoppedMachine['value'] != null) {
      if(isStoppedMachine['value'] == YesNo.yes) {
        isStoppedMachine['cellAdress'] = 'D10';
      } else {
        isStoppedMachine['cellAdress'] = 'E10';
      }
      isStoppedMachine['value'] = '[ X ] ${isStoppedMachine['value']?.toUpperCase()}';
    }

    if(isWarranty['value'] != null) {
      if(isWarranty['value'] == YesNo.yes) {
        isWarranty['cellAdress'] = 'G10';
      } else {
        isWarranty['cellAdress'] = 'H10';
      }
      isWarranty['value'] = '[ X ] ${isWarranty['value']?.toUpperCase()}';
    }
    
    if(equipment['value'] != null) {
      equipment['cellAdress'] = 'C11';
      if(equipment['value'] == Equipment.loader) {
        equipment['value'] = '[ X ] Carregadeira        [   ] Escavadeira    [   ] Rolo Compactador       [   ] Trator       [   ] Outros';
      } else if (equipment['value'] == Equipment.excavator) {
        equipment['value'] = '[   ] Carregadeira        [ X ] Escavadeira    [   ] Rolo Compactador       [   ] Trator       [   ] Outros';
      } else if (equipment['value'] == Equipment.rollerCompactor) {
        equipment['value'] = '[   ] Carregadeira        [   ] Escavadeira    [ X ] Rolo Compactador       [   ] Trator       [   ] Outros';
      } else if (equipment['value'] == Equipment.tractor) {
        equipment['value'] = '[   ] Carregadeira        [   ] Escavadeira    [   ] Rolo Compactador       [ X ] Trator       [   ] Outros';
      } else if (equipment['value'] == Equipment.other) {
        equipment['value'] = '[   ] Carregadeira        [   ] Escavadeira    [   ] Rolo Compactador       [   ] Trator       [ X ] Outros';
      }
    }

    if(equipmentApplication['value'] != null) {
      equipmentApplication['cellAdress'] = 'C12';
      if(equipmentApplication['value'] == EquipmentApplication.loading) {
        equipmentApplication['value'] = '[ X ] Carregamento      [   ] Escavação      [   ] Terraplanagem      [   ] Rompedor      [   ] Sucata/Tesoura';
      } else if(equipmentApplication['value'] == EquipmentApplication.excavation) {
        equipmentApplication['value'] = '[   ] Carregamento      [ X ] Escavação      [   ] Terraplanagem      [   ] Rompedor      [   ] Sucata/Tesoura';
      } else if(equipmentApplication['value'] == EquipmentApplication.terraplanning) {
        equipmentApplication['value'] = '[   ] Carregamento      [   ] Escavação      [ X ] Terraplanagem      [   ] Rompedor      [   ] Sucata/Tesoura';
      } else if(equipmentApplication['value'] == EquipmentApplication.digger) {
        equipmentApplication['value'] = '[   ] Carregamento      [   ] Escavação      [   ] Terraplanagem      [ X ] Rompedor      [   ] Sucata/Tesoura';
      } else if(equipmentApplication['value'] == EquipmentApplication.scrap) {
        equipmentApplication['value'] = '[   ] Carregamento      [   ] Escavação      [   ] Terraplanagem      [   ] Rompedor      [ X ] Sucata/Tesoura';
      }
    }

    if(fleet['value'] != null) {
      fleet['value'] = 'FROTA: ${fleet['value']}';
      fleetSecond['value'] = '${fleet['value']}';
    }

    model['value'] == null ? '' : model['value'] = 'MODELO: ${model['value']}';
    serie['value'] == null ? '': serie['value'] = 'SÉRIE: ${serie['value']}';
    hourMeter['value'] == null ? '' : hourMeter['value'] = 'HORÍMETRO: ${hourMeter['value']}';
    plate['value'] == null ? '' : plate['value'] = 'PLACA: ${plate['value']}';
  }

  List<Map<String, String?>> toList() {
    final List<Map<String, String?>> list = [];
    list.add(date);
    list.add(client);
    list.add(localOfAttendance);
    list.add(os);
    list.add(requester);
    list.add(attendant);
    list.add(maintenance);
    list.add(correctiveMaintenanceOrigin);
    list.add(isStoppedMachine);
    list.add(isWarranty);
    list.add(equipment);
    list.add(equipmentApplication);
    list.add(fleet);
    list.add(fleetSecond);
    list.add(model);
    list.add(serie);
    list.add(hourMeter);
    list.add(plate);
    return list;
  }
}