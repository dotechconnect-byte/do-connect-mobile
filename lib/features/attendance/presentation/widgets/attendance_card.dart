import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/attendance_model.dart';

class AttendanceCard extends StatelessWidget {
  final AttendanceModel attendance;
  final VoidCallback? onTap;

  const AttendanceCard({
    super.key,
    required this.attendance,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
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
        child: Row(
          children: [
            // Number Badge
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: ColorManager.grey6,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  '#${attendance.number}',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Status
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          attendance.name,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s15,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      _buildStatusBadge(),
                    ],
                  ),
                  SizedBox(height: 6.h),

                  // Details Row
                  Wrap(
                    spacing: 12.w,
                    runSpacing: 4.h,
                    children: [
                      _buildDetailItem('Shift: ${attendance.shift}'),
                      _buildDetailItem('Location: ${attendance.location}'),
                      _buildDetailItem('Station: ${attendance.station}'),
                    ],
                  ),

                  // Check-in Time
                  if (attendance.checkInTime != null) ...[
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Text(
                          'In: ',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.textSecondary,
                          ),
                        ),
                        Text(
                          attendance.checkInTime!,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.semiBold,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String text) {
    return Text(
      text,
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s12,
        fontWeight: FontWeightManager.regular,
        color: ColorManager.textSecondary,
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (attendance.status) {
      case AttendanceStatus.processing:
        backgroundColor = const Color(0xFF10B981);
        textColor = ColorManager.white;
        label = 'Processing';
        break;
      case AttendanceStatus.pending:
        backgroundColor = ColorManager.black;
        textColor = ColorManager.white;
        label = 'Pending';
        break;
      case AttendanceStatus.confirmed:
        backgroundColor = ColorManager.primary;
        textColor = ColorManager.white;
        label = 'Confirmed';
        break;
      case AttendanceStatus.cancelled:
        backgroundColor = const Color(0xFFEF4444);
        textColor = ColorManager.white;
        label = 'Cancelled';
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
