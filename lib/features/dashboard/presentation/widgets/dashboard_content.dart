import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import 'promo_banner.dart';
import 'stat_card.dart';
import 'attendance_chart.dart';
import 'position_distribution_chart.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DashboardError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is DashboardLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<DashboardBloc>().add(const RefreshDashboardData());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  // Promo Banner
                  const PromoBanner(),

                  SizedBox(height: 20.h),

                  // Stats Grid
                  _StatsGrid(stats: state.stats),

                  SizedBox(height: 20.h),

                  // AI Insights
                  _AIInsights(),

                  SizedBox(height: 20.h),

                  // Charts Column
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      children: [
                        const AttendanceChart(),
                        SizedBox(height: 16.h),
                        const PositionDistributionChart(),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Bottom Tabs
                  _BottomTabs(
                    shifts: state.shifts,
                    selectedTab: state.selectedTab,
                  ),

                  SizedBox(height: 80.h), // Extra padding for FAB
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final List<dynamic> stats;

  const _StatsGrid({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 1.5,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) {
          final stat = stats[index];
          return StatCard(
            title: stat.title,
            value: stat.value,
            change: stat.change,
            isPositive: stat.isPositive,
            icon: stat.icon,
            iconColor: stat.iconColor,
          );
        },
      ),
    );
  }
}

class _AIInsights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.grey4, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, size: 18.sp, color: ColorManager.primary),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'AI-Powered Insights',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s15,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Ask AI',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s11,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            'Smart observations and suggestions for your workforce',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s11,
              fontWeight: FontWeightManager.regular,
              color: ColorManager.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12.h),
          _InsightItem(
            icon: Icons.trending_up,
            iconColor: const Color(0xFF10B981),
            text: '80% of your DOER today are repeat hires with ratings above 4.5',
          ),
          SizedBox(height: 8.h),
          _InsightItem(
            icon: Icons.info_outline,
            iconColor: const Color(0xFF3B82F6),
            text: '3 DOER scanned in late at Downtown Office yesterday',
          ),
        ],
      ),
    );
  }
}

class _InsightItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const _InsightItem({
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Icon(icon, size: 14.sp, color: iconColor),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s12,
              fontWeight: FontWeightManager.regular,
              color: ColorManager.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _BottomTabs extends StatelessWidget {
  final List<dynamic> shifts;
  final int selectedTab;

  const _BottomTabs({required this.shifts, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.grey4, width: 1),
      ),
      child: Column(
        children: [
          Container(
            height: 36.h,
            decoration: BoxDecoration(
              color: ColorManager.grey6,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                _TabItem('Today', 0, selectedTab, context),
                _TabItem('Slots', 1, selectedTab, context),
                _TabItem('Alerts', 2, selectedTab, context),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          if (selectedTab == 0)
            ...shifts.map((shift) => _ShiftItem(shift)),
          if (selectedTab == 1)
            _SlotsContent(),
          if (selectedTab == 2)
            _AlertsContent(),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final int index;
  final int selectedTab;
  final BuildContext parentContext;

  const _TabItem(this.title, this.index, this.selectedTab, this.parentContext);

  @override
  Widget build(BuildContext context) {
    final isActive = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          parentContext.read<DashboardBloc>().add(ChangeTab(index));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: isActive ? ColorManager.white : Colors.transparent,
            borderRadius: BorderRadius.circular(6.r),
            boxShadow: isActive
                ? [BoxShadow(color: ColorManager.black.withValues(alpha: 0.05), blurRadius: 4)]
                : [],
          ),
          child: Center(
            child: Text(
              title,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s12,
                fontWeight: isActive ? FontWeightManager.semiBold : FontWeightManager.medium,
                color: isActive ? ColorManager.textPrimary : ColorManager.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

class _ShiftItem extends StatelessWidget {
  final dynamic shift;

  const _ShiftItem(this.shift);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: ColorManager.grey6,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(Icons.calendar_today, size: 16.sp, color: ColorManager.primary),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shift.position,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  '${shift.time} • ${shift.location}',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s11,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              shift.status,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s10,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SlotsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PendingActionItem(
          title: '2 Invoices to Review',
          subtitle: 'Due this week',
          actionText: 'Review',
          onTap: () {},
        ),
        SizedBox(height: 10.h),
        _PendingActionItem(
          title: '3 Staff Missing Scans',
          subtitle: 'Yesterday',
          actionText: 'Check',
          onTap: () {},
        ),
        SizedBox(height: 10.h),
        _PendingActionItem(
          title: '5 Feedback Forms Pending',
          subtitle: 'Awaiting submission',
          actionText: 'Submit',
          onTap: () {},
        ),
      ],
    );
  }
}

class _AlertsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _QuickExportItem(
          icon: Icons.download_outlined,
          title: 'Download Analytics Report (PDF)',
          onTap: () {},
        ),
        SizedBox(height: 10.h),
        _QuickExportItem(
          icon: Icons.file_download_outlined,
          title: 'Export Attendance Data (CSV)',
          onTap: () {},
        ),
        SizedBox(height: 10.h),
        _QuickExportItem(
          icon: Icons.assessment_outlined,
          title: 'Generate Performance Report',
          onTap: () {},
        ),
      ],
    );
  }
}

class _PendingActionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String actionText;
  final VoidCallback onTap;

  const _PendingActionItem({
    required this.title,
    required this.subtitle,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.grey6,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s11,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: ColorManager.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
              textStyle: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s11,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
            child: Text(actionText),
          ),
        ],
      ),
    );
  }
}

class _QuickExportItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickExportItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: ColorManager.grey6,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Icon(
                icon,
                size: 18.sp,
                color: ColorManager.primary,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 18.sp,
              color: ColorManager.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
