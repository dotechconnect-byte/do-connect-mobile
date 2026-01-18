import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../widgets/profile_content.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.cardBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colors.textPrimary,
            size: 24.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
                color: colors.textPrimary,
              ),
            ),
            Text(
              'Manage your company profile',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.regular,
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      body: const SafeArea(
        child: ProfileContent(),
      ),
    );
  }
}
