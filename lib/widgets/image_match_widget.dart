import 'package:flutter/material.dart';
import '../models/course_content.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';

class ImageMatchWidget extends StatefulWidget {
  final ImageMatchQuestion question;
  final Function(Map<String, String>) onAnswerSubmitted;
  final bool answered;
  final bool isCorrect;

  const ImageMatchWidget({
    Key? key,
    required this.question,
    required this.onAnswerSubmitted,
    required this.answered,
    required this.isCorrect,
  }) : super(key: key);

  @override
  State<ImageMatchWidget> createState() => _ImageMatchWidgetState();
}

class _ImageMatchWidgetState extends State<ImageMatchWidget> {
  Map<String, String?> _matches = {};
  String? _selectedLeftId;

  @override
  void initState() {
    super.initState();
    // Initialize matches with null values
    for (final pair in widget.question.imagePairs) {
      if (pair['id']!.startsWith('a') || pair['id']!.startsWith('f') || 
          pair['id']!.startsWith('p') || pair['id']!.startsWith('o') || 
          pair['id']!.startsWith('s')) {
        _matches[pair['id']!] = null;
      }
    }
  }

  bool get _allMatched => _matches.values.every((value) => value != null);

  List<Map<String, String>> get _leftItems {
    return widget.question.imagePairs.where((pair) {
      return pair['id']!.startsWith('a') || pair['id']!.startsWith('f') || 
             pair['id']!.startsWith('p') || pair['id']!.startsWith('o') || 
             pair['id']!.startsWith('s');
    }).toList();
  }

  List<Map<String, String>> get _rightItems {
    return widget.question.imagePairs.where((pair) {
      return pair['id']!.startsWith('h') || pair['id']!.startsWith('c') || 
             pair['id']!.startsWith('b') || pair['id']!.startsWith('u') || 
             pair['id']!.startsWith('n');
    }).toList();
  }

  void _handleItemTap(String id, bool isLeft) {
    if (widget.answered) return;

    if (isLeft) {
      setState(() {
        _selectedLeftId = id;
      });
    } else {
      if (_selectedLeftId != null) {
        setState(() {
          _matches[_selectedLeftId!] = id;
          _selectedLeftId = null;
        });
      }
    }
  }

  void _resetMatch(String leftId) {
    if (widget.answered) return;
    
    setState(() {
      _matches[leftId] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question.question,
            style: AppTheme.headingStyle,
          ),
          const SizedBox(height: 8),
          Text(
            AppConstants.imageMatchInstructions,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.lightTextColor,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildLeftColumn(),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildRightColumn(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (widget.answered && widget.question.explanation != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.isCorrect
                    ? AppTheme.correctColor.withOpacity(0.1)
                    : AppTheme.incorrectColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: widget.isCorrect
                      ? AppTheme.correctColor
                      : AppTheme.incorrectColor,
                  width: 1,
                ),
              ),
              child: Text(
                widget.question.explanation!,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textColor,
                ),
              ),
            ),
          const SizedBox(height: 20),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      children: _leftItems.map((item) {
        final isSelected = _selectedLeftId == item['id'];
        final isMatched = _matches[item['id']] != null;
        final isCorrect = widget.answered && 
                          widget.question.correctAnswer[item['id']] == _matches[item['id']];
        final isIncorrect = widget.answered && isMatched && !isCorrect;

        return Expanded(
          child: GestureDetector(
            onTap: isMatched ? () => _resetMatch(item['id']!) : () => _handleItemTap(item['id']!, true),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryColor.withOpacity(0.2)
                    : (isMatched
                        ? (widget.answered
                            ? (isCorrect
                                ? AppTheme.correctColor.withOpacity(0.2)
                                : AppTheme.incorrectColor.withOpacity(0.2))
                            : AppTheme.secondaryColor.withOpacity(0.2))
                        : Colors.white),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.primaryColor
                      : (isMatched
                          ? (widget.answered
                              ? (isCorrect
                                  ? AppTheme.correctColor
                                  : AppTheme.incorrectColor)
                              : AppTheme.secondaryColor)
                          : Colors.grey.withOpacity(0.3)),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Placeholder for image
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        item['name']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['name']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (isMatched)
                    Icon(
                      widget.answered
                          ? (isCorrect ? Icons.check_circle : Icons.cancel)
                          : Icons.link,
                      color: widget.answered
                          ? (isCorrect ? AppTheme.correctColor : AppTheme.incorrectColor)
                          : AppTheme.secondaryColor,
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRightColumn() {
    return Column(
      children: _rightItems.map((item) {
        final isMatched = _matches.values.contains(item['id']);
        final matchedLeftId = isMatched
            ? _matches.entries.firstWhere((entry) => entry.value == item['id']).key
            : null;
        final isCorrect = widget.answered && matchedLeftId != null &&
                          widget.question.correctAnswer[matchedLeftId] == item['id'];
        final isIncorrect = widget.answered && isMatched && !isCorrect;

        return Expanded(
          child: GestureDetector(
            onTap: isMatched || _selectedLeftId == null ? null : () => _handleItemTap(item['id']!, false),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isMatched
                    ? (widget.answered
                        ? (isCorrect
                            ? AppTheme.correctColor.withOpacity(0.2)
                            : AppTheme.incorrectColor.withOpacity(0.2))
                        : AppTheme.secondaryColor.withOpacity(0.2))
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isMatched
                      ? (widget.answered
                          ? (isCorrect
                              ? AppTheme.correctColor
                              : AppTheme.incorrectColor)
                          : AppTheme.secondaryColor)
                      : Colors.grey.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Placeholder for image
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        item['name']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['name']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (isMatched)
                    Icon(
                      widget.answered
                          ? (isCorrect ? Icons.check_circle : Icons.cancel)
                          : Icons.link,
                      color: widget.answered
                          ? (isCorrect ? AppTheme.correctColor : AppTheme.incorrectColor)
                          : AppTheme.secondaryColor,
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: !_allMatched || widget.answered
            ? null
            : () => widget.onAnswerSubmitted(
                  Map<String, String>.fromEntries(
                    _matches.entries.map((e) => MapEntry(e.key, e.value!)),
                  ),
                ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: Colors.grey.withOpacity(0.3),
        ),
        child: Text(
          widget.answered ? AppConstants.next : AppConstants.submit,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
