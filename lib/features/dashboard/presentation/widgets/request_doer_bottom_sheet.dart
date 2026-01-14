import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';

class RequestDoerBottomSheet extends StatefulWidget {
  const RequestDoerBottomSheet({super.key});

  @override
  State<RequestDoerBottomSheet> createState() => _RequestDoerBottomSheetState();
}

class _RequestDoerBottomSheetState extends State<RequestDoerBottomSheet> {
  int _selectedType = 0; // 0: DOER, 1: Team
  String? _selectedPosition;
  String? _selectedLocation;
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _numberOfDoerController = TextEditingController(text: '1');
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _numberOfDoerController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 8.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: colors.grey3,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Request',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s18,
                      fontWeight: FontWeightManager.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 24.sp, color: colors.textPrimary),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subtitle
                  Text(
                    'Choose to request DOER or team services',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.regular,
                      color: colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Type Selector
                  Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: colors.grey6,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        _buildTypeTab('DOER', 0, colors),
                        _buildTypeTab('Team', 1, colors),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Position
                  _buildLabel('Position *', colors),
                  _buildDropdown(
                    hint: 'Select position',
                    value: _selectedPosition,
                    items: ['Event Coordinator', 'Parking Attendant', 'Crowd Control', 'Security Guard'],
                    onChanged: (value) => setState(() => _selectedPosition = value),
                    colors: colors,
                  ),
                  SizedBox(height: 16.h),

                  // Location
                  _buildLabel('Location *', colors),
                  _buildDropdown(
                    hint: 'Select location',
                    value: _selectedLocation,
                    items: ['West Branch', 'East Branch', 'North Branch', 'South Branch'],
                    onChanged: (value) => setState(() => _selectedLocation = value),
                    colors: colors,
                  ),
                  SizedBox(height: 16.h),

                  // Date and Number of DOER
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Date *', colors),
                            _buildDateField(colors),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Number of DOER *', colors),
                            _buildTextField(
                              controller: _numberOfDoerController,
                              keyboardType: TextInputType.number,
                              colors: colors,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Start Time and End Time
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Start Time *', colors),
                            _buildTimeField(_startTimeController, colors),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('End Time *', colors),
                            _buildTimeField(_endTimeController, colors),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Things to Note
                  _buildLabel('Things to Note', colors),
                  _buildTextArea(colors),
                  SizedBox(height: 20.h),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            side: BorderSide(color: colors.grey3, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.semiBold,
                              color: colors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle submit
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'Submit Request',
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
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeTab(String label, int index, ThemeHelper colors) {
    final isSelected = _selectedType == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: isSelected ? colors.cardBackground : Colors.transparent,
            borderRadius: BorderRadius.circular(6.r),
            boxShadow: isSelected
                ? [BoxShadow(color: colors.grey3.withValues(alpha: 0.1), blurRadius: 4)]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s13,
                fontWeight: isSelected ? FontWeightManager.semiBold : FontWeightManager.medium,
                color: isSelected ? colors.textPrimary : colors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label, ThemeHelper colors) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: FontConstants.getPoppinsStyle(
          fontSize: FontSize.s13,
          fontWeight: FontWeightManager.medium,
          color: colors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required ThemeHelper colors,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colors.grey4, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              hint,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s13,
                color: colors.textSecondary,
              ),
            ),
          ),
          isExpanded: true,
          icon: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Icon(Icons.keyboard_arrow_down, size: 20.sp, color: colors.textSecondary),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  item,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    TextInputType? keyboardType,
    required ThemeHelper colors,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s13,
        color: colors.textPrimary,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.grey4, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.grey4, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.primary, width: 1),
        ),
      ),
    );
  }

  Widget _buildDateField(ThemeHelper colors) {
    return TextField(
      controller: _dateController,
      readOnly: true,
      onTap: () async {
        final pickerColors = ThemeHelper.of(context);
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: isDark
                    ? ColorScheme.dark(
                        primary: pickerColors.primary,
                        onPrimary: ColorManager.white,
                        surface: pickerColors.cardBackground,
                        onSurface: pickerColors.textPrimary,
                      )
                    : ColorScheme.light(
                        primary: pickerColors.primary,
                        onPrimary: ColorManager.white,
                        surface: pickerColors.cardBackground,
                        onSurface: pickerColors.textPrimary,
                      ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          _dateController.text = '${date.day}/${date.month}/${date.year}';
        }
      },
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s13,
        color: colors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: 'dd/mm/yyyy',
        hintStyle: FontConstants.getPoppinsStyle(
          fontSize: FontSize.s13,
          color: colors.textSecondary,
        ),
        suffixIcon: Icon(Icons.calendar_today, size: 18.sp, color: colors.textSecondary),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.grey4, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.grey4, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.primary, width: 1),
        ),
      ),
    );
  }

  Widget _buildTimeField(TextEditingController controller, ThemeHelper colors) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null && mounted) {
          controller.text = time.format(context);
        }
      },
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s13,
        color: colors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: '--:--',
        hintStyle: FontConstants.getPoppinsStyle(
          fontSize: FontSize.s13,
          color: colors.textSecondary,
        ),
        suffixIcon: Icon(Icons.access_time, size: 18.sp, color: colors.textSecondary),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.grey4, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.grey4, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.primary, width: 1),
        ),
      ),
    );
  }

  Widget _buildTextArea(ThemeHelper colors) {
    return TextField(
      controller: _notesController,
      maxLines: 3,
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s13,
        color: colors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: 'Add any special requirements or notes...',
        hintStyle: FontConstants.getPoppinsStyle(
          fontSize: FontSize.s13,
          color: colors.textSecondary,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.grey4, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.grey4, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: colors.primary, width: 1),
        ),
      ),
    );
  }
}
