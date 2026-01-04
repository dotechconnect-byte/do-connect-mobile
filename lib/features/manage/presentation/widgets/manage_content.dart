import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';

class ManageContent extends StatefulWidget {
  final String selectedTab;

  const ManageContent({
    super.key,
    required this.selectedTab,
  });

  @override
  State<ManageContent> createState() => ManageContentState();
}

class ManageContentState extends State<ManageContent> {
  DateTime _selectedDate = DateTime.now();

  // Sample data for locations with dates
  final List<LocationItem> _allLocations = [
    LocationItem(
      name: 'Downtown Office',
      doerAssigned: 0,
      date: DateTime.now(),
    ),
    LocationItem(
      name: 'West Branch',
      doerAssigned: 0,
      date: DateTime.now(),
    ),
    LocationItem(
      name: 'North Hub',
      doerAssigned: 0,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    LocationItem(
      name: 'East Mall',
      doerAssigned: 0,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    LocationItem(
      name: 'South Convention Center',
      doerAssigned: 0,
      date: DateTime.now().add(const Duration(days: 1)),
    ),
    LocationItem(
      name: 'Central Park Plaza',
      doerAssigned: 0,
      date: DateTime.now().add(const Duration(days: 1)),
    ),
    LocationItem(
      name: 'Airport Terminal',
      doerAssigned: 0,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    LocationItem(
      name: 'Harbor View Complex',
      doerAssigned: 0,
      date: DateTime.now().add(const Duration(days: 2)),
    ),
  ];

  List<LocationItem> get _locations => _allLocations.where((location) {
    return location.date.year == _selectedDate.year &&
           location.date.month == _selectedDate.month &&
           location.date.day == _selectedDate.day;
  }).toList();

  // Sample data for stations with dates
  final List<StationItem> _allStations = [
    StationItem(
      name: 'Reception Desk',
      locationName: 'Downtown Office',
      doerAssigned: 0,
      date: DateTime.now(),
    ),
    StationItem(
      name: 'Customer Service',
      locationName: 'West Branch',
      doerAssigned: 0,
      date: DateTime.now(),
    ),
    StationItem(
      name: 'Information Counter',
      locationName: 'North Hub',
      doerAssigned: 0,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    StationItem(
      name: 'Help Desk',
      locationName: 'East Mall',
      doerAssigned: 0,
      date: DateTime.now().add(const Duration(days: 1)),
    ),
  ];

  List<StationItem> get _stations => _allStations.where((station) {
    return station.date.year == _selectedDate.year &&
           station.date.month == _selectedDate.month &&
           station.date.day == _selectedDate.day;
  }).toList();

  // Sample data for managers with dates
  final List<ManagerItem> _allManagers = [
    ManagerItem(
      name: 'John Anderson',
      email: 'john.anderson@example.com',
      role: 'Operations Manager',
      doerAssigned: 0,
      date: DateTime.now(),
    ),
    ManagerItem(
      name: 'Sarah Williams',
      email: 'sarah.williams@example.com',
      role: 'Team Lead',
      doerAssigned: 0,
      date: DateTime.now(),
    ),
    ManagerItem(
      name: 'Michael Chen',
      email: 'michael.chen@example.com',
      role: 'Supervisor',
      doerAssigned: 0,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  List<ManagerItem> get _managers => _allManagers.where((manager) {
    return manager.date.year == _selectedDate.year &&
           manager.date.month == _selectedDate.month &&
           manager.date.day == _selectedDate.day;
  }).toList();

  // Sample data for events with dates
  final List<EventItem> _allEvents = [
    EventItem(
      name: 'Annual Conference 2025',
      dateString: '2025-03-15',
      locationName: 'South Convention Center',
      doerAssigned: 0,
      date: DateTime.now(),
    ),
    EventItem(
      name: 'Product Launch',
      dateString: '2025-04-20',
      locationName: 'Central Park Plaza',
      doerAssigned: 0,
      date: DateTime.now(),
    ),
    EventItem(
      name: 'Team Building Event',
      dateString: '2025-05-10',
      locationName: 'Harbor View Complex',
      doerAssigned: 0,
      date: DateTime.now().add(const Duration(days: 1)),
    ),
  ];

  List<EventItem> get _events => _allEvents.where((event) {
    return event.date.year == _selectedDate.year &&
           event.date.month == _selectedDate.month &&
           event.date.day == _selectedDate.day;
  }).toList();

  void _addNewLocation(String name) {
    setState(() {
      _allLocations.add(LocationItem(
        name: name,
        doerAssigned: 0,
        date: _selectedDate,
      ));
    });
  }

  void _deleteLocation(LocationItem location) {
    setState(() {
      _allLocations.remove(location);
    });
  }

  // Public method to add new item from parent
  void addNewItem(String name) {
    switch (widget.selectedTab) {
      case 'Locations':
        _addNewLocation(name);
        break;
      case 'Stations':
        _addNewStation(name);
        break;
      case 'Managers':
        _addNewManager(name);
        break;
      case 'Events':
        _addNewEvent(name);
        break;
    }
  }

  void _addNewStation(String name) {
    setState(() {
      _allStations.add(StationItem(
        name: name,
        locationName: _locations.isNotEmpty ? _locations.first.name : 'No Location',
        doerAssigned: 0,
        date: _selectedDate,
      ));
    });
  }

  void _addNewManager(String name) {
    setState(() {
      _allManagers.add(ManagerItem(
        name: name,
        email: '${name.toLowerCase().replaceAll(' ', '.')}@example.com',
        role: 'Manager',
        doerAssigned: 0,
        date: _selectedDate,
      ));
    });
  }

  void _addNewEvent(String name) {
    setState(() {
      _allEvents.add(EventItem(
        name: name,
        dateString: _selectedDate.toString().split(' ')[0],
        locationName: _locations.isNotEmpty ? _locations.first.name : 'No Location',
        doerAssigned: 0,
        date: _selectedDate,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Date Filter
        _buildDateFilter(),

        // Content based on selected tab
        Expanded(
          child: _buildTabContent(),
        ),
      ],
    );
  }

  Widget _buildDateFilter() {
    return Container(
      color: ColorManager.white,
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
                color: ColorManager.grey6,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: ColorManager.grey4),
              ),
              child: Icon(
                Icons.chevron_left,
                size: 20.sp,
                color: ColorManager.textPrimary,
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
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: ColorManager.primary,
                          onPrimary: ColorManager.white,
                          surface: ColorManager.white,
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
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: ColorManager.primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 18.sp,
                      color: ColorManager.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      _formatDate(_selectedDate),
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.primary,
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
                color: ColorManager.grey6,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: ColorManager.grey4),
              ),
              child: Icon(
                Icons.chevron_right,
                size: 20.sp,
                color: ColorManager.textPrimary,
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

  Widget _buildTabContent() {
    switch (widget.selectedTab) {
      case 'Locations':
        return _buildLocationsList();
      case 'Stations':
        return _buildStationsList();
      case 'Managers':
        return _buildManagersList();
      case 'Events':
        return _buildEventsList();
      default:
        return _buildLocationsList();
    }
  }

  Widget _buildLocationsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _locations.length,
      itemBuilder: (context, index) {
        return _buildModernLocationCard(_locations[index]);
      },
    );
  }

  Widget _buildModernLocationCard(LocationItem location) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showLocationDetails(location);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Modern Icon Container
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        location.color.withValues(alpha: 0.8),
                        location.color.withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: location.color.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    location.icon,
                    size: 28.sp,
                    color: ColorManager.white,
                  ),
                ),
                SizedBox(width: 14.w),

                // Location Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.name,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s15,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: ColorManager.warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 14.sp,
                              color: ColorManager.warning,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${location.doerAssigned} DOER assigned',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s11,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.warning,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),

                // Action Button
                InkWell(
                  onTap: () {
                    _showAssignDoerModal(location);
                  },
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 20.sp,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStationsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _stations.length,
      itemBuilder: (context, index) {
        return _buildStationCard(_stations[index]);
      },
    );
  }

  Widget _buildManagersList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _managers.length,
      itemBuilder: (context, index) {
        return _buildManagerCard(_managers[index]);
      },
    );
  }

  Widget _buildEventsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _events.length,
      itemBuilder: (context, index) {
        return _buildEventCard(_events[index]);
      },
    );
  }

  Widget _buildStationCard(StationItem station) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showStationDetails(station);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        station.color.withValues(alpha: 0.8),
                        station.color.withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    station.icon,
                    size: 28.sp,
                    color: ColorManager.white,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        station.name,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s15,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        station.locationName,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: ColorManager.warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 14.sp,
                              color: ColorManager.warning,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${station.doerAssigned} DOER assigned',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s11,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.warning,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildManagerCard(ManagerItem manager) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showManagerDetails(manager);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        manager.color.withValues(alpha: 0.8),
                        manager.color.withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    manager.icon,
                    size: 28.sp,
                    color: ColorManager.white,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        manager.name,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s15,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        manager.role,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.medium,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        manager.email,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s11,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textTertiary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: ColorManager.warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 14.sp,
                              color: ColorManager.warning,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${manager.doerAssigned} DOER assigned',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s11,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.warning,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(EventItem event) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showEventDetails(event);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        event.color.withValues(alpha: 0.8),
                        event.color.withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    event.icon,
                    size: 28.sp,
                    color: ColorManager.white,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s15,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14.sp,
                            color: ColorManager.textSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              event.locationName,
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14.sp,
                            color: ColorManager.textSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            event.dateString,
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: ColorManager.warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 14.sp,
                              color: ColorManager.warning,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${event.doerAssigned} DOER assigned',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s11,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.warning,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLocationDetails(LocationItem location) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorManager.grey3,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Icon and Title
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    location.color.withValues(alpha: 0.8),
                    location.color.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: location.color.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                location.icon,
                size: 40.sp,
                color: ColorManager.white,
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              location.name,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorManager.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16.sp,
                    color: ColorManager.warning,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '${location.doerAssigned} DOER assigned',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.warning,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showAddExternalDoerDialog(location);
                    },
                    icon: Icon(
                      Icons.person_add_alt_1,
                      size: 18.sp,
                      color: ColorManager.white,
                    ),
                    label: Text(
                      'External DOER',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: ColorManager.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showAssignDoerModal(location);
                    },
                    icon: Icon(
                      Icons.person_add,
                      size: 18.sp,
                      color: ColorManager.primary,
                    ),
                    label: Text(
                      'Assign DOER',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.primary,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.white,
                      foregroundColor: ColorManager.primary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      side: BorderSide(color: ColorManager.grey4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Edit and Delete Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showEditDialog(location);
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 18.sp,
                      color: ColorManager.textPrimary,
                    ),
                    label: Text(
                      'Edit',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: ColorManager.grey4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showDeleteConfirmation(location);
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      size: 18.sp,
                      color: ColorManager.error,
                    ),
                    label: Text(
                      'Delete',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.error,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: ColorManager.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  void _showAssignDoerModal(LocationItem location) {
    // Sample available DOERs data
    final List<Map<String, dynamic>> availableDoers = [
      {
        'name': 'Anna Smith',
        'date': '2025-11-05',
        'startTime': '09:00',
        'endTime': '17:00',
        'isAvailable': true,
      },
      {
        'name': 'Emily Rodriguez',
        'date': '2025-11-05',
        'startTime': '08:00',
        'endTime': '16:00',
        'isAvailable': false,
      },
      {
        'name': 'James Wilson',
        'date': '2025-11-05',
        'startTime': '14:00',
        'endTime': '22:00',
        'isAvailable': false,
      },
      {
        'name': 'Jessica Brown',
        'date': '2025-11-06',
        'startTime': '18:00',
        'endTime': '02:00',
        'isAvailable': false,
      },
      {
        'name': 'Michael Chen',
        'date': '2025-11-04',
        'startTime': '14:00',
        'endTime': '22:00',
        'isAvailable': false,
      },
      {
        'name': 'Sarah Johnson',
        'date': '2025-11-04',
        'startTime': '09:00',
        'endTime': '17:00',
        'isAvailable': false,
      },
      {
        'name': 'Lisa Anderson',
        'date': '2025-11-04',
        'startTime': '12:00',
        'endTime': '20:00',
        'isAvailable': false,
      },
      {
        'name': 'Robert Taylor',
        'date': '2025-11-04',
        'startTime': '10:00',
        'endTime': '18:00',
        'isAvailable': false,
      },
      {
        'name': 'David Park',
        'date': '2025-11-03',
        'startTime': '09:00',
        'endTime': '17:00',
        'isAvailable': false,
      },
      {
        'name': 'Anna Smith',
        'date': '2025-11-03',
        'startTime': '14:00',
        'endTime': '22:00',
        'isAvailable': false,
      },
      {
        'name': 'Amanda White',
        'date': '2025-11-03',
        'startTime': '08:00',
        'endTime': '16:00',
        'isAvailable': false,
      },
    ];

    String? selectedDoer;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assign Staff to ${location.name}',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s18,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManager.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Select a staff member to assign',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Staff Member Label
                Text(
                  'Staff Member',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 12.h),

                // Dropdown/Select Field
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.grey4),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                      title: Text(
                        selectedDoer ?? 'Select a staff member',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.medium,
                          color: selectedDoer != null ? ColorManager.textPrimary : ColorManager.grey3,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.sp,
                        color: ColorManager.textSecondary,
                      ),
                      children: [
                        Container(
                          constraints: BoxConstraints(maxHeight: 300.h),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: availableDoers.length,
                            itemBuilder: (context, index) {
                              final doer = availableDoers[index];
                              final isSelected = selectedDoer ==
                                  '${doer['name']} - ${doer['date']} (${doer['startTime']} - ${doer['endTime']})';

                              return InkWell(
                                onTap: () {
                                  setDialogState(() {
                                    selectedDoer = '${doer['name']} - ${doer['date']} (${doer['startTime']} - ${doer['endTime']})';
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                  color: isSelected
                                      ? ColorManager.primary.withValues(alpha: 0.05)
                                      : Colors.transparent,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${doer['name']} - ${doer['date']} (${doer['startTime']} - ${doer['endTime']})',
                                              style: FontConstants.getPoppinsStyle(
                                                fontSize: FontSize.s14,
                                                fontWeight: FontWeightManager.regular,
                                                color: isSelected
                                                    ? ColorManager.primary
                                                    : ColorManager.textPrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManager.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: selectedDoer != null
                  ? () {
                      Navigator.pop(context);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Staff assigned to ${location.name} successfully',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s13,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.white,
                              ),
                            ),
                            backgroundColor: ColorManager.success,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                disabledBackgroundColor: ColorManager.grey4,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
          ],
        ),
      ),
    );
  }


  void _showStationDetails(StationItem station) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorManager.grey3,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Icon and Title
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    station.color.withValues(alpha: 0.8),
                    station.color.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: station.color.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                station.icon,
                size: 40.sp,
                color: ColorManager.white,
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              station.name,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorManager.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16.sp,
                    color: ColorManager.warning,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '${station.doerAssigned} DOER assigned',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.warning,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showAddExternalDoerDialogForStation(station);
                    },
                    icon: Icon(
                      Icons.person_add_alt_1,
                      size: 18.sp,
                      color: ColorManager.white,
                    ),
                    label: Text(
                      'External DOER',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: ColorManager.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showAssignDoerModalForStation(station);
                    },
                    icon: Icon(
                      Icons.person_add,
                      size: 18.sp,
                      color: ColorManager.primary,
                    ),
                    label: Text(
                      'Assign DOER',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.primary,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.white,
                      foregroundColor: ColorManager.primary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      side: BorderSide(color: ColorManager.grey4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Edit and Delete Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showEditStationDialog(station);
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 18.sp,
                      color: ColorManager.textPrimary,
                    ),
                    label: Text(
                      'Edit',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: ColorManager.grey4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showDeleteStationConfirmation(station);
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      size: 18.sp,
                      color: ColorManager.error,
                    ),
                    label: Text(
                      'Delete',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.error,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: ColorManager.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  void _showManagerDetails(ManagerItem manager) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorManager.grey3,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Icon and Title
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    manager.color.withValues(alpha: 0.8),
                    manager.color.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: manager.color.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                manager.icon,
                size: 40.sp,
                color: ColorManager.white,
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              manager.name,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorManager.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16.sp,
                    color: ColorManager.warning,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '${manager.doerAssigned} DOER assigned',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.warning,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showAddExternalDoerDialogForManager(manager);
                    },
                    icon: Icon(
                      Icons.person_add_alt_1,
                      size: 18.sp,
                      color: ColorManager.white,
                    ),
                    label: Text(
                      'External DOER',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: ColorManager.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showAssignDoerModalForManager(manager);
                    },
                    icon: Icon(
                      Icons.person_add,
                      size: 18.sp,
                      color: ColorManager.primary,
                    ),
                    label: Text(
                      'Assign DOER',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.primary,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.white,
                      foregroundColor: ColorManager.primary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      side: BorderSide(color: ColorManager.grey4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Edit and Delete Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showEditManagerDialog(manager);
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 18.sp,
                      color: ColorManager.textPrimary,
                    ),
                    label: Text(
                      'Edit',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: ColorManager.grey4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showDeleteManagerConfirmation(manager);
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      size: 18.sp,
                      color: ColorManager.error,
                    ),
                    label: Text(
                      'Delete',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.error,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: ColorManager.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  void _showEventDetails(EventItem event) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorManager.grey3,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Icon and Title
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    event.color.withValues(alpha: 0.8),
                    event.color.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: event.color.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                event.icon,
                size: 40.sp,
                color: ColorManager.white,
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              event.name,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorManager.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16.sp,
                    color: ColorManager.warning,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '${event.doerAssigned} DOER assigned',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.warning,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showAddExternalDoerDialogForEvent(event);
                    },
                    icon: Icon(
                      Icons.person_add_alt_1,
                      size: 18.sp,
                      color: ColorManager.white,
                    ),
                    label: Text(
                      'External DOER',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: ColorManager.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showAssignDoerModalForEvent(event);
                    },
                    icon: Icon(
                      Icons.person_add,
                      size: 18.sp,
                      color: ColorManager.primary,
                    ),
                    label: Text(
                      'Assign DOER',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.primary,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.white,
                      foregroundColor: ColorManager.primary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      side: BorderSide(color: ColorManager.grey4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Edit and Delete Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showEditEventDialog(event);
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 18.sp,
                      color: ColorManager.textPrimary,
                    ),
                    label: Text(
                      'Edit',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: ColorManager.grey4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showDeleteEventConfirmation(event);
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      size: 18.sp,
                      color: ColorManager.error,
                    ),
                    label: Text(
                      'Delete',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.error,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: ColorManager.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(LocationItem location) {
    final textController = TextEditingController(text: location.name);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Edit Location',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update the location details',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.regular,
                color: ColorManager.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Name',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: textController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Enter name',
                hintStyle: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManager.grey3,
                ),
                filled: true,
                fillColor: ColorManager.grey6,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: ColorManager.grey4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: ColorManager.primary, width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              ),
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
                color: ColorManager.textPrimary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                _updateLocation(location, textController.text.trim());
                Navigator.pop(context);

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Location updated successfully',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.medium,
                          color: ColorManager.white,
                        ),
                      ),
                      backgroundColor: ColorManager.success,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            ),
            child: Text(
              'Save',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateLocation(LocationItem oldLocation, String newName) {
    setState(() {
      final index = _allLocations.indexOf(oldLocation);
      if (index != -1) {
        _allLocations[index] = LocationItem(
          name: newName,
          doerAssigned: oldLocation.doerAssigned,
          date: oldLocation.date,
        );
      }
    });
  }

  void _showDeleteConfirmation(LocationItem location) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Delete Location',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${location.name}"? This action cannot be undone.',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteLocation(location);
              Navigator.pop(context);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Location deleted successfully',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.white,
                      ),
                    ),
                    backgroundColor: ColorManager.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.error,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Delete',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddExternalDoerDialog(LocationItem location) {
    final nameController = TextEditingController();
    final contactController = TextEditingController();
    String selectedDoerType = 'Regular';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Add External DOER',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.textPrimary,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add non-system DOER who need to be assigned to locations, stations, managers, or events',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20.h),

                // Name Field
                Text(
                  'Name *',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Full name',
                    hintStyle: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.grey3,
                    ),
                    filled: true,
                    fillColor: ColorManager.grey6,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: ColorManager.grey4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: ColorManager.primary, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  ),
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 16.h),

                // Contact Number Field
                Text(
                  'Contact Number *',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: contactController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '+65 1234 5678',
                    hintStyle: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.grey3,
                    ),
                    filled: true,
                    fillColor: ColorManager.grey6,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: ColorManager.grey4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: ColorManager.primary, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  ),
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 16.h),

                // DOER Type Field
                Text(
                  'DOER Type *',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),

                // DOER Type Options
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: ['Super Regular', 'Regular', 'Staff', 'New Staff'].map((type) {
                    final isSelected = selectedDoerType == type;
                    return InkWell(
                      onTap: () {
                        setDialogState(() {
                          selectedDoerType = type;
                        });
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: isSelected ? ColorManager.primary : ColorManager.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected ? ColorManager.primary : ColorManager.grey4,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Text(
                          type,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s13,
                            fontWeight: isSelected ? FontWeightManager.semiBold : FontWeightManager.medium,
                            color: isSelected ? ColorManager.white : ColorManager.textPrimary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManager.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isNotEmpty && contactController.text.trim().isNotEmpty) {
                  Navigator.pop(context);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'External DOER added successfully',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s13,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.white,
                          ),
                        ),
                        backgroundColor: ColorManager.success,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              ),
              child: Text(
                'Add External Staff',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManager.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Station helper methods
  void _showAddExternalDoerDialogForStation(StationItem station) {
    _showAddExternalDoerDialog(LocationItem(name: station.name, doerAssigned: station.doerAssigned, date: _selectedDate));
  }

  void _showAssignDoerModalForStation(StationItem station) {
    _showAssignDoerModal(LocationItem(name: station.name, doerAssigned: station.doerAssigned, date: _selectedDate));
  }

  void _showEditStationDialog(StationItem station) {
    final textController = TextEditingController(text: station.name);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Edit Station',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
          ),
        ),
        content: TextField(
          controller: textController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter station name',
            filled: true,
            fillColor: ColorManager.grey6,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: ColorManager.primary, width: 2),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                setState(() {
                  final index = _allStations.indexOf(station);
                  if (index != -1) {
                    _allStations[index] = StationItem(
                      name: textController.text.trim(),
                      locationName: station.locationName,
                      doerAssigned: station.doerAssigned,
                      date: station.date,
                    );
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Station updated successfully'), backgroundColor: ColorManager.success),
                );
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteStationConfirmation(StationItem station) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        title: Text('Delete Station'),
        content: Text('Are you sure you want to delete "${station.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _allStations.remove(station);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Station deleted successfully'), backgroundColor: ColorManager.error),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: ColorManager.error),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  // Manager helper methods
  void _showAddExternalDoerDialogForManager(ManagerItem manager) {
    _showAddExternalDoerDialog(LocationItem(name: manager.name, doerAssigned: manager.doerAssigned, date: _selectedDate));
  }

  void _showAssignDoerModalForManager(ManagerItem manager) {
    _showAssignDoerModal(LocationItem(name: manager.name, doerAssigned: manager.doerAssigned, date: _selectedDate));
  }

  void _showEditManagerDialog(ManagerItem manager) {
    final nameController = TextEditingController(text: manager.name);
    final emailController = TextEditingController(text: manager.email);
    final roleController = TextEditingController(text: manager.role);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Edit Manager',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                fillColor: ColorManager.grey6,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: ColorManager.grey6,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: roleController,
              decoration: InputDecoration(
                labelText: 'Role',
                filled: true,
                fillColor: ColorManager.grey6,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                setState(() {
                  final index = _allManagers.indexOf(manager);
                  if (index != -1) {
                    _allManagers[index] = ManagerItem(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      role: roleController.text.trim(),
                      doerAssigned: manager.doerAssigned,
                      date: manager.date,
                    );
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Manager updated successfully'), backgroundColor: ColorManager.success),
                );
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteManagerConfirmation(ManagerItem manager) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        title: Text('Delete Manager'),
        content: Text('Are you sure you want to delete "${manager.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _allManagers.remove(manager);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Manager deleted successfully'), backgroundColor: ColorManager.error),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: ColorManager.error),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  // Event helper methods
  void _showAddExternalDoerDialogForEvent(EventItem event) {
    _showAddExternalDoerDialog(LocationItem(name: event.name, doerAssigned: event.doerAssigned, date: _selectedDate));
  }

  void _showAssignDoerModalForEvent(EventItem event) {
    _showAssignDoerModal(LocationItem(name: event.name, doerAssigned: event.doerAssigned, date: _selectedDate));
  }

  void _showEditEventDialog(EventItem event) {
    final nameController = TextEditingController(text: event.name);
    final dateController = TextEditingController(text: event.dateString);
    final locationController = TextEditingController(text: event.locationName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Edit Event',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Event Name',
                filled: true,
                fillColor: ColorManager.grey6,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                filled: true,
                fillColor: ColorManager.grey6,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                filled: true,
                fillColor: ColorManager.grey6,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                setState(() {
                  final index = _allEvents.indexOf(event);
                  if (index != -1) {
                    _allEvents[index] = EventItem(
                      name: nameController.text.trim(),
                      dateString: dateController.text.trim(),
                      locationName: locationController.text.trim(),
                      doerAssigned: event.doerAssigned,
                      date: event.date,
                    );
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Event updated successfully'), backgroundColor: ColorManager.success),
                );
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteEventConfirmation(EventItem event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        title: Text('Delete Event'),
        content: Text('Are you sure you want to delete "${event.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _allEvents.remove(event);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Event deleted successfully'), backgroundColor: ColorManager.error),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: ColorManager.error),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class LocationItem {
  final String name;
  final int doerAssigned;
  final DateTime date;

  LocationItem({
    required this.name,
    required this.doerAssigned,
    required this.date,
  });

  // Always use building icon and primary color
  IconData get icon => Icons.business;
  Color get color => ColorManager.primary;
}

class StationItem {
  final String name;
  final String locationName;
  final int doerAssigned;
  final DateTime date;

  StationItem({
    required this.name,
    required this.locationName,
    required this.doerAssigned,
    required this.date,
  });

  IconData get icon => Icons.desktop_windows;
  Color get color => ColorManager.success;
}

class ManagerItem {
  final String name;
  final String email;
  final String role;
  final int doerAssigned;
  final DateTime date;

  ManagerItem({
    required this.name,
    required this.email,
    required this.role,
    required this.doerAssigned,
    required this.date,
  });

  IconData get icon => Icons.person;
  Color get color => ColorManager.info;
}

class EventItem {
  final String name;
  final String dateString;
  final String locationName;
  final int doerAssigned;
  final DateTime date;

  EventItem({
    required this.name,
    required this.dateString,
    required this.locationName,
    required this.doerAssigned,
    required this.date,
  });

  IconData get icon => Icons.event;
  Color get color => ColorManager.warning;
}
