import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/transport_staff_model.dart';

class TransportStaffCard extends StatelessWidget {
  final TransportStaffModel staff;
  final VoidCallback onTap;

  const TransportStaffCard({
    super.key,
    required this.staff,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colors.grey4, width: 1),
      ),
      color: colors.cardBackground,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              // Avatar/Icon
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.primary.withValues(alpha: 0.8),
                      colors.primary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.person,
                  color: ColorManager.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),

              // Staff Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Name
                    Text(
                      staff.name,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.h),

                    // Region
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12.sp,
                          color: colors.primary,
                        ),
                        SizedBox(width: 3.w),
                        Flexible(
                          child: Text(
                            staff.region,
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s11,
                              fontWeight: FontWeightManager.medium,
                              color: colors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),

                    // Transport Timing
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12.sp,
                          color: colors.textSecondary,
                        ),
                        SizedBox(width: 3.w),
                        Flexible(
                          child: Text(
                            staff.transportTiming,
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s11,
                              fontWeight: FontWeightManager.regular,
                              color: colors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    // Assigned Transport
                    if (staff.assignedTransport != null) ...[
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: colors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: colors.success.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 10.sp,
                              color: colors.success,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              staff.assignedTransport!,
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.semiBold,
                                color: colors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              // Assign/Change Button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: staff.assignedTransport != null
                      ? colors.info
                      : colors.primary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      staff.assignedTransport != null
                          ? Icons.edit
                          : Icons.local_shipping,
                      size: 14.sp,
                      color: ColorManager.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      staff.assignedTransport != null ? 'Change' : 'Assign',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s11,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
