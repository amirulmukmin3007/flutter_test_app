import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.ratingFlag = false,
  });

  final String label;
  final bool isSelected;
  final Function(bool) onSelected;
  final bool ratingFlag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: ratingFlag
            ? Row(
                children: [
                  Text(label),
                  const SizedBox(width: 4),
                  Icon(Icons.star, color: Colors.yellow.shade700, size: 16),
                ],
              )
            : Text(label),
        selected: isSelected,
        onSelected: onSelected,
        selectedColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Colors.grey.shade100,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade700,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}
