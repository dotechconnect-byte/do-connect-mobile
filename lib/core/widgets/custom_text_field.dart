import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../consts/color_manager.dart';
import '../consts/font_manager.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool showPasswordToggle;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
    this.inputFormatters,
    this.onChanged,
    this.showPasswordToggle = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),

        // Text Field
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword && _obscureText,
            keyboardType: widget.keyboardType,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            validator: widget.validator,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s14.sp,
              fontWeight: FontWeightManager.regular,
              color: ColorManager.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeightManager.regular,
                color: ColorManager.textTertiary,
              ),
              prefixIcon: Icon(
                widget.prefixIcon,
                color: _isFocused
                    ? ColorManager.authPrimary
                    : ColorManager.textTertiary,
                size: 20.sp,
              ),
              suffixIcon: widget.isPassword && widget.showPasswordToggle
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: ColorManager.textTertiary,
                        size: 20.sp,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: ColorManager.authInputBackground,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: ColorManager.authInputBorder,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: ColorManager.authInputBorder,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: ColorManager.authPrimary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: ColorManager.error,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: ColorManager.error,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: ColorManager.grey4,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
