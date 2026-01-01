import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/user_model.dart';

class AvailabilityModal extends StatefulWidget {
  final UserModel user;

  const AvailabilityModal({
    super.key,
    required this.user,
  });

  @override
  State<AvailabilityModal> createState() => _AvailabilityModalState();
}

class _AvailabilityModalState extends State<AvailabilityModal> {
  // Sample availability data
  final List<Map<String, String>> _availabilitySlots = [
    {'date': 'Dec 28, 2025', 'day': 'Saturday', 'startTime': '09:00', 'endTime': '17:00', 'status': 'available'},
    {'date': 'Dec 27, 2025', 'day': 'Friday', 'startTime': '09:00', 'endTime': '17:00', 'status': 'available'},
    {'date': 'Dec 26, 2025', 'day': 'Thursday', 'startTime': '14:00', 'endTime': '22:00', 'status': 'available'},
    {'date': 'Dec 25, 2025', 'day': 'Wednesday', 'startTime': '--', 'endTime': '--', 'status': 'unavailable'},
    {'date': 'Dec 24, 2025', 'day': 'Tuesday', 'startTime': '09:00', 'endTime': '17:00', 'status': 'available'},
    {'date': 'Dec 23, 2025', 'day': 'Monday', 'startTime': '09:00', 'endTime': '17:00', 'status': 'available'},
    {'date': 'Dec 22, 2025', 'day': 'Sunday', 'startTime': '10:00', 'endTime': '18:00', 'status': 'available'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: ColorManager.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              children: [
                // Drag Handle
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: ColorManager.grey3,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 16.h),

                // Title and Close Button
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Staff Availability',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s20,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${widget.user.name} - Weekly Schedule',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s13,
                              fontWeight: FontWeightManager.medium,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        size: 24.sp,
                        color: ColorManager.textSecondary,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: ColorManager.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: ColorManager.info.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20.sp,
                          color: ColorManager.info,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            'Viewing available time slots for the next 7 days',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeightManager.medium,
                              color: ColorManager.info,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Availability Slots List
                  ..._availabilitySlots.map((slot) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: _buildAvailabilitySlot(
                        date: slot['date']!,
                        day: slot['day']!,
                        startTime: slot['startTime']!,
                        endTime: slot['endTime']!,
                        status: slot['status']!,
                      ),
                    );
                  }),

                  SizedBox(height: 20.h),

                  // Legend
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: ColorManager.grey4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Legend',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.semiBold,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _buildLegendItem(
                          color: ColorManager.success,
                          label: 'Available',
                        ),
                        SizedBox(height: 8.h),
                        _buildLegendItem(
                          color: ColorManager.grey3,
                          label: 'Unavailable',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilitySlot({
    required String date,
    required String day,
    required String startTime,
    required String endTime,
    required String status,
  }) {
    final isAvailable = status == 'available';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isAvailable ? ColorManager.success.withValues(alpha: 0.3) : ColorManager.grey4,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          // Status indicator
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: isAvailable ? ColorManager.success : ColorManager.grey3,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),

          // Date and Day
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  day,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Time Range
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: isAvailable
                  ? ColorManager.success.withValues(alpha: 0.1)
                  : ColorManager.grey5,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14.sp,
                  color: isAvailable ? ColorManager.success : ColorManager.grey3,
                ),
                SizedBox(width: 6.w),
                Text(
                  isAvailable ? '$startTime - $endTime' : 'Not Available',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.semiBold,
                    color: isAvailable ? ColorManager.success : ColorManager.grey3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
  }) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.medium,
            color: ColorManager.textSecondary,
          ),
        ),
      ],
    );
  }
}
