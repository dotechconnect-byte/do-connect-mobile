import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';

class InviteStaffModal extends StatefulWidget {
  const InviteStaffModal({super.key});

  @override
  State<InviteStaffModal> createState() => _InviteStaffModalState();
}

class _InviteStaffModalState extends State<InviteStaffModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _sendInvitation() {
    if (_formKey.currentState!.validate()) {
      final colors = ThemeHelper.of(context);
      // Close the dialog
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invitation sent to ${_emailController.text}',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s13,
              fontWeight: FontWeightManager.medium,
              color: ColorManager.white,
            ),
          ),
          backgroundColor: colors.success,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Invite Staff Member',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s20,
                      fontWeight: FontWeightManager.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: colors.textSecondary,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Subtitle
              Text(
                'Send an invitation to join your workforce',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.regular,
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),

              // Name Field
              Text(
                'Name',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Full name',
                  hintStyle: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                    color: colors.grey3,
                  ),
                  filled: true,
                  fillColor: colors.grey6,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.grey4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.primary, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.error, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                ),
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                  color: colors.textPrimary,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),

              // Email Field
              Text(
                'Email',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'email@example.com',
                  hintStyle: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                    color: colors.grey3,
                  ),
                  filled: true,
                  fillColor: colors.grey6,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.grey4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.primary, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.error, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                ),
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                  color: colors.textPrimary,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),

              // Action Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colors.grey4),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.semiBold,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Send Invitation Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _sendInvitation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Send Invitation',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
