import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';

class TalentPoolScreen extends StatefulWidget {
  const TalentPoolScreen({super.key});

  @override
  State<TalentPoolScreen> createState() => _TalentPoolScreenState();
}

class _TalentPoolScreenState extends State<TalentPoolScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSkills = 'All Skills';
  String _selectedLevel = 'All Levels';
  String _selectedLocation = 'All Locations';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openWhatsApp(String phoneNumber, String talentName) async {
    const platform = MethodChannel('whatsapp_launcher');

    try {
      // Remove any special characters and spaces from phone number
      String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

      // Remove leading + if present for wa.me format
      if (cleanPhone.startsWith('+')) {
        cleanPhone = cleanPhone.substring(1);
      }

      final message =
          'Hi $talentName,\nI found your profile on Do Connect and would like to discuss a job opportunity.';

      await platform.invokeMethod('openWhatsApp', {
        'phone': '918848917803',
        'message': message,
      });
    } on PlatformException catch (e) {
      debugPrint('Platform error: ${e.code} - ${e.message}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not open WhatsApp. Please make sure WhatsApp is installed.',
            ),
            backgroundColor: ColorManager.error,
          ),
        );
      }
    } catch (e) {
      debugPrint('Unexpected error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error opening WhatsApp.'),
            backgroundColor: ColorManager.error,
          ),
        );
      }
    }
  }

  // Sample talent pool data
  List<Map<String, dynamic>> _getTalentPool() {
    return [
      {
        'name': 'Sarah Johnson',
        'title': 'Senior Software Engineer',
        'rating': 4.5,
        'location': 'Singapore',
        'experience': '8 years experience',
        'email': 'sarah.j@email.com',
        'phone': '+65 9123 4567',
        'skills': ['React', 'Node.js', 'TypeScript', 'AWS'],
        'bio': 'Strong candidate, interested in senior roles',
        'lastContact': '1/15/2024',
        'avatar': 'SJ',
        'status': 'Available',
        'statusColor': ColorManager.success,
      },
      {
        'name': 'Michael Chen',
        'title': 'Product Designer',
        'rating': 4.8,
        'location': 'Remote',
        'experience': '5 years experience',
        'email': 'm.chen@email.com',
        'phone': '+65 8234 5678',
        'skills': ['UI/UX', 'Figma', 'Design Systems', 'Prototyping'],
        'bio': 'Excellent portfolio, looking for flexible work',
        'lastContact': '1/20/2024',
        'avatar': 'MC',
        'status': 'Passive',
        'statusColor': ColorManager.warning,
      },
      {
        'name': 'Emma Wilson',
        'title': 'Marketing Manager',
        'rating': 4.3,
        'location': 'Singapore',
        'experience': '6 years experience',
        'email': 'e.wilson@email.com',
        'phone': '+65 9345 6789',
        'skills': ['Digital Marketing', 'SEO', 'Content Strategy', 'Analytics'],
        'bio': 'Great communication skills, B2B experience',
        'lastContact': '1/18/2024',
        'avatar': 'EW',
        'status': 'Available',
        'statusColor': ColorManager.success,
      },
      {
        'name': 'David Lee',
        'title': 'DevOps Engineer',
        'rating': 4.6,
        'location': 'Singapore',
        'experience': '7 years experience',
        'email': 'd.lee@email.com',
        'phone': '+65 8456 7890',
        'skills': ['Kubernetes', 'Docker', 'CI/CD', 'Terraform'],
        'bio': 'Cloud infrastructure expert, AWS certified',
        'lastContact': '1/12/2024',
        'avatar': 'DL',
        'status': 'Contacted',
        'statusColor': ColorManager.info,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);
    final talents = _getTalentPool();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.cardBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Talent Pool',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
                color: colors.textPrimary,
              ),
            ),
            Text(
              'Manage your jobs and find the best talent',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s11,
                fontWeight: FontWeightManager.regular,
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search and Filters Section
          Container(
            color: colors.cardBackground,
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Search bar
                Container(
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: colors.grey6,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: colors.grey4),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name, skills, or title...',
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
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                    ),
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.regular,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                // Filters row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterDropdown(
                        _selectedSkills,
                        [
                          'All Skills',
                          'React',
                          'Node.js',
                          'UI/UX',
                          'Marketing',
                        ],
                        (value) => setState(() => _selectedSkills = value!),
                        colors,
                      ),
                      SizedBox(width: 8.w),
                      _buildFilterDropdown(
                        _selectedLevel,
                        ['All Levels', 'Junior', 'Mid', 'Senior', 'Lead'],
                        (value) => setState(() => _selectedLevel = value!),
                        colors,
                      ),
                      SizedBox(width: 8.w),
                      _buildFilterDropdown(
                        _selectedLocation,
                        [
                          'All Locations',
                          'Remote',
                          'Singapore',
                          'New York',
                          'London',
                        ],
                        (value) => setState(() => _selectedLocation = value!),
                        colors,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Talent Cards
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: talents.length,
              itemBuilder: (context, index) {
                return _buildTalentCard(talents[index], colors);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
    ThemeHelper colors,
  ) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: colors.grey6,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.grey4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items:
              items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeightManager.regular,
                      color: colors.textPrimary,
                    ),
                  ),
                );
              }).toList(),
          onChanged: onChanged,
          icon: Icon(
            Icons.arrow_drop_down,
            color: colors.textSecondary,
            size: 20.sp,
          ),
          dropdownColor: colors.cardBackground,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  Widget _buildTalentCard(Map<String, dynamic> talent, ThemeHelper colors) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: ColorManager.primary.withValues(alpha: 0.1),
                  child: Text(
                    talent['avatar'],
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
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              talent['name'],
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,
                                color: colors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: talent['statusColor'].withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(
                                color: talent['statusColor'].withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            child: Text(
                              talent['status'],
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.semiBold,
                                color: talent['statusColor'],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        talent['title'],
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.regular,
                          color: colors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => Icon(
                              index < talent['rating'].floor()
                                  ? Icons.star
                                  : (index < talent['rating']
                                      ? Icons.star_half
                                      : Icons.star_border),
                              size: 14.sp,
                              color: ColorManager.warning,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${talent['rating']}',
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

          // Contact Info
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: colors.grey6,
              border: Border(
                top: BorderSide(color: colors.grey5),
                bottom: BorderSide(color: colors.grey5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14.sp,
                      color: colors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      talent['location'],
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.regular,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.work_outline,
                      size: 14.sp,
                      color: colors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      talent['experience'],
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.regular,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.email, size: 14.sp, color: colors.textSecondary),
                    SizedBox(width: 4.w),
                    Text(
                      talent['email'],
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.regular,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.phone, size: 14.sp, color: colors.textSecondary),
                    SizedBox(width: 4.w),
                    Text(
                      talent['phone'],
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.regular,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Skills
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children:
                      (talent['skills'] as List<String>).map((skill) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: ColorManager.primary.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ),
                          child: Text(
                            skill,
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s11,
                              fontWeight: FontWeightManager.medium,
                              color: ColorManager.primary,
                            ),
                          ),
                        );
                      }).toList(),
                ),
                SizedBox(height: 12.h),
                Text(
                  talent['bio'],
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: colors.textSecondary,
                  ).copyWith(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),

          // Action Buttons
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await _openWhatsApp(talent['phone'], talent['name']);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorManager.success,
                      side: BorderSide(
                        color: ColorManager.success.withValues(alpha: 0.5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    icon: Icon(
                      Icons.chat,
                      size: 16.sp,
                      color: ColorManager.success,
                    ),
                    label: Text(
                      'WhatsApp',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.success,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Invite to job
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    icon: Icon(Icons.person_add, size: 16.sp),
                    label: Text(
                      'Invite to Job',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.semiBold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
