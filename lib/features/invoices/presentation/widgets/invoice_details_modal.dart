import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/invoice_model.dart';

class InvoiceDetailsModal extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceDetailsModal({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Invoice Details',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s20,
                              fontWeight: FontWeightManager.bold,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Detailed view of invoice ${invoice.invoiceNumber}',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s13,
                              fontWeight: FontWeightManager.regular,
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
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
                  // Invoice Info Card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: colors.grey4),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow('Invoice Number', invoice.invoiceNumber, colors),
                        SizedBox(height: 12.h),
                        _buildInfoRow('Period', invoice.period, colors),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoColumn('Submitted Date', invoice.submittedDate, colors: colors),
                            ),
                            Expanded(
                              child: _buildInfoColumn('Due Date', invoice.dueDate, colors: colors),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Divider(color: colors.grey4),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoColumn('Total Amount', invoice.amount,
                                  colors: colors, valueColor: colors.primary, valueBold: true),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status',
                                    style: FontConstants.getPoppinsStyle(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeightManager.regular,
                                      color: colors.textSecondary,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  _buildStatusBadge(invoice.status, colors),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoColumn('DOER Count', '${invoice.staffCount} DOER', colors: colors),
                            ),
                            Expanded(
                              child: _buildInfoColumn('Total Hours', invoice.totalHours, colors: colors),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Connected Attendance Dates
                  if (invoice.attendanceDates.isNotEmpty) ...[
                    SizedBox(height: 20.h),
                    Text(
                      'Connected Attendance Dates',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ...invoice.attendanceDates.map((attendance) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _buildAttendanceDateCard(attendance, context),
                      );
                    }),
                  ],

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
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

  Widget _buildInfoColumn(
    String label,
    String value, {
    required ThemeHelper colors,
    Color? valueColor,
    bool valueBold = false,
  }) {
    return Column(
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
        SizedBox(height: 4.h),
        Text(
          value,
          style: FontConstants.getPoppinsStyle(
            fontSize: valueBold ? FontSize.s16 : FontSize.s14,
            fontWeight: valueBold ? FontWeightManager.bold : FontWeightManager.semiBold,
            color: valueColor ?? colors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(InvoiceStatus status, ThemeHelper colors) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case InvoiceStatus.pending:
        backgroundColor = colors.warning.withValues(alpha: 0.1);
        textColor = colors.warning;
        text = 'PENDING';
        break;
      case InvoiceStatus.paid:
        backgroundColor = colors.success.withValues(alpha: 0.1);
        textColor = colors.success;
        text = 'PAID';
        break;
      case InvoiceStatus.overdue:
        backgroundColor = colors.error.withValues(alpha: 0.1);
        textColor = colors.error;
        text = 'OVERDUE';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: FontConstants.getPoppinsStyle(
          fontSize: FontSize.s11,
          fontWeight: FontWeightManager.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildAttendanceDateCard(AttendanceDate attendance, BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.grey6,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Orange Circle Icon
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.circle,
                size: 8.sp,
                color: ColorManager.white,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attendance.date,
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '${attendance.doerCount} DOER • ${attendance.hours} • ${attendance.shifts} shifts',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // View Details Link
          InkWell(
            onTap: () {
              // Close invoice details modal
              Navigator.pop(context);

              // Close invoices screen and return navigation data
              Navigator.pop(context, {
                'action': 'view_attendance',
                'date': attendance.date,
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colors.primary,
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                'View Details',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.semiBold,
                  color: colors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
