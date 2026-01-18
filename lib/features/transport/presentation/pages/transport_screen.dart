import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/transport_staff_model.dart';
import '../widgets/transport_content.dart';

class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final GlobalKey<TransportContentState> _transportContentKey = GlobalKey<TransportContentState>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddStaffBottomSheet() {
    final nameController = TextEditingController();
    final pickupController = TextEditingController();
    String selectedRegion = 'North';
    TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);
    final notesController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final regions = ['North', 'South', 'East', 'West', 'Central'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final colors = ThemeHelper.of(context);
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Drag Handle
                        Center(
                          child: Container(
                            width: 40.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: colors.grey3,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Header
                        Row(
                          children: [
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                color: ColorManager.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Icons.person_add,
                                color: ColorManager.primary,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Add External Staff',
                                    style: FontConstants.getPoppinsStyle(
                                      fontSize: FontSize.s18,
                                      fontWeight: FontWeightManager.bold,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    'Add staff for transport assignment',
                                    style: FontConstants.getPoppinsStyle(
                                      fontSize: FontSize.s12,
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
                                color: colors.textSecondary,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),

                        // Staff Name
                        Text(
                          'Staff Name',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.medium,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: nameController,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,
                            color: colors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter staff name',
                            hintStyle: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.regular,
                              color: colors.grey2,
                            ),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: colors.grey2,
                              size: 20.sp,
                            ),
                            filled: true,
                            fillColor: colors.grey6,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.grey4),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.grey4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: ColorManager.primary, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(color: ColorManager.error),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter staff name';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16.h),

                        // Region
                        Text(
                          'Region/Zone',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.medium,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: colors.grey6,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: colors.grey4),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedRegion,
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down, color: colors.textSecondary),
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.regular,
                                color: colors.textPrimary,
                              ),
                              dropdownColor: colors.cardBackground,
                              items: regions.map((region) {
                                return DropdownMenuItem(
                                  value: region,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 20.sp,
                                        color: colors.grey2,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(region),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setModalState(() {
                                  selectedRegion = value!;
                                });
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Pick Up/Drop Off Location
                        Text(
                          'Pick Up/Drop Off Location',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.medium,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: pickupController,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,
                            color: colors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'e.g., Station A, Mall B',
                            hintStyle: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.regular,
                              color: colors.grey2,
                            ),
                            prefixIcon: Icon(
                              Icons.pin_drop_outlined,
                              color: colors.grey2,
                              size: 20.sp,
                            ),
                            filled: true,
                            fillColor: colors.grey6,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.grey4),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.grey4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: ColorManager.primary, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(color: ColorManager.error),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter pickup/drop off location';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16.h),

                        // Transport Timing
                        Text(
                          'Transport Timing',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.medium,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        InkWell(
                          onTap: () async {
                            final isDark = Theme.of(context).brightness == Brightness.dark;
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: isDark
                                        ? ColorScheme.dark(
                                            primary: ColorManager.primary,
                                            onPrimary: ColorManager.white,
                                            surface: colors.cardBackground,
                                            onSurface: colors.textPrimary,
                                          )
                                        : ColorScheme.light(
                                            primary: ColorManager.primary,
                                            onPrimary: ColorManager.white,
                                            surface: colors.cardBackground,
                                            onSurface: colors.textPrimary,
                                          ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              setModalState(() {
                                selectedTime = picked;
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                            decoration: BoxDecoration(
                              color: colors.grey6,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: colors.grey4),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: colors.grey2,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  _formatTimeOfDay(selectedTime),
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeightManager.regular,
                                    color: colors.textPrimary,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: colors.textSecondary,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Notes (Optional)
                        Text(
                          'Notes (Optional)',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.medium,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: notesController,
                          maxLines: 2,
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,
                            color: colors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Any special requirements...',
                            hintStyle: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.regular,
                              color: colors.grey2,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 24.h),
                              child: Icon(
                                Icons.note_outlined,
                                color: colors.grey2,
                                size: 20.sp,
                              ),
                            ),
                            filled: true,
                            fillColor: colors.grey6,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.grey4),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: colors.grey4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: ColorManager.primary, width: 2),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Add Staff Button
                        SizedBox(
                          width: double.infinity,
                          height: 52.h,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                // Format time
                                final hour = selectedTime.hourOfPeriod == 0 ? 12 : selectedTime.hourOfPeriod;
                                final minute = selectedTime.minute.toString().padLeft(2, '0');
                                final period = selectedTime.period == DayPeriod.am ? 'AM' : 'PM';
                                final formattedTime = '$hour:$minute $period';

                                // Create new staff
                                final newStaff = TransportStaffModel(
                                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                                  name: nameController.text.trim(),
                                  region: selectedRegion,
                                  pickUpDropOff: pickupController.text.trim(),
                                  transportTiming: formattedTime,
                                  notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
                                );

                                // Add to list
                                _transportContentKey.currentState?.addStaff(newStaff);

                                // Close the bottom sheet
                                Navigator.pop(context);

                                // Show success message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${nameController.text} added successfully',
                                      style: FontConstants.getPoppinsStyle(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeightManager.medium,
                                        color: ColorManager.white,
                                      ),
                                    ),
                                    backgroundColor: ColorManager.success,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    margin: EdgeInsets.all(16.w),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              foregroundColor: ColorManager.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            icon: Icon(Icons.person_add, size: 20.sp),
                            label: Text(
                              'Add Staff',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.semiBold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Transport Management',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.bold,
                color: colors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Zone-based staff assignment',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s11,
                fontWeight: FontWeightManager.regular,
                color: colors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Container(
            color: colors.cardBackground,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: colors.grey6,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: colors.grey4),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search DOER, shifts, invoices...',
                        hintStyle: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.regular,
                          color: colors.textSecondary,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20.sp,
                          color: colors.textSecondary,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  size: 20.sp,
                                  color: colors.textSecondary,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      ),
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.regular,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TransportContent(
        key: _transportContentKey,
        searchQuery: _searchQuery,
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Download List Button
            FloatingActionButton.extended(
              heroTag: 'transport_download_fab',
              onPressed: () {},
              backgroundColor: colors.cardBackground,
              foregroundColor: colors.textPrimary,
              elevation: 2,
              icon: Icon(Icons.download, size: 18.sp),
              label: Text(
                'Download',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.semiBold,
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Add External Staff Button
            FloatingActionButton.extended(
              heroTag: 'transport_add_staff_fab',
              onPressed: _showAddStaffBottomSheet,
              backgroundColor: colors.primary,
              foregroundColor: ColorManager.white,
              elevation: 4,
              icon: Icon(Icons.person_add, size: 18.sp),
              label: Text(
                'Add Staff',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.semiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
