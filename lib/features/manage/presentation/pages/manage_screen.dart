import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../widgets/manage_content.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  int _selectedTabIndex = 0;
  final GlobalKey<ManageContentState> _contentKey = GlobalKey<ManageContentState>();

  final List<ManageTab> _tabs = [
    ManageTab(
      title: 'Locations',
      subtitle: 'Manage locations, stations, managers, and events with DOER assignments',
    ),
    ManageTab(
      title: 'Stations',
      subtitle: 'Configure and manage station settings and assignments',
    ),
    ManageTab(
      title: 'Managers',
      subtitle: 'Manage team managers and their permissions',
    ),
    ManageTab(
      title: 'Events',
      subtitle: 'Organize and schedule events and activities',
    ),
  ];

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
              'Manage',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.textPrimary,
              ),
            ),
            Text(
              _tabs[_selectedTabIndex].subtitle,
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s11,
                fontWeight: FontWeightManager.regular,
                color: ColorManager.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Modern Tab Bar
          Container(
            color: ColorManager.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: _buildTabChip(_tabs[index].title, index),
                  );
                }),
              ),
            ),
          ),

          // Content
          Expanded(
            child: ManageContent(
              key: _contentKey,
              selectedTab: _tabs[_selectedTabIndex].title,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddNewDialog();
        },
        backgroundColor: ColorManager.primary,
        elevation: 2,
        icon: Icon(
          Icons.add,
          size: 20.sp,
          color: ColorManager.white,
        ),
        label: Text(
          'Add New',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTabChip(String label, int index) {
    final isSelected = _selectedTabIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : ColorManager.grey6,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? ColorManager.primary : ColorManager.grey4,
          ),
        ),
        child: Text(
          label,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s13,
            fontWeight: isSelected ? FontWeightManager.semiBold : FontWeightManager.medium,
            color: isSelected ? ColorManager.white : ColorManager.textSecondary,
          ),
        ),
      ),
    );
  }

  void _showAddNewDialog() {
    final textController = TextEditingController();
    String dialogTitle = '';
    String dialogHint = '';

    switch (_tabs[_selectedTabIndex].title) {
      case 'Locations':
        dialogTitle = 'Add New Location';
        dialogHint = 'Enter location name';
        break;
      case 'Stations':
        dialogTitle = 'Add New Station';
        dialogHint = 'Enter station name';
        break;
      case 'Managers':
        dialogTitle = 'Add New Manager';
        dialogHint = 'Enter manager name';
        break;
      case 'Events':
        dialogTitle = 'Add New Event';
        dialogHint = 'Enter event name';
        break;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          dialogTitle,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
          ),
        ),
        content: TextField(
          controller: textController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: dialogHint,
            hintStyle: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
              color: ColorManager.grey3,
            ),
            filled: true,
            fillColor: ColorManager.grey6,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: ColorManager.grey4),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: ColorManager.primary, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                Navigator.pop(context, textController.text.trim());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            ),
            child: Text(
              'Add',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
    ).then((result) {
      if (result != null && result is String && mounted) {
        // Add the new item through the content widget
        _contentKey.currentState?.addNewItem(result);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Added successfully',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.medium,
                color: ColorManager.white,
              ),
            ),
            backgroundColor: ColorManager.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }
}

class ManageTab {
  final String title;
  final String subtitle;

  ManageTab({
    required this.title,
    required this.subtitle,
  });
}
