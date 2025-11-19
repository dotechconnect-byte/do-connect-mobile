// lib/features/auth/presentation/widgets/account_type_selector.dart

import 'package:flutter/material.dart';

class AccountTypeSelector extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeChanged;

  const AccountTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          child: _AccountTypeButton(
            label: 'Personal',
            isSelected: selectedType == 'Personal',
            onTap: () => onTypeChanged('Personal'),
          ),
        ),
        SizedBox(width: size.width * 0.03),
        Expanded(
          child: _AccountTypeButton(
            label: 'Employer',
            isSelected: selectedType == 'Employer',
            onTap: () => onTypeChanged('Employer'),
          ),
        ),
      ],
    );
  }
}

class _AccountTypeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _AccountTypeButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? Colors.black87 : Colors.grey[600],
            ).copyWith(fontSize: (size.width * 0.04).clamp(14.0, 18.0)),
          ),
        ),
      ),
    );
  }
}
