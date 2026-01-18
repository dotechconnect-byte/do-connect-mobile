import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/attendance_model.dart';
import 'attendance_card.dart';
import 'attendance_detail_modal.dart';

class AttendanceContent extends StatefulWidget {
  final String searchQuery;
  final String? initialDate;

  const AttendanceContent({
    super.key,
    this.searchQuery = '',
    this.initialDate,
  });

  @override
  State<AttendanceContent> createState() => _AttendanceContentState();
}

class _AttendanceContentState extends State<AttendanceContent> {
  DateTime _selectedDate = DateTime.now();

  // Shift filtering
  String _selectedShift = 'All Shifts';
  final List<String> _shifts = [
    'All Shifts',
    '08:00 - 16:00',
    '14:00 - 22:00',
    '18:00 - 02:00',
  ];


  final List<AttendanceModel> _attendances = [
    AttendanceModel(
      id: '1',
      number: 1,
      name: 'Sarah Johnson',
      shift: '08:00 - 16:00',
      location: 'Downtown Office',
      station: 'Reception',
      checkInTime: '08:00',
      status: AttendanceStatus.processing,
    ),
    AttendanceModel(
      id: '2',
      number: 2,
      name: 'Michael Chen',
      shift: '14:00 - 22:00',
      location: 'Downtown Office',
      station: 'Reception',
      status: AttendanceStatus.pending,
    ),
    AttendanceModel(
      id: '3',
      number: 3,
      name: 'Emily Rodriguez',
      shift: '18:00 - 02:00',
      location: 'Downtown Office',
      station: 'Reception',
      status: AttendanceStatus.pending,
    ),
  ];

  List<AttendanceModel> get _filteredAttendances {
    var filtered = _attendances;

    // Filter by shift if not "All Shifts"
    if (_selectedShift != 'All Shifts') {
      filtered = filtered.where((attendance) => attendance.shift == _selectedShift).toList();
    }

    // Filter by search query
    if (widget.searchQuery.isNotEmpty) {
      final query = widget.searchQuery.toLowerCase();
      filtered = filtered.where((attendance) {
        return attendance.name.toLowerCase().contains(query) ||
               attendance.location.toLowerCase().contains(query) ||
               attendance.station.toLowerCase().contains(query) ||
               attendance.shift.toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
  }

  int get _totalWorked => _attendances.where((a) => a.checkInTime != null).length;
  int get _totalHours => _totalWorked * 8;
  int get _confirmed => _attendances.where((a) => a.status == AttendanceStatus.confirmed).length;
  int get _cancelled => _attendances.where((a) => a.status == AttendanceStatus.cancelled).length;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);
    final filteredAttendances = _filteredAttendances;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Stats Cards
          Container(
            padding: EdgeInsets.all(16.w),
            color: colors.cardBackground,
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total DOER Worked',
                    _totalWorked.toString(),
                    ColorManager.primary,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildStatCard(
                    'Total Hours',
                    '${_totalHours}h',
                    const Color(0xFF3B82F6),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
            color: colors.cardBackground,
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Confirmed',
                    _confirmed.toString(),
                    ColorManager.primary,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildStatCard(
                    'Cancelled / Waiting',
                    '$_cancelled / 0',
                    const Color(0xFFEF4444),
                  ),
                ),
              ],
            ),
          ),

          // Date Filter
          _buildDateFilter(),

          // Shift Filter Dropdown
          Container(
            padding: EdgeInsets.all(16.w),
            color: colors.background,
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  size: 18.sp,
                  color: colors.textSecondary,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Filter by Shift Time',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.medium,
                    color: colors.textSecondary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: colors.grey3),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedShift,
                    underline: const SizedBox(),
                    isDense: true,
                    icon: Icon(Icons.keyboard_arrow_down, size: 20.sp),
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.medium,
                      color: colors.textPrimary,
                    ),
                    items: _shifts.map((shift) {
                      return DropdownMenuItem(
                        value: shift,
                        child: Text(shift),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedShift = value);
                      }
                    },
                  ),
                ),
              ],
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
                      '${filteredAttendances.length} attendance record${filteredAttendances.length != 1 ? 's' : ''} found',
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

          // Attendance List
          filteredAttendances.isEmpty
              ? SizedBox(
                  height: 300.h,
                  child: Center(
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
                          'No attendance records found',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.semiBold,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Try adjusting your filters',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s13,
                            fontWeight: FontWeightManager.regular,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(16.w).copyWith(bottom: 80.h),
                  itemCount: filteredAttendances.length,
                  itemBuilder: (context, index) {
                    return AttendanceCard(
                      attendance: filteredAttendances[index],
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => AttendanceDetailModal(
                            attendance: filteredAttendances[index],
                          ),
                        );
                      },
                    );
                  },
                ),
        ],
      ),
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

  Widget _buildStatCard(String label, String value, Color color) {
    final colors = ThemeHelper.of(context);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colors.grey6,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s11,
              fontWeight: FontWeightManager.medium,
              color: colors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s20,
              fontWeight: FontWeightManager.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
