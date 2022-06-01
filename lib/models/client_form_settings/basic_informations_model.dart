class BasicInformationsModel {
  String? date;
  String? localOfAttendance;
  String? os;
  String? requester;
  String? attendant;
  String? maintenance;
  String? conrrectiveMaintenanceOrigin;
  bool isStoppedMachine = false;
  bool isWarranty = false;
  String? equipment;
  String? equipmentApplication;
  String? plate;
  String? fleet;
  String? model;
  String? serie;
  String? hourMeter;

  BasicInformationsModel({
      this.date,
      this.localOfAttendance,
      this.os,
      this.requester,
      this.attendant,
      this.maintenance,
      this.conrrectiveMaintenanceOrigin,
      this.isStoppedMachine = false,
      this.isWarranty = false,
      this.equipment,
      this.equipmentApplication,
      this.plate,
      this.fleet,
      this.model,
      this.serie,
      this.hourMeter,
    }) {
   _treatTheProperties();
  }

  void _treatTheProperties() {
    date != null ? 'DATA: ' : 'DATA: $date';
    localOfAttendance ??= '';
    os ??= '';
    requester ??= '';
    attendant ??= '';
    if (maintenance != null) {
      maintenance = maintenance?.toUpperCase();
    }
    conrrectiveMaintenanceOrigin ??= '';
    equipment ??= '';
    equipmentApplication ??= '';
    plate ??= '';
    fleet ??= '';
    model ??= '';
    serie ??= '';
    hourMeter ??= '';
    
  }
}