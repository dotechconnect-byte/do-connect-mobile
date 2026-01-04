import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/attendance_model.dart';

class AttendanceDetailModal extends StatefulWidget {
  final AttendanceModel attendance;

  const AttendanceDetailModal({
    super.key,
    required this.attendance,
  });

  @override
  State<AttendanceDetailModal> createState() => _AttendanceDetailModalState();
}

class _AttendanceDetailModalState extends State<AttendanceDetailModal> {
  final TextEditingController _commentsController = TextEditingController();

  int _attitudeRating = 0;
  int _knowledgeRating = 0;
  int _attireRating = 0;

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
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
              color: ColorManager.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              border: Border(
                bottom: BorderSide(color: ColorManager.grey4, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.attendance.name,
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s18,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Shift: ${widget.attendance.shift}  •  ${widget.attendance.location}  •  ${widget.attendance.station}',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s11,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textSecondary,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 24.sp, color: ColorManager.textPrimary),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.all(8.w),
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
                  // Quick Actions
                  _buildSectionHeader('Quick Actions'),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      _buildActionChip(Icons.chat_bubble_outline, 'Chat'),
                      _buildActionChip(Icons.autorenew, 'Request Replacement', isOrange: true),
                      _buildActionChip(Icons.pending, 'Processing'),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Time Tracking
                  _buildSectionHeader('Time Tracking'),
                  SizedBox(height: 12.h),

                  // 1. Actual Shift Time
                  _buildTimeSection(
                    '1. Actual Shift Time',
                    [
                      _buildTimeRow('08:00 AM', '04:00 PM'),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // 2. QR Scan Time
                  _buildTimeSection(
                    '2. QR Scan Time',
                    [
                      _buildInfoRow('Scan In:', '08:00', const Color(0xFF10B981)),
                      _buildInfoRow('Scan Out:', 'Not scanned', ColorManager.textSecondary),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // 3. Sign-In/Out Time
                  _buildTimeSection(
                    '3. Sign-In/Out Time (Backend)',
                    [
                      _buildInfoRow('Sign In:', 'Not signed in', ColorManager.textSecondary),
                      _buildInfoRow('Sign Out:', 'Not signed out', ColorManager.textSecondary),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Break Time
                  _buildTimeSection(
                    'Break Time',
                    [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.grey3),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '00:30',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Total Hours Worked
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4ED),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: const Color(0xFFFFE5DC)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Hours Worked',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s13,
                                  fontWeight: FontWeightManager.semiBold,
                                  color: ColorManager.textPrimary,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Calculated from Sign In/Out time minus break',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s10,
                                  fontWeight: FontWeightManager.regular,
                                  color: ColorManager.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '8h',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s24,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Assignments Section
                  _buildSectionHeader('Assignments'),
                  SizedBox(height: 12.h),
                  _buildDropdownButton(Icons.calendar_today, 'Assign Event'),

                  SizedBox(height: 24.h),

                  // Rate DOER Performance
                  _buildSectionHeader('Rate DOER Performance'),
                  SizedBox(height: 12.h),
                  _buildRatingRow('Attitude (1-5)', _attitudeRating, (rating) {
                    setState(() => _attitudeRating = rating);
                  }),
                  SizedBox(height: 12.h),
                  _buildRatingRow('Knowledge (1-5)', _knowledgeRating, (rating) {
                    setState(() => _knowledgeRating = rating);
                  }),
                  SizedBox(height: 12.h),
                  _buildRatingRow('Attire (1-5)', _attireRating, (rating) {
                    setState(() => _attireRating = rating);
                  }),

                  SizedBox(height: 16.h),

                  // Comments
                  Text(
                    'Comments',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.medium,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _commentsController,
                    maxLines: 4,
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Add performance notes...',
                      hintStyle: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManager.grey3,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: ColorManager.grey3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: ColorManager.grey3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: ColorManager.primary, width: 2),
                      ),
                      contentPadding: EdgeInsets.all(12.w),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Save Rating Button
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Rating saved successfully'),
                            backgroundColor: const Color(0xFF10B981),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Save Rating',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s15,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 100.h), // Extra padding for scroll
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s15,
        fontWeight: FontWeightManager.bold,
        color: ColorManager.textPrimary,
      ),
    );
  }

  Widget _buildActionChip(IconData icon, String label, {bool isOrange = false}) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label clicked'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isOrange ? ColorManager.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isOrange ? ColorManager.primary : ColorManager.grey3,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isOrange ? ColorManager.white : ColorManager.textPrimary,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.semiBold,
                color: isOrange ? ColorManager.white : ColorManager.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.medium,
            color: ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        ...children,
      ],
    );
  }

  Widget _buildTimeRow(String startTime, String endTime) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.grey6,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorManager.grey4),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, size: 18.sp, color: ColorManager.primary),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              startTime,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.textPrimary,
              ),
            ),
          ),
          Text(
            '-',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              endTime,
              textAlign: TextAlign.end,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.access_time, size: 18.sp, color: ColorManager.primary),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color valueColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Text(
            label,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s13,
              fontWeight: FontWeightManager.medium,
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            value,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s13,
              fontWeight: FontWeightManager.semiBold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownButton(IconData icon, String label) {
    return InkWell(
      onTap: () {
        // Handle dropdown
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.grey3),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: ColorManager.textSecondary),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.textSecondary,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, size: 20.sp, color: ColorManager.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(String label, int rating, Function(int) onRatingChanged) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.medium,
                color: ColorManager.textPrimary,
              ),
            ),
          ),
          ...List.generate(5, (index) {
            final starIndex = index + 1;
            return GestureDetector(
              onTap: () => onRatingChanged(starIndex),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Icon(
                  starIndex <= rating ? Icons.star : Icons.star_border,
                  size: 26.sp,
                  color: starIndex <= rating ? const Color(0xFFFFA500) : ColorManager.grey3,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
