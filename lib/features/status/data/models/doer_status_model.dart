class DoerStatusModel {
  final String id;
  final String name;
  final String gender;
  final String timeRange;
  final String location;
  final String station;
  final String manager;
  final DoerWorkStatus status;
  final String? scannedInTime;

  DoerStatusModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.timeRange,
    required this.location,
    required this.station,
    required this.manager,
    required this.status,
    this.scannedInTime,
  });

  factory DoerStatusModel.fromJson(Map<String, dynamic> json) {
    return DoerStatusModel(
      id: json['id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      timeRange: json['timeRange'] as String,
      location: json['location'] as String,
      station: json['station'] as String,
      manager: json['manager'] as String,
      status: DoerWorkStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => DoerWorkStatus.scheduled,
      ),
      scannedInTime: json['scannedInTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'timeRange': timeRange,
      'location': location,
      'station': station,
      'manager': manager,
      'status': status.name,
      'scannedInTime': scannedInTime,
    };
  }
}

enum DoerWorkStatus {
  working,
  scheduled,
  completed,
  absent,
}
