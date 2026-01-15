import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../consts/color_manager.dart';
import '../consts/font_manager.dart';

enum AccountType { personal, services }

class AccountTypeToggle extends StatefulWidget {
  final AccountType selectedType;
  final Function(AccountType) onChanged;

  const AccountTypeToggle({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  State<AccountTypeToggle> createState() => _AccountTypeToggleState();
}

class _AccountTypeToggleState extends State<AccountTypeToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    // Set initial position
    if (widget.selectedType == AccountType.services) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AccountTypeToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedType != widget.selectedType) {
      if (widget.selectedType == AccountType.services) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(4.w),
      child: Stack(
        children: [
          // Animated gradient indicator
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                left: _animation.value * (MediaQuery.of(context).size.width / 2 - 28.w),
                top: 0,
                bottom: 0,
                width: (MediaQuery.of(context).size.width / 2 - 28.w),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: ColorManager.authGradient,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.authPrimary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Buttons
          Row(
            children: [
              Expanded(
                child: _buildToggleButton(
                  type: AccountType.personal,
                  label: 'Personal',
                  icon: Icons.person_outline_rounded,
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: _buildToggleButton(
                  type: AccountType.services,
                  label: 'Services',
                  icon: Icons.business_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required AccountType type,
    required String label,
    required IconData icon,
  }) {
    final bool isSelected = widget.selectedType == type;

    return GestureDetector(
      onTap: () => widget.onChanged(type),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                style: TextStyle(
                  color: isSelected
                      ? ColorManager.white
                      : ColorManager.authSecondaryText,
                ),
                child: Icon(
                  icon,
                  size: 20.sp,
                  color: isSelected
                      ? ColorManager.white
                      : ColorManager.authSecondaryText,
                ),
              ),
              SizedBox(width: 8.w),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  fontWeight: isSelected
                      ? FontWeightManager.semiBold
                      : FontWeightManager.medium,
                  color: isSelected
                      ? ColorManager.white
                      : ColorManager.authSecondaryText,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
