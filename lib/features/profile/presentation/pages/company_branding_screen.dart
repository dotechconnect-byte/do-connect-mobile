import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';

class CompanyBrandingScreen extends StatefulWidget {
  const CompanyBrandingScreen({super.key});

  @override
  State<CompanyBrandingScreen> createState() => _CompanyBrandingScreenState();
}

class _CompanyBrandingScreenState extends State<CompanyBrandingScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _companyNameController = TextEditingController();
  final _industryController = TextEditingController();
  final _companySizeController = TextEditingController();
  final _foundedYearController = TextEditingController();
  final _websiteController = TextEditingController();
  final _aboutCompanyController = TextEditingController();
  final _companyLogoUrlController = TextEditingController();
  final _bannerImageUrlController = TextEditingController();
  final _cultureVideoUrlController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _facebookController = TextEditingController();
  final _twitterController = TextEditingController();
  final _instagramController = TextEditingController();

  // Lists for dynamic fields
  final List<TextEditingController> _perkControllers = [];
  final List<TextEditingController> _valueControllers = [];

  @override
  void dispose() {
    _companyNameController.dispose();
    _industryController.dispose();
    _companySizeController.dispose();
    _foundedYearController.dispose();
    _websiteController.dispose();
    _aboutCompanyController.dispose();
    _companyLogoUrlController.dispose();
    _bannerImageUrlController.dispose();
    _cultureVideoUrlController.dispose();
    _linkedinController.dispose();
    _facebookController.dispose();
    _twitterController.dispose();
    _instagramController.dispose();
    for (var controller in _perkControllers) {
      controller.dispose();
    }
    for (var controller in _valueControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addPerk() {
    setState(() {
      _perkControllers.add(TextEditingController());
    });
  }

  void _removePerk(int index) {
    setState(() {
      _perkControllers[index].dispose();
      _perkControllers.removeAt(index);
    });
  }

  void _addValue() {
    setState(() {
      _valueControllers.add(TextEditingController());
    });
  }

  void _removeValue(int index) {
    setState(() {
      _valueControllers[index].dispose();
      _valueControllers.removeAt(index);
    });
  }

  void _saveCompanyProfile() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement save functionality
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Company profile saved successfully!'),
          backgroundColor: ColorManager.success,
        ),
      );
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
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Company Branding',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                color: colors.cardBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.business,
                            size: 24.sp,
                            color: ColorManager.primary,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Company Branding',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s18,
                                  fontWeight: FontWeightManager.bold,
                                  color: colors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Create an attractive company profile to attract top talent',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeightManager.regular,
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Basic Information
              _buildSection(
                colors,
                'Basic Information',
                Column(
                  children: [
                    _buildTextField(
                      controller: _companyNameController,
                      label: 'Company Name',
                      hint: 'Your Company Name',
                      colors: colors,
                      isRequired: true,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _industryController,
                            label: 'Industry',
                            hint: 'e.g., Technology, Healthcare',
                            colors: colors,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildTextField(
                            controller: _companySizeController,
                            label: 'Company Size',
                            hint: 'e.g., 50-200',
                            colors: colors,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _foundedYearController,
                            label: 'Founded Year',
                            hint: '2020',
                            colors: colors,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildTextField(
                            controller: _websiteController,
                            label: 'Website',
                            hint: 'https://www.yourcompany.com',
                            colors: colors,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      controller: _aboutCompanyController,
                      label: 'About Company',
                      hint: 'Tell candidates about your company, mission, and culture...',
                      colors: colors,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Media & Branding
              _buildSection(
                colors,
                'Media & Branding',
                Column(
                  children: [
                    _buildTextField(
                      controller: _companyLogoUrlController,
                      label: 'Company Logo URL',
                      hint: 'https://',
                      colors: colors,
                      suffixIcon: Icons.download,
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      controller: _bannerImageUrlController,
                      label: 'Banner Image URL',
                      hint: 'https://',
                      colors: colors,
                      suffixIcon: Icons.download,
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      controller: _cultureVideoUrlController,
                      label: 'Culture Video URL (YouTube, Vimeo, etc.)',
                      hint: 'https://youtube.com/...',
                      colors: colors,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Perks & Benefits
              _buildSection(
                colors,
                'Perks & Benefits',
                Column(
                  children: [
                    ..._perkControllers.asMap().entries.map((entry) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: entry.value,
                                label: '',
                                hint: 'e.g., Flexible working hours',
                                colors: colors,
                                showLabel: false,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            IconButton(
                              onPressed: () => _removePerk(entry.key),
                              icon: Icon(
                                Icons.remove_circle,
                                color: ColorManager.error,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _addPerk,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ColorManager.primary,
                          side: BorderSide(
                            color: ColorManager.primary.withValues(alpha: 0.5),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        icon: Icon(Icons.add, size: 20.sp),
                        label: Text(
                          'Add Perk',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Company Values
              _buildSection(
                colors,
                'Company Values',
                Column(
                  children: [
                    ..._valueControllers.asMap().entries.map((entry) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: entry.value,
                                label: '',
                                hint: 'e.g., Innovation, Integrity',
                                colors: colors,
                                showLabel: false,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            IconButton(
                              onPressed: () => _removeValue(entry.key),
                              icon: Icon(
                                Icons.remove_circle,
                                color: ColorManager.error,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _addValue,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ColorManager.primary,
                          side: BorderSide(
                            color: ColorManager.primary.withValues(alpha: 0.5),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        icon: Icon(Icons.add, size: 20.sp),
                        label: Text(
                          'Add Value',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Social Media
              _buildSection(
                colors,
                'Social Media',
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _linkedinController,
                            label: 'LinkedIn',
                            hint: 'https://linkedin.com/company/...',
                            colors: colors,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildTextField(
                            controller: _facebookController,
                            label: 'Facebook',
                            hint: 'https://facebook.com/...',
                            colors: colors,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _twitterController,
                            label: 'Twitter',
                            hint: 'https://twitter.com/...',
                            colors: colors,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildTextField(
                            controller: _instagramController,
                            label: 'Instagram',
                            hint: 'https://instagram.com/...',
                            colors: colors,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Save Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveCompanyProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Save Company Profile',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s15,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(ThemeHelper colors, String title, Widget child) {
    return Container(
      width: double.infinity,
      color: colors.cardBackground,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.bold,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required ThemeHelper colors,
    bool isRequired = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    IconData? suffixIcon,
    bool showLabel = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Row(
            children: [
              Text(
                label,
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.medium,
                  color: colors.textPrimary,
                ),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.error,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
              : null,
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
              borderSide: BorderSide(color: ColorManager.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: ColorManager.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: ColorManager.error, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, size: 20.sp, color: colors.textSecondary)
                : null,
          ),
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.regular,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
