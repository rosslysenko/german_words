import 'package:flutter/material.dart';

class TestOption extends StatelessWidget {
  final String option;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onSelect;

  const TestOption({super.key, 
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        onPressed: onSelect,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? (isCorrect ? Colors.green : Colors.red)
              : null,
        ),
        child: Text(option),
      ),
    );
  }
}
