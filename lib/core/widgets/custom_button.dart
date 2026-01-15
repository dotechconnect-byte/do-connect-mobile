import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../consts/color_manager.dart';
import '../consts/font_manager.dart';

enum ButtonType {
  primary,
  secondary,
  outline,
  text,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool enabled;
  final IconData? icon;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.enabled = true,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = enabled && !isLoading;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48.h,
      child: _buildButton(isEnabled),
    );
  }

  Widget _buildButton(bool isEnabled) {
    switch (type) {
      case ButtonType.primary:
        return _buildPrimaryButton(isEnabled);
      case ButtonType.secondary:
        return _buildSecondaryButton(isEnabled);
      case ButtonType.outline:
        return _buildOutlineButton(isEnabled);
      case ButtonType.text:
        return _buildTextButton(isEnabled);
    }
  }

  Widget _buildPrimaryButton(bool isEnabled) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.authPrimary,
        foregroundColor: ColorManager.white,
        disabledBackgroundColor: ColorManager.authPrimary.withValues(alpha: 0.5),
        disabledForegroundColor: ColorManager.white.withValues(alpha: 0.7),
        elevation: 0,
        shadowColor: ColorManager.authPrimary.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      ),
      child: _buildButtonChild(ColorManager.white),
    );
  }

  Widget _buildSecondaryButton(bool isEnabled) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.authSecondary,
        foregroundColor: ColorManager.authSecondaryText,
        disabledBackgroundColor: ColorManager.authSecondary.withValues(alpha: 0.5),
        disabledForegroundColor:
            ColorManager.authSecondaryText.withValues(alpha: 0.5),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      ),
      child: _buildButtonChild(ColorManager.authSecondaryText),
    );
  }

  Widget _buildOutlineButton(bool isEnabled) {
    return OutlinedButton(
      onPressed: isEnabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorManager.authPrimary,
        disabledForegroundColor:
            ColorManager.authPrimary.withValues(alpha: 0.5),
        side: BorderSide(
          color: isEnabled
              ? ColorManager.authPrimary
              : ColorManager.authPrimary.withValues(alpha: 0.3),
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      ),
      child: _buildButtonChild(ColorManager.authPrimary),
    );
  }

  Widget _buildTextButton(bool isEnabled) {
    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.authPrimary,
        disabledForegroundColor:
            ColorManager.authPrimary.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      ),
      child: _buildButtonChild(ColorManager.authPrimary),
    );
  }

  Widget _buildButtonChild(Color textColor) {
    if (isLoading) {
      return SizedBox(
        height: 20.h,
        width: 20.w,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            type == ButtonType.primary ? ColorManager.white : ColorManager.authPrimary,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeightManager.semiBold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: FontSize.s16.sp,
        fontWeight: FontWeightManager.semiBold,
        letterSpacing: 0.5,
      ),
    );
  }
}
