import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/user_model.dart';
import 'user_detail_modal.dart';
import 'availability_modal.dart';
import 'assign_group_modal.dart';
import 'invite_staff_modal.dart';
import 'create_group_modal.dart';

class GroupsContent extends StatefulWidget {
  final String searchQuery;

  const GroupsContent({super.key, this.searchQuery = ''});

  @override
  State<GroupsContent> createState() => _GroupsContentState();
}

class _GroupsContentState extends State<GroupsContent> {
  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    'Loved',
    'Liked',
    'Favorites',
    'Regulars',
    'Priority',
    'Ban List'
  ];

  // Custom groups created by the user
  final List<String> _customGroups = [];

  // Sample users data with updated model
  List<UserModel> _users = [
    UserModel(
      id: '1',
      name: 'Sarah Johnson',
      email: 'sarah@example.com',
      role: 'Server',
      rating: 4.2,
      shiftsCount: 51,
      tags: const ['favourite', 'priority'],
      group: 'Favourites',
      isLoved: true,
      whatsappNumber: '+1234567890',
      availabilityStatus: 'Available',
      avatarColor: 'FFEBEE',
    ),
    UserModel(
      id: '2',
      name: 'Michael Chen',
      email: 'michael@example.com',
      role: 'Chef',
      rating: 4.5,
      shiftsCount: 42,
      tags: const ['regular'],
      group: 'Regulars',
      isLiked: true,
      availabilityStatus: 'Busy',
      avatarColor: 'E3F2FD',
    ),
    UserModel(
      id: '3',
      name: 'Emily Rodriguez',
      email: 'emily@example.com',
      role: 'Bartender',
      rating: 4.8,
      shiftsCount: 63,
      tags: const ['favourite', 'regular'],
      group: 'Favourites',
      isLoved: true,
      isLiked: true,
      whatsappNumber: '+1234567891',
      availabilityStatus: 'Available',
      avatarColor: 'FFF3E0',
    ),
    UserModel(
      id: '4',
      name: 'James Wilson',
      email: 'james@example.com',
      role: 'Manager',
      rating: 4.2,
      shiftsCount: 35,
      availabilityStatus: 'Offline',
      avatarColor: 'F3E5F5',
    ),
    UserModel(
      id: '5',
      name: 'Lisa Anderson',
      email: 'lisa@example.com',
      role: 'Server',
      rating: 4.7,
      shiftsCount: 81,
      tags: const ['regular'],
      group: 'Regulars',
      isLiked: true,
      whatsappNumber: '+1234567892',
      availabilityStatus: 'Available',
      avatarColor: 'E8F5E9',
    ),
    UserModel(
      id: '6',
      name: 'David Park',
      email: 'david@example.com',
      role: 'Host',
      rating: 4.4,
      shiftsCount: 25,
      availabilityStatus: 'Available',
      avatarColor: 'FFF9C4',
    ),
    UserModel(
      id: '7',
      name: 'Anna Smith',
      email: 'anna@example.com',
      role: 'Server',
      rating: 4.9,
      shiftsCount: 52,
      tags: const ['favourite'],
      group: 'Favourites',
      isLoved: true,
      whatsappNumber: '+1234567893',
      availabilityStatus: 'Available',
      avatarColor: 'FCE4EC',
    ),
    UserModel(
      id: '8',
      name: 'Robert Taylor',
      email: 'robert@example.com',
      role: 'Chef',
      rating: 4.4,
      shiftsCount: 28,
      tags: const ['regular'],
      group: 'Regulars',
      availabilityStatus: 'Busy',
      avatarColor: 'E1F5FE',
    ),
  ];

  List<String> get _allFilters {
    // Combine default filters with custom groups
    return [..._filters, ..._customGroups];
  }

  List<UserModel> get _filteredUsers {
    var filtered = _users;

    // Apply search filter
    if (widget.searchQuery.isNotEmpty) {
      final query = widget.searchQuery.toLowerCase();
      filtered = filtered.where((user) {
        return user.name.toLowerCase().contains(query) ||
            user.email.toLowerCase().contains(query) ||
            user.role.toLowerCase().contains(query);
      }).toList();
    }

    // Apply category filter
    switch (_selectedFilter) {
      case 'Loved':
        filtered = filtered.where((user) => user.isLoved).toList();
        break;
      case 'Liked':
        filtered = filtered.where((user) => user.isLiked).toList();
        break;
      case 'Favorites':
        filtered = filtered.where((user) => user.group == 'Favourites').toList();
        break;
      case 'Regulars':
        filtered = filtered.where((user) => user.group == 'Regulars').toList();
        break;
      case 'Priority':
        filtered = filtered.where((user) => user.group == 'Priority').toList();
        break;
      case 'Ban List':
        filtered = filtered.where((user) => user.isBanned).toList();
        break;
      default:
        // Check if it's a custom group
        if (_customGroups.contains(_selectedFilter)) {
          filtered = filtered.where((user) => user.group == _selectedFilter).toList();
        }
        break;
    }

    return filtered;
  }

  void _updateUser(String userId, UserModel updatedUser) {
    setState(() {
      final index = _users.indexWhere((u) => u.id == userId);
      if (index != -1) {
        _users[index] = updatedUser;
      }
    });
  }

  void _addCustomGroup(String groupName) {
    setState(() {
      if (!_customGroups.contains(groupName)) {
        _customGroups.add(groupName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);
    return Column(
      children: [
        // Filter Tabs
        Container(
          color: colors.cardBackground,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _allFilters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: _buildFilterChip(filter, isSelected, colors: colors),
                );
              }).toList(),
            ),
          ),
        ),

        // Action Buttons (Create Group & Invite Staff)
        Container(
          color: colors.cardBackground,
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
          child: Row(
            children: [
              // Create Group button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CreateGroupModal(
                        onGroupCreated: (groupName) {
                          _addCustomGroup(groupName);
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.group_add,
                    size: 18.sp,
                    color: colors.textPrimary,
                  ),
                  label: Text(
                    'Create Group',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.semiBold,
                      color: colors.textPrimary,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colors.grey4),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Invite Staff button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const InviteStaffModal(),
                    );
                  },
                  icon: Icon(
                    Icons.person_add,
                    size: 18.sp,
                    color: ColorManager.white,
                  ),
                  label: Text(
                    'Invite Staff',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // User Grid
        Expanded(
          child: _filteredUsers.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 64.sp,
                        color: colors.grey3,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No users found',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.medium,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(16.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 0.58,
                  ),
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    return _buildUserCard(_filteredUsers[index], colors: colors);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, {required ThemeHelper colors}) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : colors.grey6,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? colors.primary : colors.grey4,
          ),
        ),
        child: Text(
          label,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight:
                isSelected ? FontWeightManager.semiBold : FontWeightManager.medium,
            color: isSelected ? ColorManager.white : colors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(UserModel user, {required ThemeHelper colors}) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => UserDetailModal(
            user: user,
            customGroups: _customGroups,
            onFavoriteToggle: () {
              _updateUser(user.id, user.copyWith(isLoved: !user.isLoved));
            },
            onUserUpdated: (updatedUser) {
              _updateUser(user.id, updatedUser);
            },
          ),
        );
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.grey4),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar and icons
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: Color(int.parse('FF${user.avatarColor}', radix: 16)),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.grey4.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        user.initials,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.bold,
                          color: colors.primary,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Favorite icon
                  InkWell(
                    onTap: () {
                      setState(() {
                        _updateUser(user.id, user.copyWith(isLoved: !user.isLoved));
                      });
                    },
                    child: Icon(
                      user.isLoved ? Icons.favorite : Icons.favorite_border,
                      size: 20.sp,
                      color:
                          user.isLoved ? colors.error : colors.grey3,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // More icon
                  Icon(
                    Icons.more_vert,
                    size: 20.sp,
                    color: colors.grey3,
                  ),
                ],
              ),
            ),

            // User info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold,
                      color: colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14.sp, color: colors.warning),
                      SizedBox(width: 4.w),
                      Text(
                        '${user.rating}',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.semiBold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${user.shiftsCount} shifts',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s11,
                          fontWeight: FontWeightManager.regular,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // Tags
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SizedBox(
                height: 24.h,
                child: user.tags.isNotEmpty || (_customGroups.contains(user.group))
                    ? Wrap(
                        spacing: 6.w,
                        runSpacing: 6.h,
                        children: [
                          ...user.tags.map((tag) => _buildTag(tag, colors: colors)),
                          // Show custom group tag if user is in a custom group
                          if (_customGroups.contains(user.group))
                            _buildTag(user.group!, colors: colors, isCustomGroup: true),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),

            SizedBox(height: 12.h),

            // Divider
            Divider(color: colors.grey4, height: 1),

            // Action buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Row(
                children: [
                  // Availability button
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.calendar_today_outlined,
                      label: 'Availability',
                      colors: colors,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => AvailabilityModal(user: user),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 6.w),
                  // Assign Group button
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.group_add_outlined,
                      label: 'Assign',
                      colors: colors,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AssignGroupModal(
                            currentGroup: user.group ?? 'Regulars',
                            customGroups: _customGroups,
                            onGroupSelected: (group) {
                              _updateUser(user.id, user.copyWith(group: group));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Assigned to $group',
                                    style: FontConstants.getPoppinsStyle(
                                      fontSize: FontSize.s13,
                                      fontWeight: FontWeightManager.medium,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                  backgroundColor: colors.success,
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Ban button row
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
              child: SizedBox(
                width: double.infinity,
                child: _buildBanButton(user, colors: colors),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String tag, {required ThemeHelper colors, bool isCustomGroup = false}) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    if (isCustomGroup) {
      // Custom group tags - use purple/violet theme
      backgroundColor = colors.primary.withValues(alpha: 0.1);
      textColor = colors.primary;
      displayText = tag;
    } else {
      switch (tag.toLowerCase()) {
        case 'favourite':
        case 'favorite':
          backgroundColor = colors.error.withValues(alpha: 0.1);
          textColor = colors.error;
          displayText = 'favourite';
          break;
        case 'priority':
          backgroundColor = colors.warning.withValues(alpha: 0.1);
          textColor = colors.warning;
          displayText = 'priority';
          break;
        case 'regular':
          backgroundColor = colors.info.withValues(alpha: 0.1);
          textColor = colors.info;
          displayText = 'regular';
          break;
        default:
          backgroundColor = colors.grey5;
          textColor = colors.textSecondary;
          displayText = tag;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        displayText,
        style: FontConstants.getPoppinsStyle(
          fontSize: FontSize.s10,
          fontWeight: FontWeightManager.medium,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required ThemeHelper colors,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: colors.grey6,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: colors.grey4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 14.sp,
              color: colors.textPrimary,
            ),
            SizedBox(width: 4.w),
            Flexible(
              child: Text(
                label,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s10,
                  fontWeight: FontWeightManager.medium,
                  color: colors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanButton(UserModel user, {required ThemeHelper colors}) {
    return InkWell(
      onTap: () {
        setState(() {
          _updateUser(user.id, user.copyWith(isBanned: !user.isBanned));
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              user.isBanned ? 'User unbanned' : 'User banned',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.medium,
                color: ColorManager.white,
              ),
            ),
            backgroundColor: user.isBanned ? colors.success : colors.error,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: user.isBanned
              ? colors.success.withValues(alpha: 0.1)
              : colors.error.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: user.isBanned ? colors.success : colors.error,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              user.isBanned ? Icons.check_circle_outline : Icons.block,
              size: 14.sp,
              color: user.isBanned ? colors.success : colors.error,
            ),
            SizedBox(width: 6.w),
            Text(
              user.isBanned ? 'Unban' : 'Ban',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s11,
                fontWeight: FontWeightManager.semiBold,
                color: user.isBanned ? colors.success : colors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
