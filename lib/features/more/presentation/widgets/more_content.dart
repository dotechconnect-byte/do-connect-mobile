import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../invoices/presentation/pages/invoices_screen.dart';
import '../../../groups/presentation/pages/groups_screen.dart';
import '../../../manage/presentation/pages/manage_screen.dart';

class MoreContent extends StatelessWidget {
  const MoreContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Options Section
          _buildSectionTitle('Main Options'),
          SizedBox(height: 12.h),
          _buildOptionCard(
            icon: Icons.receipt_long,
            iconColor: ColorManager.primary,
            title: 'Invoices',
            subtitle: 'Manage invoices and billing',
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InvoicesScreen(),
                ),
              );

              // Handle navigation result
              if (result != null && result is Map) {
                if (result['action'] == 'view_attendance') {
                  // Use NavigationService to switch to attendance tab
                  NavigationService().switchToAttendanceTab(result['date']);
                }
              }
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            icon: Icons.group,
            iconColor: ColorManager.success,
            title: 'Groups & Users',
            subtitle: 'Manage user groups and permissions',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GroupsScreen(),
                ),
              );
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            icon: Icons.manage_accounts,
            iconColor: ColorManager.info,
            title: 'Manage',
            subtitle: 'System settings and configuration',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageScreen(),
                ),
              );
            },
          ),

          SizedBox(height: 24.h),

          // Additional Options Section
          _buildSectionTitle('Additional'),
          SizedBox(height: 12.h),
          _buildOptionCard(
            icon: Icons.work_outline,
            iconColor: ColorManager.primary,
            title: 'Full Time Jobs',
            subtitle: 'View and manage full-time positions',
            onTap: () {
              // Navigate to Full Time Jobs screen
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            icon: Icons.smart_toy_outlined,
            iconColor: ColorManager.primaryDark,
            title: 'AI Chat',
            subtitle: 'AI-powered assistance and support',
            onTap: () {
              // Navigate to AI Chat screen
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            icon: Icons.help_outline,
            iconColor: ColorManager.info,
            title: 'DO Assist AI',
            subtitle: 'Smart AI assistance for your tasks',
            onTap: () {
              // Navigate to DO Assist AI screen
            },
          ),

          SizedBox(height: 24.h),

          // Settings Section
          _buildSectionTitle('Settings'),
          SizedBox(height: 12.h),
          _buildOptionCard(
            icon: Icons.notifications_outlined,
            iconColor: ColorManager.warning,
            title: 'Notifications',
            subtitle: 'Manage notification preferences',
            onTap: () {
              // Navigate to Notifications settings
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            icon: Icons.settings_outlined,
            iconColor: ColorManager.textSecondary,
            title: 'Settings',
            subtitle: 'App settings and preferences',
            onTap: () {
              // Navigate to Settings screen
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            icon: Icons.logout,
            iconColor: ColorManager.error,
            title: 'Logout',
            subtitle: 'Sign out of your account',
            onTap: () {
              // Handle logout
              _showLogoutDialog(context);
            },
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s14,
        fontWeight: FontWeightManager.semiBold,
        color: ColorManager.textSecondary,
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorManager.grey5),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                size: 24.sp,
                color: iconColor,
              ),
            ),
            SizedBox(width: 16.w),

            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s15,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
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

            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: ColorManager.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Logout',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManager.textPrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.medium,
                color: ColorManager.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle logout logic here
            },
            child: Text(
              'Logout',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
