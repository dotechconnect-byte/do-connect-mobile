import 'package:equatable/equatable.dart';

import '../../data/models/notification_model.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;
  final List<NotificationModel> filteredNotifications;
  final NotificationCategory selectedCategory;
  final int unreadCount;
  final NotificationPreferencesModel preferences;

  const NotificationLoaded({
    required this.notifications,
    required this.filteredNotifications,
    required this.selectedCategory,
    required this.unreadCount,
    required this.preferences,
  });

  @override
  List<Object?> get props => [
        notifications,
        filteredNotifications,
        selectedCategory,
        unreadCount,
        preferences,
      ];

  NotificationLoaded copyWith({
    List<NotificationModel>? notifications,
    List<NotificationModel>? filteredNotifications,
    NotificationCategory? selectedCategory,
    int? unreadCount,
    NotificationPreferencesModel? preferences,
  }) {
    return NotificationLoaded(
      notifications: notifications ?? this.notifications,
      filteredNotifications: filteredNotifications ?? this.filteredNotifications,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      unreadCount: unreadCount ?? this.unreadCount,
      preferences: preferences ?? this.preferences,
    );
  }
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}

class PreferencesUpdated extends NotificationState {
  final NotificationPreferencesModel preferences;

  const PreferencesUpdated(this.preferences);

  @override
  List<Object?> get props => [preferences];
}
