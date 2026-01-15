import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../widgets/invoices_content.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

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
              'Invoices',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
                color: colors.textPrimary,
              ),
            ),
            Text(
              'Manage and track your payments',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.regular,
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.file_download_outlined,
              color: colors.textPrimary,
              size: 24.sp,
            ),
            onPressed: () {
              // Export all invoices
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: colors.primary,
              size: 24.sp,
            ),
            onPressed: () {
              // Make new payment/invoice
            },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: const InvoicesContent(),
    );
  }
}
