import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/image_picker_utils.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/company_model.dart';
import 'edit_company_modal.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  // Mock data - using late to allow reassignment
  late CompanyModel _company = CompanyModel(
    name: 'Acme Corporation',
    email: 'contact@acme.com',
    phone: '+1 (555) 123-4567',
    address: '123 Business St, City',
  );

  String? _companyLogoPath;

  void _handleCompanyUpdate(CompanyModel updatedCompany) {
    setState(() {
      _company = updatedCompany;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Company information updated successfully'),
        backgroundColor: Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleLogoChange() async {
    final imagePath = await ImagePickerUtils.showImageSourceDialog(
      context: context,
      title: 'Select Company Logo',
    );

    if (imagePath != null) {
      setState(() {
        _companyLogoPath = imagePath;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Company logo updated successfully'),
            backgroundColor: Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  final UserRole _currentRole = UserRole(
    name: 'Admin',
    description: 'Administrative access with most permissions',
    permissions: [
      'Manage staff and shifts',
      'View financial reports',
      'Handle attendance and rosters',
      'Process staff requests',
      'Generate reports',
      'Limited settings access',
    ],
  );

  final List<FeedbackCategory> _feedbackCategories = [
    FeedbackCategory(title: 'Staff Feedback', icon: '👥', rating: 4.3, reviewCount: 7),
    FeedbackCategory(title: 'Location Feedback', icon: '📍', rating: 4.3, reviewCount: 4),
    FeedbackCategory(title: 'Event Feedback', icon: '🎉', rating: 4.5, reviewCount: 4),
    FeedbackCategory(title: 'Station Feedback', icon: '🏢', rating: 4.3, reviewCount: 4),
    FeedbackCategory(title: 'Environment Feedback', icon: '🌍', rating: 4.0, reviewCount: 3),
    FeedbackCategory(title: 'Transport Feedback', icon: '🚗', rating: 4.0, reviewCount: 4),
    FeedbackCategory(title: 'Canteen Feedback', icon: '🍽️', rating: 4.5, reviewCount: 4),
  ];

  // Notification settings
  bool _shiftConfirmations = true;
  bool _lateArrivals = true;
  bool _invoiceReminders = true;
  bool _weeklyReports = false;
  bool _attendanceEmails = true;
  bool _invoiceEmails = true;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company Information Section
          Container(
            color: colors.cardBackground,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Company Information',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => EditCompanyModal(
                            company: _company,
                            onSave: _handleCompanyUpdate,
                          ),
                        );
                      },
                      icon: Icon(Icons.edit, size: 16.sp, color: colors.textSecondary),
                      label: Text(
                        'Edit',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.medium,
                          color: colors.textSecondary,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Update your company details',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 16.h),

                // Company Logo
                Row(
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(12.r),
                        image: _companyLogoPath != null
                            ? DecorationImage(
                                image: FileImage(File(_companyLogoPath!)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _companyLogoPath == null
                          ? Center(
                              child: Text(
                                'DC',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s20,
                                  fontWeight: FontWeightManager.bold,
                                  color: ColorManager.white,
                                ),
                              ),
                            )
                          : null,
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: _handleLogoChange,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Change Logo',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s13,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'PNG, JPG up to 2MB',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s11,
                            fontWeight: FontWeightManager.regular,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // Company Details
                Row(
                  children: [
                    Expanded(child: _buildInfoBox('Company Name', _company.name)),
                    SizedBox(width: 12.w),
                    Expanded(child: _buildInfoBox('Email', _company.email)),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(child: _buildInfoBox('Phone', _company.phone)),
                    SizedBox(width: 12.w),
                    Expanded(child: _buildInfoBox('Address', _company.address)),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Role & Permissions Section
          Container(
            color: colors.cardBackground,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Role & Permissions',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  'Your current role and access level',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 16.h),

                // Current Role
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: colors.grey6,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: colors.grey4),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Role',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s11,
                                fontWeight: FontWeightManager.medium,
                                color: colors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              _currentRole.name,
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s15,
                                fontWeight: FontWeightManager.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, size: 20.sp, color: colors.textSecondary),
                    ],
                  ),
                ),

                SizedBox(height: 12.h),

                Text(
                  _currentRole.description,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                ),

                SizedBox(height: 16.h),

                // Permissions
                Text(
                  'Permissions',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.semiBold,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),

                ..._currentRole.permissions.map((permission) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16.sp,
                        color: colors.success,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          permission,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.regular,
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Quick Stats Section
          Container(
            color: colors.cardBackground,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Stats',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('Account Type', 'Employer Pro', colors.primary),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('Member Since', 'January 2025', colors.textPrimary),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('Total Staff Hired', '47', colors.info),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildStatCard('Total Shifts', '324', colors.success),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4ED),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: const Color(0xFFFFE5DC)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 18.sp, color: colors.primary),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Notification Setting Updated\nweekly Reports disabled',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s11,
                            fontWeight: FontWeightManager.medium,
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Manager Feedback Summary
          Container(
            color: colors.cardBackground,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manager Feedback Summary',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  'View aggregated feedback from various categories',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 16.h),

                ..._feedbackCategories.map((category) => _buildFeedbackItem(category)),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Notification Settings
          Container(
            color: colors.cardBackground,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notification Settings',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  'Manage how you receive notifications',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 16.h),

                _buildNotificationToggle(
                  'Shift Confirmations',
                  'Get notified when staff confirm shifts',
                  _shiftConfirmations,
                  (value) => setState(() => _shiftConfirmations = value),
                ),
                _buildNotificationToggle(
                  'Late Arrivals',
                  'Alert when staff are running late',
                  _lateArrivals,
                  (value) => setState(() => _lateArrivals = value),
                ),
                _buildNotificationToggle(
                  'Invoice Reminders',
                  'Reminders for pending invoices',
                  _invoiceReminders,
                  (value) => setState(() => _invoiceReminders = value),
                ),
                _buildNotificationToggle(
                  'Weekly Reports',
                  'Receive weekly performance summaries',
                  _weeklyReports,
                  (value) => setState(() => _weeklyReports = value),
                ),
                _buildNotificationToggle(
                  'Send Attendance Emails',
                  'Automatically send attendance reports via email',
                  _attendanceEmails,
                  (value) => setState(() => _attendanceEmails = value),
                ),
                _buildNotificationToggle(
                  'Send Invoice Emails',
                  'Automatically send invoice notifications via email',
                  _invoiceEmails,
                  (value) => setState(() => _invoiceEmails = value),
                  isLast: true,
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Security Section
          Container(
            color: colors.cardBackground,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Security',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 16.h),

                _buildSecurityOption(
                  Icons.lock_outline,
                  'Change Password',
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Change password'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                SizedBox(height: 12.h),
                _buildSecurityOption(
                  Icons.verified_user_outlined,
                  'Two-Factor Auth',
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Setup two-factor authentication'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Contact Support
          Container(
            color: colors.cardBackground,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Support',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  'Get in touch with us',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 16.h),

                _buildContactOption(
                  Icons.phone_outlined,
                  'WhatsApp',
                  colors.primary,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Contact via WhatsApp'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                SizedBox(height: 12.h),
                _buildContactOption(
                  Icons.chat_bubble_outline,
                  'Chat with Us',
                  colors.primary,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Start chat'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 80.h), // Extra padding for FAB
        ],
      ),
    );
  }

  Widget _buildInfoBox(String label, String value) {
    final colors = ThemeHelper.of(context);
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colors.grey6,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.grey4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s11,
              fontWeight: FontWeightManager.medium,
              color: colors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s13,
              fontWeight: FontWeightManager.semiBold,
              color: colors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    final colors = ThemeHelper.of(context);
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colors.grey6,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.grey4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.medium,
                color: colors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s15,
              fontWeight: FontWeightManager.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackItem(FeedbackCategory category) {
    final colors = ThemeHelper.of(context);
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('View ${category.title}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: colors.grey4, width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: colors.grey6,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  category.icon,
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.title,
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.semiBold,
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < category.rating.floor()
                              ? Icons.star
                              : (index < category.rating ? Icons.star_half : Icons.star_border),
                          size: 14.sp,
                          color: colors.warning,
                        );
                      }),
                      SizedBox(width: 6.w),
                      Text(
                        '${category.rating} avg',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s11,
                          fontWeight: FontWeightManager.medium,
                          color: colors.textSecondary,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '• ${category.reviewCount} reviews',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s11,
                          fontWeight: FontWeightManager.regular,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_down, size: 20.sp, color: colors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationToggle(
    String title,
    String description,
    bool value,
    Function(bool) onChanged, {
    bool isLast = false,
  }) {
    final colors = ThemeHelper.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(color: colors.grey4, width: 1),
              ),
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
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  description,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s11,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: colors.primary,
            activeThumbColor: ColorManager.white,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityOption(IconData icon, String title, VoidCallback onTap) {
    final colors = ThemeHelper.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: colors.grey3),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20.sp, color: colors.textPrimary),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.medium,
                  color: colors.textPrimary,
                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 20.sp, color: colors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption(IconData icon, String title, Color color, VoidCallback onTap) {
    final colors = ThemeHelper.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: colors.grey3),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20.sp, color: color),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: colors.textPrimary,
                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 20.sp, color: colors.textSecondary),
          ],
        ),
      ),
    );
  }
}
