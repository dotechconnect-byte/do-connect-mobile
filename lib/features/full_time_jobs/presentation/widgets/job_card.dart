import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/job_model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback onTap;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and actions
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title with featured badge
                      Row(
                        children: [
                          if (job.isFeatured) ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: colors.warning.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(
                                  color: colors.warning.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 12.sp,
                                    color: colors.warning,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Featured',
                                    style: FontConstants.getPoppinsStyle(
                                      fontSize: FontSize.s10,
                                      fontWeight: FontWeightManager.semiBold,
                                      color: colors.warning,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                          ],
                          Expanded(
                            child: Text(
                              job.title,
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,
                                color: colors.textPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // Salary and Location
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            size: 16.sp,
                            color: colors.success,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            job.salaryRange,
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s13,
                              fontWeight: FontWeightManager.medium,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Icon(
                            _getLocationIcon(job.locationType),
                            size: 16.sp,
                            color: colors.primary,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              job.location,
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s13,
                                fontWeight: FontWeightManager.regular,
                                color: colors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (job.locationType == 'Multiple locations') ...[
                            SizedBox(width: 4.w),
                            TextButton(
                              onPressed: () {
                                // Show all locations
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'See all',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeightManager.medium,
                                  color: ColorManager.primary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),

                // Actions Menu
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: colors.textSecondary,
                    size: 20.sp,
                  ),
                  color: colors.cardBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(color: colors.grey5),
                  ),
                  onSelected: (value) {
                    // Handle menu actions
                  },
                  itemBuilder: (context) => [
                    _buildMenuItem(
                      Icons.visibility,
                      'View Applicants',
                      colors,
                    ),
                    _buildMenuItem(
                      Icons.trending_up,
                      'Bump Job',
                      colors,
                    ),
                    _buildMenuItem(
                      Icons.person_add_outlined,
                      'Invite Applicants',
                      colors,
                    ),
                    _buildMenuItem(
                      Icons.edit_outlined,
                      'Edit Job',
                      colors,
                    ),
                    _buildMenuItem(
                      Icons.share_outlined,
                      'Share Post',
                      colors,
                    ),
                    _buildMenuItem(
                      Icons.more_horiz,
                      'More Actions',
                      colors,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Dates and Bumps info
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: colors.grey6,
              border: Border(
                top: BorderSide(color: colors.grey5),
                bottom: BorderSide(color: colors.grey5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildInfoColumn(
                    'Posted on',
                    DateFormat('dd MMM yyyy, hh:mm a').format(job.postedOn),
                    'by ${job.postedBy}',
                    colors,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40.h,
                  color: colors.grey4,
                ),
                Expanded(
                  child: _buildInfoColumn(
                    'Expires on',
                    DateFormat('dd MMM yyyy, hh:mm a').format(job.expiresOn),
                    null,
                    colors,
                  ),
                ),
              ],
            ),
          ),

          // Previous and Next Bump
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: colors.grey6,
              border: Border(
                bottom: BorderSide(color: colors.grey5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildInfoColumn(
                    'Previous bump',
                    job.previousBump ?? 'Not set',
                    null,
                    colors,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40.h,
                  color: colors.grey4,
                ),
                Expanded(
                  child: _buildInfoColumn(
                    'Next bump',
                    job.nextBump ?? 'Not set',
                    null,
                    colors,
                  ),
                ),
              ],
            ),
          ),

          // Stats Row
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(job.views.toString(), 'Views', colors.textPrimary, colors),
                _buildStatItem(job.applications.toString(), 'Applications', colors.success, colors),
                _buildStatItem(job.shares.toString(), 'Shares', colors.info, colors),
                _buildStatItem(job.messages.toString(), 'Messages', colors.warning, colors),
                _buildStatItem(job.saved.toString(), 'Saved', colors.primaryDark, colors),
                _buildStatItem(job.invitations.toString(), 'Invitations', colors.error, colors),
              ],
            ),
          ),

          // View Analytics Button
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: TextButton.icon(
              onPressed: () {
                // View detailed analytics
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              ),
              icon: Icon(
                Icons.bar_chart,
                size: 16.sp,
                color: ColorManager.primary,
              ),
              label: Text(
                'View detailed analytics',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(
    IconData icon,
    String label,
    ThemeHelper colors,
  ) {
    return PopupMenuItem<String>(
      value: label,
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: colors.textSecondary),
          SizedBox(width: 12.w),
          Text(
            label,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s13,
              fontWeight: FontWeightManager.regular,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(
    String label,
    String value,
    String? subtitle,
    ThemeHelper colors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s11,
            fontWeight: FontWeightManager.regular,
            color: colors.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s12,
            fontWeight: FontWeightManager.semiBold,
            color: colors.textPrimary,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s10,
              fontWeight: FontWeightManager.regular,
              color: colors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStatItem(String value, String label, Color valueColor, ThemeHelper colors) {
    return Column(
      children: [
        Text(
          value,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
            color: valueColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s11,
            fontWeight: FontWeightManager.regular,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }

  IconData _getLocationIcon(String locationType) {
    switch (locationType) {
      case 'Remote':
        return Icons.home_outlined;
      case 'Multiple locations':
        return Icons.location_on_outlined;
      default:
        return Icons.location_on_outlined;
    }
  }
}
