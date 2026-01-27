import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/interceptor/app_dio.dart';
import 'core/services/cache_services.dart';
import 'core/services/notification_service.dart';
import 'features/notifications/data/repositories/notification_repository_impl.dart';
import 'features/notifications/domain/repositories/notification_repository.dart';
import 'features/notifications/presentation/bloc/notification_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // ==================== Core Services ====================
  locator.registerLazySingleton<CacheService>(() => CacheService());
  locator.registerLazySingleton<Dio>(() => Api().dio);
  locator.registerLazySingleton<NotificationService>(() => NotificationService());

  // ==================== Repositories ====================
  locator.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      cacheService: locator<CacheService>(),
      notificationService: locator<NotificationService>(),
    ),
  );

  // ==================== Blocs ====================
  locator.registerFactory<NotificationBloc>(
    () => NotificationBloc(repository: locator<NotificationRepository>()),
  );
}
