import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';

class AssignGroupModal extends StatefulWidget {
  final String currentGroup;
  final Function(String) onGroupSelected;
  final List<String>? customGroups;

  const AssignGroupModal({
    super.key,
    required this.currentGroup,
    required this.onGroupSelected,
    this.customGroups,
  });

  @override
  State<AssignGroupModal> createState() => _AssignGroupModalState();
}

class _AssignGroupModalState extends State<AssignGroupModal> {
  late String selectedGroup;

  List<String> get availableGroups {
    final defaultGroups = [
      'Favourites',
      'Regulars',
      'Priority',
    ];

    if (widget.customGroups != null && widget.customGroups!.isNotEmpty) {
      // Combine default groups with custom groups
      return [...defaultGroups, ...widget.customGroups!];
    }

    return defaultGroups;
  }

  @override
  void initState() {
    super.initState();
    selectedGroup = widget.currentGroup;
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      backgroundColor: colors.cardBackground,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assign to Group',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.bold,
                    color: colors.textPrimary,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    size: 22.sp,
                    color: colors.textSecondary,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            // Subtitle
            Text(
              'Assign this staff member to a group',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.regular,
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 20.h),

            // Select Group Label
            Text(
              'Select Group',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),

            // Group Dropdown
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: colors.grey4),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: InkWell(
                onTap: () {
                  _showGroupPicker();
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedGroup,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.medium,
                          color: colors.textPrimary,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.sp,
                        color: colors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.grey4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Cancel',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onGroupSelected(selectedGroup);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                    ),
                    child: Text(
                      'Assign',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showGroupPicker() {
    final colors = ThemeHelper.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.grey3,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),

            // Group Options
            ...availableGroups.map((group) {
              final isSelected = selectedGroup == group;
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedGroup = group;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  color: isSelected
                      ? colors.primary.withValues(alpha: 0.05)
                      : Colors.transparent,
                  child: Row(
                    children: [
                      if (isSelected)
                        Icon(
                          Icons.check,
                          size: 20.sp,
                          color: colors.primary,
                        ),
                      if (isSelected) SizedBox(width: 12.w),
                      Text(
                        group,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s14,
                          fontWeight: isSelected
                              ? FontWeightManager.semiBold
                              : FontWeightManager.medium,
                          color: isSelected
                              ? colors.primary
                              : colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
