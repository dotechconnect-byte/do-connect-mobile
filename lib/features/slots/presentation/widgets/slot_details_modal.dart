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
  bool _isStaffExpanded = false;
  bool _isGroupsExpanded = false;
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
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Drag Handle
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.grey3,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Header
          _buildHeader(),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Slot Info Card
                  _buildSlotInfoCard(),

                  SizedBox(height: 24.h),

                  // Assigned Groups Section
                  _buildExpandableSectionHeader(
                    icon: Icons.groups_rounded,
                    title: 'Assigned Groups',
                    count: _selectedGroups.length,
                    isExpanded: _isGroupsExpanded,
                    onToggle: _isEditMode ? null : () {
                      setState(() => _isGroupsExpanded = !_isGroupsExpanded);
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildAssignedGroups(),

                  SizedBox(height: 24.h),

                  // Directly Assigned Staff Section
                  _buildExpandableSectionHeader(
                    icon: Icons.person_rounded,
                    title: 'Directly Assigned Staff',
                    count: _selectedStaff.length,
                    isExpanded: _isStaffExpanded,
                    onToggle: _isEditMode ? null : () {
                      setState(() => _isStaffExpanded = !_isStaffExpanded);
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildAssignedStaff(),

                  if (!_isEditMode) ...[
                    SizedBox(height: 24.h),
                    _buildEditButton(),
                  ],

                  if (_isEditMode) ...[
                    SizedBox(height: 24.h),
                    _buildActionButtons(),
                  ],

                  SizedBox(height: 24.h),

                  // Booked Staff Section
                  _buildBookedStaffSection(),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final colors = ThemeHelper.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 12.w, 16.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.grey4.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Icon with gradient background
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.primary,
                  colors.primary.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              _isEditMode ? Icons.edit_rounded : Icons.calendar_today_rounded,
              size: 20.sp,
              color: ColorManager.white,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isEditMode ? 'Edit Slot Requirements' : 'Slot Booking Details',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.bold,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _isEditMode
                      ? 'Modify groups and staff assignments'
                      : 'View and manage staff bookings',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: colors.grey5,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                size: 18.sp,
                color: colors.textSecondary,
              ),
            ),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildSlotInfoCard() {
    final colors = ThemeHelper.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.primary.withValues(alpha: 0.08),
            colors.primary.withValues(alpha: 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: colors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Time Slot
              Expanded(
                child: _buildInfoChip(
                  icon: Icons.access_time_rounded,
                  label: 'Time Slot',
                  value: widget.slot.timeRange,
                  iconColor: colors.primary,
                ),
              ),
              SizedBox(width: 12.w),
              // Location
              Expanded(
                child: _buildInfoChip(
                  icon: Icons.location_on_rounded,
                  label: 'Location',
                  value: widget.slot.location,
                  iconColor: colors.info,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Staff Status
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: colors.cardBackground,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: colors.grey4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people_alt_rounded,
                  size: 18.sp,
                  color: widget.slot.isFilled ? colors.success : colors.primary,
                ),
                SizedBox(width: 8.w),
                Text(
                  '${widget.slot.currentStaff}/${widget.slot.requiredStaff}',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.bold,
                    color: widget.slot.isFilled ? colors.success : colors.primary,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  'Staff Booked',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.medium,
                    color: colors.textSecondary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: widget.slot.isFilled
                        ? colors.success.withValues(alpha: 0.1)
                        : colors.warning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    widget.slot.isFilled ? 'Filled' : 'Open',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s11,
                      fontWeight: FontWeightManager.semiBold,
                      color: widget.slot.isFilled ? colors.success : colors.warning,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    final colors = ThemeHelper.of(context);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.grey4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(icon, size: 14.sp, color: iconColor),
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s11,
                  fontWeight: FontWeightManager.medium,
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s13,
              fontWeight: FontWeightManager.bold,
              color: colors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSectionHeader({
    required IconData icon,
    required String title,
    required int count,
    required bool isExpanded,
    VoidCallback? onToggle,
  }) {
    final colors = ThemeHelper.of(context);
    final isExpandable = onToggle != null;

    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: colors.primary),
            SizedBox(width: 8.w),
            Text(
              title,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s15,
                fontWeight: FontWeightManager.bold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                count.toString(),
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.bold,
                  color: colors.primary,
                ),
              ),
            ),
            const Spacer(),
            if (isExpandable)
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: colors.grey5,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20.sp,
                    color: colors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignedGroups() {
    final colors = ThemeHelper.of(context);

    if (_isEditMode) {
      return Container(
        decoration: BoxDecoration(
          color: colors.grey6,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: colors.grey4),
        ),
        child: Column(
          children: _availableGroups.asMap().entries.map((entry) {
            final index = entry.key;
            final group = entry.value;
            final isSelected = _selectedGroups.contains(group.name);
            final isLast = index == _availableGroups.length - 1;

            return Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedGroups.remove(group.name);
                      } else {
                        _selectedGroups.add(group.name);
                      }
                    });
                  },
                  borderRadius: BorderRadius.vertical(
                    top: index == 0 ? Radius.circular(14.r) : Radius.zero,
                    bottom: isLast ? Radius.circular(14.r) : Radius.zero,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    child: Row(
                      children: [
                        _buildModernCheckbox(isSelected),
                        SizedBox(width: 12.w),
                        Icon(
                          Icons.groups_rounded,
                          size: 18.sp,
                          color: isSelected ? colors.primary : colors.textSecondary,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                group.name,
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s13,
                                  fontWeight: FontWeightManager.semiBold,
                                  color: colors.textPrimary,
                                ),
                              ),
                              Text(
                                '${group.memberCount} members',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s11,
                                  fontWeight: FontWeightManager.regular,
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isLast)
                  Divider(height: 1, color: colors.grey4, indent: 14.w, endIndent: 14.w),
              ],
            );
          }).toList(),
        ),
      );
    }

    // View mode - expandable groups section
    return AnimatedCrossFade(
      firstChild: _buildGroupsCollapsedView(),
      secondChild: _buildGroupsExpandedView(),
      crossFadeState: _isGroupsExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }

  Widget _buildGroupsCollapsedView() {
    final colors = ThemeHelper.of(context);
    final displayCount = _selectedGroups.length > 3 ? 3 : _selectedGroups.length;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.primary.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          // Stacked circle avatars for groups
          SizedBox(
            width: (displayCount * 18.0 + 14).w,
            height: 32.h,
            child: Stack(
              children: List.generate(
                displayCount,
                (index) => Positioned(
                  left: index * 18.0.w,
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colors.primary,
                          colors.primary.withValues(alpha: 0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.cardBackground, width: 2),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.groups_rounded,
                        size: 14.sp,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedGroups.length == 1
                      ? _selectedGroups.first
                      : '${_selectedGroups.length} Groups Assigned',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Tap to view details',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s11,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupsExpandedView() {
    final colors = ThemeHelper.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.grey6,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: colors.grey4),
      ),
      child: Column(
        children: _selectedGroups.asMap().entries.map((entry) {
          final index = entry.key;
          final group = entry.value;
          final groupData = _availableGroups.firstWhere(
            (g) => g.name == group,
            orElse: () => GroupItem(name: group, memberCount: 0),
          );
          final isLast = index == _selectedGroups.length - 1;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(14.w),
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colors.primary,
                            colors.primary.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.groups_rounded,
                          size: 18.sp,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group,
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.semiBold,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '${groupData.memberCount} members',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeightManager.regular,
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: colors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 14.sp,
                            color: colors.success,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Assigned',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s11,
                              fontWeight: FontWeightManager.semiBold,
                              color: colors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(height: 1, color: colors.grey4, indent: 14.w, endIndent: 14.w),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAssignedStaff() {
    final colors = ThemeHelper.of(context);

    if (_isEditMode) {
      return Container(
        decoration: BoxDecoration(
          color: colors.grey6,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: colors.grey4),
        ),
        child: Column(
          children: _availableStaff.asMap().entries.map((entry) {
            final index = entry.key;
            final staff = entry.value;
            final isSelected = _selectedStaff.contains(staff.name);
            final isLast = index == _availableStaff.length - 1;

            return Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedStaff.remove(staff.name);
                      } else {
                        _selectedStaff.add(staff.name);
                      }
                    });
                  },
                  borderRadius: BorderRadius.vertical(
                    top: index == 0 ? Radius.circular(14.r) : Radius.zero,
                    bottom: isLast ? Radius.circular(14.r) : Radius.zero,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    child: Row(
                      children: [
                        _buildModernCheckbox(isSelected),
                        SizedBox(width: 12.w),
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colors.primary.withValues(alpha: 0.1)
                                : colors.grey4,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              staff.name.split(' ').map((n) => n[0]).take(2).join(),
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.bold,
                                color: isSelected ? colors.primary : colors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                staff.name,
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s13,
                                  fontWeight: FontWeightManager.semiBold,
                                  color: colors.textPrimary,
                                ),
                              ),
                              Text(
                                staff.position,
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s11,
                                  fontWeight: FontWeightManager.regular,
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isLast)
                  Divider(height: 1, color: colors.grey4, indent: 14.w, endIndent: 14.w),
              ],
            );
          }).toList(),
        ),
      );
    }

    // View mode - expandable staff section
    return AnimatedCrossFade(
      firstChild: _buildStaffCollapsedView(),
      secondChild: _buildStaffExpandedView(),
      crossFadeState: _isStaffExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }

  Widget _buildStaffCollapsedView() {
    final colors = ThemeHelper.of(context);
    final displayCount = _selectedStaff.length > 3 ? 3 : _selectedStaff.length;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colors.info.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.info.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          // Stacked circle avatars for staff
          SizedBox(
            width: (displayCount * 18.0 + 14).w,
            height: 32.h,
            child: Stack(
              children: List.generate(
                displayCount,
                (index) {
                  final staffName = _selectedStaff[index];
                  return Positioned(
                    left: index * 18.0.w,
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colors.primary,
                            colors.primary.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.cardBackground, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          staffName.split(' ').map((n) => n[0]).take(2).join(),
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedStaff.length == 1
                      ? _selectedStaff.first
                      : '${_selectedStaff.length} Staff Members',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Tap to view details',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s11,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffExpandedView() {
    final colors = ThemeHelper.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.grey6,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: colors.grey4),
      ),
      child: Column(
        children: _selectedStaff.asMap().entries.map((entry) {
          final index = entry.key;
          final staffName = entry.value;
          final staffData = _availableStaff.firstWhere(
            (s) => s.name == staffName,
            orElse: () => StaffItem(name: staffName, position: 'Staff'),
          );
          final isLast = index == _selectedStaff.length - 1;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(14.w),
                child: Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colors.primary,
                            colors.primary.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          staffName.split(' ').map((n) => n[0]).take(2).join(),
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staffName,
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.semiBold,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Icon(
                                Icons.work_outline_rounded,
                                size: 12.sp,
                                color: colors.textSecondary,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                staffData.position,
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeightManager.regular,
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: colors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 14.sp,
                            color: colors.success,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Assigned',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s11,
                              fontWeight: FontWeightManager.semiBold,
                              color: colors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(height: 1, color: colors.grey4, indent: 14.w, endIndent: 14.w),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildModernCheckbox(bool isSelected) {
    final colors = ThemeHelper.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        color: isSelected ? colors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: isSelected ? colors.primary : colors.grey3,
          width: 2,
        ),
      ),
      child: isSelected
          ? Icon(
              Icons.check_rounded,
              size: 14.sp,
              color: ColorManager.white,
            )
          : null,
    );
  }

  Widget _buildEditButton() {
    final colors = ThemeHelper.of(context);

    return Container(
      width: double.infinity,
      height: 52.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.primary,
            colors.primary.withValues(alpha: 0.85),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() => _isEditMode = true);
          },
          borderRadius: BorderRadius.circular(14.r),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit_rounded,
                  size: 20.sp,
                  color: ColorManager.white,
                ),
                SizedBox(width: 10.w),
                Text(
                  'Edit Slot Requirements',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s15,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final colors = ThemeHelper.of(context);

    return Row(
      children: [
        // Cancel Button
        Expanded(
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: colors.grey5,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.grey4),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() => _isEditMode = false);
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Center(
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
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Save Button
        Expanded(
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.primary,
                  colors.primary.withValues(alpha: 0.85),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() => _isEditMode = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(Icons.check_circle_rounded, color: ColorManager.white, size: 20.sp),
                          SizedBox(width: 10.w),
                          const Text('Changes saved successfully'),
                        ],
                      ),
                      backgroundColor: colors.success,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      margin: EdgeInsets.all(16.w),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_rounded,
                        size: 20.sp,
                        color: ColorManager.white,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Save Changes',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookedStaffSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.badge_rounded, size: 18.sp, color: colors.primary),
            SizedBox(width: 8.w),
            Text(
              'Booked Staff Members',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s15,
                fontWeight: FontWeightManager.bold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: colors.grey4,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '0',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.bold,
                  color: colors.textSecondary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
          decoration: BoxDecoration(
            color: colors.grey6,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: colors.grey4,
              width: 1,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: colors.grey4.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.people_outline_rounded,
                    size: 40.sp,
                    color: colors.grey2,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'No staff booked yet',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s15,
                    fontWeight: FontWeightManager.semiBold,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Staff members will appear here once booked',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
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
