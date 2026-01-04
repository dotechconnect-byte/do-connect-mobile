import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
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
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
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
              color: ColorManager.grey6,
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
                    color: const Color(0xFFFFE5DC),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 24.sp,
                      color: ColorManager.primary,
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
                          color: ColorManager.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        doer.gender,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textSecondary,
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
                      color: ColorManager.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      doer.timeRange,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.textPrimary,
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
                          color: ColorManager.textPrimary,
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
                        color: ColorManager.textSecondary,
                      ),
                    ),
                    Text(
                      doer.station,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.textPrimary,
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
                        color: ColorManager.textSecondary,
                      ),
                    ),
                    Text(
                      doer.manager,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.textPrimary,
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
                      color: const Color(0xFFD1FAE5),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16.sp,
                          color: const Color(0xFF10B981),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Scanned In: ${doer.scannedInTime}',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.semiBold,
                            color: const Color(0xFF059669),
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
                          side: BorderSide(color: ColorManager.grey3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          foregroundColor: ColorManager.textPrimary,
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
                        icon: Icon(Icons.message_outlined, size: 16.sp),
                        label: const Text('Message'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          side: BorderSide(color: ColorManager.grey3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          foregroundColor: ColorManager.textPrimary,
                          textStyle: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s13,
                            fontWeight: FontWeightManager.semiBold,
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
