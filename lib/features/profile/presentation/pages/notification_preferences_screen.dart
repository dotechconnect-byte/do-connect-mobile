import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  // Master Toggle
  bool _enableAllNotifications = true;

  // Notification Types
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _whatsAppNotifications = true;

  // Categories
  bool _invoiceNotifications = true;
  bool _jobNotifications = true;
  bool _doerStatusNotifications = true;
  bool _slotAssignmentNotifications = true;
  bool _paymentNotifications = true;

  void _savePreferences() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Preferences saved',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.medium,
            color: ColorManager.white,
          ),
        ),
        backgroundColor: ColorManager.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.cardBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: colors.textPrimary,
          ),
        ),
        title: Text(
          'Notifications',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: colors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                // Master Toggle
                _buildMasterToggle(colors),

                SizedBox(height: 24.h),

                // Delivery Methods
                _buildSectionLabel('Delivery Methods', colors),
                SizedBox(height: 8.h),
                _buildCard(
                  colors,
                  children: [
                    _buildToggleItem(
                      colors,
                      icon: Icons.notifications_outlined,
                      title: 'Push Notifications',
                      value: _pushNotifications,
                      onChanged: (v) => setState(() => _pushNotifications = v),
                    ),
                    _buildToggleItem(
                      colors,
                      icon: Icons.email_outlined,
                      title: 'Email',
                      value: _emailNotifications,
                      onChanged: (v) => setState(() => _emailNotifications = v),
                    ),
                    _buildToggleItem(
                      colors,
                      icon: Icons.chat_bubble_outline,
                      title: 'WhatsApp',
                      value: _whatsAppNotifications,
                      onChanged: (v) => setState(() => _whatsAppNotifications = v),
                      isLast: true,
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Categories
                _buildSectionLabel('Categories', colors),
                SizedBox(height: 8.h),
                _buildCard(
                  colors,
                  children: [
                    _buildToggleItem(
                      colors,
                      icon: Icons.receipt_long_outlined,
                      title: 'Invoices',
                      value: _invoiceNotifications,
                      onChanged: (v) => setState(() => _invoiceNotifications = v),
                    ),
                    _buildToggleItem(
                      colors,
                      icon: Icons.work_outline,
                      title: 'Jobs',
                      value: _jobNotifications,
                      onChanged: (v) => setState(() => _jobNotifications = v),
                    ),
                    _buildToggleItem(
                      colors,
                      icon: Icons.person_outline,
                      title: 'DOER Status',
                      value: _doerStatusNotifications,
                      onChanged: (v) => setState(() => _doerStatusNotifications = v),
                    ),
                    _buildToggleItem(
                      colors,
                      icon: Icons.event_available_outlined,
                      title: 'Slots & Assignments',
                      value: _slotAssignmentNotifications,
                      onChanged: (v) => setState(() => _slotAssignmentNotifications = v),
                    ),
                    _buildToggleItem(
                      colors,
                      icon: Icons.payments_outlined,
                      title: 'Payments',
                      value: _paymentNotifications,
                      onChanged: (v) => setState(() => _paymentNotifications = v),
                      isLast: true,
                    ),
                  ],
                ),

                SizedBox(height: 32.h),
              ],
            ),
          ),

          // Save Button
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: colors.cardBackground,
              border: Border(
                top: BorderSide(color: colors.grey5, width: 1),
              ),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: _savePreferences,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: ColorManager.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s15,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMasterToggle(ThemeHelper colors) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey5),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: _enableAllNotifications
                  ? colors.primary.withValues(alpha: 0.1)
                  : colors.grey5,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              _enableAllNotifications
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_off_outlined,
              size: 22.sp,
              color: _enableAllNotifications ? colors.primary : colors.grey2,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Notifications',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s15,
                    fontWeight: FontWeightManager.semiBold,
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  _enableAllNotifications ? 'Enabled' : 'Disabled',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _enableAllNotifications,
            onChanged: (value) => setState(() => _enableAllNotifications = value),
            activeThumbColor: ColorManager.white,
            activeTrackColor: colors.primary,
            inactiveThumbColor: colors.grey3,
            inactiveTrackColor: colors.grey4,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String title, ThemeHelper colors) {
    return Text(
      title,
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s13,
        fontWeight: FontWeightManager.semiBold,
        color: colors.textSecondary,
      ),
    );
  }

  Widget _buildCard(ThemeHelper colors, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey5),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildToggleItem(
    ThemeHelper colors, {
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
    bool isLast = false,
  }) {
    final isEnabled = _enableAllNotifications;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22.sp,
                color: isEnabled ? colors.textPrimary : colors.grey3,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.medium,
                    color: isEnabled ? colors.textPrimary : colors.grey3,
                  ),
                ),
              ),
              Switch(
                value: value,
                onChanged: isEnabled ? onChanged : null,
                activeThumbColor: ColorManager.white,
                activeTrackColor: colors.primary,
                inactiveThumbColor: colors.grey3,
                inactiveTrackColor: colors.grey4,
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            thickness: 1,
            color: colors.grey5,
            indent: 50.w,
          ),
      ],
    );
  }
}
