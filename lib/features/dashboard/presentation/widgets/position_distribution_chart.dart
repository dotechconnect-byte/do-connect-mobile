import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';

class PositionDistributionChart extends StatelessWidget {
  const PositionDistributionChart({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    final positions = [
      {'name': 'Server', 'count': 12, 'color': colors.primary},
      {'name': 'Barman', 'count': 8, 'color': colors.success},
      {'name': 'Security Guard', 'count': 6, 'color': Color(0xFFFBBF24)},
      {'name': 'Concierge', 'count': 4, 'color': colors.error},
    ];

    final maxCount = positions.map((e) => e['count'] as int).reduce((a, b) => a > b ? a : b);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey4, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Position Distribution',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.semiBold,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Current active staff',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s12,
              fontWeight: FontWeightManager.regular,
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 20.h),
          ...positions.map((position) {
            final percentage = (position['count'] as int) / maxCount;
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        position['name'] as String,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.medium,
                          color: colors.textPrimary,
                        ),
                      ),
                      Text(
                        position['count'].toString(),
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.semiBold,
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Stack(
                    children: [
                      Container(
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: colors.grey5,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: percentage,
                        child: Container(
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: position['color'] as Color,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
