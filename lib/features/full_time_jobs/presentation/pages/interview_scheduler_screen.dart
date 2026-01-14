import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';

class InterviewSchedulerScreen extends StatefulWidget {
  const InterviewSchedulerScreen({super.key});

  @override
  State<InterviewSchedulerScreen> createState() =>
      _InterviewSchedulerScreenState();
}

class _InterviewSchedulerScreenState extends State<InterviewSchedulerScreen> {
  String _selectedFilter = 'All';
  List<Map<String, dynamic>> _upcomingInterviews = [];
  final List<Map<String, dynamic>> _pastInterviews = [];

  @override
  void initState() {
    super.initState();
    _upcomingInterviews = _getInitialUpcomingInterviews();
    _pastInterviews.addAll(_getInitialPastInterviews());
  }

  // Sample interview data
  List<Map<String, dynamic>> _getInitialUpcomingInterviews() {
    return [
      {
        'name': 'Sarah Johnson',
        'title': 'Senior React Developer',
        'date': 'Thu, Jan 25',
        'time': '10:00 AM (1 hour)',
        'type': 'Video Interview',
        'interviewers': 'John Doe, Jane Smith',
        'notes': 'Technical round - focus on React and system design',
        'avatar': 'SJ',
        'status': 'scheduled',
        'statusColor': ColorManager.warning,
        'meetingLink': 'Join Meeting',
      },
      {
        'name': 'Michael Chen',
        'title': 'Product Designer',
        'date': 'Thu, Jan 25',
        'time': '2:00 PM (45 minutes)',
        'type': 'In-Person Interview',
        'location': 'Office - Meeting Room 3',
        'interviewers': 'Alice Wong',
        'notes': 'Portfolio review',
        'avatar': 'MC',
        'status': 'scheduled',
        'statusColor': ColorManager.warning,
      },
      {
        'name': 'Emma Wilson',
        'title': 'Marketing Manager',
        'date': 'Fri, Jan 26',
        'time': '11:00 AM (1 hour)',
        'type': 'Video Interview',
        'interviewers': 'Bob Lee, Carol Tan',
        'notes': '',
        'avatar': 'EW',
        'status': 'scheduled',
        'statusColor': ColorManager.warning,
        'meetingLink': 'Join Meeting',
      },
    ];
  }

  List<Map<String, dynamic>> _getInitialPastInterviews() {
    return [
      {
        'name': 'David Lee',
        'title': 'DevOps Engineer',
        'date': 'Sat, Jan 20',
        'time': '3:00 PM (1 hour)',
        'type': 'Video Interview',
        'interviewers': 'Tom Chen',
        'notes': 'Strong technical skills, good culture fit',
        'avatar': 'DL',
        'status': 'completed',
        'statusColor': ColorManager.success,
        'meetingLink': 'Join Meeting',
      },
    ];
  }

  void _addNewInterview(Map<String, dynamic> interview) {
    setState(() {
      _upcomingInterviews.insert(0, interview);
    });
  }

  void _updateInterview(int index, Map<String, dynamic> updatedInterview) {
    setState(() {
      _upcomingInterviews[index] = updatedInterview;
    });
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Interview Scheduler',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: colors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: ColorManager.primary),
            onPressed: () {
              _showScheduleInterviewBottomSheet(context, colors);
            },
            tooltip: 'Schedule Interview',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Tabs
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            color: colors.cardBackground,
            child: Row(
              children: [
                _buildFilterTab('All', colors),
                SizedBox(width: 8.w),
                _buildFilterTab('Upcoming', colors),
                SizedBox(width: 8.w),
                _buildFilterTab('Past', colors),
              ],
            ),
          ),

          // Interview List
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                if (_selectedFilter == 'All' || _selectedFilter == 'Upcoming') ...[
                  Text(
                    'Upcoming Interviews (${_upcomingInterviews.length})',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ..._upcomingInterviews.asMap().entries.map((entry) {
                    return _buildInterviewCard(entry.value, colors, entry.key, true);
                  }),
                ],
                if (_selectedFilter == 'All') SizedBox(height: 24.h),
                if (_selectedFilter == 'All' || _selectedFilter == 'Past') ...[
                  Text(
                    'Past Interviews',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ..._pastInterviews.asMap().entries.map((entry) {
                    return _buildInterviewCard(entry.value, colors, entry.key, false);
                  }),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label, ThemeHelper colors) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : colors.grey6,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? ColorManager.primary : colors.grey4,
          ),
        ),
        child: Text(
          label,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.medium,
            color: isSelected ? Colors.white : colors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildInterviewCard(
      Map<String, dynamic> interview,
      ThemeHelper colors,
      int index,
      bool isFromUpcomingList) {
    final isUpcoming = interview['status'] == 'scheduled';

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isUpcoming
              ? ColorManager.warning.withValues(alpha: 0.3)
              : ColorManager.success.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Status Badge
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isUpcoming
                    ? [
                        ColorManager.warning.withValues(alpha: 0.15),
                        ColorManager.warning.withValues(alpha: 0.05),
                      ]
                    : [
                        ColorManager.success.withValues(alpha: 0.15),
                        ColorManager.success.withValues(alpha: 0.05),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorManager.primary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    interview['avatar'],
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s16,
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
                        interview['name'],
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        interview['title'],
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.regular,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: interview['statusColor'],
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: interview['statusColor'].withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    isUpcoming ? 'Scheduled' : 'Completed',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s11,
                      fontWeight: FontWeightManager.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Interview Details
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date & Time Card
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: ColorManager.primary.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: ColorManager.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.calendar_today,
                          size: 18.sp,
                          color: ColorManager.primary,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              interview['date'],
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 14.sp,
                                  color: colors.textSecondary,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  interview['time'],
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.medium,
                                    color: colors.textSecondary,
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
                SizedBox(height: 12.h),

                // Interview Type & Location
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: colors.grey6,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: interview['type'] == 'Video Interview'
                                  ? ColorManager.success.withValues(alpha: 0.1)
                                  : ColorManager.warning.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Icon(
                              interview['type'] == 'Video Interview'
                                  ? Icons.videocam
                                  : Icons.location_on,
                              size: 16.sp,
                              color: interview['type'] == 'Video Interview'
                                  ? ColorManager.success
                                  : ColorManager.warning,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            interview['type'],
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s13,
                              fontWeight: FontWeightManager.semiBold,
                              color: colors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      if (interview['location'] != null) ...[
                        SizedBox(height: 8.h),
                        Divider(height: 1, color: colors.grey4),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(Icons.place, size: 16.sp, color: colors.textSecondary),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                interview['location'],
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s13,
                                  fontWeight: FontWeightManager.regular,
                                  color: colors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 12.h),

                // Interviewers
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.people, size: 16.sp, color: colors.textSecondary),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Interviewers: ${interview['interviewers']}',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.regular,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),

                // Notes
                if (interview['notes'] != null && interview['notes'].isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: colors.grey6,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      interview['notes'],
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.regular,
                        color: colors.textSecondary,
                      ).copyWith(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Action Buttons
          if (isUpcoming)
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Column(
                children: [
                  // Primary Action - Join Meeting (if video interview)
                  if (interview['meetingLink'] != null)
                    Container(
                      width: double.infinity,
                      height: 48.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            ColorManager.success,
                            Color(0xFF2ECC71),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.success.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Join meeting functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        icon: Icon(Icons.videocam, size: 20.sp),
                        label: Text(
                          'Join Meeting',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ),
                    ),
                  if (interview['meetingLink'] != null) SizedBox(height: 10.h),

                  // Secondary Actions Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 44.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: ColorManager.primary.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                          ),
                          child: OutlinedButton.icon(
                            onPressed: () {
                              _showScheduleInterviewBottomSheet(
                                context,
                                colors,
                                existingInterview: interview,
                                interviewIndex: index,
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: ColorManager.primary,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            icon: Icon(Icons.edit_calendar, size: 18.sp),
                            label: Text(
                              'Reschedule',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s13,
                                fontWeight: FontWeightManager.semiBold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Container(
                          height: 44.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: ColorManager.error.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                          ),
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Cancel functionality
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: ColorManager.error,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            icon: Icon(Icons.close, size: 18.sp),
                            label: Text(
                              'Cancel',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s13,
                                fontWeight: FontWeightManager.semiBold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showScheduleInterviewBottomSheet(
    BuildContext context,
    ThemeHelper colors, {
    Map<String, dynamic>? existingInterview,
    int? interviewIndex,
  }) {
    final isEditing = existingInterview != null;

    // Pre-populate controllers if editing
    final candidateController = TextEditingController(
      text: existingInterview?['name'] ?? '',
    );
    final positionController = TextEditingController(
      text: existingInterview?['title'] ?? '',
    );
    final interviewersController = TextEditingController(
      text: existingInterview?['interviewers'] ?? '',
    );
    final locationController = TextEditingController(
      text: existingInterview?['meetingLink'] ?? existingInterview?['location'] ?? '',
    );
    final notesController = TextEditingController(
      text: existingInterview?['notes'] ?? '',
    );

    // Pre-populate dropdowns and date/time if editing
    String selectedType = existingInterview?['type'] ?? 'Select type';
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    String selectedDuration = 'Select duration';

    // Parse existing date and time if editing
    if (isEditing && existingInterview!['time'] != null) {
      final timeString = existingInterview['time'] as String;
      // Extract duration from time string like "10:00 AM (1 hour)"
      final durationMatch = RegExp(r'\(([^)]+)\)').firstMatch(timeString);
      if (durationMatch != null) {
        selectedDuration = durationMatch.group(1)!;
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: colors.cardBackground,
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
                  border: Border(
                    bottom: BorderSide(color: colors.grey5),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      isEditing ? 'Update Interview' : 'Schedule New Interview',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s18,
                        fontWeight: FontWeightManager.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.close, color: colors.textPrimary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Form Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Candidate & Position Row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Candidate *',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s13,
                                    fontWeight: FontWeightManager.medium,
                                    color: colors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                _buildTextField(
                                  candidateController,
                                  'Enter candidate name',
                                  colors,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Position *',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s13,
                                    fontWeight: FontWeightManager.medium,
                                    color: colors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                _buildTextField(
                                  positionController,
                                  'Enter position',
                                  colors,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Interview Type
                      Text(
                        'Interview Type *',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.medium,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildDropdownField(
                        selectedType,
                        ['Select type', 'Video Interview', 'In-Person Interview', 'Phone Interview'],
                        (value) {
                          if (value != null) {
                            setModalState(() => selectedType = value);
                          }
                        },
                        colors,
                      ),
                      SizedBox(height: 16.h),

                      // Date & Time Row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date *',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s13,
                                    fontWeight: FontWeightManager.medium,
                                    color: colors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                InkWell(
                                  onTap: () async {
                                    final DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(const Duration(days: 365)),
                                    );
                                    if (picked != null) {
                                      setModalState(() => selectedDate = picked);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                                    decoration: BoxDecoration(
                                      color: colors.grey6,
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(color: colors.grey4),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_today, size: 16.sp, color: colors.textSecondary),
                                        SizedBox(width: 8.w),
                                        Text(
                                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                          style: FontConstants.getPoppinsStyle(
                                            fontSize: FontSize.s13,
                                            fontWeight: FontWeightManager.regular,
                                            color: colors.textPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time *',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s13,
                                    fontWeight: FontWeightManager.medium,
                                    color: colors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                InkWell(
                                  onTap: () async {
                                    final TimeOfDay? picked = await showTimePicker(
                                      context: context,
                                      initialTime: selectedTime,
                                    );
                                    if (picked != null) {
                                      setModalState(() => selectedTime = picked);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                                    decoration: BoxDecoration(
                                      color: colors.grey6,
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(color: colors.grey4),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.access_time, size: 16.sp, color: colors.textSecondary),
                                        SizedBox(width: 8.w),
                                        Text(
                                          selectedTime.format(context),
                                          style: FontConstants.getPoppinsStyle(
                                            fontSize: FontSize.s13,
                                            fontWeight: FontWeightManager.regular,
                                            color: colors.textPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Duration
                      Text(
                        'Duration *',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.medium,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildDropdownField(
                        selectedDuration,
                        ['Select duration', '30 minutes', '45 minutes', '1 hour', '1.5 hours', '2 hours'],
                        (value) {
                          if (value != null) {
                            setModalState(() => selectedDuration = value);
                          }
                        },
                        colors,
                      ),
                      SizedBox(height: 16.h),

                      // Interviewers
                      Text(
                        'Interviewers *',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.medium,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildTextField(
                        interviewersController,
                        'Enter interviewer names (e.g., John Doe, Jane Smith)',
                        colors,
                      ),
                      SizedBox(height: 16.h),

                      // Location / Meeting Link (only for Video Interview)
                      if (selectedType == 'Video Interview') ...[
                        Text(
                          'Meeting Link *',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s13,
                            fontWeight: FontWeightManager.medium,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _buildTextField(
                          locationController,
                          'Enter video meeting link',
                          colors,
                        ),
                        SizedBox(height: 16.h),
                      ] else if (selectedType == 'In-Person Interview') ...[
                        Text(
                          'Location *',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s13,
                            fontWeight: FontWeightManager.medium,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _buildTextField(
                          locationController,
                          'Enter office location (e.g., Office - Meeting Room 3)',
                          colors,
                        ),
                        SizedBox(height: 16.h),
                      ],

                      // Notes
                      Text(
                        'Notes',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.medium,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: notesController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Add any notes or instructions for the interview...',
                          hintStyle: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s13,
                            fontWeight: FontWeightManager.regular,
                            color: colors.textSecondary,
                          ),
                          filled: true,
                          fillColor: colors.grey6,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(color: colors.grey4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(color: colors.grey4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        ),
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.regular,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),

              // Bottom Actions
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: colors.cardBackground,
                  border: Border(
                    top: BorderSide(color: colors.grey5),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.textPrimary,
                          side: BorderSide(color: colors.grey4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        child: Text(
                          'Cancel',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate fields
                          if (candidateController.text.isEmpty ||
                              positionController.text.isEmpty ||
                              selectedType == 'Select type' ||
                              selectedDuration == 'Select duration' ||
                              interviewersController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all required fields'),
                                backgroundColor: ColorManager.error,
                              ),
                            );
                            return;
                          }

                          // Check location/meeting link for video and in-person interviews
                          if ((selectedType == 'Video Interview' || selectedType == 'In-Person Interview') &&
                              locationController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(selectedType == 'Video Interview'
                                    ? 'Please enter meeting link'
                                    : 'Please enter location'),
                                backgroundColor: ColorManager.error,
                              ),
                            );
                            return;
                          }

                          // Get avatar initials from candidate name
                          final nameParts = candidateController.text.trim().split(' ');
                          final avatar = nameParts.length >= 2
                              ? '${nameParts[0][0]}${nameParts[1][0]}'
                              : nameParts[0].substring(0, nameParts[0].length >= 2 ? 2 : 1);

                          // Format date
                          final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                          final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                          final formattedDate = '${days[selectedDate.weekday % 7]}, ${months[selectedDate.month - 1]} ${selectedDate.day}';

                          // Format time
                          final formattedTime = '${selectedTime.format(context)} (${selectedDuration.replaceAll('Select duration', '1 hour')})';

                          // Create new interview
                          final newInterview = {
                            'name': candidateController.text.trim(),
                            'title': positionController.text.trim(),
                            'date': formattedDate,
                            'time': formattedTime,
                            'type': selectedType,
                            'interviewers': interviewersController.text.trim(),
                            'notes': notesController.text.trim(),
                            'avatar': avatar.toUpperCase(),
                            'status': 'scheduled',
                            'statusColor': ColorManager.warning,
                            if (selectedType == 'Video Interview')
                              'meetingLink': locationController.text.trim(),
                            if (selectedType == 'In-Person Interview')
                              'location': locationController.text.trim(),
                          };

                          // Add to list or update existing
                          if (isEditing && interviewIndex != null) {
                            _updateInterview(interviewIndex, newInterview);
                          } else {
                            _addNewInterview(newInterview);
                          }

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isEditing
                                  ? 'Interview updated successfully!'
                                  : 'Interview scheduled successfully!'),
                              backgroundColor: ColorManager.success,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        child: Text(
                          isEditing ? 'Update Interview' : 'Schedule Interview',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
    ThemeHelper colors,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: colors.grey6,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.grey4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: colors.textSecondary),
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.regular,
            color: colors.textPrimary,
          ),
          dropdownColor: colors.cardBackground,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.regular,
                  color: item == value && item.startsWith('Select')
                      ? colors.textSecondary
                      : colors.textPrimary,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    ThemeHelper colors,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: FontConstants.getPoppinsStyle(
          fontSize: FontSize.s13,
          fontWeight: FontWeightManager.regular,
          color: colors.textSecondary,
        ),
        filled: true,
        fillColor: colors.grey6,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: colors.grey4),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: colors.grey4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: ColorManager.primary),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      ),
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s13,
        fontWeight: FontWeightManager.regular,
        color: colors.textPrimary,
      ),
    );
  }
}
