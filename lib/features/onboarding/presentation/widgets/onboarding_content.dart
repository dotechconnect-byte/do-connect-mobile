import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/onboarding_model.dart';
import 'feature_item.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingModel model;
  final bool isActive;

  const OnboardingContent({
    super.key,
    required this.model,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),

            // Icon with animation
            AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: isActive ? 1.0 : 0.0,
              curve: Curves.easeOut,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 600),
                scale: isActive ? 1.0 : 0.3,
                curve: Curves.elasticOut,
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: ColorManager.onboardingIconBg,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Icon(
                    model.icon,
                    size: 40.sp,
                    color: ColorManager.onboardingIconColor,
                  ),
                ),
              ),
            ),

            SizedBox(height: 40.h),

            // Title with animation
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: isActive ? 1.0 : 0.0,
              curve: Curves.easeOut,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 500),
                offset: isActive ? Offset.zero : const Offset(0, 0.3),
                curve: Curves.easeOut,
                child: Text(
                  model.title,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s32,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.textPrimary,
                    height: 1.3,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Subtitle with animation
            AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: isActive ? 1.0 : 0.0,
              curve: Curves.easeOut,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 600),
                offset: isActive ? Offset.zero : const Offset(0, 0.2),
                curve: Curves.easeOut,
                child: Text(
                  model.subtitle,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            SizedBox(height: 40.h),

            // Features list
            ...List.generate(
              model.features.length,
              (index) => FeatureItem(
                text: model.features[index],
                index: index,
              ),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
