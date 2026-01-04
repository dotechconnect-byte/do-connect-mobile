import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/slot_model.dart';

class SlotCard extends StatelessWidget {
  final SlotModel slot;
  final VoidCallback? onTap;

  const SlotCard({
    super.key,
    required this.slot,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.grey4, width: 1),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: ColorManager.grey6,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 18.sp,
                  color: ColorManager.primary,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    slot.timeRange,
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: ColorManager.primary, width: 1),
                  ),
                  child: Text(
                    slot.position,
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s11,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16.sp,
                      color: ColorManager.textSecondary,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        slot.location,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.medium,
                          color: ColorManager.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Staff ratio and details
                Row(
                  children: [
                    // Staff ratio
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: slot.isFilled
                              ? ColorManager.success.withValues(alpha: 0.1)
                              : ColorManager.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 18.sp,
                              color: slot.isFilled ? ColorManager.success : ColorManager.primary,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              slot.staffRatio,
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,
                                color: slot.isFilled ? ColorManager.success : ColorManager.primary,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Staff',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                // Groups and Direct Staff
                Row(
                  children: [
                    Expanded(
                      child: _InfoItem(
                        label: 'Groups',
                        value: slot.groups.toString(),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _InfoItem(
                        label: 'Direct Staff',
                        value: slot.directStaff.toString(),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // View Details Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onTap,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      side: BorderSide(color: ColorManager.grey3, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'View Details',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: ColorManager.grey6,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s11,
              fontWeight: FontWeightManager.medium,
              color: ColorManager.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s15,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
