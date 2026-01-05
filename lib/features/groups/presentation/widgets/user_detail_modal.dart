import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/user_model.dart';
import 'assign_group_modal.dart';
import 'availability_modal.dart';

class UserDetailModal extends StatefulWidget {
  final UserModel user;
  final VoidCallback onFavoriteToggle;
  final Function(UserModel)? onUserUpdated;
  final List<String>? customGroups;

  const UserDetailModal({
    super.key,
    required this.user,
    required this.onFavoriteToggle,
    this.onUserUpdated,
    this.customGroups,
  });

  @override
  State<UserDetailModal> createState() => _UserDetailModalState();
}

class _UserDetailModalState extends State<UserDetailModal> {
  late TextEditingController _commentsController;
  bool _isEditingComments = false;
  late UserModel _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _commentsController = TextEditingController(text: widget.user.comments);
  }

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: colors.cardBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              children: [
                // Drag Handle
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: colors.grey3,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 16.h),

                // Title and Close Button
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Staff Member Details',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s20,
                          fontWeight: FontWeightManager.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        size: 24.sp,
                        color: colors.textSecondary,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
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
                  // User Avatar and Basic Info
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: colors.grey4),
                    ),
                    child: Column(
                      children: [
                        // Avatar
                        Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            color: Color(int.parse('FF${widget.user.avatarColor}', radix: 16)),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colors.grey4.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.user.initials,
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s36,
                                fontWeight: FontWeightManager.bold,
                                color: colors.primary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Name
                        Text(
                          _currentUser.name,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s20,
                            fontWeight: FontWeightManager.bold,
                            color: colors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 6.h),

                        // Email
                        Text(
                          _currentUser.email,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,
                            color: colors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.h),

                        // Rating and Shifts
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, size: 18.sp, color: colors.warning),
                            SizedBox(width: 6.w),
                            Text(
                              '${_currentUser.rating}',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: colors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                '${_currentUser.shiftsCount} shifts',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s13,
                                  fontWeight: FontWeightManager.semiBold,
                                  color: colors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),

                        // Tags
                        if (_currentUser.tags.isNotEmpty)
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            alignment: WrapAlignment.center,
                            children: _currentUser.tags.map((tag) => _buildTag(tag, colors: colors)).toList(),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Action Buttons Row 1
                  Row(
                    children: [
                      // Call button
                      Expanded(
                        child: _buildPrimaryActionButton(
                          icon: Icons.phone,
                          label: 'Call',
                          color: colors.success,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Calling ${widget.user.name}...',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s13,
                                    fontWeight: FontWeightManager.medium,
                                    color: ColorManager.white,
                                  ),
                                ),
                                backgroundColor: colors.success,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Availability button
                      Expanded(
                        child: _buildPrimaryActionButton(
                          icon: Icons.calendar_today,
                          label: 'Availability',
                          color: colors.info,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => AvailabilityModal(user: widget.user),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Like button (full width)
                  SizedBox(
                    width: double.infinity,
                    child: _buildPrimaryActionButton(
                      icon: _currentUser.isLoved ? Icons.favorite : Icons.favorite_border,
                      label: _currentUser.isLoved ? 'Liked' : 'Like',
                      color: _currentUser.isLoved ? colors.error : colors.grey3,
                      onTap: () {
                        setState(() {
                          _currentUser = _currentUser.copyWith(isLoved: !_currentUser.isLoved);
                        });
                        widget.onFavoriteToggle();
                      },
                    ),
                  ),

                  // WhatsApp button (conditional)
                  if (_currentUser.hasWhatsApp) ...[
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: double.infinity,
                      child: _buildPrimaryActionButton(
                        icon: Icons.chat_bubble,
                        label: 'Message on WhatsApp',
                        color: const Color(0xFF25D366),
                        onTap: () {
                          // Launch WhatsApp
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Opening WhatsApp...',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s13,
                                  fontWeight: FontWeightManager.medium,
                                  color: ColorManager.white,
                                ),
                              ),
                              backgroundColor: const Color(0xFF25D366),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  SizedBox(height: 16.h),

                  // Details Section
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: colors.grey4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Details',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailRow('Role', _currentUser.role, colors: colors),
                        if (_currentUser.group != null) ...[
                          SizedBox(height: 12.h),
                          Divider(color: colors.grey4, height: 1),
                          SizedBox(height: 12.h),
                          _buildDetailRow('Group', _currentUser.group!, colors: colors),
                        ],
                        if (_currentUser.availabilityStatus != null) ...[
                          SizedBox(height: 12.h),
                          Divider(color: colors.grey4, height: 1),
                          SizedBox(height: 12.h),
                          _buildDetailRow('Status', _currentUser.availabilityStatus!, colors: colors),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Assign Group Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AssignGroupModal(
                            currentGroup: _currentUser.group ?? 'Regulars',
                            customGroups: widget.customGroups,
                            onGroupSelected: (group) {
                              setState(() {
                                // Determine tags based on group
                                List<String> newTags = [];
                                if (group == 'Favourites') {
                                  newTags = ['favourite'];
                                } else if (group == 'Regulars') {
                                  newTags = ['regular'];
                                } else if (group == 'Priority') {
                                  newTags = ['priority'];
                                }

                                // Update local state with new group and tags
                                _currentUser = _currentUser.copyWith(
                                  group: group,
                                  tags: newTags,
                                );
                              });

                              // Call the callback to update parent
                              if (widget.onUserUpdated != null) {
                                widget.onUserUpdated!(_currentUser);
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Assigned to $group group',
                                    style: FontConstants.getPoppinsStyle(
                                      fontSize: FontSize.s13,
                                      fontWeight: FontWeightManager.medium,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                  backgroundColor: colors.success,
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.group_add,
                        size: 18.sp,
                        color: ColorManager.white,
                      ),
                      label: Text(
                        'Assign to Group',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Comments Section
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: colors.grey4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Comments',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isEditingComments = !_isEditingComments;
                                  if (!_isEditingComments) {
                                    // Save changes
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Comments saved',
                                          style: FontConstants.getPoppinsStyle(
                                            fontSize: FontSize.s13,
                                            fontWeight: FontWeightManager.medium,
                                            color: ColorManager.white,
                                          ),
                                        ),
                                        backgroundColor: colors.success,
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                });
                              },
                              borderRadius: BorderRadius.circular(8.r),
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: _isEditingComments
                                      ? colors.success.withValues(alpha: 0.1)
                                      : colors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  _isEditingComments ? Icons.check : Icons.edit,
                                  size: 18.sp,
                                  color: _isEditingComments
                                      ? colors.success
                                      : colors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        _isEditingComments
                            ? TextField(
                                controller: _commentsController,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: 'Add comments about this staff member...',
                                  hintStyle: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s13,
                                    fontWeight: FontWeightManager.regular,
                                    color: colors.textSecondary,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: BorderSide(color: colors.grey4),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: BorderSide(color: colors.grey4),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: BorderSide(color: colors.primary),
                                  ),
                                  contentPadding: EdgeInsets.all(12.w),
                                ),
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s13,
                                  fontWeight: FontWeightManager.regular,
                                  color: colors.textPrimary,
                                ),
                              )
                            : Text(
                                _commentsController.text.isEmpty
                                    ? 'No comments yet. Tap the edit icon to add comments.'
                                    : _commentsController.text,
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s13,
                                  fontWeight: FontWeightManager.regular,
                                  color: _commentsController.text.isEmpty
                                      ? colors.textSecondary
                                      : colors.textPrimary,
                                ),
                              ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag, {required ThemeHelper colors}) {
    Color backgroundColor;
    Color textColor;
    String displayText;

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

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        displayText,
        style: FontConstants.getPoppinsStyle(
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.semiBold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildPrimaryActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: color,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {required ThemeHelper colors}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.regular,
            color: colors.textSecondary,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.semiBold,
              color: colors.textPrimary,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
