import 'dart:developer';

class RegistersModel {

  final Map<String, String?> _oneWayDepartureDateTime = {
    'cellAdress': 'C42',
  };
  final Map<String, String?> _oneWayArrivalDateTime = {
    'cellAdress': 'C43',
  };
  final Map<String, String?> _returnDepartureDateTime = {
    'cellAdress': 'H42',
  };
  final Map<String, String?> _returnArrivalDateTime = {
    'cellAdress': 'H43',
  };
  final Map<String, String?> _initialKm = {
    'cellAdress': 'F45',
  };
  final Map<String, String?> _finalKm = {
    'cellAdress': 'I45',
  };
  final Map<String, String?> _attendanceDate = {
    'cellAdress': 'C47',
  };
  final Map<String, String?> _attendanceStartTime = {
    'cellAdress': 'E47',
  };
  final Map<String, String?> _attendanceEndTime = {
    'cellAdress': 'G47',
  };

  String? oneWayDepartureDate;
  String? oneWayDepartureTime;

  String? oneWayArrivalDate;
  String? oneWayArrivalTime;

  String? returnDepartureDate;
  String? returnDepartureTime;

  String? returnArrivalDate;
  String? returnArrivalTime;
  
  String? initialKm;
  String? finalKm;

  String? attendanceDate;
  String? attendanceStartTime;
  String? attendanceEndTime;

  void treatTheProperties() {
    
    // Treating values of the departure
    if (oneWayDepartureDate != null || oneWayDepartureTime != null) {
      _oneWayDepartureDateTime['value'] =
           'DATA E HORA SAÍDA: ${oneWayDepartureDate ?? ''} ${oneWayDepartureTime ?? ''}';
    }
    
    if (oneWayArrivalDate != null || oneWayArrivalTime != null) {
      _oneWayArrivalDateTime['value'] =
           'DATA E HORA CHEGADA: ${oneWayArrivalDate ?? ''} ${oneWayArrivalTime ?? ''}';
    }

    // Treating values of the arrival
    if (returnDepartureDate != null || returnDepartureTime != null) {
      _returnDepartureDateTime['value'] =
           'DATA E HORA SAÍDA: ${returnDepartureDate ?? ''} ${returnDepartureTime ?? ''}';
    }

    if (returnArrivalDate != null || returnArrivalTime != null) {
      _returnArrivalDateTime['value'] =
           'DATA E HORA CHEGADA: ${returnArrivalDate ?? ''} ${returnArrivalTime ?? ''}';
    }

    _initialKm['value'] = 'KM INICIAL: ${initialKm ?? ''}';
    _finalKm['value'] = 'KM FINAL: ${finalKm ?? ''}';

    _attendanceDate['value'] = attendanceDate ?? '';
    _attendanceStartTime['value'] = attendanceStartTime ?? '';
    _attendanceEndTime['value'] = attendanceEndTime ?? '';

  }

  List<Map<String, String?>> toList() {
    final List<Map<String, String?>> list = [];
    list.add(_oneWayDepartureDateTime);
    list.add(_oneWayArrivalDateTime);
    list.add(_returnDepartureDateTime);
    list.add(_returnArrivalDateTime);
    list.add(_initialKm);
    list.add(_finalKm);
    list.add(_attendanceDate);
    list.add(_attendanceStartTime);
    list.add(_attendanceEndTime);
    return list;
  }
}