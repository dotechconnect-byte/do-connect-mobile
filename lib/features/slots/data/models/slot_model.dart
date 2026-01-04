class SlotModel {
  final String id;
  final String timeRange;
  final String position;
  final String location;
  final int currentStaff;
  final int requiredStaff;
  final int groups;
  final int directStaff;
  final String date;
  final SlotStatus status;

  SlotModel({
    required this.id,
    required this.timeRange,
    required this.position,
    required this.location,
    required this.currentStaff,
    required this.requiredStaff,
    required this.groups,
    required this.directStaff,
    required this.date,
    this.status = SlotStatus.staff,
  });

  bool get isFilled => currentStaff >= requiredStaff;

  String get staffRatio => '$currentStaff/$requiredStaff';

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      id: json['id'] ?? '',
      timeRange: json['timeRange'] ?? '',
      position: json['position'] ?? '',
      location: json['location'] ?? '',
      currentStaff: json['currentStaff'] ?? 0,
      requiredStaff: json['requiredStaff'] ?? 0,
      groups: json['groups'] ?? 0,
      directStaff: json['directStaff'] ?? 0,
      date: json['date'] ?? '',
      status: _parseStatus(json['status']),
    );
  }

  static SlotStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'staff':
        return SlotStatus.staff;
      case 'pending':
        return SlotStatus.pending;
      case 'filled':
        return SlotStatus.filled;
      default:
        return SlotStatus.staff;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timeRange': timeRange,
      'position': position,
      'location': location,
      'currentStaff': currentStaff,
      'requiredStaff': requiredStaff,
      'groups': groups,
      'directStaff': directStaff,
      'date': date,
      'status': status.toString().split('.').last,
    };
  }
}

enum SlotStatus {
  staff,
  pending,
  filled,
}
