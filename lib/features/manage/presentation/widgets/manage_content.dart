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
  // Sample data for locations
  List<LocationItem> _locations = [
    LocationItem(
      name: 'Downtown Office',
      doerAssigned: 0,
    ),
    LocationItem(
      name: 'West Branch',
      doerAssigned: 0,
    ),
    LocationItem(
      name: 'North Hub',
      doerAssigned: 0,
    ),
    LocationItem(
      name: 'East Mall',
      doerAssigned: 0,
    ),
    LocationItem(
      name: 'South Convention Center',
      doerAssigned: 0,
    ),
    LocationItem(
      name: 'Central Park Plaza',
      doerAssigned: 0,
    ),
    LocationItem(
      name: 'Airport Terminal',
      doerAssigned: 0,
    ),
    LocationItem(
      name: 'Harbor View Complex',
      doerAssigned: 0,
    ),
  ];

  void _addNewLocation(String name) {
    setState(() {
      _locations.add(LocationItem(
        name: name,
        doerAssigned: 0,
      ));
    });
  }

  void _updateLocation(LocationItem oldLocation, String newName) {
    setState(() {
      final index = _locations.indexOf(oldLocation);
      if (index != -1) {
        _locations[index] = LocationItem(
          name: newName,
          doerAssigned: oldLocation.doerAssigned,
        );
      }
    });
  }

  void _deleteLocation(LocationItem location) {
    setState(() {
      _locations.remove(location);
    });
  }

  // Public method to add new item from parent
  void addNewItem(String name) {
    _addNewLocation(name);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Content based on selected tab
        Expanded(
          child: _buildTabContent(),
        ),
      ],
    );
  }

  Widget _buildTabContent() {
    switch (widget.selectedTab) {
      case 'Locations':
        return _buildLocationsList();
      case 'Stations':
        return _buildComingSoon('Stations');
      case 'Managers':
        return _buildComingSoon('Managers');
      case 'Events':
        return _buildComingSoon('Events');
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

  Widget _buildComingSoon(String tabName) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.construction_outlined,
              size: 56.sp,
              color: ColorManager.primary,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            '$tabName Coming Soon',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'This feature is under development',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s13,
              fontWeight: FontWeightManager.regular,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
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
            // Drag Handle and Close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40), // Spacer for alignment
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: ColorManager.grey3,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showAddExternalDoerDialog(location);
                  },
                  icon: Icon(
                    Icons.person_add_alt_1,
                    size: 22.sp,
                    color: ColorManager.primary,
                  ),
                  tooltip: 'Add External DOER',
                ),
              ],
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
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showAssignDoerModal(location);
                    },
                    icon: Icon(
                      Icons.person_add,
                      size: 18.sp,
                      color: ColorManager.white,
                    ),
                    label: Text(
                      'Assign DOER',
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
              ],
            ),
            SizedBox(height: 12.h),

            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
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
                  'Delete Location',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.error,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
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
                              final isAvailable = doer['isAvailable'] as bool;

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

  void _showEditDialog(LocationItem location) {
    final textController = TextEditingController(text: location.name);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Edit location',
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

  void _showDeleteConfirmation(LocationItem location) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
}

class LocationItem {
  final String name;
  final int doerAssigned;

  LocationItem({
    required this.name,
    required this.doerAssigned,
  });

  // Always use building icon and primary color
  IconData get icon => Icons.business;
  Color get color => ColorManager.primary;
}
