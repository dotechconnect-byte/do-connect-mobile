import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../../dashboard/presentation/widgets/notification_panel.dart';
import '../../../dashboard/presentation/widgets/request_doer_bottom_sheet.dart';
import '../../../dashboard/presentation/widgets/dashboard_content.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../slots/presentation/widgets/slots_content.dart';
import '../../../status/presentation/widgets/status_content.dart';
import '../../../attendance/presentation/widgets/attendance_content.dart';
import '../../../more/presentation/widgets/more_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _attendanceFilterDate;

  final List<String> _titles = [
    'Analytics Dashboard',
    'Slots Management',
    'DOER Status',
    'Attendance',
    'More',
  ];

  final List<String> _subtitles = [
    'Real-time insights and workforce analytics',
    'Manage all current and upcoming shift slots',
    'Monitor DOER attendance and shift status in real-time',
    'Track and manage DOER attendance',
    'Additional options',
  ];

  @override
  void initState() {
    super.initState();

    // Listen for tab switch requests
    NavigationService().tabSwitchNotifier.addListener(_handleTabSwitch);
  }

  @override
  void dispose() {
    NavigationService().tabSwitchNotifier.removeListener(_handleTabSwitch);
    _searchController.dispose();
    super.dispose();
  }

  void _handleTabSwitch() {
    final tabData = NavigationService().tabSwitchNotifier.value;
    if (tabData != null && tabData['tab'] != null) {
      setState(() {
        _selectedIndex = tabData['tab'] as int;
        // Set the attendance filter date if provided
        if (tabData['date'] != null) {
          _attendanceFilterDate = tabData['date'] as String;
        }
      });

      // Show snackbar with the date
      if (tabData['date'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Viewing attendance for ${tabData['date']}',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.medium,
                color: ColorManager.white,
              ),
            ),
            backgroundColor: ColorManager.success,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }

      // Clear the notification
      NavigationService().clearTabSwitch();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Common Header
            Container(
              padding: EdgeInsets.all(16.w),
              color: colors.cardBackground,
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
                                color: colors.textPrimary,
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
                                color: colors.textSecondary,
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
                            color: colors.textPrimary,
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
                  if (_selectedIndex == 1 || _selectedIndex == 2 || _selectedIndex == 3) ...[
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: colors.grey6,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 20.sp,
                            color: colors.textSecondary,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s13,
                                fontWeight: FontWeightManager.regular,
                                color: colors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search DOER, shifts, invoices...',
                                hintStyle: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s13,
                                  fontWeight: FontWeightManager.regular,
                                  color: colors.textSecondary,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                              ),
                            ),
                          ),
                          if (_searchQuery.isNotEmpty)
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                size: 20.sp,
                                color: colors.textSecondary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
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
                  _SlotsTab(searchQuery: _searchQuery),
                  _StatusTab(searchQuery: _searchQuery),
                  _AttendanceTab(
                    searchQuery: _searchQuery,
                    initialDate: _attendanceFilterDate,
                  ),
                  const MoreContent(),
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
    final colors = ThemeHelper.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.08),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 65.h,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.dashboard_outlined, Icons.dashboard_rounded, 'Dashboard', 0),
              _buildNavItem(Icons.calendar_today_outlined, Icons.calendar_today_rounded, 'Slots', 1),
              _buildNavItem(Icons.assessment_outlined, Icons.assessment_rounded, 'Status', 2),
              _buildNavItem(Icons.fact_check_outlined, Icons.fact_check_rounded, 'Attend', 3),
              _buildNavItem(Icons.more_horiz, Icons.more_horiz_rounded, 'More', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData inactiveIcon, IconData activeIcon, String label, int index) {
    final colors = ThemeHelper.of(context);
    final isActive = _selectedIndex == index;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (_selectedIndex != index) {
              setState(() => _selectedIndex = index);
            }
          },
          borderRadius: BorderRadius.circular(12.r),
          splashColor: ColorManager.primary.withValues(alpha: 0.1),
          highlightColor: ColorManager.primary.withValues(alpha: 0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 2.w),
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              color: isActive ? ColorManager.primary.withValues(alpha: 0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isActive ? activeIcon : inactiveIcon,
                  color: isActive ? ColorManager.primary : colors.textSecondary,
                  size: 22.sp,
                ),
                SizedBox(height: 2.h),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s10,
                      fontWeight: isActive ? FontWeightManager.semiBold : FontWeightManager.medium,
                      color: isActive ? ColorManager.primary : colors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                // Active indicator dot
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(top: 2.h),
                  height: 3.h,
                  width: isActive ? 3.w : 0,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
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
  final String searchQuery;

  const _SlotsTab({this.searchQuery = ''});

  @override
  Widget build(BuildContext context) {
    return SlotsContent(searchQuery: searchQuery);
  }
}

// Status Tab Content
class _StatusTab extends StatelessWidget {
  final String searchQuery;

  const _StatusTab({this.searchQuery = ''});

  @override
  Widget build(BuildContext context) {
    return StatusContent(searchQuery: searchQuery);
  }
}

// Attendance Tab Content
class _AttendanceTab extends StatelessWidget {
  final String searchQuery;
  final String? initialDate;

  const _AttendanceTab({
    this.searchQuery = '',
    this.initialDate,
  });

  @override
  Widget build(BuildContext context) {
    return AttendanceContent(
      searchQuery: searchQuery,
      initialDate: initialDate,
    );
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
