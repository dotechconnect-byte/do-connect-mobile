import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/doer_status_model.dart';
import 'doer_status_card.dart';

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

class StatusContent extends StatefulWidget {
  final String searchQuery;

  const StatusContent({super.key, this.searchQuery = ''});

  @override
  State<StatusContent> createState() => _StatusContentState();
}

class _StatusContentState extends State<StatusContent> {
  late final List<DateItem> _dates;
  late int _selectedDateIndex;
  final ScrollController _scrollController = ScrollController();

  // Time slot filtering
  String? _selectedTimeSlot; // null means "All"
  final List<String> _timeSlots = [
    '08:00 - 16:00',
    '14:00 - 22:00',
    '18:00 - 02:00',
  ];

  @override
  void initState() {
    super.initState();
    _dates = _generateDates();
    _selectedDateIndex = _dates.indexWhere((date) => date.isToday);

    // Auto-scroll to Today after the widget is built
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
    final filteredDoers = _filteredDoers;

    return Column(
      children: [
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

        // Time Slot Filter Tabs
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          color: ColorManager.backgroundColor,
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
            color: ColorManager.backgroundColor,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${filteredDoers.length} DOER${filteredDoers.length != 1 ? 's' : ''} found',
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
                        color: ColorManager.grey3,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No DOERs found',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Try adjusting your search',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textSecondary,
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
                        // Handle message action
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Message ${filteredDoers[index].name}'),
                            behavior: SnackBarBehavior.floating,
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

  Widget _buildTimeSlotTab(String label, String? timeSlot) {
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
          color: isSelected ? ColorManager.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? ColorManager.primary : ColorManager.grey3,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time,
              size: 14.sp,
              color: isSelected ? ColorManager.primary : ColorManager.textSecondary,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s12,
                fontWeight: isSelected ? FontWeightManager.semiBold : FontWeightManager.medium,
                color: isSelected ? ColorManager.primary : ColorManager.textSecondary,
              ),
            ),
            if (count > 0) ...[
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isSelected ? ColorManager.primary : ColorManager.grey4,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  count.toString(),
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s10,
                    fontWeight: FontWeightManager.semiBold,
                    color: isSelected ? ColorManager.white : ColorManager.textSecondary,
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
