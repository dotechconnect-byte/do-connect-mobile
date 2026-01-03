import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../invoices/presentation/pages/invoices_screen.dart';
import '../../../groups/presentation/pages/groups_screen.dart';
import '../../../manage/presentation/pages/manage_screen.dart';
import '../../../transport/presentation/pages/transport_screen.dart';

class MoreContent extends StatefulWidget {
  const MoreContent({super.key});

  @override
  State<MoreContent> createState() => _MoreContentState();
}

class _MoreContentState extends State<MoreContent> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    // Determine colors based on theme
    final cardColor = isDarkMode ? ColorManager.darkCardBackground : ColorManager.white;
    final textPrimaryColor = isDarkMode ? ColorManager.darkTextPrimary : ColorManager.textPrimary;
    final textSecondaryColor = isDarkMode ? ColorManager.darkTextSecondary : ColorManager.textSecondary;
    final borderColor = isDarkMode ? ColorManager.darkGrey5 : ColorManager.grey5;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Options Section
          _buildSectionTitle('Main Options', textSecondaryColor),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.receipt_long,
            iconColor: ColorManager.primary,
            title: 'Invoices',
            subtitle: 'Manage invoices and billing',
            cardColor: cardColor,
            textPrimaryColor: textPrimaryColor,
            textSecondaryColor: textSecondaryColor,
            borderColor: borderColor,
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
            context,
            icon: Icons.group,
            iconColor: ColorManager.success,
            title: 'Groups & Users',
            subtitle: 'Manage user groups and permissions',
            cardColor: cardColor,
            textPrimaryColor: textPrimaryColor,
            textSecondaryColor: textSecondaryColor,
            borderColor: borderColor,
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
            context,
            icon: Icons.manage_accounts,
            iconColor: ColorManager.info,
            title: 'Manage',
            subtitle: 'System settings and configuration',
            cardColor: cardColor,
            textPrimaryColor: textPrimaryColor,
            textSecondaryColor: textSecondaryColor,
            borderColor: borderColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageScreen(),
                ),
              );
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.local_shipping,
            iconColor: const Color(0xFFFF6B00),
            title: 'Transport Management',
            subtitle: 'Zone-based staff assignment with drag-and-drop',
            cardColor: cardColor,
            textPrimaryColor: textPrimaryColor,
            textSecondaryColor: textSecondaryColor,
            borderColor: borderColor,
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const TransportScreen(),
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
          ),

          SizedBox(height: 24.h),

          // Additional Options Section
          _buildSectionTitle('Additional', textSecondaryColor),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.work_outline,
            iconColor: ColorManager.primary,
            title: 'Full Time Jobs',
            subtitle: 'View and manage full-time positions',
            cardColor: cardColor,
            textPrimaryColor: textPrimaryColor,
            textSecondaryColor: textSecondaryColor,
            borderColor: borderColor,
            onTap: () {
              // Navigate to Full Time Jobs screen
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.smart_toy_outlined,
            iconColor: ColorManager.primaryDark,
            title: 'AI Chat',
            subtitle: 'AI-powered assistance and support',
            cardColor: cardColor,
            textPrimaryColor: textPrimaryColor,
            textSecondaryColor: textSecondaryColor,
            borderColor: borderColor,
            onTap: () {
              // Navigate to AI Chat screen
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.help_outline,
            iconColor: ColorManager.info,
            title: 'DO Assist AI',
            subtitle: 'Smart AI assistance for your tasks',
            cardColor: cardColor,
            textPrimaryColor: textPrimaryColor,
            textSecondaryColor: textSecondaryColor,
            borderColor: borderColor,
            onTap: () {
              // Navigate to DO Assist AI screen
            },
          ),

          SizedBox(height: 24.h),

          // Settings Section
          _buildSectionTitle('Settings', textSecondaryColor),
          SizedBox(height: 12.h),

          // Dark Mode Toggle
          _buildDarkModeToggle(
            themeProvider,
            isDarkMode,
            cardColor,
            textPrimaryColor,
            textSecondaryColor,
            borderColor,
          ),

          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.notifications_outlined,
            iconColor: ColorManager.warning,
            title: 'Notifications',
            subtitle: 'Manage notification preferences',
            cardColor: cardColor,
            textPrimaryColor: textPrimaryColor,
            textSecondaryColor: textSecondaryColor,
            borderColor: borderColor,
            onTap: () {
              // Navigate to Notifications settings
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.settings_outlined,
            iconColor: textSecondaryColor,
            title: 'Settings',
            subtitle: 'App settings and preferences',
            cardColor: cardColor,
            textPrimaryColor: textPrimaryColor,
            textSecondaryColor: textSecondaryColor,
            borderColor: borderColor,
            onTap: () {
              // Navigate to Settings screen
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.logout,
            iconColor: ColorManager.error,
            title: 'Logout',
            subtitle: 'Sign out of your account',
            cardColor: cardColor,
            textPrimaryColor: textPrimaryColor,
            textSecondaryColor: textSecondaryColor,
            borderColor: borderColor,
            onTap: () {
              // Handle logout
              _showLogoutDialog(context, cardColor, textPrimaryColor, textSecondaryColor);
            },
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Text(
      title,
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s14,
        fontWeight: FontWeightManager.semiBold,
        color: textColor,
      ),
    );
  }

  Widget _buildDarkModeToggle(
    ThemeProvider themeProvider,
    bool isDarkMode,
    Color cardColor,
    Color textPrimaryColor,
    Color textSecondaryColor,
    Color borderColor,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: (isDarkMode ? ColorManager.darkPrimary : ColorManager.primary).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              size: 24.sp,
              color: isDarkMode ? ColorManager.darkPrimary : ColorManager.primary,
            ),
          ),
          SizedBox(width: 16.w),

          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dark Mode',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s15,
                    fontWeight: FontWeightManager.semiBold,
                    color: textPrimaryColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  isDarkMode ? 'Switch to light theme' : 'Switch to dark theme',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: textSecondaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Toggle Switch
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
            activeThumbColor: ColorManager.darkPrimary,
            activeTrackColor: ColorManager.darkPrimary.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color cardColor,
    required Color textPrimaryColor,
    required Color textSecondaryColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: borderColor),
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
                      color: textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.regular,
                      color: textSecondaryColor,
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
              color: textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(
    BuildContext context,
    Color cardColor,
    Color textPrimaryColor,
    Color textSecondaryColor,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Logout',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: textPrimaryColor,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: textSecondaryColor,
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
                color: textSecondaryColor,
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
