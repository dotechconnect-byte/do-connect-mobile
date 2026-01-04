import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: currentPage == index ? 32.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: currentPage == index
                ? ColorManager.onboardingDotActive
                : ColorManager.onboardingDot,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }
}
