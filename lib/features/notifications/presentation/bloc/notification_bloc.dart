import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/notification_model.dart';
import '../../domain/repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _repository;

  NotificationBloc({required NotificationRepository repository})
      : _repository = repository,
        super(const NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<FilterByCategory>(_onFilterByCategory);
    on<MarkNotificationAsRead>(_onMarkAsRead);
    on<MarkAllNotificationsAsRead>(_onMarkAllAsRead);
    on<DeleteNotification>(_onDeleteNotification);
    on<AddNotification>(_onAddNotification);
    on<LoadPreferences>(_onLoadPreferences);
    on<UpdatePreferences>(_onUpdatePreferences);
    on<SubscribeToTopic>(_onSubscribeToTopic);
    on<UnsubscribeFromTopic>(_onUnsubscribeFromTopic);
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoading());

    final notificationsResult = await _repository.getNotifications();
    final preferencesResult = await _repository.getPreferences();

    notificationsResult.fold(
      (failure) => emit(NotificationError(failure.message)),
      (notifications) {
        final preferences = preferencesResult.fold(
          (_) => const NotificationPreferencesModel(),
          (prefs) => prefs,
        );

        final unreadCount = notifications.where((n) => !n.isRead).length;

        emit(NotificationLoaded(
          notifications: notifications,
          filteredNotifications: notifications,
          selectedCategory: NotificationCategory.all,
          unreadCount: unreadCount,
          preferences: preferences,
        ));
      },
    );
  }

  Future<void> _onFilterByCategory(
    FilterByCategory event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      List<NotificationModel> filtered;
      if (event.category == NotificationCategory.all) {
        filtered = currentState.notifications;
      } else {
        filtered = currentState.notifications
            .where((n) => n.category == event.category)
            .toList();
      }

      emit(currentState.copyWith(
        filteredNotifications: filtered,
        selectedCategory: event.category,
      ));
    }
  }

  Future<void> _onMarkAsRead(
    MarkNotificationAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      final result = await _repository.markAsRead(event.notificationId);

      result.fold(
        (failure) => emit(NotificationError(failure.message)),
        (_) {
          final updatedNotifications = currentState.notifications.map((n) {
            if (n.id == event.notificationId) {
              return n.copyWith(isRead: true);
            }
            return n;
          }).toList();

          final updatedFiltered = currentState.filteredNotifications.map((n) {
            if (n.id == event.notificationId) {
              return n.copyWith(isRead: true);
            }
            return n;
          }).toList();

          final unreadCount = updatedNotifications.where((n) => !n.isRead).length;

          emit(currentState.copyWith(
            notifications: updatedNotifications,
            filteredNotifications: updatedFiltered,
            unreadCount: unreadCount,
          ));
        },
      );
    }
  }

  Future<void> _onMarkAllAsRead(
    MarkAllNotificationsAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      final result = await _repository.markAllAsRead();

      result.fold(
        (failure) => emit(NotificationError(failure.message)),
        (_) {
          final updatedNotifications =
              currentState.notifications.map((n) => n.copyWith(isRead: true)).toList();

          final updatedFiltered =
              currentState.filteredNotifications.map((n) => n.copyWith(isRead: true)).toList();

          emit(currentState.copyWith(
            notifications: updatedNotifications,
            filteredNotifications: updatedFiltered,
            unreadCount: 0,
          ));
        },
      );
    }
  }

  Future<void> _onDeleteNotification(
    DeleteNotification event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      final result = await _repository.deleteNotification(event.notificationId);

      result.fold(
        (failure) => emit(NotificationError(failure.message)),
        (_) {
          final updatedNotifications = currentState.notifications
              .where((n) => n.id != event.notificationId)
              .toList();

          final updatedFiltered = currentState.filteredNotifications
              .where((n) => n.id != event.notificationId)
              .toList();

          final unreadCount = updatedNotifications.where((n) => !n.isRead).length;

          emit(currentState.copyWith(
            notifications: updatedNotifications,
            filteredNotifications: updatedFiltered,
            unreadCount: unreadCount,
          ));
        },
      );
    }
  }

  Future<void> _onAddNotification(
    AddNotification event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      final updatedNotifications = [event.notification, ...currentState.notifications];

      List<NotificationModel> updatedFiltered;
      if (currentState.selectedCategory == NotificationCategory.all ||
          event.notification.category == currentState.selectedCategory) {
        updatedFiltered = [event.notification, ...currentState.filteredNotifications];
      } else {
        updatedFiltered = currentState.filteredNotifications;
      }

      final unreadCount = updatedNotifications.where((n) => !n.isRead).length;

      emit(currentState.copyWith(
        notifications: updatedNotifications,
        filteredNotifications: updatedFiltered,
        unreadCount: unreadCount,
      ));
    }
  }

  Future<void> _onLoadPreferences(
    LoadPreferences event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await _repository.getPreferences();

    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (preferences) {
        final currentState = state;
        if (currentState is NotificationLoaded) {
          emit(currentState.copyWith(preferences: preferences));
        } else {
          emit(PreferencesUpdated(preferences));
        }
      },
    );
  }

  Future<void> _onUpdatePreferences(
    UpdatePreferences event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await _repository.updatePreferences(event.preferences);

    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (_) {
        final currentState = state;
        if (currentState is NotificationLoaded) {
          emit(currentState.copyWith(preferences: event.preferences));
        } else {
          emit(PreferencesUpdated(event.preferences));
        }
      },
    );
  }

  Future<void> _onSubscribeToTopic(
    SubscribeToTopic event,
    Emitter<NotificationState> emit,
  ) async {
    await _repository.subscribeToTopic(event.topic);
  }

  Future<void> _onUnsubscribeFromTopic(
    UnsubscribeFromTopic event,
    Emitter<NotificationState> emit,
  ) async {
    await _repository.unsubscribeFromTopic(event.topic);
  }
}
