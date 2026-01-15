import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/doer_status_model.dart';
import 'doer_status_card.dart';

class StatusContent extends StatefulWidget {
  final String searchQuery;

  const StatusContent({super.key, this.searchQuery = ''});

  @override
  State<StatusContent> createState() => _StatusContentState();
}

class _StatusContentState extends State<StatusContent> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _openWhatsApp(String name) async {
    const platform = MethodChannel('whatsapp_launcher');
    try {
      // Sample phone number - in real app, get from doer model
      const phoneNumber = '1234567890';
      final message = 'Hi $name, reaching out from Do Connect regarding your shift.';
      await platform.invokeMethod('openWhatsApp', {
        'phone': phoneNumber,
        'message': message,
      });
    } on PlatformException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open WhatsApp: ${e.message}'),
            backgroundColor: ColorManager.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // Time slot filtering
  String? _selectedTimeSlot; // null means "All"
  final List<String> _timeSlots = [
    '08:00 - 16:00',
    '14:00 - 22:00',
    '18:00 - 02:00',
  ];

  final List<DoerStatusModel> _doers = [
    DoerStatusModel(
      id: '1',
      name: 'Sarah Johnson',
      gender: 'Male',
      timeRange: '08:00 - 16:00',
      location: 'Downtown Office',
      station: 'Reception',
      manager: 'Robert Williams',
      status: DoerWorkStatus.working,
      scannedInTime: '08:00',
    ),
    DoerStatusModel(
      id: '2',
      name: 'Michael Chen',
      gender: 'Male',
      timeRange: '14:00 - 22:00',
      location: 'North Hub',
      station: 'Security',
      manager: 'Jennifer Davis',
      status: DoerWorkStatus.scheduled,
    ),
    DoerStatusModel(
      id: '3',
      name: 'Emma Martinez',
      gender: 'Female',
      timeRange: '18:00 - 02:00',
      location: 'East Mall',
      station: 'Customer Service',
      manager: 'David Wilson',
      status: DoerWorkStatus.working,
      scannedInTime: '18:05',
    ),
    DoerStatusModel(
      id: '4',
      name: 'James Anderson',
      gender: 'Male',
      timeRange: '09:00 - 17:00',
      location: 'West Branch',
      station: 'Maintenance',
      manager: 'Lisa Brown',
      status: DoerWorkStatus.completed,
    ),
  ];

  List<DoerStatusModel> get _filteredDoers {
    var filtered = _doers;

    // Filter by time slot if selected
    if (_selectedTimeSlot != null) {
      filtered = filtered.where((doer) => doer.timeRange == _selectedTimeSlot).toList();
    }

    // Filter by search query
    if (widget.searchQuery.isNotEmpty) {
      final query = widget.searchQuery.toLowerCase();
      filtered = filtered.where((doer) {
        return doer.name.toLowerCase().contains(query) ||
               doer.location.toLowerCase().contains(query) ||
               doer.station.toLowerCase().contains(query) ||
               doer.manager.toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);
    final filteredDoers = _filteredDoers;

    return Column(
      children: [
        // Date Filter
        _buildDateFilter(),

        // Time Slot Filter Tabs
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          color: colors.background,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // All tab
                _buildTimeSlotTab('All', null),
                SizedBox(width: 8.w),
                // Time slot tabs
                ..._timeSlots.map((timeSlot) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: _buildTimeSlotTab(timeSlot, timeSlot),
                  );
                }),
              ],
            ),
          ),
        ),

        // Results Count (if searching)
        if (widget.searchQuery.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            color: colors.background,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${filteredDoers.length} DOER${filteredDoers.length != 1 ? 's' : ''} found',
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

        // DOER List
        Expanded(
          child: filteredDoers.isEmpty
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
                        'No DOERs found',
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
                  padding: EdgeInsets.all(16.w).copyWith(bottom: 80.h),
                  itemCount: filteredDoers.length,
                  itemBuilder: (context, index) {
                    return DoerStatusCard(
                      doer: filteredDoers[index],
                      onPing: () {
                        // Handle ping action
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ping sent to ${filteredDoers[index].name}'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      onMessage: () {
                        _openWhatsApp(filteredDoers[index].name);
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

  Widget _buildTimeSlotTab(String label, String? timeSlot) {
    final colors = ThemeHelper.of(context);
    final isSelected = _selectedTimeSlot == timeSlot;
    final count = timeSlot == null
        ? _doers.length
        : _doers.where((doer) => doer.timeRange == timeSlot).length;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTimeSlot = timeSlot;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? colors.cardBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? colors.primary : colors.grey3,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time,
              size: 14.sp,
              color: isSelected ? colors.primary : colors.textSecondary,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s12,
                fontWeight: isSelected ? FontWeightManager.semiBold : FontWeightManager.medium,
                color: isSelected ? colors.primary : colors.textSecondary,
              ),
            ),
            if (count > 0) ...[
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary : colors.grey4,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  count.toString(),
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s10,
                    fontWeight: FontWeightManager.semiBold,
                    color: isSelected ? ColorManager.white : colors.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
