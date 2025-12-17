import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  int _currentIndex = 0;

  final List<BannerData> banners = [
    BannerData(
      title: 'Exclusive Member Benefits!',
      subtitle: 'Special perks and priority access to shifts',
      gradient: [Color(0xFFFF6B35), Color(0xFFFF8C5F)],
    ),
    BannerData(
      title: 'Boost Your Career Growth!',
      subtitle: 'Access exclusive training programs',
      gradient: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
    ),
    BannerData(
      title: 'Earn More with Bonuses!',
      subtitle: 'Complete shifts and get instant rewards',
      gradient: [Color(0xFF10B981), Color(0xFF34D399)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: CarouselSlider.builder(
            itemCount: banners.length,
            options: CarouselOptions(
              height: 120.h,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final banner = banners[index];
              return Container(
                width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: banner.gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: banner.gradient[0].withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    bottom: -10,
                    child: Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          banner.title,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          banner.subtitle,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.white.withValues(alpha: 0.9),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            'Learn more',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s11,
                              fontWeight: FontWeightManager.semiBold,
                              color: banner.gradient[0],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          ),
        ),
        SizedBox(height: 12.h),
        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: banners.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentIndex == entry.key ? 24.w : 8.w,
              height: 8.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: _currentIndex == entry.key
                    ? ColorManager.primary
                    : ColorManager.grey3,
                borderRadius: BorderRadius.circular(4.r),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class BannerData {
  final String title;
  final String subtitle;
  final List<Color> gradient;

  BannerData({
    required this.title,
    required this.subtitle,
    required this.gradient,
  });
}
