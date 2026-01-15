import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isPrimary;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? ColorManager.primary : ColorManager.white,
          foregroundColor: isPrimary ? ColorManager.white : colors.textPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(
                    color: colors.grey4,
                    width: 1.5,
                  ),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isPrimary ? ColorManager.white : ColorManager.primary,
                  ),
                ),
              )
            : Text(
                text,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.semiBold,
                  color: isPrimary ? ColorManager.white : colors.textPrimary,
                ),
              ),
      ),
    );
  }
}
