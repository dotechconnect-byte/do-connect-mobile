import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
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

                      // Salary
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
                        ],
                      ),
                      SizedBox(height: 8.h),

                      // Location
                      Row(
                        children: [
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
                        ],
                      ),
                    ],
                  ),
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
        ],
        ),
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
