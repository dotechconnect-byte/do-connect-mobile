import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/job_model.dart';
import '../pages/job_details_screen.dart';
import 'job_card.dart';

class FullTimeJobsContent extends StatefulWidget {
  final String selectedTab;
  final String searchQuery;
  final String selectedPoster;
  final String selectedLocation;
  final String selectedSort;
  final VoidCallback? onClearFilters;

  const FullTimeJobsContent({
    super.key,
    required this.selectedTab,
    required this.searchQuery,
    required this.selectedPoster,
    required this.selectedLocation,
    required this.selectedSort,
    this.onClearFilters,
  });

  @override
  State<FullTimeJobsContent> createState() => _FullTimeJobsContentState();
}

class _FullTimeJobsContentState extends State<FullTimeJobsContent> {
  late List<JobModel> _jobs;

  @override
  void initState() {
    super.initState();
    _jobs = _getInitialJobs();
  }

  List<JobModel> _getInitialJobs() {
    return [
      JobModel(
        id: '1',
        title: 'Event Coordinator - Full Time',
        salaryRange: '\$50,000 - 60,000 per year',
        location: 'New York, NY',
        locationType: 'On-site',
        postedOn: DateTime(2025, 10, 18, 10, 30),
        expiresOn: DateTime(2025, 11, 18, 10, 30),
        postedBy: 'Admin',
        previousBump: 'Not set',
        nextBump: '22 Oct 2025, 10:00 AM',
        views: 45,
        applications: 3,
        shares: 1,
        messages: 0,
        saved: 2,
        invitations: 0,
        isFeatured: false,
        status: 'scheduled',
      ),
      JobModel(
        id: '2',
        title: 'Software Engineer - React & Node.js',
        salaryRange: '\$90,000 - 120,000 per year',
        location: 'Austin, TX',
        locationType: 'On-site',
        postedOn: DateTime(2025, 10, 22, 15, 0),
        expiresOn: DateTime(2025, 11, 22, 15, 0),
        postedBy: 'Tech Team',
        previousBump: 'Not set',
        nextBump: '25 Oct 2025, 09:00 AM',
        views: 78,
        applications: 5,
        shares: 3,
        messages: 0,
        saved: 8,
        invitations: 0,
        isFeatured: true,
        status: 'active',
      ),
      JobModel(
        id: '3',
        title: 'PART-TIME SERVER ROLE! ⭐ EARN UP TO : \$1000/WEEK,\$200/DAY! (FAST-PACED, FLEXIBLE SHIFTS)',
        salaryRange: '\$15.00 - 20.00 per hour',
        location: 'Multiple locations',
        locationType: 'Multiple locations',
        postedOn: DateTime(2025, 10, 20, 13, 45),
        expiresOn: DateTime(2025, 11, 17, 13, 45),
        postedBy: 'Bib',
        previousBump: '21 Oct 2025, 01:21 PM',
        nextBump: 'Not set',
        views: 287,
        applications: 12,
        shares: 4,
        messages: 0,
        saved: 10,
        invitations: 0,
        isFeatured: true,
        status: 'active',
      ),
      JobModel(
        id: '4',
        title: 'HOSPITALITY PROFESSIONAL (EARN \$200/DAY)',
        salaryRange: '\$15.00 - 20.00 per hour',
        location: 'Multiple locations',
        locationType: 'Multiple locations',
        postedOn: DateTime(2025, 10, 15, 14, 59),
        expiresOn: DateTime(2025, 11, 15, 14, 59),
        postedBy: 'Bib',
        previousBump: 'Not set',
        nextBump: 'Not set',
        views: 156,
        applications: 8,
        shares: 2,
        messages: 0,
        saved: 5,
        invitations: 0,
        isFeatured: true,
        status: 'active',
      ),
      JobModel(
        id: '5',
        title: 'Customer Service Representative',
        salaryRange: '\$18.00 - 22.00 per hour',
        location: 'Remote',
        locationType: 'Remote',
        postedOn: DateTime(2025, 9, 1, 9, 0),
        expiresOn: DateTime(2025, 10, 1, 9, 0),
        postedBy: 'HR Team',
        previousBump: '15 Sep 2025, 02:00 PM',
        nextBump: 'Not set',
        views: 523,
        applications: 45,
        shares: 12,
        messages: 3,
        saved: 28,
        invitations: 5,
        isFeatured: false,
        status: 'expired',
      ),
      JobModel(
        id: '6',
        title: 'Marketing Manager - Full Time Position',
        salaryRange: '\$70,000 - 85,000 per year',
        location: 'San Francisco, CA',
        locationType: 'On-site',
        postedOn: DateTime(2025, 9, 10, 11, 0),
        expiresOn: DateTime(2025, 10, 10, 11, 0),
        postedBy: 'Admin',
        previousBump: 'Not set',
        nextBump: 'Not set',
        views: 312,
        applications: 23,
        shares: 8,
        messages: 1,
        saved: 15,
        invitations: 2,
        isFeatured: false,
        status: 'expired',
      ),
    ];
  }

  void _updateJob(JobModel updatedJob) {
    setState(() {
      final index = _jobs.indexWhere((job) => job.id == updatedJob.id);
      if (index != -1) {
        _jobs[index] = updatedJob;
      }
    });
  }

  List<JobModel> _getFilteredJobs() {
    final allJobs = _jobs;

    // Filter by tab (status)
    var filteredJobs = allJobs.where((job) {
      return job.status == widget.selectedTab.toLowerCase();
    }).toList();

    // Filter by search query
    if (widget.searchQuery.isNotEmpty) {
      filteredJobs = filteredJobs.where((job) {
        return job.title.toLowerCase().contains(widget.searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by poster
    if (widget.selectedPoster != 'All Posters') {
      filteredJobs = filteredJobs.where((job) {
        return job.postedBy == widget.selectedPoster;
      }).toList();
    }

    // Filter by location
    if (widget.selectedLocation != 'All Locations') {
      filteredJobs = filteredJobs.where((job) {
        return job.location.contains(widget.selectedLocation) ||
            job.locationType == widget.selectedLocation;
      }).toList();
    }

    // Sort
    switch (widget.selectedSort) {
      case 'Most recent':
        filteredJobs.sort((a, b) => b.postedOn.compareTo(a.postedOn));
        break;
      case 'Oldest first':
        filteredJobs.sort((a, b) => a.postedOn.compareTo(b.postedOn));
        break;
      case 'Most views':
        filteredJobs.sort((a, b) => b.views.compareTo(a.views));
        break;
      case 'Most applications':
        filteredJobs.sort((a, b) => b.applications.compareTo(a.applications));
        break;
    }

    return filteredJobs;
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);
    final filteredJobs = _getFilteredJobs();

    if (filteredJobs.isEmpty) {
      return _buildEmptyState(colors, widget.onClearFilters);
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: filteredJobs.length,
      itemBuilder: (context, index) {
        return JobCard(
          job: filteredJobs[index],
          onTap: () async {
            final updatedJob = await Navigator.push<JobModel>(
              context,
              MaterialPageRoute(
                builder: (context) => JobDetailsScreen(job: filteredJobs[index]),
              ),
            );

            if (updatedJob != null) {
              _updateJob(updatedJob);
            }
          },
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeHelper colors, VoidCallback? onClearFilters) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80.sp,
            color: colors.grey3,
          ),
          SizedBox(height: 16.h),
          Text(
            'No jobs found',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your filters or search criteria',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
              color: colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: onClearFilters,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.grey6,
              foregroundColor: colors.textPrimary,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
                side: BorderSide(color: colors.grey4),
              ),
            ),
            child: Text(
              'Clear Filters',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
