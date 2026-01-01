import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../widgets/groups_content.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.sp,
            color: ColorManager.textPrimary,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Groups & Users',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.textPrimary,
              ),
            ),
            Text(
              'Manage your staff network',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s11,
                fontWeight: FontWeightManager.regular,
                color: ColorManager.textSecondary,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: ColorManager.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.grey6,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ColorManager.grey4),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search users...',
                  hintStyle: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textSecondary,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20.sp,
                    color: ColorManager.textSecondary,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                          icon: Icon(
                            Icons.clear,
                            size: 18.sp,
                            color: ColorManager.textSecondary,
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManager.textPrimary,
                ),
              ),
            ),
          ),

          // Groups Content
          Expanded(
            child: GroupsContent(searchQuery: _searchQuery),
          ),
        ],
      ),
    );
  }
}
