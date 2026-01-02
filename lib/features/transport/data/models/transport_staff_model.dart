class TransportStaffModel {
  final String id;
  final String name;
  final String region;
  final String pickUpDropOff;
  final String transportTiming;
  final String? notes;

  TransportStaffModel({
    required this.id,
    required this.name,
    required this.region,
    required this.pickUpDropOff,
    required this.transportTiming,
    this.notes,
  });
}
