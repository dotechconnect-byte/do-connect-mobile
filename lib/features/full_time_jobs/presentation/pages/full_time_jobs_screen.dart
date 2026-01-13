import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../widgets/full_time_jobs_content.dart';
import 'talent_pool_screen.dart';

class FullTimeJobsScreen extends StatefulWidget {
  const FullTimeJobsScreen({super.key});

  @override
  State<FullTimeJobsScreen> createState() => _FullTimeJobsScreenState();
}

class _FullTimeJobsScreenState extends State<FullTimeJobsScreen> {
  int _selectedTabIndex = 1; // Default to 'Active' tab
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedPoster = 'All Posters';
  String _selectedLocation = 'All Locations';
  String _selectedSort = 'Most recent';

  final List<String> _tabs = ['Scheduled', 'Active', 'Expired', 'Draft'];
  final List<int> _tabCounts = [2, 2, 1, 0]; // Sample counts

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
      _selectedPoster = 'All Posters';
      _selectedLocation = 'All Locations';
      _selectedSort = 'Most recent';
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Full Time Jobs',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
                color: colors.textPrimary,
              ),
            ),
            Text(
              'Manage your job postings',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s11,
                fontWeight: FontWeightManager.regular,
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.people, color: colors.textPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TalentPoolScreen(),
                ),
              );
            },
            tooltip: 'Talent Pool',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: Container(
            color: colors.cardBackground,
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
            child: Row(
              children: [
                // Balance display - half width
                Expanded(
                  child: Container(
                    height: 44.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: colors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: colors.warning.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 16.sp,
                          color: colors.warning,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Balance',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s11,
                            fontWeight: FontWeightManager.medium,
                            color: colors.textSecondary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '50 coins',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.semiBold,
                            color: colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Post New Job button - half width
                Expanded(
                  child: SizedBox(
                    height: 44.h,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to post new job screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      icon: Icon(
                        Icons.add,
                        size: 18.sp,
                        color: ColorManager.white,
                      ),
                      label: Text(
                        'Post New Job',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Tabs Section
          Container(
            color: colors.cardBackground,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  final isSelected = _selectedTabIndex == index;
                  final count = _tabCounts[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: _buildTabChip(
                      _tabs[index],
                      count,
                      isSelected,
                      () {
                        setState(() => _selectedTabIndex = index);
                      },
                      colors,
                    ),
                  );
                }),
              ),
            ),
          ),

          // Search and Filters Section
          Container(
            color: colors.cardBackground,
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Search field
                  SizedBox(
                    width: 250.w,
                    child: Container(
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: colors.grey6,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: colors.grey4),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() => _searchQuery = value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search jobs by title...',
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
                                    size: 18.sp,
                                    color: colors.textSecondary,
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() => _searchQuery = '');
                                  },
                                )
                              : null,
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
                  ),
                  SizedBox(width: 12.w),

                  // Poster filter dropdown
                  _buildFilterDropdown(
                    _selectedPoster,
                    ['All Posters', 'Admin', 'HR Team', 'Tech Team'],
                    (value) => setState(() => _selectedPoster = value!),
                    colors,
                  ),
                  SizedBox(width: 8.w),

                  // Location filter dropdown
                  _buildFilterDropdown(
                    _selectedLocation,
                    ['All Locations', 'Remote', 'New York, NY', 'Austin, TX', 'San Francisco, CA'],
                    (value) => setState(() => _selectedLocation = value!),
                    colors,
                  ),
                  SizedBox(width: 8.w),

                  // Sort dropdown
                  _buildFilterDropdown(
                    _selectedSort,
                    ['Most recent', 'Oldest first', 'Most views', 'Most applications'],
                    (value) => setState(() => _selectedSort = value!),
                    colors,
                  ),
                  SizedBox(width: 12.w),

                  // Reset filters button
                  TextButton(
                    onPressed: _resetFilters,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    ),
                    child: Text(
                      'Reset Filters',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          Expanded(
            child: FullTimeJobsContent(
              selectedTab: _tabs[_selectedTabIndex],
              searchQuery: _searchQuery,
              selectedPoster: _selectedPoster,
              selectedLocation: _selectedLocation,
              selectedSort: _selectedSort,
              onClearFilters: _resetFilters,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabChip(
    String label,
    int count,
    bool isSelected,
    VoidCallback onTap,
    ThemeHelper colors,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? ColorManager.primary : colors.grey4,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (count > 0) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorManager.white.withValues(alpha: 0.2)
                      : colors.grey5,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  count.toString(),
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s11,
                    fontWeight: FontWeightManager.semiBold,
                    color: isSelected ? ColorManager.white : colors.textSecondary,
                  ),
                ),
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s13,
                fontWeight: isSelected ? FontWeightManager.semiBold : FontWeightManager.medium,
                color: isSelected ? ColorManager.white : colors.textSecondary,
              ),
            ),
          ],
        ),
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
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: colors.grey6,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.grey4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items.map((String item) {
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
}
