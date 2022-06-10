import 'package:formulario_de_atendimento/default_values/default_values.dart';

class BasicInformationsModel {

  String? spreedsheetDate;
  String? client;
  String? localOfAttendance;
  String? os;
  String? requester;
  String? attendant;
  bool isCorrective = true;
  String? correctiveMaintenanceOrigin;
  bool isStoppedMachine = false;
  bool isWarranty = false;
  String? equipment;
  String? equipmentApplication;
  String? fleet;
  String? model;
  String? serie;
  String? odometer;

  void treatTheProperties() {
    
    if(equipment != null) {
      if(equipment == Equipment.loader) {
        equipment = '[ X ] Carregadeira        [   ] Escavadeira    [   ] Rolo Compactador       [   ] Trator       [   ] Outros';
      } else if (equipment == Equipment.excavator) {
        equipment = '[   ] Carregadeira        [ X ] Escavadeira    [   ] Rolo Compactador       [   ] Trator       [   ] Outros';
      } else if (equipment == Equipment.rollerCompactor) {
        equipment = '[   ] Carregadeira        [   ] Escavadeira    [ X ] Rolo Compactador       [   ] Trator       [   ] Outros';
      } else if (equipment == Equipment.tractor) {
        equipment = '[   ] Carregadeira        [   ] Escavadeira    [   ] Rolo Compactador       [ X ] Trator       [   ] Outros';
      } else if (equipment == Equipment.other) {
        equipment = '[   ] Carregadeira        [   ] Escavadeira    [   ] Rolo Compactador       [   ] Trator       [ X ] Outros';
      }
    }

    if(equipmentApplication != null) {
      if(equipmentApplication == EquipmentApplication.loading) {
        equipmentApplication = '[ X ] Carregamento      [   ] Escavação      [   ] Terraplanagem      [   ] Rompedor      [   ] Sucata/Tesoura';
      } else if(equipmentApplication == EquipmentApplication.excavation) {
        equipmentApplication = '[   ] Carregamento      [ X ] Escavação      [   ] Terraplanagem      [   ] Rompedor      [   ] Sucata/Tesoura';
      } else if(equipmentApplication == EquipmentApplication.terraplanning) {
        equipmentApplication = '[   ] Carregamento      [   ] Escavação      [ X ] Terraplanagem      [   ] Rompedor      [   ] Sucata/Tesoura';
      } else if(equipmentApplication == EquipmentApplication.digger) {
        equipmentApplication = '[   ] Carregamento      [   ] Escavação      [   ] Terraplanagem      [ X ] Rompedor      [   ] Sucata/Tesoura';
      } else if(equipmentApplication == EquipmentApplication.scrap) {
        equipmentApplication = '[   ] Carregamento      [   ] Escavação      [   ] Terraplanagem      [   ] Rompedor      [ X ] Sucata/Tesoura';
      }
    }
  }
}