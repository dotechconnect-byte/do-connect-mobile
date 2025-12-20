class InvoiceModel {
  final String invoiceNumber;
  final String period;
  final String submittedDate;
  final int staffCount;
  final String totalHours;
  final String amount;
  final String dueDate;
  final InvoiceStatus status;
  final List<AttendanceDate> attendanceDates;

  InvoiceModel({
    required this.invoiceNumber,
    required this.period,
    required this.submittedDate,
    required this.staffCount,
    required this.totalHours,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.attendanceDates,
  });
}

enum InvoiceStatus {
  pending,
  paid,
  overdue,
}

class AttendanceDate {
  final String date;
  final int doerCount;
  final String hours;
  final int shifts;

  AttendanceDate({
    required this.date,
    required this.doerCount,
    required this.hours,
    required this.shifts,
  });
}

// Extension for status display
extension InvoiceStatusExtension on InvoiceStatus {
  String get displayName {
    switch (this) {
      case InvoiceStatus.pending:
        return 'pending';
      case InvoiceStatus.paid:
        return 'paid';
      case InvoiceStatus.overdue:
        return 'overdue';
    }
  }
}
