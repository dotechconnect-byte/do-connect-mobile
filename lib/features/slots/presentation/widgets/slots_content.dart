import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/slot_model.dart';
import 'slot_card.dart';
import 'slot_details_modal.dart';

class SlotsContent extends StatefulWidget {
  final String searchQuery;

  const SlotsContent({super.key, this.searchQuery = ''});

  @override
  State<SlotsContent> createState() => _SlotsContentState();
}

class _SlotsContentState extends State<SlotsContent> {
  DateTime _selectedDate = DateTime.now();

  final List<SlotModel> _slots = [
    SlotModel(
      id: '1',
      timeRange: '09:00 - 17:00',
      position: 'Security Guard',
      location: 'West Branch',
      currentStaff: 0,
      requiredStaff: 2,
      groups: 1,
      directStaff: 2,
      date: 'Thursday, December 18, 2025',
    ),
    SlotModel(
      id: '2',
      timeRange: '14:00 - 22:00',
      position: 'Server',
      location: 'North Hub',
      currentStaff: 0,
      requiredStaff: 3,
      groups: 1,
      directStaff: 2,
      date: 'Thursday, December 18, 2025',
    ),
    SlotModel(
      id: '3',
      timeRange: '18:00 - 02:00',
      position: 'Receptionist',
      location: 'East Mall',
      currentStaff: 0,
      requiredStaff: 4,
      groups: 1,
      directStaff: 2,
      date: 'Thursday, December 18, 2025',
    ),
    SlotModel(
      id: '4',
      timeRange: '09:00 - 17:00',
      position: 'VIP Host',
      location: 'South Convention Center',
      currentStaff: 0,
      requiredStaff: 2,
      groups: 1,
      directStaff: 2,
      date: 'Thursday, December 18, 2025',
    ),
    SlotModel(
      id: '5',
      timeRange: '14:00 - 22:00',
      position: 'Barman',
      location: 'Central Park Plaza',
      currentStaff: 0,
      requiredStaff: 3,
      groups: 1,
      directStaff: 2,
      date: 'Thursday, December 18, 2025',
    ),
  ];

  List<SlotModel> get _filteredSlots {
    if (widget.searchQuery.isEmpty) {
      return _slots;
    }

    final query = widget.searchQuery.toLowerCase();
    return _slots.where((slot) {
      return slot.position.toLowerCase().contains(query) ||
             slot.location.toLowerCase().contains(query) ||
             slot.timeRange.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);
    final filteredSlots = _filteredSlots;

    return Column(
      children: [
        // Date Filter
        _buildDateFilter(),

        // Search Results Count
        if (widget.searchQuery.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            color: colors.background,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${filteredSlots.length} slot${filteredSlots.length != 1 ? 's' : ''} found',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.semiBold,
                      color: colors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Slots List
        Expanded(
          child: filteredSlots.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64.sp,
                        color: colors.grey3,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No slots found',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.semiBold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Try adjusting your search',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.regular,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 80.h),
                  itemCount: filteredSlots.length,
                  itemBuilder: (context, index) {
                    return SlotCard(
                      slot: filteredSlots[index],
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => SlotDetailsModal(
                            slot: filteredSlots[index],
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildDateFilter() {
    final colors = ThemeHelper.of(context);

    return Container(
      color: colors.cardBackground,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          // Previous Day Button
          InkWell(
            onTap: () {
              setState(() {
                _selectedDate = _selectedDate.subtract(const Duration(days: 1));
              });
            },
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: colors.grey6,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: colors.grey4),
              ),
              child: Icon(
                Icons.chevron_left,
                size: 20.sp,
                color: colors.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Date Display with Calendar Picker
          Expanded(
            child: InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    final pickerColors = ThemeHelper.of(context);
                    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 18.sp,
                      color: colors.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      _formatDate(_selectedDate),
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Next Day Button
          InkWell(
            onTap: () {
              setState(() {
                _selectedDate = _selectedDate.add(const Duration(days: 1));
              });
            },
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: colors.grey6,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: colors.grey4),
              ),
              child: Icon(
                Icons.chevron_right,
                size: 20.sp,
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));
    final selectedDay = DateTime(date.year, date.month, date.day);

    if (selectedDay == today) {
      return 'Today, ${_getMonthName(date.month)} ${date.day}';
    } else if (selectedDay == yesterday) {
      return 'Yesterday, ${_getMonthName(date.month)} ${date.day}';
    } else if (selectedDay == tomorrow) {
      return 'Tomorrow, ${_getMonthName(date.month)} ${date.day}';
    } else {
      return '${_getDayName(date.weekday)}, ${_getMonthName(date.month)} ${date.day}, ${date.year}';
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '';
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1: return 'Jan';
      case 2: return 'Feb';
      case 3: return 'Mar';
      case 4: return 'Apr';
      case 5: return 'May';
      case 6: return 'Jun';
      case 7: return 'Jul';
      case 8: return 'Aug';
      case 9: return 'Sep';
      case 10: return 'Oct';
      case 11: return 'Nov';
      case 12: return 'Dec';
      default: return '';
    }
  }
}
