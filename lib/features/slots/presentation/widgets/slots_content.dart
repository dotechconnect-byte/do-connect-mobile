import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../data/models/slot_model.dart';
import 'slot_card.dart';
import 'slot_details_modal.dart';

class SlotsContent extends StatefulWidget {
  final String searchQuery;

  const SlotsContent({super.key, this.searchQuery = ''});

  @override
  State<SlotsContent> createState() => _SlotsContentState();
}

class _SlotsContentState extends State<SlotsContent> {
  final List<String> _dates = [
    'Dec 14',
    'Dec 15',
    'Dec 16',
    'Yesterday',
    'Today',
    'Tomorrow',
    'Dec 20',
    'Dec 21',
    'Dec 22',
    'Dec 23',
    'Dec 24',
    'Dec 25',
    'Dec 26',
    'Dec 27',
  ];

  int _selectedDateIndex = 4; // Today selected by default (index 4 is 'Today')
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Auto-scroll to Today after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final double itemWidth = 80.w; // Approximate width of each date item
        final double offset = (_selectedDateIndex - 1) * itemWidth;
        _scrollController.animateTo(
          offset.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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

  List<SlotModel> get _filteredSlots {
    if (widget.searchQuery.isEmpty) {
      return _slots;
    }

    final query = widget.searchQuery.toLowerCase();
    return _slots.where((slot) {
      return slot.position.toLowerCase().contains(query) ||
             slot.location.toLowerCase().contains(query) ||
             slot.timeRange.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSlots = _filteredSlots;

    return Column(
      children: [
        // Date Selector
        Container(
          height: 50.h,
          color: ColorManager.white,
          child: ListView.builder(
            controller: _scrollController,
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
              Expanded(
                child: Text(
                  'Thursday, December 18, 2025',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s15,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),
              if (widget.searchQuery.isNotEmpty)
                Text(
                  '${filteredSlots.length} result${filteredSlots.length != 1 ? 's' : ''}',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.primary,
                  ),
                ),
            ],
          ),
        ),

        // Slots List
        Expanded(
          child: filteredSlots.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64.sp,
                        color: ColorManager.grey3,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No slots found',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Try adjusting your search',
                        style: FontConstants.getPoppinsStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 80.h),
                  itemCount: filteredSlots.length,
                  itemBuilder: (context, index) {
                    return SlotCard(
                      slot: filteredSlots[index],
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => SlotDetailsModal(
                            slot: filteredSlots[index],
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
