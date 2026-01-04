import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/onboarding_model.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/page_indicator.dart';
import '../../../auth/presentation/pages/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _onGetStarted();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onGetStarted() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _skipOnboarding() {
    _pageController.animateToPage(
      onboardingPages.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Logo and Skip
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  Text(
                    'Do Connect',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s20,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.primary,
                    ),
                  ),

                  // Skip Button
                  if (_currentPage < onboardingPages.length - 1)
                    TextButton(
                      onPressed: _skipOnboarding,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.medium,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // PageView Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  return OnboardingContent(
                    model: onboardingPages[index],
                    isActive: index == _currentPage,
                  );
                },
              ),
            ),

            // Bottom Navigation Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  // Page Indicator
                  PageIndicator(
                    currentPage: _currentPage,
                    pageCount: onboardingPages.length,
                  ),

                  SizedBox(height: 32.h),

                  // Navigation Buttons
                  Row(
                    children: [
                      // Previous Button
                      if (_currentPage > 0)
                        Expanded(
                          child: GestureDetector(
                            onTapDown: (_) =>
                                _buttonAnimationController.forward(),
                            onTapUp: (_) {
                              _buttonAnimationController.reverse();
                              _previousPage();
                            },
                            onTapCancel: () =>
                                _buttonAnimationController.reverse(),
                            child: ScaleTransition(
                              scale: _buttonScaleAnimation,
                              child: Container(
                                height: 56.h,
                                decoration: BoxDecoration(
                                  color: ColorManager.grey5,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Center(
                                  child: Text(
                                    'Previous',
                                    style: FontConstants.getPoppinsStyle(
                                      fontSize: FontSize.s16,
                                      fontWeight: FontWeightManager.semiBold,
                                      color: ColorManager.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      if (_currentPage > 0) SizedBox(width: 16.w),

                      // Next/Get Started Button
                      Expanded(
                        flex: _currentPage > 0 ? 1 : 2,
                        child: GestureDetector(
                          onTapDown: (_) => _buttonAnimationController.forward(),
                          onTapUp: (_) {
                            _buttonAnimationController.reverse();
                            _nextPage();
                          },
                          onTapCancel: () =>
                              _buttonAnimationController.reverse(),
                          child: ScaleTransition(
                            scale: _buttonScaleAnimation,
                            child: Container(
                              height: 56.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorManager.primary,
                                    ColorManager.primaryLight,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorManager.primary.withValues(alpha: 0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _currentPage == onboardingPages.length - 1
                                        ? 'Get Started'
                                        : 'Next',
                                    style: FontConstants.getPoppinsStyle(
                                      fontSize: FontSize.s16,
                                      fontWeight: FontWeightManager.semiBold,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: ColorManager.white,
                                    size: 20.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
