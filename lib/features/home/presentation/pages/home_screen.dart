import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../dashboard/presentation/widgets/notification_panel.dart';
import '../../../dashboard/presentation/widgets/request_doer_bottom_sheet.dart';
import '../../../dashboard/presentation/widgets/dashboard_content.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../slots/presentation/widgets/slots_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    'Analytics Dashboard',
    'Slots Management',
    'Status',
    'Profile',
    'More',
  ];

  final List<String> _subtitles = [
    'Real-time insights and workforce analytics',
    'Manage all current and upcoming shift slots',
    'Track your work status',
    'Manage your profile',
    'Additional options',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Common Header
            Container(
              padding: EdgeInsets.all(16.w),
              color: ColorManager.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Logo
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            'D',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s18,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _titles[_selectedIndex],
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,
                                color: ColorManager.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              _subtitles[_selectedIndex],
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Stack(
                        children: [
                          IconButton(
                            icon: Icon(Icons.notifications_outlined, size: 24.sp),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      const NotificationPanel(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;
                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(tween);
                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
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
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: const BoxDecoration(
                                color: ColorManager.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Search Bar (only show for specific tabs)
                  if (_selectedIndex == 1) ...[
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: ColorManager.grey6,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 20.sp,
                            color: ColorManager.textSecondary,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Search DOER, shifts, invoices...',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s13,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Content Area
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  _DashboardTab(),
                  _SlotsTab(),
                  _PlaceholderTab(title: 'Status'),
                  _PlaceholderTab(title: 'Profile'),
                  _PlaceholderTab(title: 'More'),
                ],
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
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
        backgroundColor: ColorManager.primary,
        icon: Icon(Icons.add, color: ColorManager.white, size: 20.sp),
        label: Text(
          'Request DOER',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManager.white,
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
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
              _buildNavItem(Icons.dashboard_outlined, 'Dashboard', 0),
              _buildNavItem(Icons.calendar_today_outlined, 'Slots', 1),
              _buildNavItem(Icons.assessment_outlined, 'Status', 2),
              _buildNavItem(Icons.person_outline, 'Profile', 3),
              _buildNavItem(Icons.more_horiz, 'More', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
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

// Dashboard Tab Content
class _DashboardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(const LoadDashboardData()),
      child: const DashboardContent(),
    );
  }
}

// Slots Tab Content
class _SlotsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SlotsContent();
  }
}

// Placeholder for other tabs
class _PlaceholderTab extends StatelessWidget {
  final String title;

  const _PlaceholderTab({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 64.sp,
            color: ColorManager.grey3,
          ),
          SizedBox(height: 16.h),
          Text(
            '$title Coming Soon',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.semiBold,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'This feature is under development',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s13,
              fontWeight: FontWeightManager.regular,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
