import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/promo_banner.dart';
import '../widgets/stat_card.dart';
import '../widgets/attendance_chart.dart';
import '../widgets/position_distribution_chart.dart';
import '../widgets/request_doer_bottom_sheet.dart';
import '../widgets/notification_panel.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(const LoadDashboardData()),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DashboardError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.error,
                  ),
                ),
              );
            }

            if (state is DashboardLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<DashboardBloc>().add(const RefreshDashboardData());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _TopBar(),
                      SizedBox(height: 12.h),
                      const PromoBanner(),
                      SizedBox(height: 16.h),
                      _StatsGrid(stats: state.stats),
                      SizedBox(height: 16.h),
                      _AIInsights(),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          children: [
                            const AttendanceChart(),
                            SizedBox(height: 12.h),
                            const PositionDistributionChart(),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _BottomTabs(
                        shifts: state.shifts,
                        selectedTab: state.selectedTab,
                      ),
                      SizedBox(height: 80.h),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border(bottom: BorderSide(color: ColorManager.grey4, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Analytics Dashboard',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Real-time insights',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s11,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, size: 22.sp),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const NotificationPanel(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(position: offsetAnimation, child: child);
                      },
                      transitionDuration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                color: ColorManager.textPrimary,
                padding: EdgeInsets.all(8.w),
                constraints: const BoxConstraints(),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: const BoxDecoration(
                    color: ColorManager.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 4.w),
          SizedBox(
            height: 36.h,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: const RequestDoerBottomSheet(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                foregroundColor: ColorManager.white,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                textStyle: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.semiBold,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 16.sp),
                  SizedBox(width: 4.w),
                  const Text('DOER'),
                ],
              ),
            ),
          ),
        ],
      ),
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
              Icon(Icons.auto_awesome, color: ColorManager.primary, size: 18.sp),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'AI-Powered Insights',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s15,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Ask AI',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _InsightItem(
            Icons.people,
            '80% of DOER have ratings above 4.5',
            ColorManager.primary,
          ),
          SizedBox(height: 10.h),
          _InsightItem(
            Icons.schedule,
            '3 DOER scanned in late yesterday',
            const Color(0xFFFBBF24),
          ),
        ],
      ),
    );
  }
}

class _InsightItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _InsightItem(this.icon, this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Icon(icon, size: 14.sp, color: color),
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
  final BuildContext context;

  const _TabItem(this.title, this.index, this.selectedTab, this.context);

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<DashboardBloc>().add(ChangeTab(index)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: isSelected ? ColorManager.white : Colors.transparent,
            borderRadius: BorderRadius.circular(6.r),
            boxShadow: isSelected
                ? [BoxShadow(color: ColorManager.black.withValues(alpha: 0.05), blurRadius: 4)]
                : [],
          ),
          child: Center(
            child: Text(
              title,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s11,
                fontWeight: isSelected ? FontWeightManager.semiBold : FontWeightManager.medium,
                color: isSelected ? ColorManager.textPrimary : ColorManager.textSecondary,
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
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(Icons.access_time, size: 18.sp, color: ColorManager.primary),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shift.time,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s11,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  shift.position,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  shift.assignedTo,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s11,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: ColorManager.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              'Confirmed',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s10,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.success,
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

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(Icons.dashboard_outlined, 'Dashboard', true),
              _NavItem(Icons.calendar_today_outlined, 'Slots', false),
              _NavItem(Icons.assessment_outlined, 'Status', false),
              _NavItem(Icons.person_outline, 'Profile', false),
              _NavItem(Icons.more_horiz, 'More', false),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavItem(this.icon, this.label, this.isActive);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? ColorManager.primary : ColorManager.textSecondary,
            size: 22.sp,
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s10,
              fontWeight: isActive ? FontWeightManager.semiBold : FontWeightManager.regular,
              color: isActive ? ColorManager.primary : ColorManager.textSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
