import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/doer_status_model.dart';

class DoerStatusCard extends StatelessWidget {
  final DoerStatusModel doer;
  final VoidCallback? onPing;
  final VoidCallback? onMessage;

  const DoerStatusCard({
    super.key,
    required this.doer,
    this.onPing,
    this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with name and status
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: colors.grey6,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 24.sp,
                      color: colors.primary,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Name and Gender
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doer.name,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s15,
                          fontWeight: FontWeightManager.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        doer.gender,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.regular,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status Badge
                _buildStatusBadge(),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              children: [
                // Time Range
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16.sp,
                      color: colors.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      doer.timeRange,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.medium,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16.sp,
                      color: const Color(0xFF3B82F6),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        doer.location,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.medium,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // Station
                Row(
                  children: [
                    Text(
                      'Station: ',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.medium,
                        color: colors.textSecondary,
                      ),
                    ),
                    Text(
                      doer.station,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.semiBold,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),

                // Manager
                Row(
                  children: [
                    Text(
                      'Manager: ',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.medium,
                        color: colors.textSecondary,
                      ),
                    ),
                    Text(
                      doer.manager,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.semiBold,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),

                // Scanned In Status
                if (doer.scannedInTime != null) ...[
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: colors.success.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16.sp,
                          color: colors.success,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Scanned In: ${doer.scannedInTime}',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.semiBold,
                            color: colors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: 12.h),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onPing,
                        icon: Icon(Icons.notifications_outlined, size: 16.sp),
                        label: const Text('Ping'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          side: BorderSide(color: colors.grey3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          foregroundColor: colors.textPrimary,
                          textStyle: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s13,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onMessage,
                        icon: Icon(Icons.chat, size: 16.sp, color: const Color(0xFF25D366)),
                        label: Text(
                          'WhatsApp',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s13,
                            fontWeight: FontWeightManager.semiBold,
                            color: const Color(0xFF25D366),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          side: const BorderSide(color: Color(0xFF25D366)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (doer.status) {
      case DoerWorkStatus.working:
        backgroundColor = const Color(0xFF10B981);
        textColor = ColorManager.white;
        label = 'working';
        break;
      case DoerWorkStatus.scheduled:
        backgroundColor = const Color(0xFFF59E0B);
        textColor = ColorManager.white;
        label = 'scheduled';
        break;
      case DoerWorkStatus.completed:
        backgroundColor = const Color(0xFF6366F1);
        textColor = ColorManager.white;
        label = 'completed';
        break;
      case DoerWorkStatus.absent:
        backgroundColor = const Color(0xFFEF4444);
        textColor = ColorManager.white;
        label = 'absent';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: FontConstants.getPoppinsStyle(
          fontSize: FontSize.s11,
          fontWeight: FontWeightManager.semiBold,
          color: textColor,
        ),
      ),
    );
  }
}
