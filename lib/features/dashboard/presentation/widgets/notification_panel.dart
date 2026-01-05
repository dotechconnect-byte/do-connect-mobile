import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';

enum NotificationCategory { all, jobs, bills, work, money, alerts }

class NotificationPanel extends StatefulWidget {
  const NotificationPanel({super.key});

  @override
  State<NotificationPanel> createState() => _NotificationPanelState();
}

class _NotificationPanelState extends State<NotificationPanel> {
  NotificationCategory _selectedCategory = NotificationCategory.all;

  List<NotificationItem> _notifications = [
    NotificationItem(
      icon: Icons.receipt_long,
      iconColor: const Color(0xFFFBBF24),
      title: 'Invoice Overdue',
      message: 'Invoice #INV-2024-001 from Marriott Hotel is 5 days overdue',
      time: '5 days ago',
      isUnread: true,
      category: NotificationCategory.bills,
    ),
    NotificationItem(
      icon: Icons.payment,
      iconColor: ColorManager.success,
      title: 'Payment Received',
      message: '¥45,000 payment received for Invoice #INV-2024-002',
      time: 'about 3 hours ago',
      isUnread: true,
      category: NotificationCategory.money,
    ),
    NotificationItem(
      icon: Icons.work_outline,
      iconColor: ColorManager.primary,
      title: 'New Job Applications',
      message: '12 new applications for Kitchen Manager position',
      time: 'about 1 hour ago',
      isUnread: true,
      category: NotificationCategory.jobs,
    ),
    NotificationItem(
      icon: Icons.event,
      iconColor: const Color(0xFF3B82F6),
      title: 'Interview Scheduled',
      message:
          'Interview confirmed with Sarah Kumar for Chef position on Jan 28',
      time: 'about 5 hours ago',
      isUnread: false,
      category: NotificationCategory.jobs,
    ),
    NotificationItem(
      icon: Icons.person_off_outlined,
      iconColor: ColorManager.error,
      title: 'DOER Availability Change',
      message: 'Raj Kumar marked unavailable for next week shifts',
      time: 'about 2 hours ago',
      isUnread: true,
      category: NotificationCategory.work,
    ),
    NotificationItem(
      icon: Icons.warning_amber_outlined,
      iconColor: const Color(0xFFFBBF24),
      title: 'Attendance Issue',
      message: '3 DOERs marked late today at Grand Hotel event',
      time: 'about 2 hours ago',
      isUnread: false,
      category: NotificationCategory.work,
    ),
    NotificationItem(
      icon: Icons.event_busy,
      iconColor: ColorManager.error,
      title: 'Urgent Slot Unfilled',
      message: 'Event tomorrow at Regal Palace still needs 2 DOERs',
      time: '1 day ago',
      isUnread: false,
      category: NotificationCategory.alerts,
    ),
  ];

  List<NotificationItem> get _filteredNotifications {
    if (_selectedCategory == NotificationCategory.all) {
      return _notifications;
    }
    return _notifications
        .where((n) => n.category == _selectedCategory)
        .toList();
  }

  int _getCategoryCount(NotificationCategory category) {
    if (category == NotificationCategory.all) {
      return _notifications.length;
    }
    return _notifications.where((n) => n.category == category).length;
  }

  int get _unreadCount {
    return _notifications.where((n) => n.isUnread).length;
  }

  void _markAllAsRead() {
    setState(() {
      _notifications =
          _notifications.map((notification) {
            return NotificationItem(
              icon: notification.icon,
              iconColor: notification.iconColor,
              title: notification.title,
              message: notification.message,
              time: notification.time,
              isUnread: false,
              category: notification.category,
            );
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: colors.background),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
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
                    if (_unreadCount > 0)
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
                          _unreadCount.toString(),
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
              ),

              // Action Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: _unreadCount > 0 ? _markAllAsRead : null,
                        icon: Icon(
                          Icons.done_all,
                          size: 16.sp,
                          color:
                              _unreadCount > 0
                                  ? colors.primary
                                  : colors.grey3,
                        ),
                        label: Text(
                          'Mark all read',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.medium,
                            color:
                                _unreadCount > 0
                                    ? colors.primary
                                    : colors.grey3,
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
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings_outlined,
                          size: 16.sp,
                          color: colors.textSecondary,
                        ),
                        label: Text(
                          'Settings',
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
              ),

              SizedBox(height: 12.h),

              // Tabs
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                height: 40.h,
                decoration: BoxDecoration(
                  color: colors.grey6,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    _buildTab('All', NotificationCategory.all, colors),
                    _buildTab('Jobs', NotificationCategory.jobs, colors),
                    _buildTab('Bills', NotificationCategory.bills, colors),
                    _buildTab('Work', NotificationCategory.work, colors),
                    _buildTab('Money', NotificationCategory.money, colors),
                    _buildTab('Alerts', NotificationCategory.alerts, colors),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Notifications List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: _filteredNotifications.length,
                  itemBuilder: (context, index) {
                    final notification = _filteredNotifications[index];
                    return _NotificationCard(notification: notification, colors: colors);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String label, NotificationCategory category, ThemeHelper colors) {
    final isSelected = _selectedCategory == category;
    final count = _getCategoryCount(category);
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedCategory = category),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: isSelected ? colors.cardBackground : Colors.transparent,
            borderRadius: BorderRadius.circular(6.r),
            boxShadow:
                isSelected
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
                    fontWeight:
                        isSelected
                            ? FontWeightManager.semiBold
                            : FontWeightManager.medium,
                    color:
                        isSelected
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
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final ThemeHelper colors;

  const _NotificationCard({required this.notification, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color:
            notification.isUnread
                ? colors.primary.withValues(alpha: 0.03)
                : colors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color:
              notification.isUnread
                  ? colors.primary.withValues(alpha: 0.1)
                  : colors.grey4,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: notification.iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              notification.icon,
              size: 20.sp,
              color: notification.iconColor,
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
                    if (notification.isUnread)
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
                  notification.time,
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
            itemBuilder:
                (context) => [
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

class NotificationItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String time;
  final bool isUnread;
  final NotificationCategory category;

  NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.time,
    this.isUnread = false,
    required this.category,
  });
}
