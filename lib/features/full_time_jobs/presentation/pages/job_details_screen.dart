import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/job_model.dart';
import 'edit_job_screen.dart';
import 'view_applicants_screen.dart';

class JobDetailsScreen extends StatefulWidget {
  final JobModel job;

  const JobDetailsScreen({
    super.key,
    required this.job,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late JobModel _currentJob;

  @override
  void initState() {
    super.initState();
    _currentJob = widget.job;
  }

  Future<void> _navigateToEditJob() async {
    final updatedJob = await Navigator.push<JobModel>(
      context,
      MaterialPageRoute(
        builder: (context) => EditJobScreen(job: _currentJob),
      ),
    );

    if (updatedJob != null) {
      setState(() {
        _currentJob = updatedJob;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.cardBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context, _currentJob),
        ),
        title: Text(
          'Job Details',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
            color: colors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Title with Featured Badge
            Row(
              children: [
                if (_currentJob.isFeatured) ...[
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
              ],
            ),
            SizedBox(height: 8.h),

            Text(
              _currentJob.title,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeightManager.bold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),

            // Salary and Location
            _buildDetailRow('Salary', _currentJob.salaryRange, Icons.attach_money, colors.success, colors),
            SizedBox(height: 12.h),
            _buildDetailRow('Location', _currentJob.location, _getLocationIcon(_currentJob.locationType), colors.primary, colors),
            SizedBox(height: 20.h),

            // Dates Section
            Text(
              'Dates & Timeline',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.semiBold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.grey5),
              ),
              child: Column(
                children: [
                  _buildInfoRow('Posted on', DateFormat('dd MMM yyyy, hh:mm a').format(_currentJob.postedOn), colors),
                  SizedBox(height: 8.h),
                  _buildInfoRow('Posted by', _currentJob.postedBy, colors),
                  Divider(height: 24.h, color: colors.grey4),
                  _buildInfoRow('Expires on', DateFormat('dd MMM yyyy, hh:mm a').format(_currentJob.expiresOn), colors),
                  Divider(height: 24.h, color: colors.grey4),
                  _buildInfoRow('Previous bump', _currentJob.previousBump ?? 'Not set', colors),
                  SizedBox(height: 8.h),
                  _buildInfoRow('Next bump', _currentJob.nextBump ?? 'Not set', colors),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Statistics Section
            Text(
              'Job Statistics',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.semiBold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.grey5),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildStatCard('Views', _currentJob.views.toString(), colors.textPrimary, colors)),
                      SizedBox(width: 12.w),
                      Expanded(child: _buildStatCard('Applications', _currentJob.applications.toString(), colors.success, colors)),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(child: _buildStatCard('Shares', _currentJob.shares.toString(), colors.info, colors)),
                      SizedBox(width: 12.w),
                      Expanded(child: _buildStatCard('Messages', _currentJob.messages.toString(), colors.warning, colors)),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(child: _buildStatCard('Saved', _currentJob.saved.toString(), colors.primaryDark, colors)),
                      SizedBox(width: 12.w),
                      Expanded(child: _buildStatCard('Invitations', _currentJob.invitations.toString(), colors.error, colors)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Action Buttons
            Text(
              'Actions',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.semiBold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),

            // View Applicants Button
            _buildFullWidthButton(
              'View Applicants',
              Icons.people_outline,
              ColorManager.primary,
              colors,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewApplicantsScreen(job: _currentJob),
                  ),
                );
              },
            ),
            SizedBox(height: 12.h),

            // Bump Job Button
            _buildFullWidthButton(
              'Bump Job',
              Icons.trending_up,
              ColorManager.warning,
              colors,
              onPressed: () {
                // TODO: Show bump job dialog/screen
              },
            ),
            SizedBox(height: 12.h),

            // Invite Applicants Button
            _buildFullWidthButton(
              'Invite Applicants',
              Icons.person_add_outlined,
              ColorManager.success,
              colors,
              onPressed: () {
                // TODO: Navigate to Invite Applicants screen
              },
            ),
            SizedBox(height: 12.h),

            // Edit Job Button
            _buildFullWidthButton(
              'Edit Job',
              Icons.edit_outlined,
              ColorManager.info,
              colors,
              onPressed: _navigateToEditJob,
            ),
            SizedBox(height: 12.h),

            // Share Button
            _buildFullWidthButton(
              'Share Post',
              Icons.share_outlined,
              ColorManager.primary,
              colors,
              onPressed: () => _shareJob(),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon, Color iconColor, ThemeHelper colors) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: iconColor),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.regular,
                  color: colors.textSecondary,
                ),
              ),
              Text(
                value,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, ThemeHelper colors) {
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
        Text(
          value,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.semiBold,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color valueColor, ThemeHelper colors) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.grey6,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colors.grey5),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s24,
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
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _shareJob() async {
    try {
      final shareText = '''
${_currentJob.title}

Salary: ${_currentJob.salaryRange}
Location: ${_currentJob.location}

Posted on: ${DateFormat('dd MMM yyyy').format(_currentJob.postedOn)}
Expires on: ${DateFormat('dd MMM yyyy').format(_currentJob.expiresOn)}

Posted by: ${_currentJob.postedBy}

Apply now on Do Connect!
''';

      await Share.share(
        shareText,
        subject: _currentJob.title,
      );
    } catch (e) {
      // Handle share error silently
      debugPrint('Error sharing job: $e');
    }
  }

  Widget _buildFullWidthButton(
    String label,
    IconData icon,
    Color color,
    ThemeHelper colors, {
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.1),
          foregroundColor: color,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(color: color.withValues(alpha: 0.3), width: 1.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20.sp, color: color),
            SizedBox(width: 12.w),
            Text(
              label,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s15,
                fontWeight: FontWeightManager.semiBold,
                color: color,
              ),
            ),
          ],
        ),
      ),
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
