import 'package:equatable/equatable.dart';

import '../../data/models/notification_model.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

/// Load all notifications
class LoadNotifications extends NotificationEvent {
  const LoadNotifications();
}

/// Filter notifications by category
class FilterByCategory extends NotificationEvent {
  final NotificationCategory category;

  const FilterByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

/// Mark a single notification as read
class MarkNotificationAsRead extends NotificationEvent {
  final String notificationId;

  const MarkNotificationAsRead(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

/// Mark all notifications as read
class MarkAllNotificationsAsRead extends NotificationEvent {
  const MarkAllNotificationsAsRead();
}

/// Delete a notification
class DeleteNotification extends NotificationEvent {
  final String notificationId;

  const DeleteNotification(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

/// Add a new notification (from FCM)
class AddNotification extends NotificationEvent {
  final NotificationModel notification;

  const AddNotification(this.notification);

  @override
  List<Object?> get props => [notification];
}

/// Load notification preferences
class LoadPreferences extends NotificationEvent {
  const LoadPreferences();
}

/// Update notification preferences
class UpdatePreferences extends NotificationEvent {
  final NotificationPreferencesModel preferences;

  const UpdatePreferences(this.preferences);

  @override
  List<Object?> get props => [preferences];
}

/// Subscribe to a notification topic
class SubscribeToTopic extends NotificationEvent {
  final String topic;

  const SubscribeToTopic(this.topic);

  @override
  List<Object?> get props => [topic];
}

/// Unsubscribe from a notification topic
class UnsubscribeFromTopic extends NotificationEvent {
  final String topic;

  const UnsubscribeFromTopic(this.topic);

  @override
  List<Object?> get props => [topic];
}
