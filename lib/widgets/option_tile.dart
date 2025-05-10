import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool? isCorrect;
  final VoidCallback onTap;
  final Color? color;

  const OptionTile({
    super.key,
    required this.text,
    required this.isSelected,
    this.isCorrect,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = color ?? Theme.of(context).colorScheme.primary;
    
    Color backgroundColor;
    Color borderColor;
    Color textColor;

    if (isSelected && isCorrect != null) {
      backgroundColor = isCorrect! ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1);
      borderColor = isCorrect! ? Colors.green : Colors.red;
      textColor = isCorrect! ? Colors.green : Colors.red;
    } else if (isSelected) {
      backgroundColor = primaryColor.withOpacity(0.1);
      borderColor = primaryColor;
      textColor = primaryColor;
    } else if (isCorrect != null && isCorrect!) {
      backgroundColor = Colors.green.withOpacity(0.1);
      borderColor = Colors.green;
      textColor = Colors.green;
    } else {
      backgroundColor = Colors.white;
      borderColor = Colors.grey.withOpacity(0.3);
      textColor = Colors.black87;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
