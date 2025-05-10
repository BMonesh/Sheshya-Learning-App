import 'package:flutter/material.dart';

class DraggableImageCard extends StatelessWidget {
  final String id;
  final String imagePath;
  final String label;
  final bool isTarget;
  final bool isMatched;
  final Function(String, String) onMatch;

  const DraggableImageCard({
    super.key,
    required this.id,
    required this.imagePath,
    required this.label,
    this.isTarget = false,
    this.isMatched = false,
    required this.onMatch,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: isMatched
            ? Colors.green.withOpacity(0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isMatched
              ? Colors.green
              : Colors.grey.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: isMatched
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // In a real app, we would use Image.asset or Image.network
          // For this mock, we'll use a placeholder
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                label.substring(0, 1),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    if (isTarget) {
      return DragTarget<String>(
        onWillAccept: (data) => !isMatched,
        onAccept: (data) {
          onMatch(data, id);
        },
        builder: (context, candidateData, rejectedData) {
          return cardContent;
        },
      );
    } else {
      return Draggable<String>(
        data: id,
        feedback: cardContent,
        childWhenDragging: Opacity(
          opacity: 0.5,
          child: cardContent,
        ),
        child: cardContent,
      );
    }
  }
}
