import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final Color? color;

  const ProgressBar({
    super.key,
    required this.current,
    required this.total,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = color ?? Theme.of(context).colorScheme.primary;
    final progress = current / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question $current of $total',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: MediaQuery.of(context).size.width * progress - 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
