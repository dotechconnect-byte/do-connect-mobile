class TransportStaffModel {
  final String id;
  final String name;
  final String region;
  final String pickUpDropOff;
  final String transportTiming;
  final String? notes;
  String? assignedTransport;

  TransportStaffModel({
    required this.id,
    required this.name,
    required this.region,
    required this.pickUpDropOff,
    required this.transportTiming,
    this.notes,
    this.assignedTransport,
  });
}
