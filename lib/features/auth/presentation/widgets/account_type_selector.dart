import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';

class AccountTypeSelector extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeChanged;

  const AccountTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: ColorManager.grey6,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          Expanded(
            child: _buildTab(
              text: 'Personal',
              isSelected: selectedType == 'personal',
              onTap: () => onTypeChanged('personal'),
            ),
          ),
          Expanded(
            child: _buildTab(
              text: 'Employer',
              isSelected: selectedType == 'employer',
              onTap: () => onTypeChanged('employer'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ColorManager.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s14,
              fontWeight: isSelected
                  ? FontWeightManager.semiBold
                  : FontWeightManager.medium,
              color: isSelected
                  ? ColorManager.textPrimary
                  : ColorManager.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
