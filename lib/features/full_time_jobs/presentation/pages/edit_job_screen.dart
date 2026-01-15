import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../../data/models/job_model.dart';

class EditJobScreen extends StatefulWidget {
  final JobModel job;

  const EditJobScreen({
    super.key,
    required this.job,
  });

  @override
  State<EditJobScreen> createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _salaryMinController;
  late TextEditingController _salaryMaxController;
  late TextEditingController _locationController;
  late String _locationType;
  late bool _isFeatured;
  late DateTime _expiresOn;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.job.title);

    // Parse salary range
    final salaryParts = widget.job.salaryRange.replaceAll('\$', '').replaceAll(',', '').split('-');
    _salaryMinController = TextEditingController(text: salaryParts.isNotEmpty ? salaryParts[0].trim() : '');
    _salaryMaxController = TextEditingController(text: salaryParts.length > 1 ? salaryParts[1].trim().split(' ')[0] : '');

    _locationController = TextEditingController(text: widget.job.location);
    _locationType = widget.job.locationType;
    _isFeatured = widget.job.isFeatured;
    _expiresOn = widget.job.expiresOn;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _salaryMinController.dispose();
    _salaryMaxController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _saveJob() {
    if (_formKey.currentState!.validate()) {
      // Create updated job model
      final updatedJob = JobModel(
        id: widget.job.id,
        title: _titleController.text,
        salaryRange: '\$${_salaryMinController.text} - \$${_salaryMaxController.text} per year',
        location: _locationController.text,
        locationType: _locationType,
        postedOn: widget.job.postedOn,
        expiresOn: _expiresOn,
        postedBy: widget.job.postedBy,
        previousBump: widget.job.previousBump,
        nextBump: widget.job.nextBump,
        views: widget.job.views,
        applications: widget.job.applications,
        shares: widget.job.shares,
        messages: widget.job.messages,
        saved: widget.job.saved,
        invitations: widget.job.invitations,
        isFeatured: _isFeatured,
        status: widget.job.status,
      );

      // Return the updated job to the previous screen
      Navigator.pop(context, updatedJob);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Job updated successfully'),
          backgroundColor: ColorManager.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _selectExpiryDate() async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _expiresOn.isAfter(DateTime.now()) ? _expiresOn : DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) {
          final colors = ThemeHelper.of(context);
          final isDark = Theme.of(context).brightness == Brightness.dark;

          return Theme(
            data: isDark
              ? ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: ColorManager.primary,
                    onPrimary: Colors.white,
                    surface: colors.cardBackground,
                    onSurface: colors.textPrimary,
                  ),
                  dialogTheme: DialogThemeData(
                    backgroundColor: colors.cardBackground,
                  ),
                )
              : ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: ColorManager.primary,
                    onPrimary: Colors.white,
                    surface: colors.cardBackground,
                    onSurface: colors.textPrimary,
                  ),
                  dialogTheme: DialogThemeData(
                    backgroundColor: colors.cardBackground,
                  ),
                ),
            child: child!,
          );
        },
      );

      if (picked != null && picked != _expiresOn) {
        setState(() {
          _expiresOn = picked;
        });
      }
    } catch (e) {
      debugPrint('Error selecting date: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to select date. Please try again.'),
            backgroundColor: ColorManager.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
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
          icon: Icon(Icons.close, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Job',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
            color: colors.textPrimary,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _saveJob,
            child: Text(
              'Save',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Title
              Text(
                'Job Title',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _titleController,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  color: colors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter job title',
                  hintStyle: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    color: colors.textSecondary,
                  ),
                  filled: true,
                  fillColor: colors.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.grey5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.grey5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: ColorManager.primary, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter job title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),

              // Salary Range
              Text(
                'Salary Range (per year)',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _salaryMinController,
                      keyboardType: TextInputType.number,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        color: colors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Min',
                        prefixText: '\$ ',
                        hintStyle: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s14,
                          color: colors.textSecondary,
                        ),
                        filled: true,
                        fillColor: colors.cardBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: colors.grey5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: colors.grey5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: ColorManager.primary, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      '-',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s18,
                        fontWeight: FontWeightManager.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _salaryMaxController,
                      keyboardType: TextInputType.number,
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        color: colors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Max',
                        prefixText: '\$ ',
                        hintStyle: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s14,
                          color: colors.textSecondary,
                        ),
                        filled: true,
                        fillColor: colors.cardBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: colors.grey5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: colors.grey5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: ColorManager.primary, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Location
              Text(
                'Location',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _locationController,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  color: colors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter location',
                  hintStyle: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    color: colors.textSecondary,
                  ),
                  filled: true,
                  fillColor: colors.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.grey5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.grey5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: ColorManager.primary, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),

              // Location Type
              Text(
                'Location Type',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: colors.cardBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.grey5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _locationType,
                    isExpanded: true,
                    dropdownColor: colors.cardBackground,
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s14,
                      color: colors.textPrimary,
                    ),
                    items: ['Remote', 'On-site', 'Multiple locations'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _locationType = newValue;
                        });
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Expiry Date
              Text(
                'Expiry Date',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              InkWell(
                onTap: _selectExpiryDate,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: colors.grey5),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: colors.textSecondary, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text(
                        DateFormat('dd MMM yyyy').format(_expiresOn),
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s14,
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Featured Toggle
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colors.cardBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.grey5),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: ColorManager.warning, size: 24.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Featured Job',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.semiBold,
                              color: colors.textPrimary,
                            ),
                          ),
                          Text(
                            'Mark this job as featured',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s12,
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _isFeatured,
                      onChanged: (value) {
                        setState(() {
                          _isFeatured = value;
                        });
                      },
                      activeTrackColor: ColorManager.primary,
                      activeThumbColor: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
