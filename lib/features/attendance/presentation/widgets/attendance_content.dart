import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/attendance_model.dart';
import 'attendance_card.dart';
import 'attendance_detail_modal.dart';

class DateItem {
  final DateTime date;
  final String label;
  final bool isToday;
  final bool isYesterday;
  final bool isTomorrow;

  DateItem({
    required this.date,
    required this.label,
    this.isToday = false,
    this.isYesterday = false,
    this.isTomorrow = false,
  });
}

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
  late final List<DateItem> _dates;
  late int _selectedDateIndex;
  final ScrollController _scrollController = ScrollController();

  // Shift filtering
  String _selectedShift = 'All Shifts';
  final List<String> _shifts = [
    'All Shifts',
    '08:00 - 16:00',
    '14:00 - 22:00',
    '18:00 - 02:00',
  ];

  @override
  void initState() {
    super.initState();
    _dates = _generateDates();

    // If initialDate is provided, try to find and select that date
    if (widget.initialDate != null) {
      _selectedDateIndex = _findDateIndexByString(widget.initialDate!);
      if (_selectedDateIndex == -1) {
        // If date not found, default to today
        _selectedDateIndex = _dates.indexWhere((date) => date.isToday);
      }
    } else {
      _selectedDateIndex = _dates.indexWhere((date) => date.isToday);
    }

    // Auto-scroll to selected date after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients && _selectedDateIndex >= 0) {
        final double itemWidth = 80.w;
        final double offset = (_selectedDateIndex - 1) * itemWidth;
        _scrollController.animateTo(
          offset.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  int _findDateIndexByString(String dateString) {
    // Try to match the date string (e.g., "Wednesday, November 5, 2025")
    // Parse and compare dates
    try {
      // Extract date components from the string
      // This is a simplified version - you may need more robust parsing
      for (int i = 0; i < _dates.length; i++) {
        final date = _dates[i].date;
        // Check if the date label matches or the formatted date matches
        if (dateString.contains(date.day.toString()) &&
            dateString.contains(_getMonthName(date.month))) {
          return i;
        }
      }
    } catch (e) {
      // If parsing fails, return -1
      return -1;
    }
    return -1;
  }

  String _getMonthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

  List<DateItem> _generateDates() {
    final now = DateTime.now();
    final List<DateItem> dates = [];

    // Generate dates from 3 days ago to 7 days ahead
    for (int i = -3; i <= 7; i++) {
      final date = now.add(Duration(days: i));
      String label;

      if (i == -1) {
        label = 'Yesterday';
      } else if (i == 0) {
        label = 'Today';
      } else if (i == 1) {
        label = 'Tomorrow';
      } else {
        label = '${_getMonthAbbr(date.month)} ${date.day}';
      }

      dates.add(DateItem(
        date: date,
        label: label,
        isToday: i == 0,
        isYesterday: i == -1,
        isTomorrow: i == 1,
      ));
    }

    return dates;
  }

  String _getMonthAbbr(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
    final filteredAttendances = _filteredAttendances;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Stats Cards
          Container(
            padding: EdgeInsets.all(16.w),
            color: ColorManager.white,
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
            color: ColorManager.white,
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

          // Date Selector
          Container(
            height: 50.h,
            color: ColorManager.white,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              scrollDirection: Axis.horizontal,
              itemCount: _dates.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedDateIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDateIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: isSelected ? ColorManager.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: isSelected ? ColorManager.primary : ColorManager.grey3,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _dates[index].label,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: isSelected ? FontWeightManager.semiBold : FontWeightManager.medium,
                          color: isSelected ? ColorManager.white : ColorManager.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Shift Filter Dropdown
          Container(
            padding: EdgeInsets.all(16.w),
            color: ColorManager.backgroundColor,
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  size: 18.sp,
                  color: ColorManager.textSecondary,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Filter by Shift Time',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.textSecondary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: ColorManager.grey3),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedShift,
                    underline: const SizedBox(),
                    isDense: true,
                    icon: Icon(Icons.keyboard_arrow_down, size: 20.sp),
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.medium,
                      color: ColorManager.textPrimary,
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
              color: ColorManager.backgroundColor,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${filteredAttendances.length} attendance record${filteredAttendances.length != 1 ? 's' : ''} found',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.primary,
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
                          color: ColorManager.grey3,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No attendance records found',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.semiBold,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Try adjusting your filters',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s13,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.textSecondary,
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

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: ColorManager.grey6,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.grey4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s11,
              fontWeight: FontWeightManager.medium,
              color: ColorManager.textSecondary,
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
