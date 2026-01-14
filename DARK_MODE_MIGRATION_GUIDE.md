# Dark Mode Migration Guide

## Quick Reference for Updating Widgets

To make any widget support dark mode, follow these 3 simple steps:

### Step 1: Add Import
```dart
import '../../../../core/utils/theme_helper.dart';
```

### Step 2: Add Theme Helper in build()
```dart
@override
Widget build(BuildContext context) {
  final colors = ThemeHelper.of(context);  // Add this line

  // Rest of your widget code
}
```

### Step 3: Replace Hard-coded Colors

| Replace This | With This |
|-------------|-----------|
| `ColorManager.white` | `colors.cardBackground` |
| `ColorManager.backgroundColor` | `colors.background` |
| `ColorManager.textPrimary` | `colors.textPrimary` |
| `ColorManager.textSecondary` | `colors.textSecondary` |
| `ColorManager.textTertiary` | `colors.textTertiary` |
| `ColorManager.grey` | `colors.grey` |
| `ColorManager.grey1` through `grey6` | `colors.grey1` through `grey6` |
| `ColorManager.error` | `colors.error` |
| `ColorManager.success` | `colors.success` |
| `ColorManager.warning` | `colors.warning` |
| `ColorManager.info` | `colors.info` |
| `ColorManager.primary` | `colors.primary` |

### Complete Example

**Before:**
```dart
import 'package:flutter/material.dart';
import '../../../../core/consts/color_manager.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.white,
      child: Text(
        'Hello',
        style: TextStyle(color: ColorManager.textPrimary),
      ),
    );
  }
}
```

**After:**
```dart
import 'package:flutter/material.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/utils/theme_helper.dart';  // 1. Add import

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);  // 2. Add helper

    return Container(
      color: colors.cardBackground,  // 3. Use theme colors
      child: Text(
        'Hello',
        style: TextStyle(color: colors.textPrimary),
      ),
    );
  }
}
```

## Files Already Updated ✅

- ✅ lib/core/consts/color_manager.dart
- ✅ lib/core/theme/app_theme.dart
- ✅ lib/core/providers/theme_provider.dart
- ✅ lib/main.dart
- ✅ lib/features/more/presentation/widgets/more_content.dart
- ✅ lib/features/home/presentation/pages/home_screen.dart
- ✅ lib/features/dashboard/presentation/widgets/stat_card.dart
- ✅ lib/features/dashboard/presentation/widgets/promo_banner.dart
- ✅ lib/features/attendance/presentation/widgets/attendance_card.dart
- ✅ lib/features/profile/presentation/widgets/profile_content.dart (partial)

## Files Needing Updates 🔧

### High Priority (Most Visible)
- [ ] lib/features/attendance/presentation/widgets/attendance_content.dart
- [ ] lib/features/slots/presentation/widgets/slots_content.dart
- [ ] lib/features/status/presentation/widgets/status_content.dart
- [ ] lib/features/groups/presentation/widgets/groups_content.dart
- [ ] lib/features/manage/presentation/widgets/manage_content.dart
- [ ] lib/features/invoices/presentation/widgets/invoices_content.dart
- [ ] lib/features/transport/presentation/widgets/transport_content.dart

### Medium Priority (Modals & Dialogs)
- [ ] lib/features/attendance/presentation/widgets/attendance_detail_modal.dart
- [ ] lib/features/profile/presentation/widgets/edit_company_modal.dart
- [ ] lib/features/dashboard/presentation/widgets/request_doer_bottom_sheet.dart
- [ ] lib/features/slots/presentation/widgets/slot_details_modal.dart

### Lower Priority (Charts & Secondary Widgets)
- [ ] lib/features/dashboard/presentation/widgets/attendance_chart.dart
- [ ] lib/features/dashboard/presentation/widgets/position_distribution_chart.dart
- [ ] lib/features/dashboard/presentation/widgets/notification_panel.dart

## Testing Checklist

After updating files, test:
1. Toggle dark mode in More → Settings
2. Navigate through all tabs
3. Open modals and bottom sheets
4. Check text readability
5. Verify card backgrounds switch properly

## Color Palette Reference

### Light Mode
- Background: #F9FAFB
- Cards: #FFFFFF
- Primary: #FF6B35
- Text: #111827

### Dark Mode
- Background: #0F0F0F
- Cards: #1A1A1A
- Primary: #FF7A4D
- Text: #F3F4F6
