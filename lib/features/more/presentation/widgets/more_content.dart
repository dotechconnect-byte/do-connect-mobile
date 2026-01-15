import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../invoices/presentation/pages/invoices_screen.dart';
import '../../../groups/presentation/pages/groups_screen.dart';
import '../../../manage/presentation/pages/manage_screen.dart';
import '../../../transport/presentation/pages/transport_screen.dart';
import '../../../full_time_jobs/presentation/pages/full_time_jobs_screen.dart';
import '../../../profile/presentation/pages/notification_preferences_screen.dart';
import '../../../auth/presentation/pages/login_screen.dart';

class MoreContent extends StatefulWidget {
  const MoreContent({super.key});

  @override
  State<MoreContent> createState() => _MoreContentState();
}

class _MoreContentState extends State<MoreContent> {
  bool _isNavigating = false; // Prevent double-tap crashes

  void _showComingSoonBottomSheet(String featureName, IconData icon) {
    final colors = ThemeHelper.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.grey4,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 32.h),

              // Icon with animated container
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40.sp,
                  color: colors.primary,
                ),
              ),
              SizedBox(height: 24.h),

              // Title
              Text(
                featureName,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s20,
                  fontWeight: FontWeightManager.bold,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),

              // Coming Soon Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Coming Soon',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.semiBold,
                    color: colors.primary,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Description
              Text(
                'We\'re working hard to bring this feature to you. Stay tuned!',
                textAlign: TextAlign.center,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 32.h),

              // Got It Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: ColorManager.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Got It',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s15,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  void _showChangePasswordBottomSheet() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool isCurrentPasswordVisible = false;
    bool isNewPasswordVisible = false;
    bool isConfirmPasswordVisible = false;
    bool isLoading = false;
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final colors = ThemeHelper.of(context);
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Drag Handle
                        Center(
                          child: Container(
                            width: 40.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: colors.grey3,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Header
                        Row(
                          children: [
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                color: ColorManager.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Icons.lock_outline,
                                color: ColorManager.primary,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Change Password',
                                    style: FontConstants.getPoppinsStyle(
                                      fontSize: FontSize.s18,
                                      fontWeight: FontWeightManager.bold,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    'Update your account password',
                                    style: FontConstants.getPoppinsStyle(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeightManager.regular,
                                      color: colors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.close,
                                color: colors.textSecondary,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),

                        // Current Password
                        Text(
                          'Current Password',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.medium,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: currentPasswordController,
                          obscureText: !isCurrentPasswordVisible,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,
                            color: colors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter current password',
                            hintStyle: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.regular,
                              color: colors.grey2,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: colors.grey2,
                              size: 20.sp,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isCurrentPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: colors.grey2,
                                size: 20.sp,
                              ),
                              onPressed: () {
                                setModalState(() {
                                  isCurrentPasswordVisible = !isCurrentPasswordVisible;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: colors.grey6,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.grey4),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.grey4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: ColorManager.primary, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: ColorManager.error),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your current password';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16.h),

                        // New Password
                        Text(
                          'New Password',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.medium,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: newPasswordController,
                          obscureText: !isNewPasswordVisible,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,
                            color: colors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter new password',
                            hintStyle: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.regular,
                              color: colors.grey2,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: colors.grey2,
                              size: 20.sp,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isNewPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: colors.grey2,
                                size: 20.sp,
                              ),
                              onPressed: () {
                                setModalState(() {
                                  isNewPasswordVisible = !isNewPasswordVisible;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: colors.grey6,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.grey4),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.grey4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: ColorManager.primary, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: ColorManager.error),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a new password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16.h),

                        // Confirm New Password
                        Text(
                          'Confirm New Password',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.medium,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: !isConfirmPasswordVisible,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,
                            color: colors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Confirm new password',
                            hintStyle: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.regular,
                              color: colors.grey2,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: colors.grey2,
                              size: 20.sp,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isConfirmPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: colors.grey2,
                                size: 20.sp,
                              ),
                              onPressed: () {
                                setModalState(() {
                                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: colors.grey6,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.grey4),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.grey4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: ColorManager.primary, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: ColorManager.error),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your new password';
                            }
                            if (value != newPasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 12.h),

                        // Password Requirements Info
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: colors.info.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: colors.info.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 18.sp,
                                color: colors.info,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  'Password must be at least 6 characters long',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.regular,
                                    color: colors.info,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Update Button
                        SizedBox(
                          width: double.infinity,
                          height: 52.h,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      setModalState(() => isLoading = true);

                                      final navigator = Navigator.of(context);
                                      final messenger = ScaffoldMessenger.of(context);

                                      // TODO: Implement actual password change API call
                                      Future.delayed(const Duration(seconds: 2), () {
                                        navigator.pop();
                                        messenger.showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Password changed successfully',
                                              style: FontConstants.getPoppinsStyle(
                                                fontSize: FontSize.s14,
                                                fontWeight: FontWeightManager.medium,
                                                color: ColorManager.white,
                                              ),
                                            ),
                                            backgroundColor: ColorManager.success,
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      });
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              foregroundColor: ColorManager.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: isLoading
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        ColorManager.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Update Password',
                                    style: FontConstants.getPoppinsStyle(
                                      fontSize: FontSize.s16,
                                      fontWeight: FontWeightManager.semiBold,
                                      color: ColorManager.white,
                                    ),
                                  ),
                          ),
                        ),

                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final colors = ThemeHelper.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Options Section
          _buildSectionTitle('Main Options', colors.textSecondary),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.receipt_long,
            iconColor: colors.primary,
            title: 'Invoices',
            subtitle: 'Manage invoices and billing',
            cardColor: colors.cardBackground,
            textPrimaryColor: colors.textPrimary,
            textSecondaryColor: colors.textSecondary,
            borderColor: colors.grey5,
            onTap: () async {
              if (_isNavigating) return;
              _isNavigating = true;
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InvoicesScreen(),
                ),
              );
              _isNavigating = false;

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
            iconColor: colors.success,
            title: 'Groups & Users',
            subtitle: 'Manage user groups and permissions',
            cardColor: colors.cardBackground,
            textPrimaryColor: colors.textPrimary,
            textSecondaryColor: colors.textSecondary,
            borderColor: colors.grey5,
            onTap: () async {
              if (_isNavigating) return;
              _isNavigating = true;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GroupsScreen(),
                ),
              );
              _isNavigating = false;
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.manage_accounts,
            iconColor: colors.info,
            title: 'Manage',
            subtitle: 'System settings and configuration',
            cardColor: colors.cardBackground,
            textPrimaryColor: colors.textPrimary,
            textSecondaryColor: colors.textSecondary,
            borderColor: colors.grey5,
            onTap: () async {
              if (_isNavigating) return;
              _isNavigating = true;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageScreen(),
                ),
              );
              _isNavigating = false;
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.local_shipping,
            iconColor: const Color(0xFFFF6B00),
            title: 'Transport Management',
            subtitle: 'Zone-based staff assignment with drag-and-drop',
            cardColor: colors.cardBackground,
            textPrimaryColor: colors.textPrimary,
            textSecondaryColor: colors.textSecondary,
            borderColor: colors.grey5,
            onTap: () async {
              if (_isNavigating) return;
              _isNavigating = true;
              await Navigator.push(
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
              _isNavigating = false;
            },
          ),

          SizedBox(height: 24.h),

          // Additional Options Section
          _buildSectionTitle('Additional', colors.textSecondary),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.work_outline,
            iconColor: colors.primary,
            title: 'Full Time Jobs',
            subtitle: 'View and manage full-time positions',
            cardColor: colors.cardBackground,
            textPrimaryColor: colors.textPrimary,
            textSecondaryColor: colors.textSecondary,
            borderColor: colors.grey5,
            onTap: () async {
              if (_isNavigating) return;
              _isNavigating = true;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FullTimeJobsScreen(),
                ),
              );
              _isNavigating = false;
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.smart_toy_outlined,
            iconColor: colors.primaryDark,
            title: 'AI Chat',
            subtitle: 'AI-powered assistance and support',
            cardColor: colors.cardBackground,
            textPrimaryColor: colors.textPrimary,
            textSecondaryColor: colors.textSecondary,
            borderColor: colors.grey5,
            onTap: () {
              _showComingSoonBottomSheet('AI Chat', Icons.smart_toy_outlined);
            },
          ),
          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.help_outline,
            iconColor: colors.info,
            title: 'DO Assist AI',
            subtitle: 'Smart AI assistance for your tasks',
            cardColor: colors.cardBackground,
            textPrimaryColor: colors.textPrimary,
            textSecondaryColor: colors.textSecondary,
            borderColor: colors.grey5,
            onTap: () {
              _showComingSoonBottomSheet('DO Assist AI', Icons.help_outline);
            },
          ),

          SizedBox(height: 24.h),

          // Settings Section
          _buildSectionTitle('Settings', colors.textSecondary),
          SizedBox(height: 12.h),

          // Change Password
          _buildOptionCard(
            context,
            icon: Icons.lock_outline,
            iconColor: colors.primary,
            title: 'Change Password',
            subtitle: 'Update your account password',
            cardColor: colors.cardBackground,
            textPrimaryColor: colors.textPrimary,
            textSecondaryColor: colors.textSecondary,
            borderColor: colors.grey5,
            onTap: () {
              _showChangePasswordBottomSheet();
            },
          ),

          SizedBox(height: 12.h),

          // Dark Mode Toggle
          _buildDarkModeToggle(
            themeProvider,
            isDarkMode,
            colors,
          ),

          SizedBox(height: 12.h),

          // Notifications
          _buildOptionCard(
            context,
            icon: Icons.notifications_outlined,
            iconColor: const Color(0xFFFBBF24),
            title: 'Notifications',
            subtitle: 'Manage notification preferences',
            cardColor: colors.cardBackground,
            textPrimaryColor: colors.textPrimary,
            textSecondaryColor: colors.textSecondary,
            borderColor: colors.grey5,
            onTap: () async {
              if (_isNavigating) return;
              _isNavigating = true;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPreferencesScreen(),
                ),
              );
              _isNavigating = false;
            },
          ),

          SizedBox(height: 12.h),
          _buildOptionCard(
            context,
            icon: Icons.logout,
            iconColor: colors.error,
            title: 'Logout',
            subtitle: 'Sign out of your account',
            cardColor: colors.cardBackground,
            textPrimaryColor: colors.textPrimary,
            textSecondaryColor: colors.textSecondary,
            borderColor: colors.grey5,
            onTap: () {
              // Handle logout
              _showLogoutDialog(context, colors);
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
    ThemeHelper colors,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey5),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              size: 24.sp,
              color: colors.primary,
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
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  isDarkMode ? 'Switch to light theme' : 'Switch to dark theme',
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

          // Toggle Switch
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
            activeThumbColor: colors.primary,
            activeTrackColor: colors.primary.withValues(alpha: 0.5),
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
    ThemeHelper colors,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.grey4,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 28.h),

              // Logout Icon
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: colors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_rounded,
                  size: 36.sp,
                  color: colors.error,
                ),
              ),
              SizedBox(height: 20.h),

              // Title
              Text(
                'Logout',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s20,
                  fontWeight: FontWeightManager.bold,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),

              // Description
              Text(
                'Are you sure you want to logout from your account?',
                textAlign: TextAlign.center,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 28.h),

              // Buttons Row
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: colors.grey4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s15,
                            fontWeight: FontWeightManager.semiBold,
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Logout Button
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Navigate to login screen and clear all routes
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.error,
                          foregroundColor: ColorManager.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s15,
                            fontWeight: FontWeightManager.semiBold,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }
}
