import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/slot_model.dart';
import '../widgets/slot_card.dart';
import '../../../dashboard/presentation/widgets/request_doer_bottom_sheet.dart';

class SlotsScreen extends StatefulWidget {
  const SlotsScreen({super.key});

  @override
  State<SlotsScreen> createState() => _SlotsScreenState();
}

class _SlotsScreenState extends State<SlotsScreen> {
  final List<String> _dates = [
    'Dec 14',
    'Dec 15',
    'Yesterday',
    'Today',
    'Tomorrow',
    'Dec 19',
    'Dec 20',
    'Dec 21',
    'Dec 22',
    'Dec 23',
    'Dec 24',
    'Dec 25',
    'Dec 26',
    'Dec 27',
  ];

  int _selectedDateIndex = 4; // Tomorrow selected by default

  final List<SlotModel> _slots = [
    SlotModel(
      id: '1',
      timeRange: '09:00 - 17:00',
      position: 'Security Guard',
      location: 'West Branch',
      currentStaff: 0,
      requiredStaff: 2,
      groups: 1,
      directStaff: 2,
      date: 'Thursday, December 18, 2025',
    ),
    SlotModel(
      id: '2',
      timeRange: '14:00 - 22:00',
      position: 'Server',
      location: 'North Hub',
      currentStaff: 0,
      requiredStaff: 3,
      groups: 1,
      directStaff: 2,
      date: 'Thursday, December 18, 2025',
    ),
    SlotModel(
      id: '3',
      timeRange: '18:00 - 02:00',
      position: 'Receptionist',
      location: 'East Mall',
      currentStaff: 0,
      requiredStaff: 4,
      groups: 1,
      directStaff: 2,
      date: 'Thursday, December 18, 2025',
    ),
    SlotModel(
      id: '4',
      timeRange: '09:00 - 17:00',
      position: 'VIP Host',
      location: 'South Convention Center',
      currentStaff: 0,
      requiredStaff: 2,
      groups: 1,
      directStaff: 2,
      date: 'Thursday, December 18, 2025',
    ),
    SlotModel(
      id: '5',
      timeRange: '14:00 - 22:00',
      position: 'Barman',
      location: 'Central Park Plaza',
      currentStaff: 0,
      requiredStaff: 3,
      groups: 1,
      directStaff: 2,
      date: 'Thursday, December 18, 2025',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16.w),
              color: ColorManager.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu, size: 24.sp),
                        onPressed: () {},
                        color: ColorManager.textPrimary,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Slots Management',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s20,
                                fontWeight: FontWeightManager.bold,
                                color: ColorManager.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Manage all current and upcoming shift slots',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Stack(
                        children: [
                          IconButton(
                            icon: Icon(Icons.notifications_outlined, size: 22.sp),
                            onPressed: () {},
                            color: ColorManager.textPrimary,
                            padding: EdgeInsets.all(8.w),
                            constraints: const BoxConstraints(),
                          ),
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              width: 6.w,
                              height: 6.w,
                              decoration: const BoxDecoration(
                                color: ColorManager.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Search Bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: ColorManager.grey6,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 20.sp,
                          color: ColorManager.textSecondary,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Search DOER, shifts, invoices...',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s13,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Date Selector
            Container(
              height: 50.h,
              color: ColorManager.white,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                scrollDirection: Axis.horizontal,
                itemCount: _dates.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedDateIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedDateIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: isSelected ? ColorManager.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: isSelected ? ColorManager.primary : ColorManager.grey3,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _dates[index],
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s13,
                            fontWeight: isSelected ? FontWeightManager.semiBold : FontWeightManager.medium,
                            color: isSelected ? ColorManager.white : ColorManager.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Date Header
            Container(
              padding: EdgeInsets.all(16.w),
              color: ColorManager.backgroundColor,
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 18.sp,
                    color: ColorManager.primary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Thursday, December 18, 2025',
                    style: FontConstants.getPoppinsStyle(
                      fontSize: FontSize.s15,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Slots List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
                itemCount: _slots.length,
                itemBuilder: (context, index) {
                  return SlotCard(
                    slot: _slots[index],
                    onTap: () {
                      // Handle view details
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: const RequestDoerBottomSheet(),
            ),
          );
        },
        backgroundColor: ColorManager.primary,
        icon: Icon(Icons.add, color: ColorManager.white, size: 20.sp),
        label: Text(
          'Request',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManager.white,
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.dashboard_outlined, 'Dashboard', false),
              _buildNavItem(Icons.calendar_today_outlined, 'Slots', true),
              _buildNavItem(Icons.assessment_outlined, 'Status', false),
              _buildNavItem(Icons.person_outline, 'Profile', false),
              _buildNavItem(Icons.more_horiz, 'More', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (!isActive && label == 'Dashboard') {
          Navigator.pop(context);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? ColorManager.primary : ColorManager.textSecondary,
            size: 22.sp,
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s10,
              fontWeight: isActive ? FontWeightManager.semiBold : FontWeightManager.regular,
              color: isActive ? ColorManager.primary : ColorManager.textSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
