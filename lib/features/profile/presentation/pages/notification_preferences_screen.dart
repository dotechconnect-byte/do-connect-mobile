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
  // Invoice Notifications
  bool _muteInvoiceNotifications = false;
  bool _invoiceSendToEmail = true;
  bool _invoiceSendToWhatsApp = false;

  // Full-Time Job Notifications
  bool _muteJobNotifications = false;
  bool _jobSendToEmail = true;
  bool _jobSendToWhatsApp = true;

  // DOER Status Updates
  bool _muteStatusNotifications = false;
  bool _statusSendToEmail = false;
  bool _statusSendToWhatsApp = true;

  // Slot & Assignment Notifications
  bool _muteSlotNotifications = false;
  bool _slotSendToEmail = true;
  bool _slotSendToWhatsApp = true;

  void _savePreferences() {
    // TODO: Implement save functionality
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification preferences saved successfully!'),
        backgroundColor: ColorManager.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        children: [
          // Custom Header with Close Button
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16.h,
              left: 20.w,
              right: 20.w,
              bottom: 20.h,
            ),
            decoration: BoxDecoration(
              color: colors.cardBackground,
              border: Border(
                bottom: BorderSide(color: colors.grey5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notification Preferences',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s20,
                          fontWeight: FontWeightManager.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Manage how you receive notifications for different categories',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.regular,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: colors.textPrimary, size: 24.sp),
                  padding: EdgeInsets.all(8.w),
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Invoice Notifications
                  _buildNotificationCategory(
                    colors,
                    'Invoice Notifications',
                    _muteInvoiceNotifications,
                    (value) => setState(() => _muteInvoiceNotifications = value),
                    _invoiceSendToEmail,
                    (value) => setState(() => _invoiceSendToEmail = value),
                    _invoiceSendToWhatsApp,
                    (value) => setState(() => _invoiceSendToWhatsApp = value),
                    'Mute all invoice notifications',
                  ),

                  SizedBox(height: 24.h),

                  // Full-Time Job Notifications
                  _buildNotificationCategory(
                    colors,
                    'Full-Time Job Notifications',
                    _muteJobNotifications,
                    (value) => setState(() => _muteJobNotifications = value),
                    _jobSendToEmail,
                    (value) => setState(() => _jobSendToEmail = value),
                    _jobSendToWhatsApp,
                    (value) => setState(() => _jobSendToWhatsApp = value),
                    'Mute all job notifications',
                  ),

                  SizedBox(height: 24.h),

                  // DOER Status Updates
                  _buildNotificationCategory(
                    colors,
                    'DOER Status Updates',
                    _muteStatusNotifications,
                    (value) => setState(() => _muteStatusNotifications = value),
                    _statusSendToEmail,
                    (value) => setState(() => _statusSendToEmail = value),
                    _statusSendToWhatsApp,
                    (value) => setState(() => _statusSendToWhatsApp = value),
                    'Mute all status notifications',
                  ),

                  SizedBox(height: 24.h),

                  // Slot & Assignment Notifications
                  _buildNotificationCategory(
                    colors,
                    'Slot & Assignment Notifications',
                    _muteSlotNotifications,
                    (value) => setState(() => _muteSlotNotifications = value),
                    _slotSendToEmail,
                    (value) => setState(() => _slotSendToEmail = value),
                    _slotSendToWhatsApp,
                    (value) => setState(() => _slotSendToWhatsApp = value),
                    'Mute all slot notifications',
                  ),
                ],
              ),
            ),
          ),

          // Bottom Actions
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: colors.cardBackground,
              border: Border(
                top: BorderSide(color: colors.grey5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.textPrimary,
                      side: BorderSide(color: colors.grey4, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Cancel',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s15,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _savePreferences,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                    ),
                    child: Text(
                      'Save Preferences',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s15,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCategory(
    ThemeHelper colors,
    String title,
    bool muteValue,
    Function(bool) onMuteChanged,
    bool emailValue,
    Function(bool) onEmailChanged,
    bool whatsAppValue,
    Function(bool) onWhatsAppChanged,
    String muteLabel,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Title
          Text(
            title,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.bold,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),

          // Mute All Option
          _buildNotificationOption(
            colors,
            Icons.notifications_off_outlined,
            muteLabel,
            muteValue,
            onMuteChanged,
          ),

          SizedBox(height: 12.h),

          // Send to Email Option
          _buildNotificationOption(
            colors,
            Icons.email_outlined,
            'Send to Email',
            emailValue,
            onEmailChanged,
          ),

          SizedBox(height: 12.h),

          // Send to WhatsApp Option
          _buildNotificationOption(
            colors,
            Icons.chat_bubble_outline,
            'Send to WhatsApp',
            whatsAppValue,
            onWhatsAppChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationOption(
    ThemeHelper colors,
    IconData icon,
    String label,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20.sp,
          color: colors.textSecondary,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
              color: colors.textPrimary,
            ),
          ),
        ),
        Transform.scale(
          scale: 0.9,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: ColorManager.primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: colors.grey4,
          ),
        ),
      ],
    );
  }
}
