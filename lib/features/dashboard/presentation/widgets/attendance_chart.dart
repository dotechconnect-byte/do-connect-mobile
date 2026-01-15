import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';

class AttendanceChart extends StatelessWidget {
  const AttendanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

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
            'Attendance Rate Trend',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.semiBold,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Last 7 days',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s12,
              fontWeight: FontWeightManager.regular,
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 180.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: colors.grey4,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      reservedSize: 35.w,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}%',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.regular,
                            color: colors.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        if (value.toInt() >= 0 && value.toInt() < days.length) {
                          return Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              days[value.toInt()],
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.regular,
                                color: colors.textSecondary,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: 70,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 85),
                      FlSpot(1, 88),
                      FlSpot(2, 82),
                      FlSpot(3, 90),
                      FlSpot(4, 87),
                      FlSpot(5, 92),
                      FlSpot(6, 89),
                    ],
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [
                        colors.primary,
                        colors.primaryLight,
                      ],
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: colors.primary,
                          strokeWidth: 2,
                          strokeColor: colors.cardBackground,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          colors.primary.withValues(alpha: 0.2),
                          colors.primary.withValues(alpha: 0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
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
}
