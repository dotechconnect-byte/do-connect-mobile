import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../../notifications/data/models/notification_model.dart';
import '../../../notifications/presentation/bloc/notification_bloc.dart';
import '../../../notifications/presentation/bloc/notification_event.dart';
import '../../../notifications/presentation/bloc/notification_state.dart';
import '../../../profile/presentation/pages/notification_preferences_screen.dart';

class NotificationPanel extends StatefulWidget {
  const NotificationPanel({super.key});

  @override
  State<NotificationPanel> createState() => _NotificationPanelState();
}

class _NotificationPanelState extends State<NotificationPanel> {
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    // Load notifications when panel opens
    context.read<NotificationBloc>().add(const LoadNotifications());
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: colors.background),
            child: SafeArea(
              child: Column(
                children: [
                  // Header
                  _buildHeader(context, colors, state),

                  // Action Buttons
                  _buildActionButtons(context, colors, state),

                  SizedBox(height: 12.h),

                  // Tabs
                  _buildTabs(context, colors, state),

                  SizedBox(height: 16.h),

                  // Notifications List
                  Expanded(
                    child: _buildNotificationsList(context, colors, state),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, ThemeHelper colors, NotificationState state) {
    final unreadCount =
        state is NotificationLoaded ? state.unreadCount : 0;

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Icon(
            Icons.notifications,
            size: 24.sp,
            color: colors.textPrimary,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Notifications',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeightManager.bold,
                color: colors.textPrimary,
              ),
            ),
          ),
          if (unreadCount > 0)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: colors.error,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                unreadCount.toString(),
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManager.white,
                ),
              ),
            ),
          SizedBox(width: 8.w),
          IconButton(
            icon: Icon(Icons.close, size: 24.sp, color: colors.textPrimary),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, ThemeHelper colors, NotificationState state) {
    final unreadCount =
        state is NotificationLoaded ? state.unreadCount : 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: unreadCount > 0
                  ? () => context
                      .read<NotificationBloc>()
                      .add(const MarkAllNotificationsAsRead())
                  : null,
              icon: Icon(
                Icons.done_all,
                size: 16.sp,
                color: unreadCount > 0 ? colors.primary : colors.grey3,
              ),
              label: Text(
                'Mark all read',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.medium,
                  color: unreadCount > 0 ? colors.primary : colors.grey3,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8.h),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextButton.icon(
              onPressed: () async {
                if (_isNavigating) return;
                _isNavigating = true;
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationPreferencesScreen(),
                  ),
                );
                _isNavigating = false;
              },
              icon: Icon(
                Icons.tune,
                size: 16.sp,
                color: colors.textSecondary,
              ),
              label: Text(
                'Preferences',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.medium,
                  color: colors.textSecondary,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8.h),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(
      BuildContext context, ThemeHelper colors, NotificationState state) {
    final selectedCategory = state is NotificationLoaded
        ? state.selectedCategory
        : NotificationCategory.all;
    final notifications =
        state is NotificationLoaded ? state.notifications : <NotificationModel>[];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 40.h,
      decoration: BoxDecoration(
        color: colors.grey6,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          _buildTab(
            context,
            'All',
            NotificationCategory.all,
            selectedCategory,
            notifications.length,
            colors,
          ),
          _buildTab(
            context,
            'Jobs',
            NotificationCategory.jobs,
            selectedCategory,
            notifications.where((n) => n.category == NotificationCategory.jobs).length,
            colors,
          ),
          _buildTab(
            context,
            'Bills',
            NotificationCategory.bills,
            selectedCategory,
            notifications.where((n) => n.category == NotificationCategory.bills).length,
            colors,
          ),
          _buildTab(
            context,
            'Work',
            NotificationCategory.work,
            selectedCategory,
            notifications.where((n) => n.category == NotificationCategory.work).length,
            colors,
          ),
          _buildTab(
            context,
            'Money',
            NotificationCategory.money,
            selectedCategory,
            notifications.where((n) => n.category == NotificationCategory.money).length,
            colors,
          ),
          _buildTab(
            context,
            'Alerts',
            NotificationCategory.alerts,
            selectedCategory,
            notifications.where((n) => n.category == NotificationCategory.alerts).length,
            colors,
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    String label,
    NotificationCategory category,
    NotificationCategory selectedCategory,
    int count,
    ThemeHelper colors,
  ) {
    final isSelected = selectedCategory == category;

    return Expanded(
      child: GestureDetector(
        onTap: () =>
            context.read<NotificationBloc>().add(FilterByCategory(category)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: isSelected ? colors.cardBackground : Colors.transparent,
            borderRadius: BorderRadius.circular(6.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: colors.grey3.withValues(alpha: 0.1),
                      blurRadius: 4,
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s11,
                    fontWeight: isSelected
                        ? FontWeightManager.semiBold
                        : FontWeightManager.medium,
                    color: isSelected
                        ? colors.textPrimary
                        : colors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (count > 0 && category == NotificationCategory.all) ...[
                  SizedBox(width: 4.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      count.toString(),
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s10,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsList(
      BuildContext context, ThemeHelper colors, NotificationState state) {
    if (state is NotificationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is NotificationError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: colors.error),
            SizedBox(height: 16.h),
            Text(
              state.message,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () => context
                  .read<NotificationBloc>()
                  .add(const LoadNotifications()),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is NotificationLoaded) {
      final notifications = state.filteredNotifications;

      if (notifications.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_off_outlined,
                size: 48.sp,
                color: colors.grey3,
              ),
              SizedBox(height: 16.h),
              Text(
                'No notifications',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _NotificationCard(
            notification: notification,
            colors: colors,
            onMarkAsRead: () => context
                .read<NotificationBloc>()
                .add(MarkNotificationAsRead(notification.id)),
            onDelete: () => context
                .read<NotificationBloc>()
                .add(DeleteNotification(notification.id)),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final ThemeHelper colors;
  final VoidCallback onMarkAsRead;
  final VoidCallback onDelete;

  const _NotificationCard({
    required this.notification,
    required this.colors,
    required this.onMarkAsRead,
    required this.onDelete,
  });

  IconData _getCategoryIcon(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.jobs:
        return Icons.work_outline;
      case NotificationCategory.bills:
        return Icons.receipt_long;
      case NotificationCategory.work:
        return Icons.person_outline;
      case NotificationCategory.money:
        return Icons.payment;
      case NotificationCategory.alerts:
        return Icons.warning_amber_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _getCategoryColor(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.jobs:
        return ColorManager.primary;
      case NotificationCategory.bills:
        return const Color(0xFFFBBF24);
      case NotificationCategory.work:
        return const Color(0xFF3B82F6);
      case NotificationCategory.money:
        return ColorManager.success;
      case NotificationCategory.alerts:
        return ColorManager.error;
      default:
        return ColorManager.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = _getCategoryColor(notification.category);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: notification.isRead
            ? colors.cardBackground
            : colors.primary.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: notification.isRead
              ? colors.grey4
              : colors.primary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              _getCategoryIcon(notification.category),
              size: 20.sp,
              color: iconColor,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.semiBold,
                          color: colors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!notification.isRead)
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: colors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  notification.message,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Text(
                  notification.timeAgo,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s11,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              size: 18.sp,
              color: colors.textSecondary,
            ),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              if (value == 'mark_read') {
                onMarkAsRead();
              } else if (value == 'delete') {
                onDelete();
              }
            },
            itemBuilder: (context) => [
              if (!notification.isRead)
                PopupMenuItem(
                  value: 'mark_read',
                  child: Text(
                    'Mark as read',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s12,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              PopupMenuItem(
                value: 'delete',
                child: Text(
                  'Delete',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    color: colors.error,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
