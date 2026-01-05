import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/invoice_model.dart';
import 'invoice_details_modal.dart';

class InvoicesContent extends StatefulWidget {
  const InvoicesContent({super.key});

  @override
  State<InvoicesContent> createState() => _InvoicesContentState();
}

class _InvoicesContentState extends State<InvoicesContent> {
  // Sample data - replace with actual data from BLoC
  final List<InvoiceModel> _invoices = [
    InvoiceModel(
      invoiceNumber: 'INV-2025-014',
      period: 'Aug 25-31, 2025',
      submittedDate: 'Sep 1',
      staffCount: 15,
      totalHours: '368h',
      amount: '\$13,800',
      dueDate: '2025-09-08',
      status: InvoiceStatus.overdue,
      attendanceDates: [],
    ),
    InvoiceModel(
      invoiceNumber: 'INV-2025-013',
      period: 'Nov 26-Dec 2, 2025',
      submittedDate: 'Dec 3',
      staffCount: 19,
      totalHours: '467h',
      amount: '\$17,500',
      dueDate: '2025-12-10',
      status: InvoiceStatus.pending,
      attendanceDates: [
        AttendanceDate(
          date: 'Wednesday, November 5, 2025',
          doerCount: 2,
          hours: '16 hours',
          shifts: 2,
        ),
        AttendanceDate(
          date: 'Tuesday, November 4, 2025',
          doerCount: 3,
          hours: '24 hours',
          shifts: 3,
        ),
        AttendanceDate(
          date: 'Monday, November 3, 2025',
          doerCount: 3,
          hours: '24 hours',
          shifts: 3,
        ),
        AttendanceDate(
          date: 'Sunday, November 2, 2025',
          doerCount: 2,
          hours: '16 hours',
          shifts: 2,
        ),
      ],
    ),
    InvoiceModel(
      invoiceNumber: 'INV-2025-012',
      period: 'Nov 19-25, 2025',
      submittedDate: 'Nov 26',
      staffCount: 17,
      totalHours: '376h',
      amount: '\$14,100',
      dueDate: '2025-12-03',
      status: InvoiceStatus.pending,
      attendanceDates: [],
    ),
    InvoiceModel(
      invoiceNumber: 'INV-2025-011',
      period: 'Nov 12-18, 2025',
      submittedDate: 'Nov 19',
      staffCount: 20,
      totalHours: '448h',
      amount: '\$16,800',
      dueDate: '2025-11-26',
      status: InvoiceStatus.pending,
      attendanceDates: [],
    ),
    InvoiceModel(
      invoiceNumber: 'INV-2025-003',
      period: 'Sep 15-21, 2025',
      submittedDate: 'Sep 22',
      staffCount: 18,
      totalHours: '486h',
      amount: '\$18,200',
      dueDate: '2025-09-29',
      status: InvoiceStatus.paid,
      attendanceDates: [],
    ),
  ];

  String _getTotalAmount() {
    // In real app, calculate from all invoices
    return '\$216,950';
  }

  String _getPendingAmount() {
    // In real app, calculate from pending invoices
    return '\$143,200';
  }

  int _getPendingCount() {
    return _invoices.where((inv) => inv.status == InvoiceStatus.pending).length;
  }

  String _getPaidAmount() {
    // In real app, calculate from paid invoices
    return '\$45,250';
  }

  int _getPaidCount() {
    return _invoices.where((inv) => inv.status == InvoiceStatus.paid).length;
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Modern Summary Cards with Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.primary,
                  colors.primaryDark,
                ],
              ),
            ),
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Total Amount - Large Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: colors.cardBackground.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.account_balance_wallet,
                              size: 24.sp,
                              color: colors.primary,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Amount',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s13,
                                  fontWeight: FontWeightManager.medium,
                                  color: colors.textSecondary,
                                ),
                              ),
                              Text(
                                _getTotalAmount(),
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s28,
                                  fontWeight: FontWeightManager.bold,
                                  color: colors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),

                // Pending and Paid Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildModernSummaryCard(
                        title: 'Pending',
                        amount: _getPendingAmount(),
                        count: _getPendingCount(),
                        icon: Icons.schedule,
                        color: ColorManager.warning,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildModernSummaryCard(
                        title: 'Paid',
                        amount: _getPaidAmount(),
                        count: _getPaidCount(),
                        icon: Icons.check_circle,
                        color: ColorManager.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Invoice History Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invoice History',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.bold,
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  '${_invoices.length} invoices',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.medium,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Invoice List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemCount: _invoices.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final invoice = _invoices[index];
              return _buildModernInvoiceCard(invoice);
            },
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildModernSummaryCard({
    required String title,
    required String amount,
    required int count,
    required IconData icon,
    required Color color,
  }) {
    final colors = ThemeHelper.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.cardBackground.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 20.sp, color: color),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s11,
              fontWeight: FontWeightManager.medium,
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            amount,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            '$count invoices',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s10,
              fontWeight: FontWeightManager.regular,
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernInvoiceCard(InvoiceModel invoice) {
    final colors = ThemeHelper.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.grey4),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _viewInvoiceDetails(invoice),
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            invoice.invoiceNumber,
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s15,
                              fontWeight: FontWeightManager.bold,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          _buildStatusBadge(invoice.status),
                        ],
                      ),
                    ),
                    Text(
                      invoice.amount,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s18,
                        fontWeight: FontWeightManager.bold,
                        color: colors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Details Row
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14.sp, color: colors.textSecondary),
                    SizedBox(width: 6.w),
                    Text(
                      invoice.period,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.regular,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.people_outline, size: 14.sp, color: colors.textSecondary),
                    SizedBox(width: 6.w),
                    Text(
                      '${invoice.staffCount} DOER',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.regular,
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Icon(Icons.access_time, size: 14.sp, color: colors.textSecondary),
                    SizedBox(width: 6.w),
                    Text(
                      invoice.totalHours,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.regular,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Divider
                Divider(color: colors.grey4, height: 1),
                SizedBox(height: 12.h),

                // Action Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.visibility_outlined,
                        label: 'View Details',
                        onTap: () => _viewInvoiceDetails(invoice),
                        isPrimary: true,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.file_download_outlined,
                        label: 'Download',
                        onTap: () => _downloadInvoice(invoice),
                        isPrimary: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    final colors = ThemeHelper.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isPrimary
              ? colors.primary.withValues(alpha: 0.1)
              : colors.grey5,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isPrimary ? colors.primary : colors.grey4,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isPrimary ? colors.primary : colors.textSecondary,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.semiBold,
                color: isPrimary ? colors.primary : colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _viewInvoiceDetails(InvoiceModel invoice) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InvoiceDetailsModal(invoice: invoice),
    );
  }

  void _downloadInvoice(InvoiceModel invoice) {
    // Show download confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.download, color: ColorManager.white, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Downloading ${invoice.invoiceNumber}...',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: ColorManager.success,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );

    // In real app: Implement actual download logic here
    // Example: Download PDF, save to device, etc.
  }

  Widget _buildStatusBadge(InvoiceStatus status) {
    final colors = ThemeHelper.of(context);
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case InvoiceStatus.pending:
        backgroundColor = colors.warning.withValues(alpha: 0.1);
        textColor = colors.warning;
        text = 'pending';
        break;
      case InvoiceStatus.paid:
        backgroundColor = colors.success.withValues(alpha: 0.1);
        textColor = colors.success;
        text = 'paid';
        break;
      case InvoiceStatus.overdue:
        backgroundColor = colors.error.withValues(alpha: 0.1);
        textColor = colors.error;
        text = 'overdue';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: FontConstants.getPoppinsStyle(
          fontSize: FontSize.s10,
          fontWeight: FontWeightManager.semiBold,
          color: textColor,
        ),
      ),
    );
  }
}
