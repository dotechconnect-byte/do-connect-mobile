import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/invoice_model.dart';

class InvoiceDetailsModal extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceDetailsModal({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: ColorManager.backgroundColor,
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
              color: ColorManager.white,
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
                    color: ColorManager.grey3,
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
                              color: ColorManager.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Detailed view of invoice ${invoice.invoiceNumber}',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s13,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManager.textSecondary,
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
                        color: ColorManager.textSecondary,
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
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: ColorManager.grey4),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow('Invoice Number', invoice.invoiceNumber),
                        SizedBox(height: 12.h),
                        _buildInfoRow('Period', invoice.period),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoColumn('Submitted Date', invoice.submittedDate),
                            ),
                            Expanded(
                              child: _buildInfoColumn('Due Date', invoice.dueDate),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Divider(color: ColorManager.grey4),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoColumn('Total Amount', invoice.amount,
                                  valueColor: ColorManager.primary, valueBold: true),
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
                                      color: ColorManager.textSecondary,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  _buildStatusBadge(invoice.status),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoColumn('DOER Count', '${invoice.staffCount} DOER'),
                            ),
                            Expanded(
                              child: _buildInfoColumn('Total Hours', invoice.totalHours),
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
                        color: ColorManager.textPrimary,
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.textSecondary,
          ),
        ),
        Text(
          value,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoColumn(
    String label,
    String value, {
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
            color: ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: FontConstants.getPoppinsStyle(
            fontSize: valueBold ? FontSize.s16 : FontSize.s14,
            fontWeight: valueBold ? FontWeightManager.bold : FontWeightManager.semiBold,
            color: valueColor ?? ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(InvoiceStatus status) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case InvoiceStatus.pending:
        backgroundColor = ColorManager.warning.withValues(alpha: 0.1);
        textColor = ColorManager.warning;
        text = 'PENDING';
        break;
      case InvoiceStatus.paid:
        backgroundColor = ColorManager.success.withValues(alpha: 0.1);
        textColor = ColorManager.success;
        text = 'PAID';
        break;
      case InvoiceStatus.overdue:
        backgroundColor = ColorManager.error.withValues(alpha: 0.1);
        textColor = ColorManager.error;
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
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.grey6,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.grey4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Orange Circle Icon
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: ColorManager.primary,
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
                    color: ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '${attendance.doerCount} DOER • ${attendance.hours} • ${attendance.shifts} shifts',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textSecondary,
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
                    color: ColorManager.primary,
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                'View Details',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
