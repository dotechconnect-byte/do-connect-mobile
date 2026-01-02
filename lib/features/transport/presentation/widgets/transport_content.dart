import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/transport_staff_model.dart';
import 'transport_staff_card.dart';

class TransportContent extends StatefulWidget {
  final String searchQuery;

  const TransportContent({
    super.key,
    this.searchQuery = '',
  });

  @override
  State<TransportContent> createState() => _TransportContentState();
}

class _TransportContentState extends State<TransportContent> {
  DateTime _selectedDate = DateTime.now();

  // Filter states
  String _selectedZone = 'All Zones';
  String _selectedShift = 'All Shifts';
  String _selectedDepartment = 'All Departments';

  final List<String> _zones = [
    'All Zones',
    'North',
    'South',
    'East',
    'West',
    'Central',
  ];

  final List<String> _shifts = [
    'All Shifts',
    '08:00 - 16:00',
    '14:00 - 22:00',
    '18:00 - 02:00',
  ];

  final List<String> _departments = [
    'All Departments',
    'Security',
    'Reception',
    'Maintenance',
    'Customer Service',
  ];

  // Sample transport staff data
  final List<TransportStaffModel> _allStaff = [
    TransportStaffModel(
      id: '1',
      name: 'John Smith',
      region: 'North',
      pickUpDropOff: 'Station A',
      transportTiming: '08:00 AM',
    ),
    TransportStaffModel(
      id: '2',
      name: 'Sarah Johnson',
      region: 'North',
      pickUpDropOff: 'Mall B',
      transportTiming: '08:30 AM',
      notes: 'Prefers early pickup',
    ),
    TransportStaffModel(
      id: '3',
      name: 'Michael Chen',
      region: 'South',
      pickUpDropOff: 'Station C',
      transportTiming: '09:00 AM',
    ),
    TransportStaffModel(
      id: '4',
      name: 'Emily Rodriguez',
      region: 'East',
      pickUpDropOff: 'Hub D',
      transportTiming: '08:15 AM',
    ),
    TransportStaffModel(
      id: '5',
      name: 'David Wilson',
      region: 'West',
      pickUpDropOff: 'Station E',
      transportTiming: '08:45 AM',
    ),
    TransportStaffModel(
      id: '6',
      name: 'Lisa Brown',
      region: 'Central',
      pickUpDropOff: 'Mall F',
      transportTiming: '09:15 AM',
    ),
    TransportStaffModel(
      id: '7',
      name: 'James Taylor',
      region: 'North',
      pickUpDropOff: 'Hub G',
      transportTiming: '08:00 AM',
    ),
    TransportStaffModel(
      id: '8',
      name: 'Emma Davis',
      region: 'South',
      pickUpDropOff: 'Station H',
      transportTiming: '08:30 AM',
    ),
  ];

  List<TransportStaffModel> get _filteredStaff {
    var filtered = _allStaff;

    // Filter by zone
    if (_selectedZone != 'All Zones') {
      filtered = filtered.where((staff) => staff.region == _selectedZone).toList();
    }

    // Filter by search query
    if (widget.searchQuery.isNotEmpty) {
      final query = widget.searchQuery.toLowerCase();
      filtered = filtered.where((staff) {
        return staff.name.toLowerCase().contains(query) ||
               staff.region.toLowerCase().contains(query) ||
               staff.pickUpDropOff.toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
  }

  int get _totalStaff => _allStaff.length;
  int get _externalStaff => 0;
  int get _transportUnits => 3;
  int get _totalAssigned {
    int count = 0;
    for (var staff in _allStaff) {
      if (staff.assignedTransport != null) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final filteredStaff = _filteredStaff;

    return CustomScrollView(
      slivers: [
        // Date Filter
        SliverToBoxAdapter(
          child: _buildDateFilter(),
        ),

        // Filters Section
        SliverToBoxAdapter(
          child: _buildFilters(),
        ),

        // Stats Cards - Simplified
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(16.w),
            color: ColorManager.backgroundColor,
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Staff',
                    _totalStaff.toString(),
                    Icons.people,
                    ColorManager.primary,
                    '$_externalStaff external',
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildStatCard(
                    'Transport Units',
                    _transportUnits.toString(),
                    Icons.local_shipping,
                    const Color(0xFF3B82F6),
                    '$_totalAssigned assigned',
                  ),
                ),
              ],
            ),
          ),
        ),

        // Staff Section Header
        SliverToBoxAdapter(
          child: Container(
            color: ColorManager.backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Staff',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s18,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${filteredStaff.length} total',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Staff List
        filteredStaff.isEmpty
            ? SliverFillRemaining(
                child: Container(
                  color: ColorManager.backgroundColor,
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
                          'No staff found',
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
                ),
              )
            : SliverPadding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return TransportStaffCard(
                        staff: filteredStaff[index],
                        onTap: () => _showStaffDetails(filteredStaff[index]),
                      );
                    },
                    childCount: filteredStaff.length,
                  ),
                ),
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

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: ColorManager.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.filter_list, size: 18.sp, color: ColorManager.textPrimary),
              SizedBox(width: 8.w),
              Text(
                'Filters',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManager.textPrimary,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Save current filter view
                },
                child: Text(
                  'Save View',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Filter dropdowns
          Row(
            children: [
              Expanded(child: _buildFilterDropdown('Zone', _zones, _selectedZone, (value) {
                setState(() => _selectedZone = value!);
              })),
              SizedBox(width: 12.w),
              Expanded(child: _buildFilterDropdown('Shift Time', _shifts, _selectedShift, (value) {
                setState(() => _selectedShift = value!);
              })),
            ],
          ),
          SizedBox(height: 12.h),
          _buildFilterDropdown('Department', _departments, _selectedDepartment, (value) {
            setState(() => _selectedDepartment = value!);
          }),

          // Saved Views
          SizedBox(height: 16.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _buildSavedViewChip('East Morning'),
              _buildSavedViewChip('Central Urgent'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label, List<String> items, String value, Function(String?) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.grey6,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorManager.grey4),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        isDense: true,
        icon: Icon(Icons.keyboard_arrow_down, size: 20.sp, color: ColorManager.textPrimary),
        style: FontConstants.getPoppinsStyle(
          fontSize: FontSize.s13,
          fontWeight: FontWeightManager.medium,
          color: ColorManager.textPrimary,
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSavedViewChip(String label) {
    return InkWell(
      onTap: () {
        // Apply saved view filters
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: ColorManager.grey6,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: ColorManager.grey4),
        ),
        child: Text(
          label,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s12,
            fontWeight: FontWeightManager.medium,
            color: ColorManager.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.grey4),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 20.sp, color: color),
          ),
          SizedBox(width: 12.w),
          Expanded(
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
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        value,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s20,
                          fontWeight: FontWeightManager.bold,
                          color: color,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s11,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showStaffDetails(TransportStaffModel staff) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            // Drag Handle
            Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ColorManager.grey3,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Staff Info
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      staff.name,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s20,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  SizedBox(height: 8.h),
                  _buildDetailRow(Icons.location_on, 'Region', staff.region),
                  SizedBox(height: 8.h),
                  _buildDetailRow(Icons.pin_drop, 'Pick Up/Drop Off', staff.pickUpDropOff),
                  SizedBox(height: 8.h),
                  _buildDetailRow(Icons.access_time, 'Transport Timing', staff.transportTiming),
                  if (staff.notes != null) ...[
                    SizedBox(height: 8.h),
                    _buildDetailRow(Icons.note, 'Notes', staff.notes!),
                  ],

                  SizedBox(height: 24.h),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showTransportSelectionSheet(staff);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        foregroundColor: ColorManager.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Assign Transport',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s15,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Transport units with their current assignments
  final Map<String, List<String>> _transportAssignments = {
    'Bus A': [],
    'Shuttle B': [],
    'Van C': [],
  };

  final Map<String, int> _transportCapacity = {
    'Bus A': 16,
    'Shuttle B': 12,
    'Van C': 8,
  };

  void _assignStaffToTransport(TransportStaffModel staff, String transportName) {
    setState(() {
      // Remove from previous transport if assigned
      if (staff.assignedTransport != null) {
        _transportAssignments[staff.assignedTransport]?.remove(staff.id);
      }

      // Assign to new transport
      staff.assignedTransport = transportName;
      _transportAssignments[transportName]?.add(staff.id);
    });
  }

  int _getAssignedCount(String transportName) {
    return _transportAssignments[transportName]?.length ?? 0;
  }

  void _showTransportSelectionSheet(TransportStaffModel staff) {
    final transportUnits = [
      {
        'name': 'Bus A',
        'route': 'North Zone',
        'color': const Color(0xFFFF6B00),
        'icon': Icons.directions_bus_rounded,
      },
      {
        'name': 'Shuttle B',
        'route': 'East Zone',
        'color': const Color(0xFF3B82F6),
        'icon': Icons.airport_shuttle_rounded,
      },
      {
        'name': 'Van C',
        'route': 'West Zone',
        'color': const Color(0xFF10B981),
        'icon': Icons.local_shipping_outlined,
      },
    ];

    String? expandedUnit;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ColorManager.grey3,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Transport',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s20,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Choose transport for ${staff.name}',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1.h, color: ColorManager.grey4),

            // Transport Units List
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.all(16.w),
                itemCount: transportUnits.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final unit = transportUnits[index];
                  final unitName = unit['name'] as String;
                  final currentSeats = _getAssignedCount(unitName);
                  final totalSeats = _transportCapacity[unitName] ?? 0;
                  final fillPercentage = totalSeats > 0 ? currentSeats / totalSeats : 0.0;
                  final isCurrentlyAssigned = staff.assignedTransport == unitName;
                  final isExpanded = expandedUnit == unitName;

                  // Get assigned staff for this transport
                  final assignedStaffIds = _transportAssignments[unitName] ?? [];
                  final assignedStaff = _allStaff.where((s) => assignedStaffIds.contains(s.id)).toList();

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Toggle expand/collapse
                          setModalState(() {
                            expandedUnit = isExpanded ? null : unitName;
                          });
                        },
                        borderRadius: BorderRadius.circular(16.r),
                    child: Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isCurrentlyAssigned
                              ? [
                                  (unit['color'] as Color).withValues(alpha: 0.15),
                                  (unit['color'] as Color).withValues(alpha: 0.05),
                                ]
                              : [
                                  ColorManager.white,
                                  (unit['color'] as Color).withValues(alpha: 0.03),
                                ],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: isCurrentlyAssigned
                              ? (unit['color'] as Color).withValues(alpha: 0.5)
                              : (unit['color'] as Color).withValues(alpha: 0.2),
                          width: isCurrentlyAssigned ? 2 : 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Icon
                              Container(
                                width: 48.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      (unit['color'] as Color).withValues(alpha: 0.2),
                                      (unit['color'] as Color).withValues(alpha: 0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(14.r),
                                  border: Border.all(
                                    color: (unit['color'] as Color).withValues(alpha: 0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  unit['icon'] as IconData,
                                  color: unit['color'] as Color,
                                  size: 24.sp,
                                ),
                              ),
                              SizedBox(width: 14.w),

                              // Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      unit['name'] as String,
                                      style: FontConstants.getPoppinsStyle(
                                        fontSize: FontSize.s15,
                                        fontWeight: FontWeightManager.bold,
                                        color: ColorManager.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_rounded,
                                          size: 13.sp,
                                          color: ColorManager.textSecondary,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          unit['route'] as String,
                                          style: FontConstants.getPoppinsStyle(
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeightManager.medium,
                                            color: ColorManager.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Capacity badge or checkmark
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isCurrentlyAssigned)
                                    Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        color: unit['color'] as Color,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: (unit['color'] as Color).withValues(alpha: 0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 16.sp,
                                        color: ColorManager.white,
                                      ),
                                    )
                                  else
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            unit['color'] as Color,
                                            (unit['color'] as Color).withValues(alpha: 0.85),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (unit['color'] as Color).withValues(alpha: 0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.people_rounded,
                                            size: 14.sp,
                                            color: ColorManager.white,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            '$currentSeats/$totalSeats',
                                            style: FontConstants.getPoppinsStyle(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeightManager.bold,
                                              color: ColorManager.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (currentSeats > 0) ...[
                                    SizedBox(width: 8.w),
                                    Icon(
                                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                      size: 20.sp,
                                      color: unit['color'] as Color,
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),

                          // Progress bar
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    color: (unit['color'] as Color).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: fillPercentage,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            unit['color'] as Color,
                                            (unit['color'] as Color).withValues(alpha: 0.7),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (unit['color'] as Color).withValues(alpha: 0.3),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '${(fillPercentage * 100).toInt()}%',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s10,
                                  fontWeight: FontWeightManager.bold,
                                  color: unit['color'] as Color,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Assigned Staff List & Assign Button (Expandable)
                  if (isExpanded)
                    Container(
                      margin: EdgeInsets.only(top: 8.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: (unit['color'] as Color).withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: (unit['color'] as Color).withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Assigned Staff List
                          if (assignedStaff.isNotEmpty) ...[
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 14.sp,
                                  color: unit['color'] as Color,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Assigned Staff (${assignedStaff.length})',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.semiBold,
                                    color: unit['color'] as Color,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            ...assignedStaff.map((s) => Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: Row(
                                children: [
                                  Container(
                                    width: 6.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      color: unit['color'] as Color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      s.name,
                                      style: FontConstants.getPoppinsStyle(
                                        fontSize: FontSize.s11,
                                        fontWeight: FontWeightManager.medium,
                                        color: ColorManager.textPrimary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    s.transportTiming,
                                    style: FontConstants.getPoppinsStyle(
                                      fontSize: FontSize.s10,
                                      fontWeight: FontWeightManager.regular,
                                      color: ColorManager.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: 12.h),
                          ],

                          // Assign Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _assignStaffToTransport(staff, unitName);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${staff.name} assigned to $unitName',
                                      style: FontConstants.getPoppinsStyle(
                                        fontSize: FontSize.s13,
                                        fontWeight: FontWeightManager.medium,
                                        color: ColorManager.white,
                                      ),
                                    ),
                                    backgroundColor: unit['color'] as Color,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    margin: EdgeInsets.all(16.w),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: unit['color'] as Color,
                                foregroundColor: ColorManager.white,
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                elevation: 0,
                              ),
                              icon: Icon(
                                isCurrentlyAssigned ? Icons.swap_horiz : Icons.add,
                                size: 18.sp,
                              ),
                              label: Text(
                                isCurrentlyAssigned ? 'Move ${staff.name} Here' : 'Assign ${staff.name} Here',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeightManager.semiBold,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.sp, color: ColorManager.primary),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManager.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
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
