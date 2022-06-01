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
    'cellAdress': 'B43',
  };
  Map<String, String?> fleet = {
    'cellAdress': 'B15',
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

  // final String dateCellAdress = 'J5';
  // final String clientCellAdress = 'D6';
  // final String localOfAttendanceCellAdress = 'D7';
  // final String osCellAdress = 'I6';
  // final String requesterCellAdress = 'D9';
  // final String attendantCellAdress = 'I9';
  // late final String maintenanceCellAdress;
  // late final String correctiveMaintenanceOriginCellAdress;
  // late final String isStoppedMachineCellAdress;
  // late final String isWarrantyCellAdress;
  // late final String equipmentCellAdress;
  // late final String equipmentApplicationCellAdress;
  // final String fleetCellAdress = 'B15';
  // final String fleetSecondCellAdress = 'D43';
  // final String modelCellAdress = 'D15';
  // final String serieCellAdress = 'F15';
  // final String hourMeterCellAdress = 'J15';
  // final String plateCellAdress = 'B43';

  void treatTheProperties() {
    date['value'] == null ? date['value'] = 'DATA: ' : date['value'] = 'DATA: ${date['value']}';
    
    if (maintenance['value'] != null) {
      maintenance['value'] = '[ X ] ${maintenance['value']?.toUpperCase()}';
      if (maintenance['value'] == Maintenance.corrective) {
        maintenance['cellAdress'] = 'H7';
      } else {
        maintenance['cellAdress'] = 'J7';
      }
    }
    if(correctiveMaintenanceOrigin['value'] != null) {
      correctiveMaintenanceOrigin['value'] = '[ X ] ${correctiveMaintenanceOrigin['value']?.toUpperCase()}';
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
    }

    if(isStoppedMachine['value'] != null) {
      isStoppedMachine['value'] = '[ X ] ${isStoppedMachine['value']?.toUpperCase()}';
      if(isStoppedMachine['value'] == YesNo.yes) {
        isStoppedMachine['cellAdress'] = 'D10';
      } else {
        isStoppedMachine['cellAdress'] = 'E10';
      }
    }

    if(isWarranty['value'] != null) {
      isWarranty['value'] = '[ X ] ${isWarranty['value']?.toUpperCase()}';
      if(isWarranty['value'] == YesNo.yes) {
        isWarranty['cellAdress'] = 'G10';
      } else {
        isWarranty['cellAdress'] = 'H10';
      }
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

    fleet['value'] == null ? '' : fleet['value'] = 'FROTA: $fleet';
    model['value'] == null ? '' : model['value'] = 'MODELO: $model';
    serie['value'] == null ? '': serie['value'] = 'SÉRIE: $serie';
    hourMeter['value'] == null ? '' : hourMeter['value'] = 'HORÍMETRO: $hourMeter';
    plate['value'] == null ? '' : plate['value'] = 'PLACA: $plate';
  }

  List<Map<String, String?>> toList() {
    List<Map<String, String?>> list = [];
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
    list.add(model);
    list.add(serie);
    list.add(hourMeter);
    list.add(plate);
    return list;
  }
}