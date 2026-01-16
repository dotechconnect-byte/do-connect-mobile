import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/job_model.dart';

class ViewApplicantsScreen extends StatefulWidget {
  final JobModel job;

  const ViewApplicantsScreen({super.key, required this.job});

  @override
  State<ViewApplicantsScreen> createState() => _ViewApplicantsScreenState();
}

class _ViewApplicantsScreenState extends State<ViewApplicantsScreen> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  final String _searchQuery = '';
  late List<Map<String, dynamic>> _applicants;

  @override
  void initState() {
    super.initState();
    _applicants = _getInitialApplicants();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Sample applicant data
  List<Map<String, dynamic>> _getInitialApplicants() {
    return [
      {
        'name': 'Sarah Johnson',
        'status': 'Shortlist',
        'statusColor': ColorManager.info,
        'aiScore': 82,
        'appliedDate': DateTime(2025, 10, 21, 12, 0),
        'experience': '3 years experience',
        'currentRole': 'Server at Restaurant Group Pte Ltd',
        'message':
            'I have over 3 years of experience in fast-paced restaurant environments...',
        'avatar': 'SJ',
      },
      {
        'name': 'Michael Chen',
        'status': 'Pending',
        'statusColor': ColorManager.warning,
        'aiScore': 78,
        'appliedDate': DateTime(2025, 10, 20, 12, 0),
        'experience': '2 years experience',
        'currentRole': 'Waiter at Five Star Hotel',
        'message': 'Enthusiastic about joining your team...',
        'avatar': 'MC',
      },
      {
        'name': 'Emily Wong',
        'status': 'Interview scheduled',
        'statusColor': ColorManager.primary,
        'aiScore': 85,
        'appliedDate': DateTime(2025, 10, 19, 12, 0),
        'experience': '1.5 years experience',
        'currentRole': 'Barista & Server at Cafe Central',
        'message':
            'I am excited about the opportunity to work flexible shifts...',
        'avatar': 'EW',
      },
      {
        'name': 'Jessica Lee',
        'status': 'Rejected',
        'statusColor': ColorManager.error,
        'aiScore': 65,
        'appliedDate': DateTime(2025, 10, 17, 12, 0),
        'experience': '0.5 years experience',
        'currentRole': null,
        'message': 'Looking for part-time opportunities...',
        'avatar': 'JL',
      },
      {
        'name': 'Ryan Kumar',
        'status': 'Hired',
        'statusColor': ColorManager.success,
        'aiScore': 89,
        'appliedDate': DateTime(2025, 10, 16, 12, 0),
        'experience': '4 years experience',
        'currentRole': 'Senior Server at Italian Bistro',
        'message':
            'Experienced server with excellent customer service skills...',
        'avatar': 'RK',
      },
    ];
  }

  void _updateApplicantStatus(int index, String newStatus, Color newColor) {
    setState(() {
      _applicants[index]['status'] = newStatus;
      _applicants[index]['statusColor'] = _getStatusColor(newStatus);
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return ColorManager.warning;
      case 'Shortlist':
        return ColorManager.info;
      case 'Interview scheduled':
        return ColorManager.primary;
      case 'Rejected':
        return ColorManager.error;
      case 'Hired':
        return ColorManager.success;
      default:
        return ColorManager.warning;
    }
  }

  Map<String, int> _getStatusCounts() {
    final counts = {
      'total': _applicants.length,
      'pending': 0,
      'shortlist': 0,
      'interviews': 0,
      'rejected': 0,
      'hired': 0,
    };

    for (var applicant in _applicants) {
      final status = applicant['status'].toString().toLowerCase();
      if (status == 'pending') {
        counts['pending'] = (counts['pending'] ?? 0) + 1;
      } else if (status == 'shortlist') {
        counts['shortlist'] = (counts['shortlist'] ?? 0) + 1;
      } else if (status == 'interview scheduled') {
        counts['interviews'] = (counts['interviews'] ?? 0) + 1;
      } else if (status == 'rejected') {
        counts['rejected'] = (counts['rejected'] ?? 0) + 1;
      } else if (status == 'hired') {
        counts['hired'] = (counts['hired'] ?? 0) + 1;
      }
    }

    return counts;
  }

  List<Map<String, dynamic>> _getFilteredApplicants() {
    var applicants = _applicants;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      applicants =
          applicants.where((applicant) {
            return applicant['name'].toString().toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
          }).toList();
    }

    // Apply status filter
    if (_selectedFilter != 'All') {
      applicants =
          applicants.where((applicant) {
            return applicant['status'] == _selectedFilter;
          }).toList();
    }

    return applicants;
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);
    final filteredApplicants = _getFilteredApplicants();
    final statusCounts = _getStatusCounts();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.cardBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Applicant Management',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
                color: colors.textPrimary,
              ),
            ),
            Text(
              'Review and manage candidates',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s11,
                fontWeight: FontWeightManager.regular,
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Job Info Header
          Container(
            width: double.infinity,
            color: colors.cardBackground,
            padding: EdgeInsets.all(16.w),
            child: Center(
              child: Text(
                widget.job.title,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.bold,
                  color: colors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          // Stats Row
          Container(
            width: double.infinity,
            color: colors.cardBackground,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildStatChip(
                      'Total',
                      '${statusCounts['total']}',
                      colors.textPrimary,
                      colors,
                    ),
                    SizedBox(width: 12.w),
                    _buildStatChip(
                      'Pending',
                      '${statusCounts['pending']}',
                      ColorManager.warning,
                      colors,
                    ),
                    SizedBox(width: 12.w),
                    _buildStatChip(
                      'Shortlisted',
                      '${statusCounts['shortlist']}',
                      ColorManager.info,
                      colors,
                    ),
                    SizedBox(width: 12.w),
                    _buildStatChip(
                      'Interviews',
                      '${statusCounts['interviews']}',
                      ColorManager.primary,
                      colors,
                    ),
                    SizedBox(width: 12.w),
                    _buildStatChip(
                      'Rejected',
                      '${statusCounts['rejected']}',
                      ColorManager.error,
                      colors,
                    ),
                    SizedBox(width: 12.w),
                    _buildStatChip(
                      'Hired',
                      '${statusCounts['hired']}',
                      ColorManager.success,
                      colors,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Filter and Search Section
          Container(
            color: colors.cardBackground,
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter by Status',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.medium,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: colors.grey6,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: colors.grey4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedFilter,
                      isExpanded: true,
                      dropdownColor: colors.cardBackground,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        color: colors.textPrimary,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'All',
                          child: Text('All Applications (${statusCounts['total']})'),
                        ),
                        DropdownMenuItem(
                          value: 'Pending',
                          child: Text('Pending (${statusCounts['pending']})'),
                        ),
                        DropdownMenuItem(
                          value: 'Shortlist',
                          child: Text('Shortlist (${statusCounts['shortlist']})'),
                        ),
                        DropdownMenuItem(
                          value: 'Interview scheduled',
                          child: Text('Interview scheduled (${statusCounts['interviews']})'),
                        ),
                        DropdownMenuItem(
                          value: 'Rejected',
                          child: Text('Rejected (${statusCounts['rejected']})'),
                        ),
                        DropdownMenuItem(
                          value: 'Hired',
                          child: Text('Hired (${statusCounts['hired']})'),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedFilter = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Applicants List
          Expanded(
            child:
                filteredApplicants.isEmpty
                    ? _buildEmptyState(colors)
                    : ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: filteredApplicants.length,
                      itemBuilder: (context, index) {
                        final applicant = filteredApplicants[index];
                        final originalIndex = _applicants.indexOf(applicant);
                        return _buildApplicantCard(
                          applicant,
                          originalIndex,
                          colors,
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(
    String label,
    String count,
    Color color,
    ThemeHelper colors,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s10,
            fontWeight: FontWeightManager.regular,
            color: colors.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          count,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s20,
            fontWeight: FontWeightManager.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildApplicantCard(
    Map<String, dynamic> applicant,
    int applicantIndex,
    ThemeHelper colors,
  ) {
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
          // Header with name and status
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: ColorManager.primary.withValues(alpha: 0.1),
                  child: Text(
                    applicant['avatar'],
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        applicant['name'],
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.bold,
                          color: colors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: applicant['statusColor'].withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: applicant['statusColor'].withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        child: Text(
                          applicant['status'],
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.semiBold,
                            color: applicant['statusColor'],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Application message
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: colors.grey6,
              border: Border(
                top: BorderSide(color: colors.grey5),
                bottom: BorderSide(color: colors.grey5),
              ),
            ),
            child: Text(
              applicant['message'],
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.regular,
                color: colors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Experience and Date
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(
                  Icons.work_outline,
                  size: 14.sp,
                  color: colors.textSecondary,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    applicant['currentRole'] != null
                        ? '${applicant['currentRole']} • ${applicant['experience']}'
                        : applicant['experience'],
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.regular,
                      color: colors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Status and Action Buttons
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Status Dropdown Button
                Expanded(
                  child: Container(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: applicant['statusColor'].withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: applicant['statusColor'].withValues(alpha: 0.3),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: applicant['status'],
                        isExpanded: true,
                        dropdownColor: colors.cardBackground,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: applicant['statusColor'],
                          size: 20.sp,
                        ),
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.semiBold,
                          color: applicant['statusColor'],
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Pending',
                            child: Row(
                              children: [
                                Container(
                                  width: 8.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.warning,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Pending',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s13,
                                    fontWeight: FontWeightManager.medium,
                                    color: ColorManager.warning,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Shortlist',
                            child: Row(
                              children: [
                                Container(
                                  width: 8.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.info,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Shortlist',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s13,
                                    fontWeight: FontWeightManager.medium,
                                    color: ColorManager.info,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Interview scheduled',
                            child: Row(
                              children: [
                                Container(
                                  width: 8.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Schedule Interview',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s13,
                                    fontWeight: FontWeightManager.medium,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Rejected',
                            child: Row(
                              children: [
                                Container(
                                  width: 8.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.error,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Reject',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s13,
                                    fontWeight: FontWeightManager.medium,
                                    color: ColorManager.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Hired',
                            child: Row(
                              children: [
                                Container(
                                  width: 8.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.success,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Hire',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s13,
                                    fontWeight: FontWeightManager.medium,
                                    color: ColorManager.success,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            _updateApplicantStatus(
                              applicantIndex,
                              newValue,
                              _getStatusColor(newValue),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Chat Button
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: colors.grey6,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: colors.grey4),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // TODO: Open chat
                    },
                    icon: Icon(
                      Icons.chat_bubble_outline,
                      size: 18.sp,
                      color: colors.textPrimary,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(width: 12.w),
                // Schedule Button
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: colors.grey6,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: colors.grey4),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // TODO: Schedule interview
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      size: 18.sp,
                      color: colors.textPrimary,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),

          // Applied date footer
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: colors.grey6,
              border: Border(top: BorderSide(color: colors.grey5)),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: Text(
              'Applied ${DateFormat('MMM dd, yyyy').format(applicant['appliedDate'])} at ${DateFormat('hh:mm a').format(applicant['appliedDate'])}',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s11,
                fontWeight: FontWeightManager.regular,
                color: colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeHelper colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 80.sp, color: colors.grey3),
          SizedBox(height: 16.h),
          Text(
            'No applicants found',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'No one has applied for this position yet',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
              color: colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
