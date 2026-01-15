class AttendanceModel {
  final String id;
  final int number;
  final String name;
  final String shift;
  final String location;
  final String station;
  final String? checkInTime;
  final AttendanceStatus status;

  AttendanceModel({
    required this.id,
    required this.number,
    required this.name,
    required this.shift,
    required this.location,
    required this.station,
    this.checkInTime,
    required this.status,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] as String,
      number: json['number'] as int,
      name: json['name'] as String,
      shift: json['shift'] as String,
      location: json['location'] as String,
      station: json['station'] as String,
      checkInTime: json['checkInTime'] as String?,
      status: AttendanceStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AttendanceStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'name': name,
      'shift': shift,
      'location': location,
      'station': station,
      'checkInTime': checkInTime,
      'status': status.name,
    };
  }
}

enum AttendanceStatus {
  processing,
  pending,
  confirmed,
  cancelled,
}
