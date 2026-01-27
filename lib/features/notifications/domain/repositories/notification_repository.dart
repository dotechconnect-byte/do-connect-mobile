import '../../../../core/utilities/typedef.dart';
import '../../data/models/notification_model.dart';

abstract class NotificationRepository {
  /// Get all notifications
  ResultFuture<List<NotificationModel>> getNotifications();

  /// Get notifications by category
  ResultFuture<List<NotificationModel>> getNotificationsByCategory(
      NotificationCategory category);

  /// Mark a notification as read
  ResultFuture<void> markAsRead(String notificationId);

  /// Mark all notifications as read
  ResultFuture<void> markAllAsRead();

  /// Delete a notification
  ResultFuture<void> deleteNotification(String notificationId);

  /// Get unread count
  ResultFuture<int> getUnreadCount();

  /// Get notification preferences
  ResultFuture<NotificationPreferencesModel> getPreferences();

  /// Update notification preferences
  ResultFuture<void> updatePreferences(NotificationPreferencesModel preferences);

  /// Register FCM token with backend
  ResultFuture<void> registerFcmToken(String token);

  /// Subscribe to a topic
  ResultFuture<void> subscribeToTopic(String topic);

  /// Unsubscribe from a topic
  ResultFuture<void> unsubscribeFromTopic(String topic);
}
