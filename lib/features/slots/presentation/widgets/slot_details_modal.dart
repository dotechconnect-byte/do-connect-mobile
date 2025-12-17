import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/slot_model.dart';

class SlotDetailsModal extends StatefulWidget {
  final SlotModel slot;

  const SlotDetailsModal({
    super.key,
    required this.slot,
  });

  @override
  State<SlotDetailsModal> createState() => _SlotDetailsModalState();
}

class _SlotDetailsModalState extends State<SlotDetailsModal> {
  bool _isEditMode = false;
  List<String> _selectedGroups = ['Evening Team'];
  List<String> _selectedStaff = ['Michael Chen', 'Lisa Anderson'];

  final List<GroupItem> _availableGroups = [
    GroupItem(name: 'Morning Team', memberCount: 12),
    GroupItem(name: 'Evening Team', memberCount: 11),
    GroupItem(name: 'Weekend Warriors', memberCount: 14),
    GroupItem(name: 'Night Shift', memberCount: 5),
    GroupItem(name: 'Event Specialists', memberCount: 9),
    GroupItem(name: 'VIP Service Team', memberCount: 5),
    GroupItem(name: 'Security Detail', memberCount: 5),
    GroupItem(name: 'Hospitality Crew', memberCount: 4),
  ];

  final List<StaffItem> _availableStaff = [
    StaffItem(name: 'Lucas Thompson', position: 'Security Guard'),
    StaffItem(name: 'Mia Jackson', position: 'VIP Host'),
    StaffItem(name: 'Alexander White', position: 'Receptionist'),
    StaffItem(name: 'Charlotte Harris', position: 'Barman'),
    StaffItem(name: 'Benjamin Martin', position: 'Driver'),
    StaffItem(name: 'Amelia King', position: 'Concierge'),
    StaffItem(name: 'Henry Wright', position: 'Event Coordinator'),
    StaffItem(name: 'Harper López', position: 'Parking Attendant'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorManager.grey4, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _isEditMode ? 'Edit Slot Requirements' : 'Slot Booking Details',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s18,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 24.sp),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_isEditMode) _buildViewSubtitle(),

                  SizedBox(height: 16.h),

                  // Slot Info Card
                  _buildSlotInfoCard(),

                  SizedBox(height: 20.h),

                  // Assigned Groups and Staff
                  Row(
                    children: [
                      Expanded(
                        child: _buildAssignedGroups(),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildAssignedStaff(),
                      ),
                    ],
                  ),

                  if (!_isEditMode) ...[
                    SizedBox(height: 20.h),

                    // Edit Button
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => _isEditMode = true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Edit Slot Requirements',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.semiBold,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Booked Staff Section
                    _buildBookedStaffSection(),
                  ],

                  if (_isEditMode) ...[
                    SizedBox(height: 20.h),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() => _isEditMode = false);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              side: BorderSide(color: ColorManager.grey3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.semiBold,
                                color: ColorManager.textPrimary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() => _isEditMode = false);
                              // Save changes logic here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              'Save Changes',
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

                    // Booked Staff Section
                    _buildBookedStaffSection(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewSubtitle() {
    return Text(
      'View and manage staff bookings',
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s13,
        fontWeight: FontWeightManager.regular,
        color: ColorManager.textSecondary,
      ),
    );
  }

  Widget _buildSlotInfoCard() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: ColorManager.grey6,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Time Slot
          Expanded(
            child: _buildInfoItem(
              Icons.access_time,
              'Time Slot',
              widget.slot.timeRange,
              ColorManager.primary,
            ),
          ),
          Container(
            width: 1,
            height: 40.h,
            color: ColorManager.grey3,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
          ),
          // Location
          Expanded(
            child: _buildInfoItem(
              Icons.location_on,
              'Location',
              widget.slot.location,
              const Color(0xFF3B82F6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16.sp, color: color),
            SizedBox(width: 6.w),
            Text(
              label,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s11,
                fontWeight: FontWeightManager.medium,
                color: ColorManager.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildAssignedGroups() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.grey4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups, size: 16.sp, color: ColorManager.primary),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Assigned Groups',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (_isEditMode)
            ..._buildGroupCheckboxes()
          else
            ..._selectedGroups.map((group) => Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Text(
                    group,
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.medium,
                      color: ColorManager.primary,
                    ),
                  ),
                )),
        ],
      ),
    );
  }

  List<Widget> _buildGroupCheckboxes() {
    return _availableGroups.map((group) {
      final isSelected = _selectedGroups.contains(group.name);
      return CheckboxListTile(
        value: isSelected,
        onChanged: (value) {
          setState(() {
            if (value == true) {
              _selectedGroups.add(group.name);
            } else {
              _selectedGroups.remove(group.name);
            }
          });
        },
        dense: true,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          '${group.name} (${group.memberCount} members)',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s12,
            fontWeight: FontWeightManager.medium,
            color: ColorManager.textPrimary,
          ),
        ),
        activeColor: ColorManager.primary,
      );
    }).toList();
  }

  Widget _buildAssignedStaff() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.grey4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, size: 16.sp, color: ColorManager.primary),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Directly Assigned Staff',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (_isEditMode)
            ..._buildStaffCheckboxes()
          else
            ..._selectedStaff.map((staff) => Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Row(
                    children: [
                      Icon(Icons.person_outline,
                          size: 14.sp, color: ColorManager.primary),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          staff,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }

  List<Widget> _buildStaffCheckboxes() {
    return _availableStaff.map((staff) {
      final isSelected = _selectedStaff.contains(staff.name);
      return CheckboxListTile(
        value: isSelected,
        onChanged: (value) {
          setState(() {
            if (value == true) {
              _selectedStaff.add(staff.name);
            } else {
              _selectedStaff.remove(staff.name);
            }
          });
        },
        dense: true,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          '${staff.name} - ${staff.position}',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s12,
            fontWeight: FontWeightManager.medium,
            color: ColorManager.textPrimary,
          ),
        ),
        activeColor: ColorManager.primary,
      );
    }).toList();
  }

  Widget _buildBookedStaffSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Booked Staff Members (0)',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s15,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(40.w),
          decoration: BoxDecoration(
            color: ColorManager.grey6,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: ColorManager.grey4,
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.people_outline,
                  size: 48.sp,
                  color: ColorManager.grey3,
                ),
                SizedBox(height: 12.h),
                Text(
                  'No staff booked yet',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GroupItem {
  final String name;
  final int memberCount;

  GroupItem({required this.name, required this.memberCount});
}

class StaffItem {
  final String name;
  final String position;

  StaffItem({required this.name, required this.position});
}
