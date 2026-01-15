import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';

class PostNewJobScreen extends StatefulWidget {
  const PostNewJobScreen({super.key});

  @override
  State<PostNewJobScreen> createState() => _PostNewJobScreenState();
}

class _PostNewJobScreenState extends State<PostNewJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _salaryMinController = TextEditingController();
  final _salaryMaxController = TextEditingController();
  final _locationController = TextEditingController();
  final _requirementsController = TextEditingController();

  String _locationType = 'On-site';
  String _employmentType = 'Full-time';
  String _experienceLevel = 'Mid-level';
  bool _isFeatured = false;
  DateTime _expiresOn = DateTime.now().add(const Duration(days: 30));
  bool _isLoading = false;

  final List<String> _locationTypes = ['Remote', 'On-site', 'Hybrid'];
  final List<String> _employmentTypes = ['Full-time', 'Part-time', 'Contract', 'Internship'];
  final List<String> _experienceLevels = ['Entry-level', 'Mid-level', 'Senior', 'Lead', 'Executive'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _salaryMinController.dispose();
    _salaryMaxController.dispose();
    _locationController.dispose();
    _requirementsController.dispose();
    super.dispose();
  }

  Future<void> _selectExpiryDate() async {
    final colors = ThemeHelper.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _expiresOn,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: isDark
              ? ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: ColorManager.primary,
                    onPrimary: Colors.white,
                    surface: colors.cardBackground,
                    onSurface: colors.textPrimary,
                  ),
                )
              : ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: ColorManager.primary,
                    onPrimary: Colors.white,
                    surface: colors.cardBackground,
                    onSurface: colors.textPrimary,
                  ),
                ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _expiresOn) {
      setState(() => _expiresOn = picked);
    }
  }

  void _postJob() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Job posted successfully!',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.medium,
                color: ColorManager.white,
              ),
            ),
            backgroundColor: ColorManager.success,
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
          'Post New Job',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
            color: colors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Job Title
                    _buildSectionLabel('Job Title', colors),
                    SizedBox(height: 8.h),
                    _buildTextField(
                      controller: _titleController,
                      hint: 'e.g. Senior Software Engineer',
                      colors: colors,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter job title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    // Job Description
                    _buildSectionLabel('Job Description', colors),
                    SizedBox(height: 8.h),
                    _buildTextField(
                      controller: _descriptionController,
                      hint: 'Describe the role and responsibilities...',
                      colors: colors,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter job description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    // Employment Type & Experience Level
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionLabel('Employment Type', colors),
                              SizedBox(height: 8.h),
                              _buildDropdown(
                                value: _employmentType,
                                items: _employmentTypes,
                                onChanged: (v) => setState(() => _employmentType = v!),
                                colors: colors,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionLabel('Experience Level', colors),
                              SizedBox(height: 8.h),
                              _buildDropdown(
                                value: _experienceLevel,
                                items: _experienceLevels,
                                onChanged: (v) => setState(() => _experienceLevel = v!),
                                colors: colors,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Salary Range
                    _buildSectionLabel('Salary Range (per year)', colors),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _salaryMinController,
                            hint: 'Min',
                            colors: colors,
                            prefix: '\$ ',
                            keyboardType: TextInputType.number,
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
                          child: _buildTextField(
                            controller: _salaryMaxController,
                            hint: 'Max',
                            colors: colors,
                            prefix: '\$ ',
                            keyboardType: TextInputType.number,
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

                    // Location & Location Type
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionLabel('Location', colors),
                              SizedBox(height: 8.h),
                              _buildTextField(
                                controller: _locationController,
                                hint: 'e.g. New York, NY',
                                colors: colors,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionLabel('Type', colors),
                              SizedBox(height: 8.h),
                              _buildDropdown(
                                value: _locationType,
                                items: _locationTypes,
                                onChanged: (v) => setState(() => _locationType = v!),
                                colors: colors,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Requirements
                    _buildSectionLabel('Requirements', colors),
                    SizedBox(height: 8.h),
                    _buildTextField(
                      controller: _requirementsController,
                      hint: 'List the key requirements for this role...',
                      colors: colors,
                      maxLines: 3,
                    ),
                    SizedBox(height: 20.h),

                    // Expiry Date
                    _buildSectionLabel('Posting Expires On', colors),
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: _selectExpiryDate,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: colors.cardBackground,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: colors.grey5),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: colors.textSecondary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              DateFormat('dd MMM yyyy').format(_expiresOn),
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s14,
                                color: colors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_drop_down,
                              color: colors.textSecondary,
                              size: 24.sp,
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
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: ColorManager.warning.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Icons.star_rounded,
                              color: ColorManager.warning,
                              size: 22.sp,
                            ),
                          ),
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
                                  'Get more visibility (5 coins)',
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
                            onChanged: (value) => setState(() => _isFeatured = value),
                            activeTrackColor: ColorManager.primary,
                            activeThumbColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Coin Cost Info
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: colors.info.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: colors.info.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: colors.info,
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Posting this job will cost ${_isFeatured ? '15' : '10'} coins from your balance.',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s13,
                                color: colors.info,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Bottom Button
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                border: Border(
                  top: BorderSide(color: colors.grey5, width: 1),
                ),
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _postJob,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: ColorManager.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(ColorManager.white),
                            ),
                          )
                        : Text(
                            'Post Job',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s16,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManager.white,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label, ThemeHelper colors) {
    return Text(
      label,
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s14,
        fontWeight: FontWeightManager.semiBold,
        color: colors.textPrimary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required ThemeHelper colors,
    int maxLines = 1,
    String? prefix,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: FontConstants.getPoppinsStyle(
        fontSize: FontSize.s14,
        color: colors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        prefixText: prefix,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorManager.error),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required ThemeHelper colors,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: colors.cardBackground,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s14,
            color: colors.textPrimary,
          ),
          icon: Icon(Icons.arrow_drop_down, color: colors.textSecondary),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
