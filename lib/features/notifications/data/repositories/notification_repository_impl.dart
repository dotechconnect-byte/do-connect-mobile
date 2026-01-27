import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/cache_services.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/utilities/typedef.dart';
import '../../domain/repositories/notification_repository.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final CacheService _cacheService;
  final NotificationService _notificationService;
  // TODO: Add remote data source when API is ready
  // final NotificationRemoteDataSource _remoteDataSource;

  static const String _notificationsCacheKey = 'cached_notifications';
  static const String _preferencesCacheKey = 'notification_preferences';

  NotificationRepositoryImpl({
    required CacheService cacheService,
    required NotificationService notificationService,
  })  : _cacheService = cacheService,
        _notificationService = notificationService;

  // In-memory notifications list (will be replaced with API calls)
  List<NotificationModel> _notifications = [];

  @override
  ResultFuture<List<NotificationModel>> getNotifications() async {
    try {
      // TODO: Replace with API call when ready
      // final result = await _remoteDataSource.getNotifications();

      // For now, return cached notifications or empty list
      final cached = await _cacheService.readCache(key: _notificationsCacheKey);
      if (cached != null) {
        final List<dynamic> jsonList = jsonDecode(cached);
        _notifications =
            jsonList.map((e) => NotificationModel.fromJson(e)).toList();
      }

      return Right(_notifications);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  ResultFuture<List<NotificationModel>> getNotificationsByCategory(
      NotificationCategory category) async {
    try {
      final result = await getNotifications();
      return result.fold(
        (failure) => Left(failure),
        (notifications) {
          if (category == NotificationCategory.all) {
            return Right(notifications);
          }
          return Right(
            notifications.where((n) => n.category == category).toList(),
          );
        },
      );
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  ResultFuture<void> markAsRead(String notificationId) async {
    try {
      // TODO: Call API when ready
      // await _remoteDataSource.markAsRead(notificationId);

      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(isRead: true);
        await _cacheNotifications();
      }

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  ResultFuture<void> markAllAsRead() async {
    try {
      // TODO: Call API when ready
      // await _remoteDataSource.markAllAsRead();

      _notifications = _notifications
          .map((n) => n.copyWith(isRead: true))
          .toList();
      await _cacheNotifications();

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  ResultFuture<void> deleteNotification(String notificationId) async {
    try {
      // TODO: Call API when ready
      // await _remoteDataSource.deleteNotification(notificationId);

      _notifications.removeWhere((n) => n.id == notificationId);
      await _cacheNotifications();

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  ResultFuture<int> getUnreadCount() async {
    try {
      final result = await getNotifications();
      return result.fold(
        (failure) => Left(failure),
        (notifications) => Right(notifications.where((n) => !n.isRead).length),
      );
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  ResultFuture<NotificationPreferencesModel> getPreferences() async {
    try {
      // TODO: Call API when ready
      // return Right(await _remoteDataSource.getPreferences());

      final cached = await _cacheService.readCache(key: _preferencesCacheKey);
      if (cached != null) {
        return Right(NotificationPreferencesModel.fromJson(jsonDecode(cached)));
      }

      return const Right(NotificationPreferencesModel());
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  ResultFuture<void> updatePreferences(
      NotificationPreferencesModel preferences) async {
    try {
      // TODO: Call API when ready
      // await _remoteDataSource.updatePreferences(preferences);

      await _cacheService.writeCache(
        key: _preferencesCacheKey,
        value: jsonEncode(preferences.toJson()),
      );

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  ResultFuture<void> registerFcmToken(String token) async {
    try {
      // TODO: Call API to register token with backend
      // await _remoteDataSource.registerFcmToken(token);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  ResultFuture<void> subscribeToTopic(String topic) async {
    try {
      await _notificationService.subscribeToTopic(topic);
      return const Right(null);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  ResultFuture<void> unsubscribeFromTopic(String topic) async {
    try {
      await _notificationService.unsubscribeFromTopic(topic);
      return const Right(null);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  /// Add a notification locally (from FCM)
  Future<void> addNotification(NotificationModel notification) async {
    _notifications.insert(0, notification);
    await _cacheNotifications();
  }

  /// Cache notifications locally
  Future<void> _cacheNotifications() async {
    final jsonList = _notifications.map((n) => n.toJson()).toList();
    await _cacheService.writeCache(
      key: _notificationsCacheKey,
      value: jsonEncode(jsonList),
    );
  }
}
