import 'package:equatable/equatable.dart';

enum NotificationCategory { all, jobs, bills, work, money, alerts }

enum NotificationType { push, email, whatsapp }

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String message;
  final NotificationCategory category;
  final DateTime createdAt;
  final bool isRead;
  final Map<String, dynamic>? data;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.category,
    required this.createdAt,
    this.isRead = false,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? json['body'] ?? '',
      category: _categoryFromString(json['category']),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      isRead: json['is_read'] ?? false,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'category': category.name,
      'created_at': createdAt.toIso8601String(),
      'is_read': isRead,
      'data': data,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    NotificationCategory? category,
    DateTime? createdAt,
    bool? isRead,
    Map<String, dynamic>? data,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      data: data ?? this.data,
    );
  }

  static NotificationCategory _categoryFromString(String? category) {
    switch (category?.toLowerCase()) {
      case 'jobs':
        return NotificationCategory.jobs;
      case 'bills':
        return NotificationCategory.bills;
      case 'work':
        return NotificationCategory.work;
      case 'money':
        return NotificationCategory.money;
      case 'alerts':
        return NotificationCategory.alerts;
      default:
        return NotificationCategory.all;
    }
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return 'about ${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return 'about ${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }

  @override
  List<Object?> get props => [id, title, message, category, createdAt, isRead, data];
}

class NotificationPreferencesModel extends Equatable {
  final bool enableAll;
  final bool pushNotifications;
  final bool emailNotifications;
  final bool whatsAppNotifications;
  final bool invoiceNotifications;
  final bool jobNotifications;
  final bool doerStatusNotifications;
  final bool slotAssignmentNotifications;
  final bool paymentNotifications;

  const NotificationPreferencesModel({
    this.enableAll = true,
    this.pushNotifications = true,
    this.emailNotifications = true,
    this.whatsAppNotifications = true,
    this.invoiceNotifications = true,
    this.jobNotifications = true,
    this.doerStatusNotifications = true,
    this.slotAssignmentNotifications = true,
    this.paymentNotifications = true,
  });

  factory NotificationPreferencesModel.fromJson(Map<String, dynamic> json) {
    return NotificationPreferencesModel(
      enableAll: json['enable_all'] ?? true,
      pushNotifications: json['push_notifications'] ?? true,
      emailNotifications: json['email_notifications'] ?? true,
      whatsAppNotifications: json['whatsapp_notifications'] ?? true,
      invoiceNotifications: json['invoice_notifications'] ?? true,
      jobNotifications: json['job_notifications'] ?? true,
      doerStatusNotifications: json['doer_status_notifications'] ?? true,
      slotAssignmentNotifications: json['slot_assignment_notifications'] ?? true,
      paymentNotifications: json['payment_notifications'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enable_all': enableAll,
      'push_notifications': pushNotifications,
      'email_notifications': emailNotifications,
      'whatsapp_notifications': whatsAppNotifications,
      'invoice_notifications': invoiceNotifications,
      'job_notifications': jobNotifications,
      'doer_status_notifications': doerStatusNotifications,
      'slot_assignment_notifications': slotAssignmentNotifications,
      'payment_notifications': paymentNotifications,
    };
  }

  NotificationPreferencesModel copyWith({
    bool? enableAll,
    bool? pushNotifications,
    bool? emailNotifications,
    bool? whatsAppNotifications,
    bool? invoiceNotifications,
    bool? jobNotifications,
    bool? doerStatusNotifications,
    bool? slotAssignmentNotifications,
    bool? paymentNotifications,
  }) {
    return NotificationPreferencesModel(
      enableAll: enableAll ?? this.enableAll,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      whatsAppNotifications: whatsAppNotifications ?? this.whatsAppNotifications,
      invoiceNotifications: invoiceNotifications ?? this.invoiceNotifications,
      jobNotifications: jobNotifications ?? this.jobNotifications,
      doerStatusNotifications: doerStatusNotifications ?? this.doerStatusNotifications,
      slotAssignmentNotifications: slotAssignmentNotifications ?? this.slotAssignmentNotifications,
      paymentNotifications: paymentNotifications ?? this.paymentNotifications,
    );
  }

  @override
  List<Object?> get props => [
        enableAll,
        pushNotifications,
        emailNotifications,
        whatsAppNotifications,
        invoiceNotifications,
        jobNotifications,
        doerStatusNotifications,
        slotAssignmentNotifications,
        paymentNotifications,
      ];
}
