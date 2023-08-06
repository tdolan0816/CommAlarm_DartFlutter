// ignore_for_file: camel_case_types

class DBDataModel {
  final int? id;
  final String origin;
  final String destination;
  final String durationInTraffic;


  const DBDataModel ({
    required this.id,
    required this.origin,
    required this.destination,
    required this.durationInTraffic,
  });

  factory DBDataModel.fromJSON(Map<String, dynamic> json) =>  DBDataModel(
    id: json['id'],
    origin: json['origin'],
    destination: json['destination'],
    durationInTraffic: json['durationInTraffic'],
  );

  Map<String, dynamic> toJSON() => {
    'origin': origin,
    'destination': destination,
    'durationInTraffic': durationInTraffic,
  };
}